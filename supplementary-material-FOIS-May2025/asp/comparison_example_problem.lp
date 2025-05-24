% Include common facts and general problem encoding:

#include "optimization_example.lp".
#include "problem_encoding.lp".

%* The below fact refers to ontology information from optimization_example.ttl:

ex:COMPARISON_EXAMPLE_PROBLEM
    a mbco:logic_based_problem ;
    a mbco:optimization_problem ;
    rdfs:comment "An example about comparing simulations or experiments"^^xs:string ;
    mbco:has_part ex:GOAL_2 ;
    mbco:has_part ex:TARGET_1 .
*%

problem("COMPARISON_EXAMPLE_PROBLEM").

%* The below facts represents ontology information from optimization_example.ttl:

ex:GOAL_2 a mbco:qualitative_constraint ;
    rdfs:comment "Evaluate the diffusion coefficient of a substance"^^xs:string ;
    mbco:has_part ex:DIFFUSION_COEFFICIENT .
*%

goal("COMPARISON_EXAMPLE_PROBLEM","select","method",1,1). % exactly one method

condition("COMPARISON_EXAMPLE_PROBLEM","method","has_output","DIFFUSION_COEFFICIENT").

%* The below facts represents ontology information from optimization_example.ttl:

ex:TARGET_1 a mbco:target ;
   rdfs:comment "Maximize precision and minimize cost"^^xs:string .
*%

target("COMPARISON_EXAMPLE_PROBLEM","has_precision_level",-2). % precision should be maximized (negative cost) with priority 2
target("COMPARISON_EXAMPLE_PROBLEM","has_cost_level",1). % cost should be minimized (positive cost) with priority 1

% Clingo (https://potassco.org/clingo/) run

%*
$ clingo comparison_example_problem.lp

clingo version 5.8.0 (6d1efb6)
Reading from comparison_example_problem.lp
problem_encoding.lp:86:25-54: info: atom does not occur in any rule head:
  condition(P,"allocate",T,M,N)

Solving...
Answer: 1 (Time: 0.005s)
problem("COMPARISON_EXAMPLE_PROBLEM") select("COMPARISON_EXAMPLE_PROBLEM","method","DISSIPATIVE_PARTICLE_DYNAMICS")
Optimization: -1 2
Answer: 2 (Time: 0.005s)
problem("COMPARISON_EXAMPLE_PROBLEM") select("COMPARISON_EXAMPLE_PROBLEM","method","GITT_TEST")
Optimization: -3 3
OPTIMUM FOUND

Models       : 2
  Optimum    : yes
Optimization : -3 3
Calls        : 1
Time         : 0.005s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
CPU Time     : 0.005s
*%
