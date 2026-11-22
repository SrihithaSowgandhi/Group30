---
name: scheme-dev
description: Use when writing or reviewing Racket 8.x code in #lang racket/base for the Scheme problems (binary tree traversals and conditional insert into a nested list). Enforces the restricted built-in list, coding conventions, file rules (definitions only, no output at load), test commands and a self-review checklist.
---

# scheme-dev

## 1. Language and version
- Racket 8.x, every file starts with the single line `#lang racket/base`. Never `#lang racket`, never `(require ...)`.
- ONLY these built-ins may be used: `define`, `lambda`, `let`, `let*`, `letrec`, named `let`, `if`, `cond` (with `else`), `and`, `or`, `not`, `begin`, `quote` (written `'`), `cons`, `car`, `cdr`, `list`, all car/cdr compositions up to four levels (`cadr`, `cddr`, `caddr`, `cdddr`, `cadddr`, `cddddr`, ...), `null?`, `pair?`, `eq?`, `assq`, `assoc`, `+ - * < > <= >= =`, `max`, `display`, `newline`. `read` is allowed in the S2 problem only.
- Everything else is forbidden. In particular: `set!` and relatives, vectors, hash tables, strings, `do`, `for`, `length`, `append`, `reverse`, `map`, `filter`, `member`, `memq`, `list-ref`, `list-tail`, and also `equal?`, `eqv?`, `list?`, `zero?`, `add1`, `sub1`, `when`, `unless`, `case`, `printf`, `format`, `write`, `print`. If a helper like these is needed, write it yourself with a `my-` prefix (`my-length`, `my-append`, `my-reverse`, `my-map`).

## 2. Coding conventions
- Names are kebab-case: `print-inorder`, `my-length`, `make-inserter`. Predicates end in `?`.
- A short comment directly above every function gives its meaning and its recursive reading, e.g. `; (my-length lst): 0 for '(), otherwise 1 plus the length of (cdr lst).`
- One function per task; small helpers instead of one big function.
- Pass all state through arguments (accumulators). No mutation, no global state.
- Prefer tail recursion with an accumulator where natural; build lists in reverse and fix with `my-reverse` only when needed. Large inputs (depth 100, 10,000 elements) must work.
- Atoms: `(not (pair? x))` and `(not (null? x))`. The empty list is `'()`.

## 3. File rules
- The file contains only definitions. Do not call any function at top level and do not print anything when the file loads: the grader appends its own calls at the end.
- Output uses `display` and `newline` only. Every printing function ends its output with a newline.

## 4. How to run and test
- Run a file: `racket FILE.rkt`. Loading the solution on its own must print nothing and exit with status 0.
- To test, keep the calls in a separate test file and join them to the solution: `cat code/FILE.rkt tests/CALLS.rkt > /tmp/t.rkt && racket /tmp/t.rkt`, then compare the output with the expected text.
- For stdin problems: `echo "42 ((1 2) (3 4 5) (6) ()) 3" | racket /tmp/t.rkt`.

## 5. Self-review checklist (apply before answering)
1. First line is `#lang racket/base` and there is no `require`.
2. Every identifier used is in the allowed list or defined in the file (scan for `length`, `append`, `map`, `reverse`, `equal?`, `when`, `format`).
3. No `set!`, vectors, hash tables, strings or loops.
4. Nothing is called or printed at top level.
5. Every function has a comment with its recursive reading, and has a base case for `'()`.
6. Empty tree/list handled: height of `'()` is 0, leaves of `'()` is 0, `'()` has length 0.
7. Left subtree/element is visited before right.
8. Output uses `display`, and each printing function ends with `newline`.
9. Checked against every example in the problem text, plus the empty case.
10. No hidden quadratic behaviour on 10,000 elements.
11. State clearly what was actually run and what was not.

## 6. Known AI failure modes in Scheme/Racket
- **Using forbidden built-ins**: `length`, `append`, `map`, `reverse`, `filter`, `member`, `list-ref` appear out of habit. Write `my-` versions.
- **Unlisted helpers**: `equal?`, `zero?`, `add1`, `when`, `unless`, `case`, `let-values`, `list?`, `format`, `printf`.
- **`#lang racket` instead of `#lang racket/base`**, or adding `(require racket/list)`.
- **Printing wrongly**: `print`/`write` instead of `display`, forgetting the final `newline`, printing a prompt, or printing during load.
- **Top-level calls**: leaving a test call like `(print-inorder t1)` in the file.
- **Wrong tree conventions**: height of `()` as 1, counting the empty tree as a leaf, visiting right before left.
- **Treating `()` as an atom** or `(pair? '())` as true in S2; length measured after insertion instead of on the original list.
- **Deep non-tail recursion on huge input**: use accumulators where possible.
- **Mutation**: `set!`, `set-car!` or vectors for accumulating results.
- **Claiming it works untested**: state exactly what was run.
