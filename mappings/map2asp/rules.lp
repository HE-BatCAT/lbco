% Clingo (https://potassco.org/clingo/) calls

%*
$ clingo optimization_example.lp comparison_example_problem.lp
$ clingo optimization_example.lp resource_allocation_example_problem.lp
*%

% ----------------------------------------------------------------------------
% Selection part for COMPARISON_EXAMPLE_PROBLEM

% Determine the attributes/values V participating in qualitative constraints C of a selection problem P

qualitative_constraint(P,C)   :- solve("select",P,M,N),
                                 property(P,"has_part",C),
                                 entity(C,"qualitative_constraint").
qualitative_constraint(P,C,V) :- qualitative_constraint(P,C),
                                 property(C,"has_part",V).

% Determine the entities (methods) E compatible with all qualitative constraints C for problem P

selectable(P,C,E,Y,V) :- qualitative_constraint(P,C,V),
                         entity(E,X),
                         property(E,Y,V),
                         not qualitative_constraint(P,E,V).
selectable(P,C,E)     :- selectable(P,C,E,Y,V).
selectable(P,E)       :- solve("select",P,M,N),
                         entity(E,X),
                         selectable(P,C,E) : qualitative_constraint(P,C).

% Select an appropriate number of compatible entities E for problem P

M {select(P,E) : selectable(P,E)} N :- solve("select",P,M,N).

% Determine the optimization target(s) C for problem P

target(P,C) :- solve("select",P,M,N),
               property(P,"has_part",C),
               entity(C,"target").
target(P,C) :- target(P,C'),
               property(C',"has_part",C),
               entity(C,"target").

% Map attributes of optimization target(s) C associated with compatible entities E for problem P to integer values V

property_target(P,C,Y,M,N) :- target(P,C),
                              property(C,Y,X,M,N).
property_target(P,C,Y)     :- property_target(P,C,Y,M,N).

possible_target(P,C,E,Y) :- property_target(P,C,Y,M,N),
                            selectable(P,E),
                            M <= #count{V : property(E,Y,V)} <= N.
possible_target(P,C,E)   :- possible_target(P,C,E,Y).

eventual_target(P,C,E)   :- possible_target(P,C,E),
                            possible_target(P,C,E,Y) : property_target(P,C,Y).
eventual_target(P,C,E,V) :- eventual_target(P,C,E),
                            V = #min{V' : possible_target(P,C,E,Y), property(E,Y,V');
                                     V' : possible_target(P,C,E,Y), property(E,Y,V''), sameAs(V'',V');
                                     V' : possible_target(P,C,E,Y), property(E,Y,V''), sameAs(V',V'')}.

% Determine scores I*V (minimization/maximization when polarity I is 1/-1) of optimization target(s) C associated with a selected entity E at optimization level L (greater integer levels stand for higher importance) for problem P

score(P,C,E,I*V,L) :- select(P,E),
                      eventual_target(P,C,E,V),
                      property(C,"has_priority",L),
                      property(C,"has_polarity",I).

% Optimize the scores S of optimization target(s) C at levels L associated with selected entities E for problem P

:~ score(P,C,E,S,L). [S@L,P,C,E]

% ----------------------------------------------------------------------------
% Scheduling part for RESOURCE_ALLOCATION_EXAMPLE_PROBLEM

% Trace process(es) O to complete back to predecessors O' for problem P

process(P,O,O,M,N)  :- solve("schedule",P,M,N),
                       property(P,"has_part",G),
                       entity(G,"goal"),
                       property(G,"has_part",O).
process(P,O,O',M,N) :- process(P,O,O'',M,N),
                       property(O'',"followsdirectly",O').
process(O,O')       :- process(P,O,O',M,N).
process(O')         :- process(O,O').

% Number K of processes that need to be performed (at most) for problem P

processes(P,K) :- process(P,O'',O'',M',N'),
                  K = #sum+{N,O,O' : process(P,O,O',M,N)}.

% Number K of processes that need to be performed after O' for problem P

succeeds(O,O,0)  :- process(O,O).
succeeds(O,O',K) :- succeeds(O,O'',K-1),
                    property(O'',"followsdirectly",O').
succeeds(O,K)    :- succeeds(O,O',K).

% Number K of processes needed to complete O for problem P

previous(O,K) :- succeeds(O,K-1),
                 not succeeds(O,K).

% J-th instance of process O' needed to complete O may be performed at steps between K1 and K2 for problem P

possible(P,O,O',J,K1,K2) :- process(P,O,O',M,N), J = 1..N,
                            processes(P,K),
                            succeeds(O,O',K'),
                            previous(O,K''), K1 = K''-K',
                            K2 = K+(J-N-1)*(K'+1)+1.
possible(P,1..K)         :- processes(P,K).

% Associate process O with itself as well as used method O' (if any)

constituent(O,O)  :- process(O).
constituent(O,O') :- constituent(O,O''),
                     property(O'',"uses_method",O').

% Calculate quantity between M and N of entities T participating in process O

participant(O,O',T,M,N) :- constituent(O,O'),
                           property(O',"has_participant",T,M,N).
participant(O,T)        :- participant(O,O',T,M,N).
participant(O,T,M,N)    :- participant(O,T),
                           M = #sum+{M',O' : participant(O,O',T,M',N')},
                           N = #sum+{N',O' : participant(O,O',T,M',N')}.

% Number N of allocatable entities T for problem P (if their available quantity is constrained)

allocatable(P,T,M,N) :- possible(P,1),
                        property(P,"has_part",C),
                        property(C,"has_participant",T,M,N).
allocatable(P,T,N)   :- allocatable(P,T,M,N).

% Schedule instance J of process O' needed to complete O to a possible step for problem P

{schedule(P,O,O',J,K1..K2)} 1 :- possible(P,O,O',J,K1,K2).

schedule(P,O,O',J) :- schedule(P,O,O',J,K).

% Minimum number of instances of process O' needed to complete O must be scheduled for problem P

:- process(P,O,O',M,N), J = 1..M,
   not schedule(P,O,O',J).

% Schedule optional instances of a process O to complete and its predecessors in consecutive order for problem P

schedule(P,O,J) :- process(P,O,O',M,N),
                   schedule(P,O,O,J), M < J.

:- process(P,O,O',M,N),
   schedule(P,O,J+1), M < J,
   not schedule(P,O,J).
:- process(P,O,O',M,N), O' != O,
   schedule(P,O,J), M < J,
   not schedule(P,O,O',J).
:- process(P,O,O',M,N), O' != O,
   schedule(P,O,O',J), M < J,
   not schedule(P,O,J).

% Instances J of process O' needed to complete O must be scheduled after their predecessors (if any) and in consecutive order for problem P

unschedule(P,O,O',J,K,K1) :- schedule(P,O,O'',J,K),
                             possible(P,O,O',J,K1,K2), K1 <= K,
                             property(O',"followsdirectly",O'').
unschedule(P,O,O',J,K,K1) :- schedule(P,O,O',J-1,K+1),
                             possible(P,O,O',J,K1,K2), K1 <= K.
unschedule(P,O,O',J,K,K1) :- unschedule(P,O,O',J,K+1,K1), K1 <= K.

:- schedule(P,O,O',J,K),
   unschedule(P,O,O',J,K,K1).

% Allocate minimum number M of entities T for each scheduled instance J of process O' needed to complete O for problem P

allocate(P,O,O',J,T,1..M) :- possible(P,O,O',J,K1,K2),
                             participant(O',T,M,N).
% {allocate(P,O,O',J,T,A)}  :- allocate(P,O,O',J,T,A-1),
%                              participant(O',T,M,N), A <= N,
%                              allocatable(P,T,M',N'), A <= N'.

% Allocated entities T must have the initial status S required for problem P

:- property(P,"has_part",S),
   entity(S,"initial_status"),
   allocate(P,O,O',1,T,1),
   not property(T,"has_status",S).

% Allocated entities T participating in processes scheduled at each step K must not exceed the allocatable quantity N for problem P

:- allocatable(P,T,N),
   possible(P,K),
   #count{A,O,O',J : allocate(P,O,O',J,T,A),
                     schedule(P,O,O',J,K)} > N.

% An instance J of process O' needed to complete O cannot be scheduled at step K for problem P if it would exceed the allocatable quantity N of some entity

impossible(P,O,O',J,K) :- allocatable(P,T,N),
                          participant(O',T,M',N'),
                          succeeds(O,O',K'),
                          possible(P,O,O',J,K1,K2), K = K1..K2-1,
                          #count{A,O'',J' : allocate(P,O'',O''',J',T,A),
                                            schedule(P,O'',O''',J',K),
                                            O'' != O;
                                     A,J' : allocate(P,O,O'',J',T,A),
                                            schedule(P,O,O'',J',K),
                                            J' < J;
                                     A,J' : allocate(P,O,O'',J',T,A),
                                            schedule(P,O,O'',J',K),
                                            succeeds(O,O'',K''),
                                            J < J', K' < K''} > N - M'.

% An instance J of process O' needed to complete O must not be delayed to step K+1 if it can be consistently scheduled at step K for problem P

:- possible(P,O,O',J,K1,K2),
   schedule(P,O,O',J,K+1), K1 <= K,
   not unschedule(P,O,O',J,K,K1),
   not impossible(P,O,O',J,K).

% Determine the labels X, polarities I, and optimization levels L of optimization target(s) for problem P

targets(P,X,I,L) :- possible(P,1),
                    property(P,"has_part",C),
                    label(C,X),
                    property(C,"has_priority",L),
                    property(C,"has_polarity",I).
targets(P,X,I,L) :- possible(P,1),
                    property(P,"has_part",B),
                    property(B,"has_part",C),
                    label(C,X),
                    property(C,"has_priority",L),
                    property(C,"has_polarity",I).

% Determine scores I (minimization/maximization when polarity I is 1/-1) for optimization target(s) labeled "Makespan" and "Processes", counting scheduled steps K or completed instances J of processes O, respectively, at optimization level L (greater integer levels stand for higher importance) for problem P

score(P,0,K,I,L) :- targets(P,"Makespan",I,L),
                    schedule(P,O,O',J,K).
score(P,O,J,I,L) :- targets(P,"Processes",I,L),
                    schedule(P,O,O,J).

% ----------------------------------------------------------------------------
% Output atoms

#show solve/4.    % problem to solve
#show score/5.    % scores contributing to optimization
#show select/2.   % selected entities (methods) for selection problem
#show schedule/5. % scheduled processes for resource allocation problem
#show allocate(P,O,O',J,T,A) : allocate(P,O,O',J,T,A),
                               not allocate(P,O,O',J,T,A+1). % allocated resources for resource allocation problem
