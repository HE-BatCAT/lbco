% ASP rules for (method) selection problem

condition(P,T,X) :- condition(P,T,X,V).

selectable(P,T,X,E) :- goal(P,"select",T,M,N),
                       entity(E,T),
                       condition(P,T,X,V),
                       property(E,X,V).
selectable(P,T,E)   :- goal(P,"select",T,M,N),
                       entity(E,T),
                       selectable(P,T,X,E) : condition(P,T,X).

M {select(P,T,E) : selectable(P,T,E)} N :- goal(P,"select",T,M,N).

:~ target(P,X,I),
   select(P,T,E),
   property(E,X,V),
   property(X,V,W),
   L = |I|, F = L/I. [F*W@L,P,X,E]

% ASP rules for resource allocation problem

process(P,O,O,M,N)  :- goal(P,"allocate",O,M,N).
process(P,O,O',M,N) :- process(P,O,O'',M,N),
                       property(O'',"followsdirectly",O').
process(O,O')       :- process(P,O,O',M,N).
process(O')         :- process(O,O').

processes(P,K) :- process(P,O'',O'',M',N'),
                  K = #sum+{N,O,O' : process(P,O,O',M,N)}.

succeeds(O,O',0) :- process(O,O'),
                    not process(O,O'') : property(O'',"followsdirectly",O').
succeeds(O,O',K) :- succeeds(O,O'',K-1),
                    property(O'',"followsdirectly",O').
succeeds(O,K)    :- succeeds(O,O',K).

previous(O,K) :- succeeds(O,K-1),
                 not succeeds(O,K).

possible(P,O,O',J,K1,K2) :- process(P,O,O',M,N), J = 1..N,
                            processes(P,K),
                            succeeds(O,O',K'),
                            previous(O,K''), K1 = K''-K',
                            K2 = K+(J-N-1)*(K'+1)+1.
possible(P,1..K)         :- processes(P,K).

constituent(O,O)  :- process(O).
constituent(O,O') :- constituent(O,O''),
                     property(O'',"uses_method",O').

participant(O,O',T,M,N) :- constituent(O,O'),
                           property(O',"has_participant",T,M,N).
participant(O,T)        :- participant(O,O',T,M,N).
participant(T)          :- participant(O,T).
participant(O,T,M,N)    :- participant(O,T),
                           M = #sum+{M',O' : participant(O,O',T,M',N')},
                           N = #sum+{N',O' : participant(O,O',T,M',N')}.

allocatable(P,T,M,N) :- condition(P,"allocate",T,M,N),
                        participant(T).
allocatable(P,T,N)   :- allocatable(P,T,M,N), N != #sup.

{schedule(P,O,O',J,K1..K2)} 1 :- possible(P,O,O',J,K1,K2).

schedule(P,O,O',J) :- schedule(P,O,O',J,K).

:- process(P,O,O',M,N), J = 1..M,
   not schedule(P,O,O',J).

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

unschedule(P,O,O',J,K,K1) :- schedule(P,O,O'',J,K),
                             possible(P,O,O',J,K1,K2), K1 <= K,
                             property(O',"followsdirectly",O'').
unschedule(P,O,O',J,K,K1) :- schedule(P,O,O',J-1,K+1),
                             possible(P,O,O',J,K1,K2), K1 <= K.
unschedule(P,O,O',J,K,K1) :- unschedule(P,O,O',J,K+1,K1), K1 <= K.

:- schedule(P,O,O',J,K),
   unschedule(P,O,O',J,K,K1).

allocate(P,O,O',J,T,1..M) :- possible(P,O,O',J,K1,K2),
                             participant(O',T,M,N).
% {allocate(P,O,O',J,T,A)}  :- allocate(P,O,O',J,T,A-1),
%                              participant(O',T,M,N), A <= N,
%                              allocatable(P,T,M',N'), A <= N'.

:- allocatable(P,T,N),
   possible(P,K),
   #count{A,O,O',J : allocate(P,O,O',J,T,A),
                     schedule(P,O,O',J,K)} > N.

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

:- possible(P,O,O',J,K1,K2),
   schedule(P,O,O',J,K+1), K1 <= K,
   not unschedule(P,O,O',J,K,K1),
   not impossible(P,O,O',J,K).

:~ target(P,"usage",I),
   schedule(P,O,O',J,K),
   L = |I|, F = L/I. [F@L,K]
:~ target(P,"usage",I),
   schedule(P,O,O,J),
   L = |I|, F = L/I. [-F@-L,O,J]

% Output atoms

#show problem/1.
#show select/3.
#show schedule/5.
#show allocate(P,O,O',J,T,A) : allocate(P,O,O',J,T,A),
                               not allocate(P,O,O',J,T,A+1).

% Example calls
%*
clingo comparison_example_problem.lp problems.lp examples.lp

clingo resource_allocation_example_problem.lp problems.lp examples.lp
*%
