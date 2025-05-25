% Selection requirements
goal("has_output","DIFFUSION_COEFFICIENT").
target("has_precision_level",-2).
target("has_cost_level",1).

% Experiment properties
property("EXPERIMENT","has_output","DIFFUSION_COEFFICIENT").
property("EXPERIMENT","has_output","ACTIVE_MATERIAL_POTENTIALS").
property("EXPERIMENT","has_participant","sample").
property("EXPERIMENT","has_participant","agent").
property("EXPERIMENT","has_cost_level","HIGH").
property("EXPERIMENT","has_precision_level","HIGH").

% Simulation properties
property("SIMULATION","has_input","PARAMETRIZATION").
property("SIMULATION","has_output","DIFFUSION_COEFFICIENT").
property("SIMULATION","has_participant","computational_device").
property("SIMULATION","has_participant","software").
property("SIMULATION","has_cost_level","MEDIUM").
property("SIMULATION","has_precision_level","LOW").

% Problem encoding
amount_level("HIGH",3).
amount_level("MEDIUM",2).
amount_level("LOW",1).

{select(METHOD) : property(METHOD,PROPERTY,VALUE), goal(PROPERTY,VALUE)} = 1.

:~ property(METHOD,PROPERTY,VALUE), target(PROPERTY,PRIORITY), select(METHOD),
   amount_level(VALUE,LEVEL). [LEVEL*PRIORITY/|PRIORITY|@|PRIORITY|,PROPERTY]

% Output predicate
#show select/1.

% Clingo (https://potassco.org/clingo/) run

%*
$ clingo selection.lp

clingo version 5.8.0 (6d1efb6)
Reading from selection.lp
Solving...
Answer: 1 (Time: 0.001s)
select("SIMULATION")
Optimization: -1 2
Answer: 2 (Time: 0.001s)
select("EXPERIMENT")
Optimization: -3 3
OPTIMUM FOUND

Models       : 2
  Optimum    : yes
Optimization : -3 3
Calls        : 1
Time         : 0.001s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
CPU Time     : 0.001s
*%
