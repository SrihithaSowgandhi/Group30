# Group 30: Principles of Programming Languages, Assignment 2

Logic and functional programming: two Prolog problems (P1, P2) and two Scheme problems (S1, S2).
Everything is in the folder `30/`.

## Layout

| Path | Contents |
|---|---|
| `30/code/` | `30_q1.pl` (P1), `30_q2.pl` (P2), `30_q3.rkt` (S1), `30_q4.rkt` (S2) |
| `30/tests/` | our own tests, one set per problem (see below) |
| `30/skills/` | the skill files `prolog-dev/SKILL.md` and `scheme-dev/SKILL.md` |
| `30/prompts/` | the prompts used, one file per problem: `P1.md`, `P2.md`, `S1.md`, `S2.md` |
| `30/P1_REPORT.md` | the value of N asked for in P1.b and what it tells us about the puzzle |

## Running the code

    swipl -q -f 30/code/30_q1.pl -g main -t halt
    racket 30/code/30_q3.rkt
    racket 30/code/30_q4.rkt

The Scheme files and the Prolog files only contain definitions, so loading them prints nothing.

## Running the tests (from the repository root)

| Problem | Command | Passing result |
|---|---|---|
| P1 | `swipl -q -f 30/tests/p1_tests.pl -g run_tests -t halt` | last line: `SUMMARY: 23 of 23 checks passed` |
| S1 | `sh 30/tests/run_s1.sh` | `S1: all checks passed` |
| S2 | `sh 30/tests/run_s2.sh` | `S2: all checks passed` |
| S2 (standard input) | `sh 30/tests/run_s2_stdin.sh` | `S2 stdin: all checks passed` |

The Scheme tests join the solution file with a file of test calls (`s1_calls.rkt`, `s2_calls.rkt`)
and compare the output with the expected text (`s1_expected.txt`, `s2_expected.txt`).
