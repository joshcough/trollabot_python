# Trollabot Deployment

Trollabot runs on **Fly.io** with a **Neon** Postgres database. Moved off Heroku on
2026-11-01 (see `FLY_MIGRATION.md` for how). No secrets are stored in this file.

## Where things live

| What | Where | Details |
|---|---|---|
| Bot | Fly.io app `trollabot` | org `personal`, region `ord` (Chicago), 1 machine, shared-cpu-1x, 256MB |
| Database | Neon project `trollabot` | id `polished-mountain-89386461`, org Trollabot (`org-broad-glade-81634571`), region aws-us-east-2 (Ohio), branch `main`, db `neondb` |
| Accounts | Fly.io, Neon | both under joshcough@gmail.com |
| Code | GitHub `joshcough/trollabot_python` | deploy from `main` |

Dashboards:
- Fly: https://fly.io/apps/trollabot
- Fly billing: https://fly.io/dashboard/personal/billing
- Neon: https://console.neon.tech/app/projects/polished-mountain-89386461/

## Cost

- Fly: ~$2/mo for the machine (pay-as-you-go, billed monthly to the card on the account).
  Fly has no free tier; a new account gets a short trial (2 hours of machine time or
  7 days) and then machines stop until a credit card is added.
- Neon: free plan (0.5GB storage; the DB is ~9MB). No card needed. The DB suspends
  after ~5 min idle and wakes on the next query (~1s).

## Secrets (Fly)

Set on the Fly app; view names with `fly secrets list -a trollabot`.

| Name | Value comes from |
|---|---|
| `DATABASE_URL` | Neon **unpooled** connection string (Neon console > Connect, pooling off; also `DATABASE_URL_UNPOOLED` in local `.env.local`) |
| `BOT_TOKEN` | Twitch OAuth token for the bot account (`oauth:...`) |
| `DISCORD_WEBHOOK_URL` | Discord webhook for error notifications |

`ENV=prod` is set in `fly.toml`. Use the unpooled Neon URL: the pooler runs in
transaction mode, which doesn't keep the session-level `REPEATABLE READ` isolation
SQLAlchemy sets per connection.

To change one: `fly secrets set -a trollabot NAME="value"` (restarts the bot).

## Files

- `Dockerfile`: Python 3.12 slim, builds psycopg2 from source (needs `gcc libc6-dev libpq-dev`).
- `fly.toml`: worker only, no HTTP service; `kill_signal = "SIGTERM"` so the bot shuts down cleanly.
- `.dockerignore`: keeps `.env`, `.env.local`, dumps, logs, `node_modules` out of the image.
- `.env.local` (gitignored, local only): Neon connection strings, written by `neon init`.
- `.neon` (gitignored): links this directory to the Neon project for the `neon` CLI.

## Everyday commands

```bash
fly deploy --ha=false          # deploy current code (always exactly 1 machine)
fly logs -a trollabot          # live logs (LOG_LEVEL=WARNING, so quiet when healthy)
fly status -a trollabot        # machine state
fly machine restart -a trollabot <machine-id>
fly ssh console -a trollabot   # shell into the container
```

Never run two copies of the bot: every chat command would get two replies.

Database:

```bash
NEON_URL="$(grep '^DATABASE_URL_UNPOOLED=' .env.local | cut -d= -f2- | tr -d '"')"
psql "$NEON_URL"
pg_dump -Fc --no-owner --no-acl "$NEON_URL" -f trollabot-$(date +%F).dump   # backup
```

If `.env.local` is missing: `neon login`, then `neon init` in the repo root (or copy the
connection string from the Neon console).

## Code notes

- `create_engine(..., pool_pre_ping=True)` is required: Neon's free tier suspends idle
  databases, and pre-ping replaces dead connections instead of erroring. Keep it on
  every `create_engine` call (the `one-connection-per-stream` branch has two).
- Twitch IRC is plain port 6667; Postgres is 5432.

## Heroku (old)

App `trollabot`: worker scaled to 0 on 2026-11-01. Its `heroku-postgresql`
essential-1 database (~$9/mo) is kept as a rollback until deleted.

Rollback: `fly scale count 0 -a trollabot && heroku ps:scale worker=1 -a trollabot`
(anything written to Neon since cutover is not in the Heroku DB).

Decommission once stable:

```bash
heroku addons:destroy heroku-postgresql -a trollabot
heroku apps:destroy trollabot
```
