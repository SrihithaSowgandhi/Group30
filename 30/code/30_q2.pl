% 30_q2.pl -- P2: Form a Valid Arithmetic Equation (SWI-Prolog)
% Definitions only: no initialization directive, no output.

:- use_module(library(lists)).
:- use_module(library(apply)).

% split_nonempty(List, Left, Right): Left and Right are both non-empty lists and appending Left and Right gives List.
split_nonempty(List, Left, Right) :-
    Left = [_|_],
    Right = [_|_],
    append(Left, Right, List).

% apply_op(Op, A, B, V): V is the integer result of applying Op (one of +, -, *, /) to integers A and B; / requires B =\= 0 and A mod B =:= 0.
apply_op(+, A, B, V) :-
    V is A + B.
apply_op(-, A, B, V) :-
    V is A - B.
apply_op(*, A, B, V) :-
    V is A * B.
apply_op(/, A, B, V) :-
    B =\= 0,
    A mod B =:= 0,
    V is A // B.
