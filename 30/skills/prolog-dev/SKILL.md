---
name: prolog-dev
description: Use when writing or reviewing SWI-Prolog 9.x code for the logic puzzle (numbered clue/2 predicates, solver, count_solutions/2) or the arithmetic equation generator. Enforces coding conventions, file rules (definitions only, no output at load), test commands and a self-review checklist.
---

# prolog-dev

## 1. Language and version
- Target SWI-Prolog 9.x only. No other Prolog dialects, no ISO-only workarounds.
- Allowed libraries (via `:- use_module(library(...)).`): `lists`, `apply`, `yall`, `aggregate`. Nothing else (no `clpfd`, `dcg/basics`, `strings`, `readutil`, `assoc`, `pairs`, etc.).
- Core built-ins (`findall/3`, `between/3`, `msort/2`, `format/2`, `is/2`, ...) are fine.

## 2. Coding conventions
- Predicate and variable-free atom names are `snake_case`: `count_solutions/2`, `valid_equation/3`. Variables are `CamelCase` or `_`.
- Put a short comment directly above every predicate giving its declarative reading, e.g. `% solution(S): S is an assignment of people to pets satisfying all clues.`
- Puzzle clues: exactly one clause per clue, in the form `clue(N, Solution) :- ...`, numbered in the order of the problem text. Do not merge or split clues.
- Keep the solver declarative: generate candidates with `permutation/2`, `member/2`, `select/3`, then test with clues. Prefer unification of terms (e.g. `person(Name, Pet, Drink)`) over flags or counters.
- `count_solutions(Count)`-style predicates use `findall/3` plus `length/2`; they must not print.
- Quoting: any atom starting with an uppercase letter, containing a special character, or a space must be quoted: `'Alex'`, `'AI'`, `'c++'`, `'Data Science'`. Plain lowercase atoms (`alex`, `python`) need no quotes. Be consistent: the same atom must be written the same way everywhere.
- Equation generator: represent expressions as terms (`add(1,2)`, `1+2`), evaluate with `is/2`; guard against division by zero and keep search bounded with `between/3`.

## 3. File rules
- A file contains only definitions (facts, rules, `:- use_module` lines). Nothing runs when it loads.
- Never call `halt/0` in the file. Never use `:- initialization(...)` in any form.
- Print nothing at load time: no `format/2`, `write/1`, or `print_message/2` directives.
- Do not use `assert*`, `retract*`, `b_setval`, `nb_setval`, or other global state. Compute with arguments and `findall/3`.
- `main/0`, if required, is an ordinary predicate that prints only when called.

## 4. How to run and test
- Run main: `swipl -q -f FILE.pl -g main -t halt`
- Run any other goal: `swipl -q -f FILE.pl -g "GOAL" -t halt`, e.g. `-g "count_solutions(N), format('~w~n', [N])"`.
- Check silent load: `swipl -q -f FILE.pl -g true -t halt` must output nothing at all (no warnings, no text). Any output means a directive, singleton warning or syntax error to fix.
- Check exit status too: `echo $?` should be 0 for success; a failing `-g` goal prints a warning and gives a non-zero status.

## 5. Self-review checklist (apply before answering)
1. Only `lists`, `apply`, `yall`, `aggregate` are imported.
2. No `halt/0`, no `initialization`, no directives that print or run goals.
3. No `assert`, `retract`, `b_setval`, `nb_setval`.
4. Every predicate has a declarative-reading comment above it.
5. One `clue/2` clause per clue, numbered correctly, covering all clues.
6. All atoms that need quotes are quoted (`'Alex'`, `'AI'`, `'c++'`), consistently.
7. No singleton variables; unused ones are `_` or `_Name`.
8. Output uses `format/2` with `~w` and `~n`, never `print/1` for results.
9. No left recursion; recursive predicates have a base case first and a decreasing argument.
10. Cuts are absent or justified in a comment; no cut changes declarative meaning.
11. No string building/parsing (`atom_codes`, `split_string`, `term_to_atom`) where terms suffice.
12. `count_solutions/2` uses `findall/3` and is checked against the expected count (puzzle should usually have exactly 1 solution).
13. Mentally run the silent-load command and one real goal; report any commands you could not run.

## 6. Known AI failure modes in Prolog
- **Missing quotes**: `Alex` is a variable, not an atom, so clues silently over-match. Quote it.
- **`print/1` or `write/1` for output**: use `format("~w~n", [X])`. Remember `format` needs a list of arguments, even for one.
- **Singleton warnings**: they print at load time and break the silent-load rule. Rename to `_`.
- **Left recursion**: `path(X,Y) :- path(X,Z), edge(Z,Y).` loops forever. Put the non-recursive goal first.
- **Cuts**: forgetting `!` after a deterministic base case leaves choice points and duplicate answers; adding `!` inside a generator or clue wrongly drops solutions. Prefer `once/1` or `->` where intent is "first only".
- **Disallowed libraries**: `clpfd`, `dicts`, `strings`, `readutil`, `pairs` creep in. Use `lists` and `apply` equivalents.
- **Strings over terms**: building `"1+2"` then parsing it. Keep expressions as terms and use `is/2`.
- **Unsafe arithmetic**: `=` instead of `is`, unbound variables in `is`, integer division surprises (`/` vs `//`), division by zero.
- **Load-time side effects**: stray `:- main.`, `:- initialization(main).`, or `halt.` at the end of the file.
- **Wrong clue counts**: dropping, merging or renumbering clues; always compare against the problem statement.
- **Claiming it works untested**: state clearly what was and was not run.