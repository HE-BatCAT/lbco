%* The below fact refers to ontology information from optimization.ttl:

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

%* The below fact represents ontology information from optimization.ttl:

ex:GOAL_1 a mbco:goal ;
   rdfs:comment "Allocate human and computational devices to run 2 DPD simulations, respecting the ordering of steps."^^xs:string .
*%

goal("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","allocate","DPD_DATA_ANALYSIS",2,2). % allocate resources for exactly two simulation runs (ending with DPD_DATA_ANALYSIS process)

%* The below fact represents ontology information from optimization.ttl:

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

%* The below fact represents ontology information from optimization.ttl:

ex:TARGET_2 a mbco:target ;
   rdfs:comment "Maximize usage of resources (minimize their idle time)."^^xs:string .
*%

target("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","usage",1). % idle time should be minimized (positive cost) with priority 1
