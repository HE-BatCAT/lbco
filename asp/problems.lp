condition(P,S,T,X) :- condition(P,S,T,X,V).

selectable(P,S,T,X,E) :- goal(P,S,"select",T,M,N),
                         entity(E,T),
                         condition(P,S,T,X,V),
                         property(E,X,V).
selectable(P,S,T,E)   :- goal(P,S,"select",T,M,N),
                         entity(E,T),
                         selectable(P,S,T,X,E) : condition(P,S,T,X).

M {select(P,S,T,E) : selectable(P,S,T,E)} N :- goal(P,S,"select",T,M,N).

:~ target(P,S,X,I),
   select(P,S,T,E),
   property(E,X,V),
   property(X,V,W),
   L = |I|, F = L/I. [F*W@L,P,S,X,E]

#show problem/1.
#show select/4.
