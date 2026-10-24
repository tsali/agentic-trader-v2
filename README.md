# Agentic Trader V2: The Trading Desk

V2 of the [$50 Agentic Trader](https://github.com/tsali/50-dollar-agentic-trader): an AI agent trading a small, real Robinhood brokerage account, with every rule and trade kept in public.

V1 proved the harness worked. Over about 10 weeks it made 164 trades with zero blow-ups, every rule honored, and a full audit trail. It also went flat: **+1.42%** while QQQ ran about +5%. The [V1 post-mortem](https://github.com/tsali/50-dollar-agentic-trader/blob/main/POSTMORTEM.md) explains why. It traded like a day-trader on social-media hype, checked every 10 minutes, kept 30% cash idle by rule, and exited on fixed numbers. Lots of churn, not much conviction.

V2 changes the mandate from "behave safely" to **make money and beat QQQ**, by thinking like a portfolio manager instead of a scalper.

## How V2 thinks

- **Regime first.** Every morning it asks whether SPY is above its 200-day average and whether QQQ is trending up. Risk-on means fully invested. Neutral means about 60% invested. Risk-off means mostly cash, chosen on purpose rather than forced by a rule.
- **Core plus satellites.** About 60% rides the single strongest-trending ETF (QQQ, SPY, or a sector ETF). It rotates only when a new leader wins clearly, two sessions in a row. The other ~40% goes to 1 to 3 swing trades held for days to weeks.
- **Catalysts, not hype.** A swing trade needs a real catalyst (an earnings beat, an upgrade, a business event, a volume breakout) plus relative strength against its sector and QQQ. Reddit chatter is only one input.
- **Exits on the thesis.** It sells when the stop hits, the trend breaks, the reason for buying is gone, the position lags the market, a better setup needs the cash, or the regime turns. There is no fixed "+12% and out." Winners run on a volatility-based (ATR) trailing stop.
- **Risk-based sizing.** Each swing trade risks about 2% of the account, more for high conviction and less for speculative ones.
- **Less screen time.** It makes decisions three times a day (open, midday, close) instead of every 10 minutes, and sends a desk review every Friday.

Kept from V1: a drawdown breaker (down 15% from peak means everything goes to cash and the bot halts), a hard floor, a kill switch, no leverage, options, shorts, or crypto, a fail-safe that does nothing on bad data, full logging, and **no values filter**. The agent can buy anything in the market.

The full rulebook the agent runs on is **[STRATEGY.md](STRATEGY.md)**, with the account number redacted. The runner is [trader_v2.sh](trader_v2.sh).

## Status

| | |
|---|---|
| Start | 2026-10-24 |
| Starting capital | $149.71 (V1's ending $49.71 plus a $100 deposit). Deposits are never counted as profit |
| Benchmark | QQQ from 704.39 (Friday 2026-10-23 close) |
| Funding | $100 auto-deposit on the 1st and 15th. Performance is time-weighted (NAV per unit, like a fund), so deposits never inflate the return |
| Mode | LIVE from the first session (Monday 2026-10-26, 8:40 CT) |

Changes to the rules are logged in [CHANGELOG.md](CHANGELOG.md), and trades in [TRADES.md](TRADES.md).

## Honest caveats

Small accounts get hurt by fractional fills and the bid/ask spread no matter how good the strategy is. One good month is noise. Beating QQQ over 6 to 12 months is the bar. If V2 trails QQQ badly over 6 months, the strategy is wrong, and this repo will say so.

This is an experiment, not financial advice.
