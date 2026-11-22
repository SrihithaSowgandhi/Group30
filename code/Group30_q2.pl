:- use_module(library(lists)).

% split_nonempty(List, Left, Right): Left and Right are both non-empty lists and appending Left and Right gives List.
split_nonempty(List, Left, Right) :-
    Left = [_|_],
    Right = [_|_],
    append(Left, Right, List).