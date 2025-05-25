# Prototype Answer Set Programming (ASP) modelling

This folder includes:

- [selection.lp](selection.lp):
  Simple ASP model of the _(method) selection example_

- [comparison_example_problem.lp](comparison_example_problem.lp):
  ASP model of the `COMPARISON_EXAMPLE_PROBLEM` defined in [optimization_example.ttl](../optimization_example.ttl)

- [resource_allocation_example_problem.lp](resource_allocation_example_problem.lp):
  ASP model of the `RESOURCE_ALLOCATION_EXAMPLE_PROBLEM` defined in [optimization_example.ttl](../optimization_example.ttl)

The latter two examples make use of the common facts in [optimization_example.lp](optimization_example.lp), which represent relevant concepts defined in [optimization_example.ttl](../optimization_example.ttl), and the general (first-order) problem encoding in [problem_encoding.lp](problem_encoding.lp).

The three examples can be run with the ASP solving system [clingo](https://potassco.org/clingo/), using command-line calls as follows:

    clingo selection.lp

    clingo comparison_example_problem.lp

    clingo resource_allocation_example_problem.lp
