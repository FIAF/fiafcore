# /// script
# requires-python = ">=3.13"
# dependencies = ["rdflib", "lxml"]
# ///
"""Run from the repository root: uv run scripts/check_taxonomy_review.py.

Synthetic regression checks; archive source datasets are not required.
"""

from pathlib import Path
import re

from lxml import etree
from rdflib import Graph, Namespace, RDF, RDFS, OWL, Literal
from rdflib.namespace import DCTERMS


F = Namespace("https://dev.fiafcore.org/")
BA = "http://www.bundesarchiv.de/schemas/de-barch/fw-view-1.0"
ontology = Graph()
for path in Path("ontology").glob("*.ttl"):
    ontology.parse(path)


def transform(path, xml):
    result = etree.XSLT(etree.parse(str(path)))(etree.fromstring(xml.encode()))
    return Graph().parse(data=etree.tostring(result), format="xml")


items = Path("transform/bfi/xsl/BFI_FIAF_LOD_Items.xsl")
manifestations = Path("transform/bfi/xsl/BFI_FIAF_LOD_Manifestations.xsl")
bundesarchiv = Path("transform/bundesarchiv/xsl/bundesarchiv.xsl")


def bfi_item(description="", stock="", base=""):
    root = etree.Element("record", priref="check")
    if description:
        etree.SubElement(root, "physical_description").text = description
    if stock:
        etree.SubElement(etree.SubElement(root, "stock"), "stock_film").text = stock
    if base:
        etree.SubElement(etree.SubElement(root, "base"), "value", lang="0").text = base
    return transform(items, etree.tostring(root).decode())


def ba_item(material="", code="", container="", gauge=""):
    return transform(bundesarchiv, f'''<root xmlns:ba="{BA}">
        <ba:Exemplar uuid="check">
            {f'<ba:Container>{container}</ba:Container>' if container else ''}
            {f'<ba:Filmbreite>{gauge}</ba:Filmbreite>' if gauge else ''}
            <ba:Aufbewahrungseinheit uuid="part">
                {f'<ba:Materialart>{material}</ba:Materialart>' if material else ''}
                {f'<ba:Rohfilmtyp>{code}</ba:Rohfilmtyp>' if code else ''}
            </ba:Aufbewahrungseinheit>
        </ba:Exemplar></root>''')


for child, parent in [("Hi8", "VideoTape"), ("SuperVHS", "VideoTape"),
                      ("DVCPROHD", "DV"), ("UltraHDBluRay", "VideoDisc"),
                      ("ProfessionalDisc", "VideoDisc"), ("VideoTape", "VideoFormat"),
                      ("VideoDisc", "VideoFormat"), ("OpenReelAudiotape", "AudioTape"),
                      ("CD", "AudioDisc"), ("QuarterInchAudiotape", "OpenReelAudiotape"),
                      ("QuerterInchAudiotape", "OpenReelAudiotape"),
                      ("MagneticFilm", "FilmFormat"), ("35mmMagneticFilm", "MagneticFilm"),
                      ("16mmMagneticFilm", "MagneticFilm"),
                      # Phase 0 Element decisions.
                      ("FilmSoundElement", "FilmElement"), ("SoundNegative", "FilmSoundElement"),
                      ("SoundPositive", "FilmSoundElement"),
                      ("SeparatedMagneticSound", "FilmSoundElement"),
                      ("OriginalCutNegative", "OriginalNegative"), ("FilmOutNegative", "Negative"),
                      ("OriginalReversalPositive", "ReversalPositive"),
                      ("OriginalSoundRecording", "AudioElement"),
                      ("HomeVideoRelease", "VideoElement"),
                      ("OriginalDigitalRecording", "DigitalElement"),
                      ("DigitalRelease", "DigitalElement"),
                      # Phase 1 Sound decisions.
                      ("Mute", "Sound"), ("Silent", "SoundCharacteristic"),
                      ("AnalogueOpticalSound", "SoundStandard"),
                      ("OpticalVariableArea", "AnalogueOpticalSound"),
                      ("OpticalVariableDensity", "AnalogueOpticalSound"),
                      ("AnalogueDiscSound", "SoundStandard"),
                      ("DolbyDigitalPlus", "AudioCodec"), ("DolbyTrueHD", "AudioCodec"),
                      ("DTSHD", "AudioCodec"),
                      # Phase 1 Colour decisions.
                      ("Warnercolor", "Eastmancolor"), ("DeLuxe", "Eastmancolor"),
                      ("Duartcolor", "Eastmancolor"), ("Metrocolor", "Eastmancolor"),
                      ("Supercinecolor", "SubtractiveColourProcess"),
                      # Phase 1 LanguageUsage decision.
                      ("Narration", "SpokenLanguage"), ("AudioDescription", "SpokenLanguage"),
                      ("NoDialogue", "Dialogue"),
                      # Phase 1 Extent decision.
                      ("Metre", "PhysicalExtent"), ("Byte", "PhysicalExtent"),
                      ("Gigabyte", "PhysicalExtent"), ("Minute", "Duration"),
                      ("Reel", "Extent"),
                      # Phase 1 Event decision.
                      ("AccessionEvent", "Event"), ("DeAcquisitionEvent", "Event"),
                      ("OutgoingLoanEvent", "Event"), ("LegalDepositEvent", "AcquisitionEvent"),
                      ("LoanEvent", "Event"),
                      ("TheatricalDistributionEvent", "DistributionEvent"),
                      ("NonTheatricalDistributionEvent", "DistributionEvent")]:
    assert list(ontology.objects(F[child], RDFS.subClassOf)) == [F[parent]], child
for removed in ["OpticalVideoDisc", "HomeViewingCopy", "OpticalSoundProcess",
                "DirectPositive", "ChromolyticSingleLayer", "ColourSeparation",
                "InstantDyeDiffusion"]:
    assert not list(ontology.triples((F[removed], None, None))), removed
assert (F.QuerterInchAudiotape, OWL.deprecated, Literal(True)) in ontology
assert (F.QuerterInchAudiotape, DCTERMS.isReplacedBy, F.QuarterInchAudiotape) in ontology
for term in ["hasAchievement", "hasAwardName", "hasDate", "nominationOnly",
             "hasVerdict", "hasIdentifierValue"]:
    assert (F[term], RDF.type, OWL.DatatypeProperty) in ontology
    assert (F[term], RDF.type, OWL.ObjectProperty) not in ontology

# Generic positives preserve their independent colour/process description.
for description in ["Positive", "BW Positive", "Original Positive", "Tinted Positive",
                    "Original / Dupe Positive", "Colour Positive", "Toned Positive"]:
    graph = bfi_item(description)
    assert (None, F.isElement, F.Positive) in graph, description
    assert (None, F.isElement, F.ReleasePrint) not in graph
graph = bfi_item("Tinted Positive")
assert (None, F.hasColourProcess, F.Tinted) in graph
assert (None, RDF.type, F.Colour) not in graph
assert (None, RDF.type, F.BlackAndWhite) not in graph

for description in ["Magnetic", "Magnetic recording", "Dupe Magnetic Recording",
                    "Magnetic Recording Loop", "Magnetic Recording 3 Track Stereophonic",
                    "Master Magnetic Recording"]:
    graph = bfi_item(description)
    expected = F.AudioMaster if description.startswith("Master") else F.AudioElement
    assert (None, F.isElement, expected) in graph
    assert (None, F.hasSoundStandard, F.Magnetic) in graph
    assert (None, F.isElement, F.SeparatedMagneticSound) not in graph
    assert (None, F.hasFormat, F.OpenReelAudiotape) not in graph

brands = ["Ampex", "Ansco", "Deko", "EMTEC", "Goerz-Tenax", "Indu", "JVC",
          "Lignose", "Mafe", "Memorex", "Perutz", "Pyral", "Sakura", "Svema", "Zonal"]
for brand in brands + ["SONY", "Kodak Canada", "Kodak France", "Pathe Freres", "Kodak"]:
    graph = bfi_item(stock=brand)
    nodes = list(graph.objects(None, F.hasStock))
    assert len(nodes) == 1, brand
    term = graph.value(nodes[0], RDF.type)
    assert (term, RDF.type, OWL.Class) in ontology, (brand, term)
for brand in ["Unmarked", "Cbema", "SVMA", "unknown credit activity"]:
    assert not list(bfi_item(stock=brand).objects(None, F.hasStock)), brand
assert (None, F.hasBase, F.PVCBase) in bfi_item(base="PVC")

for material, term in {"High 8/8mm": "VideoFormat", "D 1 oder 2": "VideoFormat",
                       "BETA": "VideoFormat", "MAZ": "VideoFormat", "AMPEX DCT": "AmpexDCT",
                       "XDCAM PFD 50DLA": "ProfessionalDisc", "FILE": "DigitalFormat"}.items():
    assert (None, F.hasFormat, F[term]) in ba_item(material), material
for container in ["", "Unbekannt", "OHNE Container"]:
    assert (None, F.hasFormat, F.DigitalFormat) in ba_item("FILE", container=container)
assert (None, F.hasFormat, F.DigitalFormat) not in ba_item("FILE", container="MXF")
assert (None, F.hasFormat, F.MXF) in ba_item("FILE", container="MXF")

for material in ["Stumme_Kopie_mit_Tonkasch", "Stummes_Duplikatnegativ_mit_Tonkasch",
                 "Stummes_Internegativ_mit_Tonkasch", "Stummes_Duplikatpositiv_mit_Tonkasch"]:
    graph = ba_item(material)
    assert (None, RDF.type, F.Mute) in graph
    assert (None, RDF.type, F.Silent) not in graph
assert (None, RDF.type, F.Silent) in ba_item("Stummes_Internegativ")
for gauge, element in [("35 mm", F.SeparatedMagneticSound), ("6,25 mm", F.AudioElement)]:
    assert (None, F.isElement, element) in ba_item("Magnetband", gauge=gauge)

for manufacturer, codes in {"Orwo": ["DP_31", "DN_21", "PF2", "PF2_V2", "TF_12d"],
                            "Kodak": ["2374", "2234", "2366"],
                            "Agfa": ["ST_8", "CP_30"]}.items():
    for code in codes:
        graph = ba_item(code=code)
        node = next(graph.objects(None, F.hasStock))
        assert (node, RDF.type, F[manufacturer]) in graph
        assert (node, F.hasStockCode, Literal(code)) in graph
    graph = ba_item(code=manufacturer)
    node = next(graph.objects(None, F.hasStock))
    assert node != F[manufacturer]
    assert (node, RDF.type, F[manufacturer]) in graph

# Exercise each credit label in both organisation and person branches.
for kind in ["Koerperschaft", "Person"]:
    for role in sorted(set(re.findall(r'\$funktion = \'([^\']+)\'', bundesarchiv.read_text()))):
        xml = f'''<root xmlns:ba="{BA}"><ba:Filmwerk uuid="work"><ba:Credit>
            <ba:{kind} uuid="agent"><ba:Funktion Funktion="{role}" /></ba:{kind}>
            </ba:Credit></ba:Filmwerk></root>'''
        # Not all roles exist in both source picklists; test those that do.
        tree = etree.parse(str(bundesarchiv))
        ns = {"xsl": "http://www.w3.org/1999/XSL/Transform"}
        blocks = tree.xpath(f'//xsl:for-each[@select="ba:Credit/ba:{kind}"]', namespaces=ns)
        if not blocks or not any(w.get("test") == f"$funktion = '{role}'"
                                 for w in blocks[0].xpath('.//xsl:when', namespaces=ns)):
            continue
        graph = transform(bundesarchiv, xml)
        for activity in graph.objects(None, F.hasActivity):
            assert (graph.value(activity, RDF.type), RDF.type, OWL.Class) in ontology

def ba_credit(kind, role):
    xml = f'''<root xmlns:ba="{BA}"><ba:Filmwerk uuid="work"><ba:Credit>
        <ba:{kind} uuid="agent"><ba:Funktion Funktion="{role}" /></ba:{kind}>
        </ba:Credit></ba:Filmwerk></root>'''
    graph = transform(bundesarchiv, xml)
    return {graph.value(activity, RDF.type) for activity in graph.objects(None, F.hasActivity)}

# Final credit decisions: broad organisation domains, precise person roles.
for kind, role, expected in [
    ("Koerperschaft", "Drehbuch", F.WritingActivity),
    ("Koerperschaft", "Fachberatung", F.Advisor),
    ("Koerperschaft", "Produzent", F.ProductionCompany),
    ("Koerperschaft", "Regie / Spielleitung / Realisation", F.DirectingActivity),
    ("Koerperschaft", "Kamera/Bild/Bildgestaltung/Fotografie", F.CinematographyActivity),
    ("Koerperschaft", "Synchronregie", F.SoundActivity),
    ("Koerperschaft", "Tonmischung/Mischton", F.SoundActivity),
    ("Person", "Drehbuch", F.WritingActivity),
    ("Person", "Fachberatung", F.Advisor),
    ("Person", "Szenenbild (Filmarchitekt / Bühnenbildner)", F.ProductionDesignActivity),
    ("Person", "Synchronmitwirkende", F.Activity),
]:
    assert expected in ba_credit(kind, role), (kind, role, expected)

for value, expected in [("Phase Alternate Line (PAL)", F.PAL), ("65mm film", F["65mmFilm"]),
                        ("Reel to reel tape", F.OpenReelAudiotape)]:
    graph = transform(manifestations, f'<record priref="check"><format_low_level>{value}</format_low_level></record>')
    predicate = F.hasBroadcastStandard if expected == F.PAL else F.hasFormat
    assert (None, predicate, expected) in graph
graph = transform(manifestations, '<record priref="check"><sound_system_manifestation>Surround Stereo</sound_system_manifestation></record>')
assert (None, F.hasSoundChannelConfiguration, F.Surround) in graph
assert (None, F.hasSoundChannelConfiguration, F.Stereo) not in graph

print("Taxonomy review regression checks passed.")
