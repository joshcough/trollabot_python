# Migrating Trollabot from Heroku to Fly.io + Neon

Goal: cut hosting from ~$16/mo (Heroku Basic dyno $7 + essential-1 Postgres $9)
to ~$2/mo (Fly shared-cpu-1x 256MB machine + Neon free Postgres).

Heroku currently deploys `main`. The bot only needs three secrets:
`BOT_TOKEN`, `DATABASE_URL`, `DISCORD_WEBHOOK_URL`.

## 1. Neon database

1. Done: project `trollabot` (`polished-mountain-89386461`) in org
   `org-broad-glade-81634571`, region AWS us-east-2, created with `neon init`.
2. Connection strings are in `.env.local` (gitignored). Use `DATABASE_URL_UNPOOLED`
   for `pg_restore` (the pooled URL goes through PgBouncer, which can break restores):

   ```bash
   export NEON_URL="$(grep '^DATABASE_URL_UNPOOLED=' .env.local | cut -d= -f2- | tr -d '"')"
   ```

3. Copy the data from Heroku (DB is ~9MB, takes seconds):

   ```bash
   HEROKU_URL="$(heroku config:get DATABASE_URL -a trollabot)"
   pg_dump -Fc --no-owner --no-acl "$HEROKU_URL" -f trollabot.dump
   pg_restore --clean --if-exists --no-owner --no-acl -d "$NEON_URL" trollabot.dump
   ```

   A test copy was done on 2026-11-01 and verified identical (all tables, row by
   row, plus sequences). Re-run at cutover; `--clean` replaces the test copy.

4. Sanity check: compare row counts, e.g.
   `psql "$NEON_URL" -c 'select count(*) from quotes'` vs the same against `$HEROKU_URL`.

Neon free tier suspends the DB after ~5 min idle; the first query afterwards takes
~1s to wake it. The engine uses `pool_pre_ping=True` so stale connections are
replaced instead of erroring.

## 2. Fly app

```bash
brew install flyctl
fly auth login
fly apps create trollabot        # if the name is taken, pick another and update fly.toml
fly secrets set -a trollabot \
  DATABASE_URL="$NEON_URL" \
  BOT_TOKEN="$(heroku config:get BOT_TOKEN -a trollabot)" \
  DISCORD_WEBHOOK_URL="$(heroku config:get DISCORD_WEBHOOK_URL -a trollabot)"
```

## 3. Cut over

Only one bot should be connected at a time, or every chat command gets two replies.

```bash
heroku ps:scale worker=0 -a trollabot   # stop Heroku bot
fly deploy --ha=false                    # build + start exactly one machine
fly logs                                 # watch it connect to IRC
```

Test a few commands in chat. If anything is wrong, roll back with
`fly scale count 0` and `heroku ps:scale worker=1 -a trollabot`.

Note: if the bot wrote anything to Heroku's DB between the backup and the cutover,
it's lost. To avoid that, scale Heroku to 0 *before* step 1.3 instead.

## 4. Decommission Heroku (after a few days of it working)

```bash
heroku addons:destroy heroku-postgresql -a trollabot
heroku apps:destroy trollabot
```

Papertrail goes away with it; use `fly logs` (or the Fly dashboard) instead.

## Memory

256MB should be enough. If `fly logs` shows OOM kills, bump `memory` in
`fly.toml` to `512mb` (~$3/mo) and redeploy.
