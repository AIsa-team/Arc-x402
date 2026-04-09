#!/usr/bin/env bash
set -euo pipefail
BASE_URL="${AISA_X402_BASE_URL:-https://api.aisa.one}"
RPC_URL="${OWS_RPC_URL:-${ARC_RPC_URL:-https://rpc.testnet.arc.network}}"

echo "== cwd =="
pwd

echo
echo "== binaries =="
for bin in node npm curl; do
  if command -v "$bin" >/dev/null 2>&1; then
    echo "ok: found $bin"
  else
    echo "missing: $bin"
  fi
done

echo
echo "== env =="
if [ -n "${OWS_MNEMONIC:-}" ]; then
  echo "ok: OWS_MNEMONIC is set"
elif [ -n "${X402_MNEMONIC:-}" ]; then
  echo "ok: X402_MNEMONIC is set"
else
  echo "missing: OWS_MNEMONIC or X402_MNEMONIC"
fi

echo
echo "== network =="
echo "API base: $BASE_URL"
echo "RPC url:  $RPC_URL"
API_CODE=$(curl --http1.1 -sS -o /tmp/arc_x402_api_probe.txt -w "%{http_code}" "$BASE_URL/health" || true)
echo "api health status: ${API_CODE:-unreachable}"
RPC_RES=$(curl -sS -X POST -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}' "$RPC_URL" || true)
echo "rpc chain probe: $RPC_RES"

echo
echo "== deps =="
for pkg in @x402/fetch @x402/evm viem; do
  if [ -d "node_modules/${pkg}" ] || npm ls "$pkg" >/dev/null 2>&1; then
    echo "ok: $pkg installed"
  else
    echo "missing: $pkg"
  fi
done
