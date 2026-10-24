# Changelog

## 2026-10-24: V2 created
- Rebuilt the agent as a "trading desk": regime filter, core ETF plus catalyst swing trades, thesis and trend exits, ATR trailing stops, 2% risk sizing, three decision sessions a day, Friday desk review.
- Removed V1's forced 30% cash rule, fixed +12%/-10% exits, 10-minute cadence, and Reddit-hype entry trigger.
- Kept: -15% drawdown breaker, hard floor, kill switch, no leverage/options/shorts, data fail-safe, no values filter.
- Starting capital $149.71 (V1 ending balance $49.71 + $100 deposit). Benchmark QQQ 704.39.
- Funding: $100 auto-deposits on the 1st and 15th. Return is tracked time-weighted (NAV per unit) so new money isn't mistaken for performance.
- First regime read (2026-10-24, dry run): NEUTRAL (SPY above its 200-day; QQQ below a falling 50-day).
