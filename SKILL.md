---
name: arc-x402
description: Access AIsa x402-paid /apis/v2/ endpoints using Arc testnet USDC and Circle Gateway. Use when setting up x402 payments, creating or funding an Arc wallet, depositing into Circle Gateway, or making paid AIsa API calls without an API key.
---

# arc-x402

Use this skill for operational work with AIsa x402-paid endpoints.

## Files

- `scripts/check-env.sh` — verify local prerequisites, environment variables, and connectivity
- `scripts/setup.mjs` — check balance, approve ERC-20 USDC, and deposit into Circle Gateway
- `scripts/x402_client.mjs` — make paid x402 API requests
- `references/setup.md` — environment and runtime guidance
- `references/troubleshooting.md` — common failures and fixes

## Workflow

1. Run `scripts/check-env.sh` first.
2. If the wallet is not ready, use `scripts/setup.mjs`.
3. If the user wants to make a paid request, use `scripts/x402_client.mjs`.
4. Read `references/troubleshooting.md` if payment or signature errors occur.

## Guardrails

- Do not confuse `/apis/v1/` API-key endpoints with `/apis/v2/` x402-paid endpoints.
- Do not tell users to transfer USDC directly to the Gateway contract; they must call `deposit()`.
- Expect OpenClaw runtime environments to differ from an interactive shell. An env var exported in a terminal may not be visible to the running agent process.
- Prefer these mnemonic sources, in order: `OWS_MNEMONIC`, `X402_MNEMONIC`, `--mnemonic-env`, `--mnemonic`.

## Typical commands

```bash
bash scripts/check-env.sh
node scripts/setup.mjs balance
node scripts/setup.mjs approve
node scripts/setup.mjs deposit --amount 5
node scripts/x402_client.mjs POST "https://api.aisa.one/apis/v2/scholar/search/scholar?query=bitcoin" --body '{}'
```
