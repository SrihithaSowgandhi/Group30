% 30_q2.pl -- P2: Form a Valid Arithmetic Equation (SWI-Prolog)
% Definitions only: no initialization directive, no output.

:- use_module(library(lists)).
:- use_module(library(apply)).

% split_nonempty(List, Left, Right): Left and Right are both non-empty lists and appending Left and Right gives List.
split_nonempty(List, Left, Right) :-
    Left = [_|_],
    Right = [_|_],
    append(Left, Right, List).
