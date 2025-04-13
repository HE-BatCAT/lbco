problem("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM").

goal("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","allocate","DPD_DATA_ANALYSIS",2,2).

condition("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","allocate","agent",1,1).
condition("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","allocate","compute_resource",#sup,#sup).
condition("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","allocate","software",#sup,#sup).

target("RESOURCE_ALLOCATION_EXAMPLE_PROBLEM","usage",1).
