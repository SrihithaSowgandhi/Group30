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

% expr_value(Numbers, Tree, Value): Tree is an expression tree over Numbers,
% using each number once and in order, and Value is the value of Tree.
% A single number is its own tree and value; otherwise Numbers splits into
% two non-empty parts, each with its own tree and value, combined by an operator.
expr_value([N], N, N).
expr_value(Numbers, t(Op, L, R), Value) :-
    split_nonempty(Numbers, Left, Right),
    expr_value(Left, L, LV),
    expr_value(Right, R, RV),
    apply_op(Op, LV, RV, Value).

% prec(Op, P): P is the precedence level of operator Op: 1 for + and -, 2 for * and /.
prec(+, 1).
prec(-, 1).
prec(*, 2).
prec(/, 2).

% show_left(Tree, ParentPrec, String): String is the string of Tree from show/2,
% wrapped in parentheses exactly when Tree is t(Op,_,_) whose precedence is lower than ParentPrec.
show_left(Tree, ParentPrec, String) :-
    show(Tree, S0),
    (   Tree = t(Op, _, _),
        prec(Op, Q),
        Q < ParentPrec
    ->  format(string(String), '(~w)', [S0])
    ;   String = S0
    ).

% show_right(Tree, ParentPrec, String): String is the string of Tree from show/2,
% wrapped in parentheses exactly when Tree is t(Op,_,_) whose precedence is lower than or equal to ParentPrec.
show_right(Tree, ParentPrec, String) :-
    show(Tree, S0),
    (   Tree = t(Op, _, _),
        prec(Op, Q),
        Q =< ParentPrec
    ->  format(string(String), '(~w)', [S0])
    ;   String = S0
    ).

% show(Tree, String): String is the space-free canonical string of Tree; an integer is its
% decimal form, and t(Op,L,R) is the left string, then Op, then the right string, with
% parentheses added by show_left/3 and show_right/3.
show(Tree, String) :-
    integer(Tree),
    format(string(String), '~d', [Tree]).
show(t(Op, L, R), String) :-
    prec(Op, P),
    show_left(L, P, LS),
    show_right(R, P, RS),
    format(string(String), '~w~w~w', [LS, Op, RS]).

% candidate(Numbers, Equation): Equation is the string "L=R" where Numbers splits into two
% non-empty parts, each part has an expression tree, and both trees have the same value.
candidate(Numbers, Equation) :-
    split_nonempty(Numbers, Left, Right),
    expr_value(Left, LTree, Value),
    expr_value(Right, RTree, Value),
    show(LTree, LS),
    show(RTree, RS),
    format(string(Equation), '~w=~w', [LS, RS]).

% generate_equation(List, Equation): Equation is one valid equation string for List,
% namely the first solution of candidate/2; it fails if candidate/2 has none.
generate_equation(List, Equation) :-
    once(candidate(List, Equation)).

% all_equations(List, Equations): Equations is the duplicate-free list, sorted by sort/2,
% of all strings E such that candidate(List, E) holds; it is [] when there are none.
all_equations(List, Equations) :-
    findall(E, candidate(List, E), Es),
    sort(Es, Equations).

% count_equations(List, N): N is the number of elements of the list of all valid equations for List,
% as given by all_equations/2; it is 0 when there are none.
count_equations(List, N) :-
    all_equations(List, Equations),
    length(Equations, N).
