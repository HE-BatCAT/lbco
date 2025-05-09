%* The below fact refers to ontology information from optimization.ttl:

ex:COMPARISON_EXAMPLE_PROBLEM
    a mbco:logic_based_problem ;
    a mbco:optimization_problem ;
    rdfs:comment "An example about comparing simulations or experiments"^^xs:string ;
    mbco:has_part ex:GOAL_2 ;
    mbco:has_part ex:TARGET_1 .
*%

problem("COMPARISON_EXAMPLE_PROBLEM").

%* The below facts represents ontology information from optimization.ttl:

ex:GOAL_2 a mbco:qualitative_constraint ;
    rdfs:comment "Evaluate the diffusion coefficient of a substance"^^xs:string .
*%

goal("COMPARISON_EXAMPLE_PROBLEM","select","method",1,1). % exactly one method

condition("COMPARISON_EXAMPLE_PROBLEM","method","has_output","DIFFUSION_COEFFICIENT").

%* The below facts represents ontology information from optimization.ttl:

ex:TARGET_1 a mbco:target ;
   rdfs:comment "Maximize precision and minimize cost"^^xs:string .
*%

target("COMPARISON_EXAMPLE_PROBLEM","has_precision_level",-2). % precision should be maximized (negative cost) with priority 2
target("COMPARISON_EXAMPLE_PROBLEM","has_cost_level",1). % cost should be minimized (positive cost) with priority 1
