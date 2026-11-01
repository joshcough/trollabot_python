#!/usr/bin/env python3
"""Report Neon compute usage for this billing period and project the month's total.

Neon's free plan allows 100 CU-hours per month; past that the database is suspended
until the next period. Exits 2 if, after at least a day, the projection is over WARN_CU_HOURS.

Requires the `neon` CLI, logged in (`neon login`).
"""
import json
import subprocess
import sys
from datetime import datetime, timezone

PROJECT_ID = "polished-mountain-89386461"
LIMIT_CU_HOURS = 100
WARN_CU_HOURS = 80


def parse(ts: str) -> datetime:
    return datetime.fromisoformat(ts.replace("Z", "+00:00"))


def main() -> int:
    out = subprocess.run(["neon", "api", f"/projects/{PROJECT_ID}"],
                         capture_output=True, text=True, check=True).stdout
    project = json.loads(out)["project"]

    used = project["compute_time_seconds"] / 3600
    start = parse(project["consumption_period_start"])
    end = parse(project["consumption_period_end"])
    now = datetime.now(timezone.utc)

    elapsed_days = max((now - start).total_seconds() / 86400, 1 / 24)
    period_days = (end - start).total_seconds() / 86400
    projected = used / elapsed_days * period_days

    print(f"{now:%Y-%m-%d %H:%M}Z  used {used:.2f} CU-h in {elapsed_days:.2f} days "
          f"({used / elapsed_days:.2f}/day)  projected {projected:.1f} of {LIMIT_CU_HOURS} "
          f"by {end:%Y-%m-%d}")
    # Under a day of data the projection is noise
    return 2 if elapsed_days >= 1 and projected > WARN_CU_HOURS else 0


if __name__ == "__main__":
    sys.exit(main())
