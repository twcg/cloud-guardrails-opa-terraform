#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "Running from: $ROOT_DIR"
echo ""

echo "== Baseline (CIS) policies =="
echo "-- bad_s3 (expected to FAIL) --"
conftest test infra/examples/bad_s3/plan.json -p policy/opa/baseline --parser json --all-namespaces || true

echo ""
echo "-- good_s3 (expected to PASS) --"
conftest test infra/examples/good_s3/plan.json -p policy/opa/baseline --parser json --all-namespaces

echo ""
echo "== All policies (baseline + custom) =="
echo "-- bad_s3 (expected to FAIL) --"
conftest test infra/examples/bad_s3/plan.json -p policy/opa --parser json --all-namespaces || true

echo ""
echo "-- good_s3 (expected to PASS) --"
conftest test infra/examples/good_s3/plan.json -p policy/opa --parser json --all-namespaces

echo ""
echo "Done."
