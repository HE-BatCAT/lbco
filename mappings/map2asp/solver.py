import argparse
import sys
import re
from rdflib import Graph, RDF, RDFS, URIRef, BNode, Literal, Namespace
from rdflib.collection import Collection
from rdflib.namespace import OWL, XSD

OWL = Namespace("http://www.w3.org/2002/07/owl#")


def atom(g: Graph, term) -> str:
    try:
        prefix, ns, local = g.compute_qname(term)
        if local: 
            return f'"{local}"'
    except Exception:
        pass
    return f'"{str(term)}"'


def bnode_only_types(g: Graph, b: BNode):
    """Return list of classes if bnode has only rdf:type triples; otherwise None."""
    types = [cls for _, _, cls in g.triples((b, RDF.type, None)) if isinstance(cls, URIRef)]
    has_other = any(True for _, p, _ in g.triples((b, None, None)) if p != RDF.type)
    return types if types and not has_other else None


def esc(s: str) -> str:
    return s.replace('\\','\\\\').replace('"','\\"').replace('\n','\\n')


def handle_domain_range_list(g: Graph, Sa, p, o, facts, functor):
    """Handle rdfs:domain/range whose object is a bnode with owl:unionOf / intersectionOf / disjointUnionOf."""
    if isinstance(o, BNode):
        for key, tag in ((OWL.unionOf,'"unionOf"'),
                         (OWL.disjointUnionOf,'"disjointUnionOf"'),
                         (OWL.intersectionOf,'"intersectionOf"')):
            for _, _, lst in g.triples((o, key, None)):
                try:
                    members = list(Collection(g, lst))
                except Exception:
                    members = []
                for m in members:
                    facts.append((Sa, f'{functor}({Sa},{tag},{atom(g,m)}).'))
                return True
    return False

def handle_restriction(g: Graph, Sa, o: BNode, facts):
    if not isinstance(o, BNode) or (o, RDF.type, OWL.Restriction) not in g:
        return False 
    
    onP = next((v for _,_,v in g.triples((o, OWL.onProperty, None))), None)
    if isinstance(onP, BNode):
        onP = next((v for _,_,v in g.triples((onP, OWL.inverseOf, None))), None)
    onPq = atom(g, onP) if onP else '"_unknownProperty"'

    mapping = {
        OWL.allValuesFrom:   "restriction_all",
        OWL.someValuesFrom:  "restriction_some",
        OWL.hasValue:        "restriction_hasValue",
        OWL.minCardinality:  "restriction_minCard",
        OWL.maxCardinality:  "restriction_maxCard",
        OWL.cardinality:     "restriction_card"
    }

    for pred, functor in mapping.items():
        v = next((val for _,_,val in g.triples((o, pred, None))), None)
        if v is not None:
            facts.append((Sa, f'{functor}({Sa},{onPq},{atom(g, v)}).'))

    return True



def facts_definition(out_path: str, ttl_path: str):
    g = Graph()
    g.parse(ttl_path, format="turtle")

    facts = []

    for s, p, o in g:
        if isinstance(s, BNode):
            continue

        if isinstance(s, URIRef) and str(s).endswith(('#', '/')):
            continue

        Sa = atom(g, s) if isinstance(s, URIRef) else None
        Pa = atom(g, p)

        if p == RDF.type and isinstance(o, URIRef):
            facts.append((Sa, f'entity({Sa},{atom(g, o)}).'))
            continue

        if p == RDFS.subClassOf and isinstance(o, URIRef):
            facts.append((Sa, f'subClassOf({Sa},{atom(g, o)}).'))
            continue

        if p == RDFS.subPropertyOf and isinstance(o, URIRef):
            facts.append((Sa, f'subPropertyOf({Sa},{atom(g, o)}).'))
            continue

        if p == RDFS.comment and isinstance(o, Literal):
            text = esc(str(o))
            facts.append((Sa, f'comment({Sa},"{text}"{"," + o.language if o.language else ""}).' if o.language else f'comment({Sa},"{text}").'))
            continue

        if p == RDFS.label and isinstance(o, Literal):
            text = esc(str(o))
            facts.append((Sa, f'label({Sa},"{text}"{"," + o.language if o.language else ""}).' if o.language else f'label({Sa},"{text}").'))
            continue

        if p == RDFS.domain:
            if isinstance(o, URIRef):
                facts.append((Sa, f'domain({Sa},{atom(g, o)}).'))
            else:
                handle_domain_range_list(g, Sa, p, o, facts, "domain")
            continue

        if p == RDFS.range:
            if isinstance(o, URIRef):
                facts.append((Sa, f'range({Sa},{atom(g, o)}).'))
            else:
                handle_domain_range_list(g, Sa, p, o, facts, "range")
            continue

        if p == OWL.equivalentClass and isinstance(o, URIRef):
            facts.append((Sa, f'equivalentClass({Sa},{atom(g,o)}).'))
            continue

        if p == OWL.sameAs and isinstance(o, URIRef):
            facts.append((Sa, f'sameAs({Sa},{atom(g,o)}).'))
            continue

        if p == OWL.differentFrom and isinstance(o, URIRef):
            facts.append((Sa, f'differentFrom({Sa},{atom(g,o)}).'))
            continue

        if p == OWL.oneOf and isinstance(o, BNode):
            members = list(Collection(g, o))  # iterate RDF list
            for m in members:
                if isinstance(m, URIRef):
                    facts.append((Sa, f'oneOf({Sa},{atom(g, m)}).'))
            continue

        if p == OWL.inverseOf and isinstance(o, URIRef):
            facts.append((Sa, f'inverseOf({Sa},{atom(g,o)}).'))
            continue

        if p == OWL.disjointWith and isinstance(o, URIRef):
            facts.append((Sa, f'disjointWith({Sa},{atom(g,o)}).'))
            continue

        if p == OWL.disjointUnionOf and isinstance(o, BNode):
            members = list(Collection(g, o))  # iterate RDF list
            for m in members:
                if isinstance(m, URIRef):
                    facts.append((Sa, f'disjointUnionOf({Sa},{atom(g, m)}).'))  
            continue

        # Restrictions
        if (p in (RDFS.subClassOf, OWL.equivalentClass)) and isinstance(o, BNode):
            handle_restriction(g, Sa, o, facts)
            continue
                

        if isinstance(o, URIRef):
            facts.append((Sa, f"property({Sa},{Pa},{atom(g, o)})."))
        elif isinstance(o, BNode):
            classes = bnode_only_types(g, o)
            if classes is not None:
                for cls in classes:
                    facts.append((Sa, f"property({Sa},{Pa},{atom(g, cls)}, 1, 1)."))
        elif isinstance(o, Literal):
            try:
                if o.datatype == XSD.integer:
                    val = int(o)
                    facts.append((Sa, f'property({Sa},{Pa},"{int(o)}").'))
                    continue
                if o.datatype in (XSD.decimal, XSD.double, XSD.float):
                    val = float(o)
                    facts.append((Sa, f'property({Sa},{Pa},"{float(o)}").'))
                    continue
                if o.datatype is None and re.fullmatch(r'^[+-]?(?:\d+|\d*\.\d+)(?:[eE][+-]?\d+)?$', str(o)):
                    val = int(o) if str(o).lstrip('+-').isdigit() else float(o)
                    facts.append((Sa, f'property({Sa},{Pa},"{val}").'))
                    continue
                facts.append((Sa, f'property({Sa},{Pa},"{esc(o)}").'))
            except Exception:
                facts.append((Sa, f'property({Sa},{Pa},"{esc(str(o))}").'))



    # write to file
    with open(out_path, "w") as f:
        f.write('#include "rules.lp".\n\n')
        grouped = {}
        for subj, fact in facts:
            grouped.setdefault(subj, []).append(fact)

        for subj in sorted(grouped.keys()):
            for line in sorted(grouped[subj]):
                f.write(line + "\n")
            f.write("\n")

    print(f"[INFO] Wrote {len(facts)} facts to {out_path}")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python solver.py <output.lp> <input.ttl>")
        sys.exit(1)
        
    ap = argparse.ArgumentParser()
    ap.add_argument("out", help="Output LP file")
    ap.add_argument("ttl", help="Input Turtle file")
    args = ap.parse_args()
    facts_definition(args.out, args.ttl)

