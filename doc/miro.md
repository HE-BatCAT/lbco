# MIRO information for LBCO ontologies

## A. Basics

**A.1 Ontology name (MUST)**
Lightweight BatCAT Core Ontologies (LBCO) - Version July 2026

**A.2 Ontology owner (MUST)**
BatCAT Consortium (Coordinator: Martin Thomas Horsch (NMBU, Norway)); LBCO main contact: Silvia Chiacchiera (STFC/UKRI, UK)

**A.3 Ontology license (MUST)**
[GNU Lesser General Public License v3.0 (LGPL-3.0)](https://spdx.org/licenses/LGPL-3.0-only.html)

**A.4 Ontology URL (MUST)**
https://github.com/HE-BatCAT/lbco/blob/main/batcat.ttl. Also, a file with all modules collated is available [here](https://github.com/HE-BatCAT/lbco/blob/main/all_LBCO_modules_combined/all_lbco_modules_combined.ttl)

**A.5 Ontology repository (MUST)**
https://github.com/HE-BatCAT/lbco

**A.6 Methodological framework (MUST)**
Requirements gathering following [LOT methodology](http://dx.doi.org/10.1016/j.engappai.2022.104755). Development and coverage analysis carried out in parallel. [Mappings](https://github.com/HE-BatCAT/lbco/tree/main/mappings) to external assets, and [alignments to TLOs](https://github.com/HE-BatCAT/lbco/tree/main/alignment), kept separate from LBCO. 

## B. Motivation

**B.1 Need (MUST)**
A light ontology capturing the connections between manufacturing, modelling, and characterization to enable digital twinning of battery manufacturing, for lithium-ion batteries (LiBs) and redox-flow batteries (RFBs).

**B.2 Competition (MUST)**
Battery Domain Ontology (BDO) (previously called BattINFO), led by Simon Clark. References: http://dx.doi.org/10.1002/aenm.202102702, https://github.com/emmo-repo/domain-battery. Battery Value Chain Ontology (BVCO). References: http://dx.doi.org/10.1002/aenm.202102702. CHAracterization MEthodology Ontology (CHAMEO) References: http://dx.doi.org/10.3233/AO-220271. Elementary Multiperspective Material Ontology (EMMO). References: https://github.com/emmo-repo/EMMO. LBCO, wrt BDO and BVCO, contains additional information on patterns such as: the relation between physical objects and their properties, the settings of a manufacturing process. See also "Other work" section and Table 1 in [the FOIS 2026 paper on LBCO](https://foisconference.org/assets/pdfs/satellitepreprints/Paper-169.pdf).

**B.3 Target audience (MUST)**
LBCO will support data ingest and retrieval and semantic interoperability within BatCAT tools and with external components. Users of the tools will be practitioners and operators in battery manufacturing, modelling and characterization, as well as business managers.

## C. Scope, requirements, development community

**C.1 Scope and coverage (MUST)**
Concepts are organized in eight modules for: (a) Higher level; (b) Characterization; (c) Manufacturing; (d) Modelling and simulation; (e) Data and metadata; (f) Optimization, decision support, design; (g) Twinning; (h)
Battery (LiB and RFB). The LBCO ontology competency questions, up-to-date with developments, can be found [here](https://github.com/HE-BatCAT/lbco/blob/main/doc/competency_questions.csv). 

**C.2 Development community (MUST)**
BatCAT Consortium (Coordinator: Martin Thomas Horsch (NMBU)).  All authors and contributors are listed in the ontology files. LBCO main contact: Silvia Chiacchiera (STFC/UKRI).

**C.3 Communication (MUST)**
https://github.com/HE-BatCAT/lbco/issues 

## D. Knowledge acquisition

**D.1 Knowledge acquisition methodology (MUST)**
Interviews, questionnaires and interactive workshops with BatCAT consortium and external collaborators. Competency questions were formulated and are updated based on feedback (from users/domain experts and from ontology engineers).

**D.2 Source knowledge location (SHOULD)**
N/A

**D.3 Content selection (SHOULD)**
Priority given to concepts relevant to users, with a bottom-up approach.

## E. Ontology content

**E.1 Knowledge Representation language**
OWL

**E.2 Development environment (OPTIONAL)**
[Protégé](http://dx.doi.org/10.1145/2757001.2757003) for development, [OOPS!](http://dx.doi.org/10.4018/ijswis.2014040102), [FOOPS!](http://ceur-ws.org/Vol-2980/paper321.pdf) for evaluation.

**E.3 Ontology metrics (SHOULD)**
LBCO overall contains 280+ classes, 45+ object properties, 10+ data properties, 85+ individuals. There are 1500+ axioms, of which 540+ are class axioms and 120+ property axioms (domain, range, subproperty, etc).

**E.4 Incorporation of other ontologies (MUST)**
External ontologies to which mappings are done are listed and collected [here](https://github.com/HE-BatCAT/lbco/tree/main/external). Otherwise, DC, DCTERMS, VANN, SKOS are used.

**E.5 Entity naming convention (MUST)**
Singular nouns are used. Properties given as verbs, third person. snake_case is used as follows:
- Individuals: all upper case
- Classes: all lower case
- Properties: all lower case

**E.6 Identifier generation policy (MUST)**
Identifiers are meaningful. The URIs prefix is from W3ID.

**E.7 Entity metadata policy (MUST)**
A label (rdfs:label) must be present for each class/property, optionally synonyms (skos:altLabel) are given if needed.

**E.8 Upper ontology (MUST)**
No single upper ontology used to avoid strong ontological commitment. Alignments to TLOs provided, in particular to the EMMO, via the higher module ([see here](https://github.com/HE-BatCAT/lbco/blob/main/alignment/awe.ttl)).

**E.9 Ontology relationships (MUST)**
In the higher module, these main object properties are defined (in alphabetical order): answers, follows, has\_input, has\_output, has\_part, has\_participant, has\_property, is\_compatible\_with, is\_incompatible\_with, is\_output\_of, uses\_method. In the lower modules, more specific properties were defined. 

**E.10 Axiom patterns (MUST)**
N/A

**E.11 Dereferenceable IRIs (SHOULD)**
All LBCO URIs are resolvable, thanks to the persistent prefix https://w3id.org/batcat{/}

## F. Managing Change

**F.1 Sustainability plan (MUST)**
BatCAT project is running till June 2027, and LBCO will be actively developed and maintained by the BatCAT consortium until then. Maintainance after project will rest with the ontology authors.

**F.2 Entity deprecation strategy (MUST)**
If a class is no longer wanted, it is kept and indicated as a owl:DeprecatedClass.

**F.3 Versioning policy (MUST)**
The LBCO set overall is versioned by "Month Year" (cf. [batcat.ttl](https://github.com/HE-BatCAT/lbco/blob/main/batcat.ttl) container), each module is versioned separetely using a X.Y.Z version.

## G. Quality Assurance

**G.1 Testing (MUST)**
LBCO was tested using reasoners (e.g., FACT++ 1.6.5, that processed it in ~200 ms) and [OOPS!](http://dx.doi.org/10.4018/ijswis.2014040102) and it is logically consistent. It does answer the competency question listed (cf. C.1 above).

**G.2 Evaluation (MUST)**
The ontology answers the competency questions listed (cf. C.1 above).

**G.3 Example of use (MUST)**
Examples are given [here](https://github.com/HE-BatCAT/lbco/tree/main/scenarios)

**G.4 Institutional endorsement (OPTIONAL)**
N/A

**G.5 Evidence of use (MUST)**
The [BatCAT - Battery Cell Assembly Twin Horizon 2020 project](http://dx.doi.org/10.3030/101137725)

### References

[1] N. Matentzoglu, J. Malone, C. Mungall, C. et al. MIRO: guidelines for minimum information for the reporting of an ontology. J Biomed Semant 9, 6 (2018). [DOI](https://doi.org/10.1186/s13326-017-0172-7)

[2] N. Matentzoglu et al., MIRO GitHub repository, Accessed 9 October 2026. [URL](https://github.com/owlcs/miro/tree/master)