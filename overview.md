# Overview of LBCO

The LBCO set of ontologies contains a modules for: (a) Higher level; (b) Optimization, decision support, design; (c) Twinning; (d) Data and
metadata; (e) Modelling and simulation; (f) Characterization; (g) Manufacturing; (h) Battery (LiB and
RFB). All modules (b) - (h) are aligned with (a), however some are vertical [(e) - (g)] and other transversal [(b) - (d) and (h)]:
this means that, for example, the data module (e.g., describing uncertainties and data quality protocols)
needs to address corresponding issues from modelling, characterization and manufacturing.

Below we briefly describe the scope of each module, also to clarify the boundaries between them.

Also, the competency questions (CQs) addressed by LBCO are tracked [here](doc/competency_questions.csv).

## Higher level concept (-> higher.ttl) 

A module to facilitate a structuring of and connection between the lower modules, and a possible alignment of LBCO with top level ontologies.

## Optimization, decision support, design (-> optimization.ttl)

A module about optimization problems, either numerical or logic-based.
It allows to state a problem and its solution.

## Twinning (-> twinning.ttl)

A module about twinning, a particular type of computational modelling. In fact, digital twinning in particular involves models (typically data-driven, or hybrid, but not necessarily) that are synchronized with the physical world making use of sensor or characterization data.
It allows to describe the twin functionalities.

## Data and metadata (-> data.ttl)

A module about (meta)data aspects, such as uncertainties, data quality protocols, and metadata schemas used to annotate data.

## Modelling and simulation (-> modelling.ttl)

A module about computational modelling and related processes, as model parametrization and validation and the involved data.

## Characterization (-> characterization.ttl)

Focuses on off-line characterization. On-line characterization (i.e., that is integrated with the manufacturing process itself, e.g., via sensors) is addressed in the manufacturing module.

## Manufacturing (-> manufacturing.ttl)

A module about manufacturing of products, via intermediate ones.
Includes on-line characterization (i.e., sensors), actuators, product and process KPIs.

## Battery (LiB and RFB) (-> battery.ttl)

A module containing all the battery specific information, such as battery manufacturing processes and battery product parts.
Two major types of batteries are considered: Lithium-ion batteries and redox-flow batteries.