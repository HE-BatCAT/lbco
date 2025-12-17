#include "rules.lp".

entity("ACTIVE_MATERIAL_POTENTIALS","continuum_variable").
entity("ACTIVE_MATERIAL_POTENTIALS","physical_quantity").

comment("COMPARISON_EXAMPLE_PROBLEM","An example about comparing simulations or experiments").
entity("COMPARISON_EXAMPLE_PROBLEM","logic_based_problem").
entity("COMPARISON_EXAMPLE_PROBLEM","optimization_problem").
property("COMPARISON_EXAMPLE_PROBLEM","has_part","GOAL_2").
property("COMPARISON_EXAMPLE_PROBLEM","has_part","TARGET_1").

comment("CONSTRAINT_1","There is only one available agent").
entity("CONSTRAINT_1","quantitative_constraint").

comment("CONSTRAINT_2","There are two available computational devices").
entity("CONSTRAINT_2","quantitative_constraint").

comment("CONSTRAINT_3","A computational method must be used").
entity("CONSTRAINT_3","qualitative_constraint").

entity("DIFFUSION_COEFFICIENT","continuum_variable").
entity("DIFFUSION_COEFFICIENT","physical_quantity").

entity("DISSIPATIVE_PARTICLE_DYNAMICS","method").
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_cost_level","MEDIUM").
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_input","DPD_MODEL_PARAMETRIZATION_1").
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_output","DIFFUSION_COEFFICIENT").
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_participant","computational_device", 1, 1).
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_participant","software", 1, 1).
property("DISSIPATIVE_PARTICLE_DYNAMICS","has_precision_level","LOW").

entity("DPD_DATA_ANALYSIS","process").
property("DPD_DATA_ANALYSIS","followsdirectly","DPD_SIMULATION_RUN").
property("DPD_DATA_ANALYSIS","has_participant","agent", 1, 1).

entity("DPD_MODEL_PARAMETRIZATION_1","model_parametrization").

property("DPD_SIMULATION_RUN","followsdirectly","DPD_SIMULATION_SETTING_UP").
property("DPD_SIMULATION_RUN","uses_method","DISSIPATIVE_PARTICLE_DYNAMICS").

entity("DPD_SIMULATION_SETTING_UP","process").
property("DPD_SIMULATION_SETTING_UP","has_participant","agent", 1, 1).

entity("EXPERIMENT_SETTING_UP","process").
property("EXPERIMENT_SETTING_UP","has_participant","agent", 1, 1).

entity("GITT_TEST","method").
property("GITT_TEST","has_cost_level","HIGH").
property("GITT_TEST","has_output","ACTIVE_MATERIAL_POTENTIALS").
property("GITT_TEST","has_output","DIFFUSION_COEFFICIENT").
property("GITT_TEST","has_participant","POTENTIOSTAT").
property("GITT_TEST","has_participant","agent", 1, 1).
property("GITT_TEST","has_participant","sample", 1, 1).
property("GITT_TEST","has_precision_level","HIGH").

comment("GOAL_1","Allocate human and computational devices to run 2 DPD simulations, respecting the ordering of steps.").
entity("GOAL_1","goal").

comment("GOAL_2","Evaluate the diffusion coefficient of a substance").
entity("GOAL_2","qualitative_constraint").
property("GOAL_2","has_part","DIFFUSION_COEFFICIENT").

comment("INITIAL_STATUS_1","Human and computational devices are available and operational. Needed software is installed").
entity("INITIAL_STATUS_1","initial_status").

entity("POTENTIOSTAT","characterization_device").

comment("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","An example about running simulations").
entity("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","logic_based_problem").
entity("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","optimization_problem").
property("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","has_part","CONSTRAINT_1").
property("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","has_part","CONSTRAINT_2").
property("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","has_part","CONSTRAINT_3").
property("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","has_part","GOAL_1").
property("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","has_part","INITIAL_STATUS_1").
property("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","has_part","TARGET_2").

entity("SOLUTION_COMPARISON","solution").
property("SOLUTION_COMPARISON","answers","COMPARISON_EXAMPLE_PROBLEM").
property("SOLUTION_COMPARISON","uses_method","answer_set_programming", 1, 1).

entity("SOLUTION_RESOURCE_ALLOCATION","solution").
property("SOLUTION_RESOURCE_ALLOCATION","answers","RESOURCE_ALLOCATION_EXAMPLE_PROBLEM").
property("SOLUTION_RESOURCE_ALLOCATION","uses_method","answer_set_programming", 1, 1).

comment("TARGET_1","Maximize precision and minimize cost").
entity("TARGET_1","target").

comment("TARGET_2","Maximize usage of resources (minimize their idle time).").
entity("TARGET_2","target").

comment("optimization_example","The authors acknowledge funding from the European Union's Horizon Europe research and\ninnovation programme under grant agreement no. 101137725, Battery Cell Assembly Twin (BatCAT).").
property("optimization_example","contributor","Fadi Al Machot (ORCID 0000-0002-1239-9261)").
property("optimization_example","contributor","Gerhard Goldbeck (ORCID 0000-0002-4181-2852)").
property("optimization_example","contributor","Ilian T. Todorov (ORCID 0000-0001-7275-1784)").
property("optimization_example","contributor","Martin Gebser (ORCID 0000-0002-8010-4752)").
property("optimization_example","contributor","Martin Petit (ORCID 0000-0002-4226-6689)").
property("optimization_example","contributor","Martin T. Horsch (ORCID 0000-0002-9464-6739)").
property("optimization_example","contributor","Mohamed El Bahnasawi (ORCID 0000-0001-9600-3182)").
property("optimization_example","contributor","Noel Vizcaino (ORCID 0000-0001-7608-9484)").
property("optimization_example","creator","Silvia Chiacchiera (ORCID 0000-0003-0422-7870)").
property("optimization_example","description","The aim of BatCAT core ontologies is covering all needed aspects of the battery domain,\nwith a focus on Industry 5.0 cell manufacturing and addressing BatCAT use-cases.").
property("optimization_example","imports","core").
property("optimization_example","imports","modelling").
property("optimization_example","imports","optimization").
property("optimization_example","license","https://www.gnu.org/licenses/lgpl-3.0.en.html").
property("optimization_example","modified","2025-05-23").
property("optimization_example","title","BatCAT core ontologies: Optimization example").
property("optimization_example","versionInfo","version 0.1.0").

