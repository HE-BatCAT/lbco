# lbco
Lightweight BatCAT Core Ontologies

Modules list and strucure is given below.

- Higher level concept (-> higher.ttl)

Transversal modules:
- Optimization, decision support, design (-> optimization.ttl)
- Twinning (-> twinning.ttl)
- Data & metadata (-> data.ttl)

Vertical modules:
- Modelling and simulation (-> modelling.ttl)
- Characterization (-> characterization.ttl)
- Manufacturing (-> manufacturing.ttl)

Battery specific modules:
- Battery (LiB and RFB) (-> battery.ttl)

* [Overview of LBCO](overview.md)

=========================================

Alignment directory:

It contains alignments of LBCO higher.ttl module to top-level or mid-level external ontologies

- Alignment to EMMO (-> alignment-with-ecb.ttl)
- (Draft) Alignment to DOLCE-LITE (-> abdul.ttl) 
- (Draft) Alignment to EMMO-LITE (-> abel.ttl)
- (Draft) Alignment to EVMPO and VIPRS (-> abovemp.ttl)

=========================================

Mappings directory:

It contains mappings of ontologies to ASP and between ontologies (LBCO and external)

- [map2asp](mappings/map2asp) Mapping from OWL/TTL to Answer Set Programming (ASP). See [documentation](mappings/map2asp/README.md)
- Example mapping of LBCO to GPO (-> map2gpo.ttl)

=========================================

External directory:

It contains snpashots of and references to relevant external ontologies LBCO connects to. It includes:

- BVCO
- ECB (Standing for: EMMO, Battery, Electrochemistry, Chemical Substance and BTO)
- GPO
- OSMO

