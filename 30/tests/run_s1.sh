#!/bin/sh
# Runs the S1 tests: joins the solution and the test calls, runs racket, compares with the expected output.
# Usage: sh 30/tests/run_s1.sh from the repository root (it works from any folder, it moves to 30/ itself).
cd "$(dirname "$0")/.." || exit 1
cat code/30_q3.rkt tests/s1_calls.rkt > /tmp/s1_test.rkt
racket /tmp/s1_test.rkt > /tmp/s1_actual.txt
if diff /tmp/s1_actual.txt tests/s1_expected.txt > /dev/null; then
  echo "S1: all checks passed"
else
  echo "S1: FAILED, difference (actual vs expected):"
  diff /tmp/s1_actual.txt tests/s1_expected.txt
  exit 1
fi
