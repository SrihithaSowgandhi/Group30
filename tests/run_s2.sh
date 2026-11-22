#!/bin/sh
# Runs the S2 tests: joins the solution and the test calls, runs racket, compares with the expected output.
# Usage (from the repository root): sh tests/run_s2.sh
cat code/Group30_q4.rkt tests/s2_calls.rkt > /tmp/s2_test.rkt
racket /tmp/s2_test.rkt > /tmp/s2_actual.txt
if diff /tmp/s2_actual.txt tests/s2_expected.txt > /dev/null; then
  echo "S2: all checks passed"
else
  echo "S2: FAILED, difference (actual vs expected):"
  diff /tmp/s2_actual.txt tests/s2_expected.txt
  exit 1
fi
