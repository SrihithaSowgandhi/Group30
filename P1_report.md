# P1 Report: Department Assignment Puzzle

## What we did

We wrote the puzzle in Prolog by generating every possible assignment of
departments, languages and projects to the four friends, then using the clues
to filter out the ones that don't fit. Each clue is its own `clue(N, Solution)`
clause, and `count_solutions(Active, N)` counts how many assignments survive a
chosen set of clues.

## The answer to P1.b

With clues 1 to 8, **N = 3**.

As a sanity check, with no clues at all `count_solutions([], N)` gives 13824,
which is 4! x 4! x 4!, one ordering each for departments, languages and
projects. So the counting itself behaves correctly.

## What N = 3 tells us

Two things. First, the clues don't contradict each other, because if they did
N would be 0. Second, they aren't enough to pin down one answer, because N is
bigger than 1. As originally written, the puzzle has three valid solutions, so
it isn't a properly set puzzle. A well-formed one should have exactly one.

The three solutions (Alex, Ben, Carla, Dana, each as department, language,
project):

- **X:** Alex (design, java, AI), Ben (development, javascript, web),
  Carla (research, c++, data), Dana (testing, python, embedded)
- **Y:** Alex (design, java, embedded), Ben (development, javascript, web),
  Carla (testing, python, AI), Dana (research, c++, data)
- **Z:** Alex (testing, python, embedded), Ben (development, javascript, web),
  Carla (design, java, AI), Dana (research, c++, data)

## The repair (P1.c)

Our ninth clue is:

> The friend who prefers embedded projects works in the design department.

In Y the embedded friend is in design. In X and Z the embedded friend is in
testing. So clue 9 is true only in Y and false in the other two, and
`count_solutions([1,2,3,4,5,6,7,8,9], N)` gives **N = 1**.

The clue can't mention anyone by name, and that limited our choices. X and Z
turn out to contain exactly the same four combinations of department, language
and project, just with different names attached. A clue that only talks about
attribute values can't tell them apart, so the clue had to keep Y, whose
combinations are different. That is why we targeted the embedded friend's
department.

## Final result

`main` prints the unique solution:

    Alex = [design, java, embedded]
    Ben = [development, javascript, web]
    Carla = [testing, python, AI]
    Dana = [research, c++, data]

## Notes

- Everything is derived from the clues. Nothing in the answer is hard-coded.
- The file uses no `assert`, `retract` or global variables, and prints nothing
  when it loads.
- The first version of our file had a duplicate `candidate_solution/1` and
  clauses in the wrong order. We found them from the load warnings and fixed
  them, which would otherwise have inflated the counts.