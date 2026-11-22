:- use_module(library(lists)).

% candidate_solution(S): S is a list of four terms p(Name, Dept, Lang, Project), in the order
% 'Alex', 'Ben', 'Carla', 'Dana', where the departments, languages and projects are each
% a permutation of their four values (every value is used exactly once).
candidate_solution([p('Alex', D1, L1, P1),
                    p('Ben', D2, L2, P2),
                    p('Carla', D3, L3, P3),
                    p('Dana', D4, L4, P4)]) :-
    permutation([research, development, design, testing], [D1, D2, D3, D4]),
    permutation([python, java, 'c++', javascript], [L1, L2, L3, L4]),
    permutation(['AI', web, embedded, data], [P1, P2, P3, P4]).

% clue(1, Solution): in Solution, the friend whose project is 'AI' is not Dana
% and does not work in research.
clue(1, Solution) :-
    member(p(Name, Dept, _, 'AI'), Solution),
    Name \= 'Dana',
    Dept \= research.

% clue(2, Solution): in Solution, Alex does not work in development
% and does not prefer C++.
clue(2, Solution) :-
    member(p('Alex', Dept, Lang, _), Solution),
    Dept \= development,
    Lang \= 'c++'.

% clue(3, Solution): in Solution, the friend working in the testing department
% likes Python.
clue(3, Solution) :-
    member(p(_, testing, python, _), Solution).