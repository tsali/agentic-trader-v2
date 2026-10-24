#!/bin/bash
# V2 trading desk runner. Usage: trader_v2.sh OPEN|MIDDAY|CLOSE|WEEKLY
# MODE file: LIVE = real orders, DRY_RUN (or anything else) = no orders, HALT = do nothing.
SESSION="${1:-OPEN}"
cd /home/tsali/amy-live/trading || exit 1
set -a; . ./.env 2>/dev/null; set +a
LOG=/home/tsali/logs/trader-v2.log
mkdir -p /home/tsali/logs
MODE=$(tr -d '[:space:]' < MODE 2>/dev/null)
if [ "$MODE" = "HALT" ]; then
  echo "== V2 $SESSION skipped: MODE=HALT $(date '+%F %T %Z') ==" >> "$LOG"; exit 0
fi
echo "===== V2 $SESSION run $(date '+%F %T %Z') MODE=$MODE =====" >> "$LOG"
[ "$SESSION" = "OPEN" ] && timeout 90 python3 reddit_pull.py >> "$LOG" 2>&1

RO="Bash WebSearch WebFetch"
for t in get_portfolio get_equity_positions get_equity_quotes get_equity_fundamentals \
         get_equity_technical_indicators get_equity_historicals get_index_quotes \
         get_earnings_results get_earnings_calendar get_equity_analyst_ratings get_equity_tradability; do
  RO="$RO mcp__robinhood-trading__$t"
done
if [ "$MODE" = "LIVE" ] && [ "$SESSION" != "WEEKLY" ]; then
  ALLOW="$RO mcp__robinhood-trading__review_equity_order mcp__robinhood-trading__place_equity_order"
  MODELINE="CURRENT MODE: LIVE (real orders permitted within all rules)."
else
  ALLOW="$RO"
  MODELINE="CURRENT MODE: DRY_RUN (do NOT place real orders; log intended actions; prefix Telegram with [DRY-RUN])."
fi
timeout 600 claude -p "${MODELINE}"$'\n'"SESSION: ${SESSION}"$'\n\n'"$(cat TRADER_PROMPT_V2.md)" \
  --allowedTools "$ALLOW" --max-turns 60 >> "$LOG" 2>&1
echo "===== V2 $SESSION done $(date '+%F %T %Z') =====" >> "$LOG"
