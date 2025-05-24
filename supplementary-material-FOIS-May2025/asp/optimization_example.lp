%* The below facts represent ontology information from optimization_example.ttl:

ex:GITT_TEST a mbco:method ;
    mbco:has_output ex:DIFFUSION_COEFFICIENT ;
    mbco:has_output ex:ACTIVE_MATERIAL_POTENTIALS ;
    mbco:has_participant ex:POTENTIOSTAT ;
    mbco:has_participant [a mbco:sample] ;
    mbco:has_participant [a mbco:agent] ;
    mbco:has_cost_level mbco:HIGH ;
    mbco:has_precision_level mbco:HIGH .
*%

entity("GITT_TEST","method").
property("GITT_TEST","has_output","DIFFUSION_COEFFICIENT").
property("GITT_TEST","has_output","ACTIVE_MATERIAL_POTENTIALS").
property("GITT_TEST","has_participant","POTENTIOSTAT").
property("GITT_TEST","has_participant","sample",1,1). % exactly one sample
property("GITT_TEST","has_participant","agent",1,1). % exactly one agent
property("GITT_TEST","has_cost_level","HIGH").
property("GITT_TEST","has_precision_level","HIGH").

%* The below facts represent ontology information from optimization_example.ttl:

ex:DISSIPATIVE_PARTICLE_DYNAMICS a mbco:method ;
    mbco:has_input ex:DPD_MODEL_PARAMETRIZATION_1 ;
    mbco:has_output ex:DIFFUSION_COEFFICIENT ;
    mbco:has_participant [a mbco:computational_device] ;
    mbco:has_participant [a mbco:software] ; # E.g., license access needed
    mbco:has_cost_level mbco:MEDIUM ;
    mbco:has_precision_level mbco:LOW .
*%

entity("DISSIPATIVE_PARTICLE_DYNAMICS","method").
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_input","DPD_MODEL_PARAMETRIZATION_1").
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_output","DIFFUSION_COEFFICIENT").
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_participant","computational_device",1,1). % exactly one computational device
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_participant","software",1,1). % exactly one software
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_cost_level","MEDIUM").
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_precision_level","LOW").

%* The below facts represent ontology information from optimization_example.ttl:

ex:DPD_DATA_ANALYSIS a mbco:process ;
    mbco:has_participant [a mbco:agent] .

ex:DPD_DATA_ANALYSIS mbco:followsdirectly ex:DPD_SIMULATION_RUN .
*%

entity("DPD_DATA_ANALYSIS","process").
property("DPD_DATA_ANALYSIS","has_participant","agent",1,1). % exactly one agent
property("DPD_DATA_ANALYSIS","followsdirectly","DPD_SIMULATION_RUN").

%* The below facts represent ontology information from optimization_example.ttl:

ex:DPD_SIMULATION_RUN
    mbco:uses_method ex:DISSIPATIVE_PARTICLE_DYNAMICS ;
    mbco:followsdirectly ex:DPD_SIMULATION_SETTING_UP .
*%

entity("DPD_SIMULATION_RUN","process").
property("DPD_SIMULATION_RUN","uses_method","DISSIPATIVE_PARTICLE_DYNAMICS").
property("DPD_SIMULATION_RUN","followsdirectly","DPD_SIMULATION_SETTING_UP").

%* The below facts represent ontology information from optimization_example.ttl:

ex:DPD_SIMULATION_SETTING_UP a mbco:process ;
    mbco:has_participant [a mbco:agent] .
*%

entity("DPD_SIMULATION_SETTING_UP","process").
property("DPD_SIMULATION_SETTING_UP","has_participant","agent",1,1). % exactly one agent

%* The below facts represent ontology information from optimization_example.ttl:

ex:EXPERIMENT_SETTING_UP a mbco:process ;
    mbco:has_participant [a mbco:agent] .
*%

entity("EXPERIMENT_SETTING_UP","process").
property("EXPERIMENT_SETTING_UP","has_participant","agent",1,1). % exactly one agent

% Auxiliary facts mapping cost levels to integers

property("has_cost_level","HIGH",3).
property("has_cost_level","MEDIUM",2).
property("has_cost_level","LOW",1).

% Auxiliary facts mapping precision levels to integers

property("has_precision_level","HIGH",3).
property("has_precision_level","MEDIUM",2).
property("has_precision_level","LOW",1).
