# Trollabot Deployment

Trollabot runs on **Fly.io** with a **Neon** Postgres database. Moved off Heroku on
2026-11-01 (see `FLY_MIGRATION.md` for how). No secrets are stored in this file.

## Where things live

| What | Where | Details |
|---|---|---|
| Bot | Fly.io app `trollabot` | org `personal`, region `ord` (Chicago), 1 machine, shared-cpu-1x, 256MB |
| Database | Neon project `trollabot` | id `polished-mountain-89386461`, org Trollabot (`org-broad-glade-81634571`), region aws-us-east-2 (Ohio), branch `main`, db `neondb` |
| Accounts | Fly.io, Neon | both under joshcough@gmail.com |
| Code | GitHub `joshcough/trollabot_python` | deploy from `main` (Fly deploys from your local checkout; pushing to GitHub does not deploy) |

Dashboards:
- Fly: https://fly.io/apps/trollabot
- Fly billing: https://fly.io/dashboard/personal/billing
- Neon: https://console.neon.tech/app/projects/polished-mountain-89386461/

## Cost

- Fly: ~$2/mo for the machine (pay-as-you-go, billed monthly to the card on the account).
  Fly has no free tier. Without a card on file, trial machines are stopped after
  **5 minutes** ("Trial machine stopping. To run for longer than 5m0s, add a credit
  card by visiting https://fly.io/trial"). This happened on cutover day; a card must
  stay on the account or the bot goes down.
- Neon: free plan (0.5GB storage; the DB is ~9MB). No card needed. The DB suspends
  after ~5 min idle and wakes on the next query (~1s).

### Neon compute budget (watch this)

The free plan allows **100 CU-hours per month**; if it runs out, Neon suspends the
database until the next period (the bot loses its DB). Usage counts only while the
database is awake, i.e. while chat is using DB commands plus 5 min after the last one.
The compute is pinned at 0.25 CU (min = max), so 100 CU-hours = **400 awake hours/month,
~13 h/day**. Don't add a keep-alive ping: 24/7 at 0.25 CU is ~182 CU-hours.

Check usage and the month's projection:

```bash
scripts/neon_usage.py
# 2026-11-01 15:50Z  used 0.14 CU-h in 0.04 days (3.45/day)  projected 101.2 of 100 by 2026-12-01
```

Real usage after the first month: ~0.18 CU-h/day, projected ~5.7 of 100 (2026-11-25),
so Neon free is comfortably enough.

Warning sign: more than ~3.3 CU-h/day on normal stream days. If the projection stays
over ~80, switch the DB (decided
fallback: the Let's Play Scrabble Heroku Postgres, in its own `trollabot` schema; note
Heroku may rotate that DB's credentials, and the Fly secret would need updating by hand).

Optional daily check on your Mac (logs to `~/Library/Logs/trollabot-neon-usage.log`,
pops a notification if the projection is over 80 or the check fails). Run once to install:

```bash
(crontab -l 2>/dev/null; echo '7 9 * * * export PATH=/opt/homebrew/bin:/usr/bin:/bin; out=$(python3 ~/work/trollabot_all/trollabot_python/scripts/neon_usage.py 2>&1); rc=$?; echo "$out" >> ~/Library/Logs/trollabot-neon-usage.log; [ $rc -ne 0 ] && osascript -e "display notification \"$out\" with title \"Trollabot Neon usage\""') | crontab -
```

Remove with `crontab -e` (delete that line).

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
# backup: needs pg_dump >= Neon's server version (18); Homebrew's postgresql@16 is too
# old, so use the keg-only libpq client (`brew install libpq`)
/opt/homebrew/opt/libpq/bin/pg_dump -Fc --no-owner --no-acl "$NEON_URL" \
  -f ~/backups/trollabot/neon-$(date +%F).dump
```

Backups live in `~/backups/trollabot/` (laptop only):
- `heroku-final-2026-11-25.dump`: the Heroku DB as frozen at cutover (3042 quotes),
  taken before deleting the Heroku add-on. Heroku's own backups were deleted with it.
- `neon-2026-11-25.dump`: live data on that date (3051 quotes).

Restore into any Postgres: `pg_restore --clean --if-exists --no-owner --no-acl -d "$URL" <file>`.

If `.env.local` is missing, copy the connection string from the Neon console, or
`neon login` then `neon env pull` in the repo root. (Avoid re-running `neon init`: it
adds Node files — `neon.ts`, `package.json`, `node_modules/` — that this Python repo
doesn't use; they were deleted after setup.)

## Code notes

- Neon drops connections in two ways: it suspends the database after 5 min with no
  queries (free plan, not configurable), and it kills any session left idle inside a
  transaction for 5 min (`idle_in_transaction_session_timeout=300000ms`). The second
  one caused the outage on cutover day. Two things together keep the bot working:
  - `create_engine(..., pool_pre_ping=True)` tests a pooled connection on checkout and
    reconnects if it's dead. Keep it on every `create_engine` call (the
    `one-connection-per-stream` branch has two).
  - `TwitchIRCBot.on_pubmsg` closes the session after every message, returning the
    connection to the pool. Without that, the session holds one connection forever,
    pre-ping never runs, and after the first drop every DB command fails with
    "Can't reconnect until invalid transaction is rolled back" (seen on cutover day).
- Twitch IRC is plain port 6667; Postgres is 5432.

## Heroku (old)

App `trollabot` and its add-ons (Postgres, Papertrail) were **deleted on 2026-11-25**,
after a final backup (`~/backups/trollabot/heroku-final-2026-11-25.dump`). The `heroku`
git remote is gone too. `Procfile` (`worker: python main.py`) and `runtime.txt` are
kept in the repo so the code can still run on Heroku unchanged.

### Going back to Heroku (emergency only)

The code runs on both platforms unchanged: `main.py` reads `DATABASE_URL`,
`BOT_TOKEN`, `DISCORD_WEBHOOK_URL`, and `postgres://` URLs are rewritten automatically.
Always stop the Fly bot first so two bots aren't in chat.

```bash
fly scale count 0 -a trollabot
heroku create trollabot            # or another name if taken; updates the `heroku` remote
heroku config:set ENV=prod BOT_TOKEN=... DISCORD_WEBHOOK_URL=... DATABASE_URL="$NEON_URL"
git push heroku main
heroku ps:scale worker=1:basic
```

That keeps Neon as the database (~$7/mo total). For a Heroku-hosted DB instead,
`heroku addons:create heroku-postgresql:essential-0` and `pg_restore` a Neon dump
into it (backup and restore commands are under "Everyday commands").

Get `BOT_TOKEN` / `DISCORD_WEBHOOK_URL` values from wherever you keep them; Fly
secrets can't be read back. If lost: `fly ssh console -a trollabot -C "printenv BOT_TOKEN"`.
