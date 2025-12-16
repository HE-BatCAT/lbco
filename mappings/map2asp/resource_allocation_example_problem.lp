solve("schedule","RESOURCE_ALLOCATION_EXAMPLE_PROBLEM",2,2).

entity("has_priority","ObjectProperty").
domain("has_priority","target").
range("has_priority","integer").

entity("has_polarity","ObjectProperty").
domain("has_polarity","target").
range("has_polarity","integer").

property("CONSTRAINT_1","has_participant","agent",0,1).
property("CONSTRAINT_2","has_participant","computational_device",0,2).
property("CONSTRAINT_3","has_participant","software").

property("agent","has_status","INITIAL_STATUS_1").
property("computational_device","has_status","INITIAL_STATUS_1").
property("software","has_status","INITIAL_STATUS_1").

property("GOAL_1","has_part","DPD_DATA_ANALYSIS").

property("TARGET_2","has_part","MAKESPAN_1").
property("TARGET_2","has_part","PROCESSES_1").

entity("MAKESPAN_1","target").
label("MAKESPAN_1","Makespan").
property("MAKESPAN_1","has_priority",2).   % more significant than processes
property("MAKESPAN_1","has_polarity",1).   % minimization

entity("PROCESSES_1","target").
label("PROCESSES_1","Processes").
property("PROCESSES_1","has_priority",1).  % less significant than makespan
property("PROCESSES_1","has_polarity",-1). % maximization

%*
comment("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","An example about running simulations").
entity("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","logic_based_problem").
entity("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","optimization_problem").
property("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","has_part","CONSTRAINT_1").
property("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","has_part","CONSTRAINT_2").
property("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","has_part","CONSTRAINT_3").
property("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","has_part","GOAL_1").
property("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","has_part","INITIAL_STATUS_1").
property("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","has_part","TARGET_2").

comment("CONSTRAINT_1","There is only one available agent").
entity("CONSTRAINT_1","quantitative_constraint").

comment("CONSTRAINT_2","There are two available computational devices").
entity("CONSTRAINT_2","quantitative_constraint").

comment("CONSTRAINT_3","A computational method must be used").
entity("CONSTRAINT_3","qualitative_constraint").

comment("GOAL_1","Allocate human and computational devices to run 2 DPD simulations, respecting the ordering of steps.").
entity("GOAL_1","goal").

comment("INITIAL_STATUS_1","Human and computational devices are available and operational. Needed software is installed").
entity("INITIAL_STATUS_1","initial_status").

comment("TARGET_2","Maximize usage of resources (minimize their idle time).").
entity("TARGET_2","target").
*%
