:- consult('../code/30_q2.pl').

check(Name, Goal) :-
    (   catch(Goal, _, fail)
    ->  format("PASS ~w~n", [Name])
    ;   format("FAIL ~w~n", [Name])
    ).

run_p2_tests :-
    check(example_4253, (all_equations([4,2,5,3], Es),
          Es == ["4*2-5=3","4*2=5+3","4-2=5-3","4/2=5-3",
                 "4=2*(5-3)","4=2+(5-3)","4=2+5-3"])),
    check(example_248, all_equations([2,4,8], ["2*4=8"])),
    check(no_solution_gen, \+ generate_equation([2,3,4], _)),
    check(no_solution_all, all_equations([2,3,4], [])),
    check(empty_list, \+ generate_equation([], _)),
    check(single_number, \+ generate_equation([5], _)),
    check(count, count_equations([4,2,5,3], 7)),
    check(gen_is_string_and_valid,
          (generate_equation([4,2,5,3], G), string(G),
           all_equations([4,2,5,3], L), memberchk(G, L))),
    check(zeros, all_equations([0,0], ["0=0"])),
    check(division, all_equations([6,3,2], ["6/3=2","6=3*2"])).