#!/usr/bin/env bash
set -euo pipefail

conftest test infra/examples/bad_s3/plan.json -p policy/opa --parser json --all-namespaces
conftest test infra/examples/good_s3/plan.json -p policy/opa --parser json --all-namespaces
