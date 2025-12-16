solve("select","COMPARISON_EXAMPLE_PROBLEM",1,1).

entity("has_priority","ObjectProperty").
domain("has_priority","target").
range("has_priority","integer").

entity("has_polarity","ObjectProperty").
domain("has_polarity","target").
range("has_polarity","integer").

property("TARGET_1","has_part","PRECISION_1").
property("TARGET_1","has_part","COST_1").

entity("PRECISION_1","target").
property("PRECISION_1","has_precision_level","coarse_amount_level",1,1).
property("PRECISION_1","has_priority",2).  % more significant than cost
property("PRECISION_1","has_polarity",-1). % maximization

entity("COST_1","target").
property("COST_1","has_cost_level","coarse_amount_level",1,1).
property("COST_1","has_priority",1).  % less significant than precision
property("COST_1","has_polarity",1).  % minimization

sameAs("HIGH",3).
sameAs("MEDIUM",2).
sameAs("LOW",1).

%*
comment("COMPARISON_EXAMPLE_PROBLEM","An example about comparing simulations or experiments").
entity("COMPARISON_EXAMPLE_PROBLEM","logic_based_problem").
entity("COMPARISON_EXAMPLE_PROBLEM","optimization_problem").
property("COMPARISON_EXAMPLE_PROBLEM","has_part","GOAL_2").
property("COMPARISON_EXAMPLE_PROBLEM","has_part","TARGET_1").

comment("GOAL_2","Evaluate the diffusion coefficient of a substance").
entity("GOAL_2","qualitative_constraint").
property("GOAL_2","has_part","DIFFUSION_COEFFICIENT").

comment("TARGET_1","Maximize precision and minimize cost").
entity("TARGET_1","target").
*%
