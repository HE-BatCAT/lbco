% ASP rules for (method) selection problem from comparison_example_problem.lp

% There is a condition on property X of the entity (method) T to select for problem P

condition(P,T,X) :- goal(P,"select",T,M,N),
                    condition(P,T,X,V).

% Determine specific instances E of the entity (method) T compatible with all required conditions for problem P

selectable(P,T,X,E) :- goal(P,"select",T,M,N),
                       entity(E,T),
                       condition(P,T,X,V),
                       property(E,X,V).
selectable(P,T,E)   :- goal(P,"select",T,M,N),
                       entity(E,T),
                       selectable(P,T,X,E) : condition(P,T,X).

% Select an appropriate number of compatible instances E of the entity (method) T for problem P

M {select(P,T,E) : selectable(P,T,E)} N :- goal(P,"select",T,M,N).

% Minimize/Maximize costs of selected instances E of the entity (method) T for problem P in the order of priority

:~ target(P,X,I),
   select(P,T,E),
   property(E,X,V),
   property(X,V,W),
   L = |I|, F = L/I. [F*W@L,P,X,T,E]

% -----------------------------------------------------------------------------

% ASP rules for resource allocation problem from resource_allocation_example_problem.lp

% Trace process(es) O to complete back to predecessors O' for problem P

process(P,O,O,M,N)  :- goal(P,"allocate",O,M,N).
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

% Calculate quantity between M and N of resources of sort T participating in process O

participant(O,O',T,M,N) :- constituent(O,O'),
                           property(O',"has_participant",T,M,N).
participant(O,T)        :- participant(O,O',T,M,N).
participant(T)          :- participant(O,T).
participant(O,T,M,N)    :- participant(O,T),
                           M = #sum+{M',O' : participant(O,O',T,M',N')},
                           N = #sum+{N',O' : participant(O,O',T,M',N')}.

% Number N of allocatable resources of sort T for problem P if their quantity is limited

allocatable(P,T,M,N) :- condition(P,"allocate",T,M,N),
                        participant(T).
allocatable(P,T,N)   :- allocatable(P,T,M,N), N != #sup.

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

% Associate each scheduled instance J of process O' needed to complete O with the minimum number M of participating resources of sort T for problem P

allocate(P,O,O',J,T,1..M) :- possible(P,O,O',J,K1,K2),
                             participant(O',T,M,N).
% {allocate(P,O,O',J,T,A)}  :- allocate(P,O,O',J,T,A-1),
%                              participant(O',T,M,N), A <= N,
%                              allocatable(P,T,M',N'), A <= N'.

% Resources of sort T participating in processes scheduled at each step K must not exceed the allocatable quantity N for problem P

:- allocatable(P,T,N),
   possible(P,K),
   #count{A,O,O',J : allocate(P,O,O',J,T,A),
                     schedule(P,O,O',J,K)} > N.

% An instance J of process O' needed to complete O cannot be scheduled at step K for problem P if it would exceed the allocatable quantity N of some participating resource

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

% Minimize/Maximize the makespan of schedules as primary indicator for usage of resources, and secondarily maximize/minimize the number of completed processes O for problem P

:~ target(P,"usage",I),
   schedule(P,O,O',J,K),
   L = |I|, F = L/I. [F@L,K]
:~ target(P,"usage",I),
   schedule(P,O,O,J),
   L = |I|, F = L/I. [-F@-L,O,J]

% Output atoms

#show problem/1. % problem to solve
#show select/3. % selected entities (methods) for selection problem
#show schedule/5. % scheduled processes for resource allocation problem
#show allocate(P,O,O',J,T,A) : allocate(P,O,O',J,T,A),
                               not allocate(P,O,O',J,T,A+1). % allocated resources for resource allocation problem

%* Example calls:

clingo comparison_example_problem.lp examples.lp problems.lp

clingo resource_allocation_example_problem.lp examples.lp problems.lp
*%
