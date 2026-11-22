## Prompt 1: prolog-dev skill file

I am working on an assignment for Principles of Programming Languages that allows to use generative AI. Please write one skill file: skills/prolog-dev/SKILL.md.

A skill file is a reusable instruction pack for an AI assistant. It must begin with a YAML header containing name (prolog-dev) and description, followed by instructions in Markdown.

The skill file is for writing SWI-Prolog 9.x code for two problems: a logic puzzle with numbered clues (clue(N, Solution) predicates, a solver, and a count_solutions/2 predicate using findall/3) and an arithmetic equation generator. It must contain these sections:

1. Language and version: SWI-Prolog 9.x. Allowed libraries are only lists, apply, yall and aggregate.
2. Coding conventions: naming (snake_case predicates), a short comment above every predicate giving its declarative reading, one clause per clue, and quoting rules for atoms such as 'Alex', 'c++' and 'AI'.
3. File rules: files contain only definitions. Never call halt/0, never use any initialization directive, and print nothing when the file loads. Do not use assert, retract, or global variables (b_setval, nb_setval).
4. How to run and test: swipl -q -f FILE.pl -g main -t halt, and swipl -q -f FILE.pl -g "GOAL" -t halt for other predicates, with a note on how to check that nothing prints at load time.
5. Self-review checklist the AI must apply before answering, as a numbered list.
6. Known failure modes of AI tools when writing Prolog, such as forgetting quotes on atoms, using print/1 instead of format/2 with ~w, singleton variable warnings, accidental infinite loops from left recursion, forgetting cuts or using them wrongly, using libraries that are not allowed, and building then parsing strings instead of working with terms.

Keep it practical and under about 100 lines. Return only the contents of the file.