% id_q2.pl -- P2: Form a Valid Arithmetic Equation (SWI-Prolog 9.x)
% Definitions only: no initialization directive, no output.

:- use_module(library(lists)).
:- use_module(library(apply)).

% ---------------------------------------------------------------
% UNIT 1: split/3
% split(List, Left, Right): List is Left followed by Right,
% both non-empty.
% ---------------------------------------------------------------
split(List, Left, Right) :-
    append(Left, Right, List),
    Left  = [_|_],
    Right = [_|_].

% ---------------------------------------------------------------
% UNIT 2: apply_op/4
% apply_op(Op, A, B, V): applying Op to A and B gives integer V.
% Division only succeeds when exact and the divisor is not zero.
% Called with Op unbound, it enumerates all four operators.
% ---------------------------------------------------------------
apply_op(+, A, B, V) :- V is A + B.
apply_op(-, A, B, V) :- V is A - B.
apply_op(*, A, B, V) :- V is A * B.
apply_op(/, A, B, V) :-
    B =\= 0,
    A mod B =:= 0,
    V is A // B.

% ---------------------------------------------------------------
% UNIT 3: expr_value/3
% expr_value(Numbers, Tree, Value): Tree is an expression tree over
% Numbers (in order, each used once) and its value is Value.
% Tree is either an integer or t(Op, LeftTree, RightTree).
% Every division inside the tree is checked by apply_op/4.
% ---------------------------------------------------------------
expr_value([N], N, N).
expr_value(List, t(Op, TL, TR), V) :-
    split(List, L, R),
    expr_value(L, TL, VL),
    expr_value(R, TR, VR),
    apply_op(Op, VL, VR, V).

% ---------------------------------------------------------------
% UNIT 4: canonical printing
% prec/2, needs_paren/3, operand/4, show/2
% ---------------------------------------------------------------
prec(+, 1).
prec(-, 1).
prec(*, 2).
prec(/, 2).

% A left operand is parenthesised only if its operator binds looser
% than the parent; a right operand if it binds looser or equally.
needs_paren(t(Op, _, _), Side, ParentPrec) :-
    prec(Op, P),
    (   Side == left
    ->  P < ParentPrec
    ;   P =< ParentPrec
    ).

operand(Tree, Side, ParentPrec, S) :-
    show(Tree, S0),
    (   needs_paren(Tree, Side, ParentPrec)
    ->  format(string(S), '(~w)', [S0])
    ;   S = S0
    ).

% show(Tree, String): canonical text of an expression tree.
show(N, S) :-
    integer(N), !,
    format(string(S), '~w', [N]).
show(t(Op, L, R), S) :-
    prec(Op, P),
    operand(L, left,  P, LS),
    operand(R, right, P, RS),
    format(string(S), '~w~w~w', [LS, Op, RS]).

% ---------------------------------------------------------------
% UNIT 5: candidate/2
% candidate(List, Eq): Eq is a valid equation string for List.
% For each split point, collect (value, tree) pairs of both sides
% and keep the pairs whose values are equal.
% ---------------------------------------------------------------
candidate(List, Eq) :-
    split(List, L, R),
    findall(V-T, expr_value(L, T, V), LPs),
    findall(V-T, expr_value(R, T, V), RPs),
    member(V-LT, LPs),
    member(V-RT, RPs),
    show(LT, LS),
    show(RT, RS),
    format(string(Eq), '~w=~w', [LS, RS]).

% ---------------------------------------------------------------
% UNIT 6: P2.a generate_equation/2
% One valid equation; fails if none (including lists of length 0/1).
% ---------------------------------------------------------------
generate_equation(List, Equation) :-
    candidate(List, Equation), !.

% ---------------------------------------------------------------
% UNIT 7: P2.b all_equations/2 and count_equations/2
% ---------------------------------------------------------------
all_equations(List, Equations) :-
    findall(E, candidate(List, E), Es0),
    sort(Es0, Equations).

count_equations(List, N) :-
    all_equations(List, Es),
    length(Es, N).