% Include common facts and general problem encoding:

#include "optimization_example.lp".
#include "problem_encoding.lp".

%* The below fact refers to ontology information from optimization_example.ttl:

ex:RESOURCE_ALLOCATION_EXAMPLE_PROBLEM
    a mbco:logic_based_problem ;
    a mbco:optimization_problem ;
    rdfs:comment "An example about running simulations"^^xs:string ;
    mbco:has_part ex:GOAL_1 ;
    mbco:has_part ex:TARGET_2 ;
    mbco:has_part ex:CONSTRAINT_1 ;
    mbco:has_part ex:CONSTRAINT_2 ;
    mbco:has_part ex:CONSTRAINT_3 ;
    mbco:has_part ex:INITIAL_STATUS_1 .
*%

problem("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM").

%* The below fact represents ontology information from optimization_example.ttl:

ex:GOAL_1 a mbco:goal ;
   rdfs:comment "Allocate human and computational devices to run 2 DPD simulations, respecting the ordering of steps."^^xs:string .
*%

goal("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","allocate","DPD_DATA_ANALYSIS",2,2). % allocate resources for exactly two simulation runs (ending with DPD_DATA_ANALYSIS process)

%* The below fact represents ontology information from optimization_example.ttl:

ex:INITIAL_STATUS_1 a mbco:initial_status ;
   rdfs:comment "Human and computational devices are available and operational. Needed software is installed"^^xs:string .

ex:CONSTRAINT_1 a mbco:quantitative_constraint ;
    rdfs:comment "There is only one available agent"^^xs:string .

ex:CONSTRAINT_2 a mbco:quantitative_constraint ;
    rdfs:comment "There are two available computational devices"^^xs:string .

ex:CONSTRAINT_3 a mbco:qualitative_constraint ;
    rdfs:comment "A computational method must be used"^^xs:string .
*%

condition("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","allocate","agent",1,1). % exactly one agent
condition("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","allocate","computational_device",2,2). % exactly two computational devices
condition("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","allocate","software",#sup,#sup). % software is installed (no limitations)

%* The below fact represents ontology information from optimization_example.ttl:

ex:TARGET_2 a mbco:target ;
   rdfs:comment "Maximize usage of resources (minimize their idle time)."^^xs:string .
*%

target("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","usage",1). % idle time should be minimized (positive cost) with priority 1

% Clingo (https://potassco.org/clingo/) run

%*
$ clingo resource_allocation_example_problem.lp

clingo version 5.8.0 (6d1efb6)
Reading from resource_allocation_example_problem.lp
problem_encoding.lp:6:21-39: info: atom does not occur in any rule head:
  condition(P,T,X,V)

problem_encoding.lp:12:24-42: info: atom does not occur in any rule head:
  condition(P,T,X,V)

Solving...
Answer: 1 (Time: 0.007s)
problem("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM") allocate("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_SIMULATION_RUN",1,"computational_device",1) allocate("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_SIMULATION_RUN",2,"computational_device",1) allocate("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_SIMULATION_RUN",1,"software",1) allocate("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_SIMULATION_RUN",2,"software",1) allocate("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_DATA_ANALYSIS",1,"agent",1) allocate("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_DATA_ANALYSIS",2,"agent",1) allocate("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_SIMULATION_SETTING_UP",1,"agent",1) allocate("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_SIMULATION_SETTING_UP",2,"agent",1) schedule("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_DATA_ANALYSIS",1,3) schedule("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_DATA_ANALYSIS",2,4) schedule("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_SIMULATION_RUN",1,2) schedule("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_SIMULATION_RUN",2,3) schedule("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_SIMULATION_SETTING_UP",1,1) schedule("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","DPD_DATA_ANALYSIS","DPD_SIMULATION_SETTING_UP",2,2)
Optimization: 4 -2
OPTIMUM FOUND

Models       : 1
  Optimum    : yes
Optimization : 4 -2
Calls        : 1
Time         : 0.007s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
CPU Time     : 0.007s
*%
