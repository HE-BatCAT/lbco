entity("GITT_TEST","method").
property("GITT_TEST","has_output","DIFFUSION_COEFFICIENT").
property("GITT_TEST","has_output","ACTIVE_MATERIAL_POTENTIALS").
property("GITT_TEST","has_participant","POTENTIOSTAT").
property("GITT_TEST","has_participant","sample",1,1).
property("GITT_TEST","has_participant","agent",1,1).
property("GITT_TEST","has_cost_level","HIGH").
property("GITT_TEST","has_precision_level","HIGH").

entity("DISSIPATIVE_PARTICLE_DYNAMICS","method").
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_input","DPD_MODEL_PARAMETRIZATION_1").
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_output","DIFFUSION_COEFFICIENT").
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_participant","compute_resource",1,1).
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_participant","software",1,1).
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_cost_level","MEDIUM").
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_precision_level","LOW").

entity("DPD_DATA_ANALYSIS","process").
property("DPD_DATA_ANALYSIS","has_participant","agent",1,1).
property("DPD_DATA_ANALYSIS","followsdirectly","DPD_SIMULATION_RUN").

entity("DPD_SIMULATION_RUN","process").
property("DPD_SIMULATION_RUN","uses_method","DISSIPATIVE_PARTICLE_DYNAMICS").
property("DPD_SIMULATION_RUN","followsdirectly","DPD_SIMULATION_SETTING_UP").

entity("DPD_SIMULATION_SETTING_UP","process").
property("DPD_SIMULATION_SETTING_UP","has_participant","agent",1,1).

entity("EXPERIMENT_SETTING_UP","process").
property("EXPERIMENT_SETTING_UP","has_participant","agent",1,1).

property("has_cost_level","HIGH",3).
property("has_cost_level","MEDIUM",2).
property("has_cost_level","LOW",1).

property("has_precision_level","HIGH",3).
property("has_precision_level","MEDIUM",2).
property("has_precision_level","LOW",1).
