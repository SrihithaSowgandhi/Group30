#!/bin/sh
# Tests print-insert-result: joins the solution with the call (print-insert-result), feeds each
# input on standard input and compares the output with the expected text.
# Usage (from the repository root): sh tests/run_s2_stdin.sh
cat code/Group30_q4.rkt > /tmp/s2_stdin.rkt
echo "(print-insert-result)" >> /tmp/s2_stdin.rkt
fail=0

# check(input, expected): runs the program on input and compares the output with expected.
check() {
  actual=$(printf '%s\n' "$1" | racket /tmp/s2_stdin.rkt)
  if [ "$actual" = "$2" ]; then
    echo "PASS: $1"
  else
    echo "FAIL: $1"
    echo "  expected: $2"
    echo "  actual:   $actual"
    fail=1
  fi
}

check "42 ((1 2) (3 4 5) (6) ()) 3" "((42 1 2) (3 4 5) (42 6) (42))"
check "0 (((1) 2) (3) ((4 5 6) ())) 3" "((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))"
check "7 () 3" "(7)"
check "7 () 0" "()"
check "x
(a (b))
5" "(x a (x b))"
check "z (a b c) 0" "(a b c)"

# 10,000 elements read from standard input: with n = 10001 the list is one longer and starts with x.
big=$(seq 1 10000 | tr '\n' ' ')
actual=$(printf 'x (%s) 10001\n' "$big" | racket /tmp/s2_stdin.rkt | cut -c1-12)
if [ "$actual" = "(x 1 2 3 4 5" ]; then echo "PASS: 10,000 elements"; else echo "FAIL: 10,000 elements ($actual)"; fail=1; fi

# Nothing but the result is printed: exactly one line of output.
lines=$(printf '7 () 3\n' | racket /tmp/s2_stdin.rkt | wc -l | tr -d ' ')
if [ "$lines" = "1" ]; then echo "PASS: one output line"; else echo "FAIL: output has $lines lines"; fail=1; fi

if [ "$fail" = "0" ]; then echo "S2 stdin: all checks passed"; else echo "S2 stdin: FAILED"; exit 1; fi
