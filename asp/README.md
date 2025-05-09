# Prototype Answer Set Programming (ASP) modeling

This folder includes files modeling the `COMPARISON_EXAMPLE_PROBLEM` and the `RESOURCE_ALLOCATION_EXAMPLE_PROBLEM` from [optimization.ttl](../optimization.ttl) for the ASP solver [clingo](https://potassco.org/clingo/). The ASP modeling is hand-made and not yet automatically generated, where the specific file contents are:

- Generally relevant process data (-> [examples.lp](examples.lp))

- Specific data for `COMPARISON_EXAMPLE_PROBLEM` (-> [comparison_example_problem.lp](comparison_example_problem.lp))

- Specific data for `RESOURCE_ALLOCATION_EXAMPLE_PROBLEM` (-> [resource_allocation_example_problem.lp](resource_allocation_example_problem.lp))

- ASP encoding of optimal solutions for both example problems (-> [problems.lp](problems.lp))

Command-line calls for running the example problems are as follows:

    clingo comparison_example_problem.lp examples.lp problems.lp
    
    clingo resource_allocation_example_problem.lp examples.lp problems.lp

## Observations

- The (method) selection and resource allocation problems are currently treated separately. That is, the file [problems.lp](problems.lp) actually consists of two encodings, where one of them is selectively applied depending on whether input data specifies a (method) selection or resource allocation problem. If it can be advantageous, (method) selection and resource allocation may be integrated to make the reasoning more flexible.

- The considered example problems are related to Business Process Modeling (BPM) and Resource-Constrained Project Scheduling Problems (RCPSPs), where similar reasoning tasks are of interest. Investigating similarities and differences may provide inspiration and is certainly relevant when going for a publication.
