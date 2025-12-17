# Prototypical Answer Set Programming (ASP) Mapping

This folder includes files modeling the `COMPARISON_EXAMPLE_PROBLEM` and the `RESOURCE_ALLOCATION_EXAMPLE_PROBLEM` defined in [optimization_example.ttl](../../optimization_example.ttl). As described in the following, the workflow consists of two stages.

## Automatic Transformation from TTL to ASP

The supplied [solver.py](solver.py) script **automatically generates ASP facts**. It uses RDFLib to parse a Turtle (TTL) knowledge base, extract relevant triples, and output ASP facts representing the triples.

Command-line calls are of the form `python solver.py <output.lp> <input.ttl>`. For example:

    python solver.py optimization_example.lp ../../optimization.ttl
   

The supported RDF → ASP conversions are:

| RDF/RDFS/OWL | Turtle Example | ASP Fact |
|--------------|----------------|----------|
| `rdf:type` | `:Dog1 rdf:type :Dog` | `entity("Dog1","Dog").` |
| `subClassOf` | `:Dog rdfs:subClassOf :Animal` | `subClassOf("Dog","Animal").` |
| `subPropertyOf` | `:hasRescuedDog rdfs:subPropertyOf :hasOwner` | `subPropertyOf("hasRescuedDog","hasOwner").` |
| `comment` | `:Dog rdfs:comment "Animal"` | `comment("Dog","Animal").` |
| `label` | `:Dog rdfs:label "Dog"` | `label("Dog","Dog").` |
| `domain` | `:hasOwner rdfs:domain :Person` | `domain("hasOwner","Person").` |
| `range` | `:hasOwner rdfs:range :Dog` | `range("hasOwner","Dog").` |
| `oneOf` | `:Color owl:oneOf(:White :Brown)` | `oneOf("Color","White").`<br>`oneOf("Color","Brown").` |
| `owl:equivalentClass`   | `:PetDog owl:equivalentClass :DomesticDog`        | `equivalentClass("PetDog","DomesticDog").` |
| `owl:differentFrom`     | `:Dog1 owl:differentFrom :Dog2`                  | `differentFrom("Dog1","Dog2").` |
| `owl:sameAs`            | `:Rex owl:sameAs :Dog1`                           | `sameAs("Rex","Dog1").` |
| `owl:inverseOf`         | `:hasOwner owl:inverseOf :ownsDog`                | `inverseOf("hasOwner","ownsDog").` |
| `owl:disjointWith`      | `:Dog owl:disjointWith :Cat`                      | `disjointWith("Dog","Cat").` |
| `owl:disjointUnionOf`   | `:Animal owl:disjointUnionOf(:Dog :Cat :Bird)`    | `disjointUnionOf("Animal","Dog").`<br>`disjointUnionOf("Animal","Cat").`<br>`disjointUnionOf("Animal","Bird").` |
| Property                | `:Dog :hasColor :Brown` | `property("Dog", "hasColor", "Brown").` |
| Property (blank node)   | `:Dog :hasTrait [ a :Friendly ].` | `property("Dog", "hasTrait", "Friendly", 1, 1).` |
| `Range` + `unionOf`         | `:hasCompanion rdfs:range [owl:unionOf(:Dog :Cat)].`      | `range("hasCompanion", "unionOf", "Dog").`<br>`range("hasCompanion", "unionOf", "Cat").` |
| `Restriction` (someValuesFrom) | `:Person rdfs:subClassOf [ a owl:Restriction; owl:onProperty :hasPet; owl:someValuesFrom :Dog ].` | `restriction_some("Person", "hasPet", "Dog").` |
| `Restriction` (allValuesFrom)  | `:Person rdfs:subClassOf [ a owl:Restriction; owl:onProperty :feeds; owl:allValuesFrom :Animal ].` | `restriction_all("Person", "feeds", "Animal").` |
| `owl:Restriction` (hasValue)         | `:Person rdfs:subClassOf [ a owl:Restriction; owl:onProperty :hasFavoriteColor; owl:hasValue :Brown ].` | `restriction_hasValue("Person", "hasFavoriteColor", "Brown").` |

**Note:**
For a detailed description of the conversion workflow and the methods used in `solver.py` to transform RDF/TTL data into ASP facts, please refer to [TTL_to_ASP.pdf](TTL_to_ASP.pdf). 

## ASP Encoding and Running the Solver Clingo

Generated ASP facts as in [optimization_example.lp](optimization_example.lp) specify the goals, constraints, and targets of optimization problems at high level.
For bridging the gap to concrete resource restrictions and optimization objectives at ASP level, we additionally use the auxiliary facts in [comparison_example_problem.lp](comparison_example_problem.lp) for the `COMPARISON_EXAMPLE_PROBLEM`, or [resource_allocation_example_problem.lp](resource_allocation_example_problem.lp) for the `RESOURCE_ALLOCATION_EXAMPLE_PROBLEM`.

Together, the generated and auxiliary ASP facts configure an optimization problem modeled by the general ASP encoding in [rules.lp](rules.lp), which can be solved by the ASP solver [clingo](https://potassco.org/clingo/). Respective example command-line calls are:

    clingo optimization_example.lp comparison_example_problem.lp
    clingo optimization_example.lp resource_allocation_example_problem.lp

**Note:**
Configuring the goals, constraints, and targets of optimization problems at ontology level and automatically generating, rather than manually adding ASP facts as in [comparison_example_problem.lp](comparison_example_problem.lp) or [resource_allocation_example_problem.lp](resource_allocation_example_problem.lp) is a topic of future work.
