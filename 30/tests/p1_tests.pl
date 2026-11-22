% Loads the solution file, resolved relative to this test file.
:- consult('../code/30_q1.pl').

% good_solution(S): S is the unique intended solution of the puzzle, so it satisfies clues 1 to 9.
good_solution([p('Alex', design, java, embedded),
               p('Ben', development, javascript, web),
               p('Carla', testing, python, 'AI'),
               p('Dana', research, 'c++', data)]).

% bad_solution(N, S): S is a hand-written solution that violates clue N.
bad_solution(1, [p('Alex', design, java, embedded),
                 p('Ben', development, javascript, web),
                 p('Carla', testing, python, data),
                 p('Dana', research, 'c++', 'AI')]).
bad_solution(2, [p('Alex', development, java, embedded),
                 p('Ben', design, javascript, web),
                 p('Carla', testing, python, 'AI'),
                 p('Dana', research, 'c++', data)]).
bad_solution(3, [p('Alex', design, python, embedded),
                 p('Ben', development, javascript, web),
                 p('Carla', testing, java, 'AI'),
                 p('Dana', research, 'c++', data)]).
bad_solution(4, [p('Alex', design, java, web),
                 p('Ben', development, javascript, embedded),
                 p('Carla', testing, python, 'AI'),
                 p('Dana', research, 'c++', data)]).
bad_solution(5, [p('Alex', testing, java, embedded),
                 p('Ben', development, javascript, web),
                 p('Carla', design, python, 'AI'),
                 p('Dana', research, 'c++', data)]).
bad_solution(6, [p('Alex', design, java, 'AI'),
                 p('Ben', development, javascript, web),
                 p('Carla', testing, python, embedded),
                 p('Dana', research, 'c++', data)]).
bad_solution(7, [p('Alex', design, 'c++', embedded),
                 p('Ben', development, javascript, web),
                 p('Carla', testing, python, 'AI'),
                 p('Dana', research, java, data)]).
bad_solution(8, [p('Alex', design, java, embedded),
                 p('Ben', research, javascript, web),
                 p('Carla', testing, python, 'AI'),
                 p('Dana', development, 'c++', data)]).
bad_solution(9, [p('Alex', development, java, embedded),
                 p('Ben', design, javascript, web),
                 p('Carla', testing, python, 'AI'),
                 p('Dana', research, 'c++', data)]).

% expected_output(Out): Out is the exact text main/0 must print.
expected_output("Alex = [design, java, embedded]\nBen = [development, javascript, web]\nCarla = [testing, python, AI]\nDana = [research, c++, data]\n").

% clue_case(Kind, N, Goal): Goal checks clue N on a satisfying (holds) or violating (violated) solution.
clue_case(holds, N, clue(N, S)) :-
    good_solution(S).
clue_case(violated, N, \+ clue(N, S)) :-
    bad_solution(N, S).

% main_output_matches: the text printed by main/0 equals the expected four lines exactly.
main_output_matches :-
    with_output_to(string(Out), main),
    expected_output(Expected),
    Out == Expected.

% test(Description, Goal): Goal is one check, described by Description.
test(Desc, Goal) :-
    between(1, 9, N),
    member(Kind, [holds, violated]),
    clue_case(Kind, N, Goal),
    format(atom(Desc), 'clue ~w ~w', [N, Kind]).
test('satisfies_clues([], S) succeeds for every candidate',
     forall(candidate_solution(S), satisfies_clues([], S))).
test('count_solutions([], N) gives 13824',
     ( count_solutions([], N), N =:= 13824 )).
test('count_solutions([1,2,3,4,5,6,7,8], N) gives 3',
     ( count_solutions([1,2,3,4,5,6,7,8], N), N =:= 3 )).
test('count_solutions([1,2,3,4,5,6,7,8,9], N) gives 1',
     ( count_solutions([1,2,3,4,5,6,7,8,9], N), N =:= 1 )).
test('main/0 prints exactly the four expected lines',
     main_output_matches).

% run_check(Goal, Result): Result is pass if Goal succeeds without error, otherwise fail.
run_check(Goal, Result) :-
    (   catch(\+ \+ call(Goal), _, fail)
    ->  Result = pass
    ;   Result = fail
    ).

% report(Result, Desc): prints one PASS or FAIL line for the check Desc.
report(pass, Desc) :-
    format('PASS: ~w~n', [Desc]).
report(fail, Desc) :-
    format('FAIL: ~w~n', [Desc]).

% run_tests: runs all checks, prints one line per check and a final summary line.
run_tests :-
    findall(Desc-Result, (test(Desc, Goal), run_check(Goal, Result)), Results),
    forall(member(Desc-Result, Results), report(Result, Desc)),
    findall(D, member(D-pass, Results), Passed),
    length(Passed, PassCount),
    length(Results, Total),
    format('SUMMARY: ~w of ~w checks passed~n', [PassCount, Total]).