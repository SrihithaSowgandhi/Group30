#!/bin/sh
# Runs the S1 tests: joins the solution and the test calls, runs racket, compares with the expected output.
# Usage (from the repository root): sh tests/run_s1.sh
cat code/Group30_q3.rkt tests/s1_calls.rkt > /tmp/s1_test.rkt
racket /tmp/s1_test.rkt > /tmp/s1_actual.txt
if diff /tmp/s1_actual.txt tests/s1_expected.txt > /dev/null; then
  echo "S1: all checks passed"
else
  echo "S1: FAILED, difference (actual vs expected):"
  diff /tmp/s1_actual.txt tests/s1_expected.txt
  exit 1
fi
