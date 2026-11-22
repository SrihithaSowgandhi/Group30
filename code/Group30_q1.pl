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

% clue(4, Solution): in Solution, Bens project is web and Ben does not work
% in testing.
clue(4, Solution) :-
    member(p('Ben', Dept, _, web), Solution),
    Dept \= testing.

:- use_module(library(lists)).


% clue(5, Solution): in Solution, the friend whose favorite language is Java
% works in the design department.
clue(5, Solution) :-
    member(p(_, design, java, _), Solution).

% clue(6, Solution): in Solution, Carlas project is not embedded and
% Carla does not work in development.
clue(6, Solution) :-
    member(p('Carla', Dept, _, Project), Solution),
    Project \= embedded,
    Dept \= development.

% clue(7, Solution): in Solution, Danas favorite language is not Java and
% she works in research or testing.
clue(7, Solution) :-
    member(p('Dana', Dept, Lang, _), Solution),
    Lang \= java,
    ( Dept = research ; Dept = testing ).

% clue(8, Solution): in Solution, the friend whose project is data works in
% research and does not use JavaScript.
clue(8, Solution) :-
    member(p(_, research, Lang, data), Solution),
    Lang \= javascript.