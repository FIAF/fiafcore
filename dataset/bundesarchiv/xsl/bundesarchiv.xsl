<?xml version="1.0" encoding="UTF-8"?>

<!-- Bundesarchiv XML data to FIAFcore -->
<!-- Paul Duchesne -->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:fiaf="https://dev.fiafcore.org/"
    xmlns:ba="http://www.bundesarchiv.de/schemas/de-barch/fw-view-1.0"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/" exclude-result-prefixes="oai ba">

    <xsl:output method="xml" indent="yes" />

    <xsl:template match="/">
        <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
            xmlns:fiaf="https://dev.fiafcore.org/">
            <xsl:apply-templates select="//ba:Filmwerk" />
            <xsl:apply-templates select="//ba:Manifestation" />
            <xsl:apply-templates select="//ba:Exemplar" />
            <xsl:apply-templates select="//ba:Aufbewahrungseinheit" />
        </rdf:RDF>
    </xsl:template>

    <xsl:template match="*">
        <xsl:apply-templates select="*" />
    </xsl:template>

    <!-- fiafcore:Work -->

    <xsl:template match="ba:Filmwerk">
        <rdf:Description rdf:about="bundesarchiv://resource/work/{@uuid}">

            <xsl:if test="not(ba:Filmart)">
                <rdf:type rdf:resource="https://dev.fiafcore.org/Work" />
            </xsl:if>
            <xsl:if test="ba:Filmart">
                <xsl:variable name="work_type" select="ba:Filmart" />
                <xsl:choose>
                    <xsl:when test="$work_type = 'Unbekannt'">
                        <rdf:type rdf:resource="https://dev.fiafcore.org/Work" />
                    </xsl:when>
                    <xsl:when test="$work_type = 'Documentation'">
                        <rdf:type rdf:resource="https://dev.fiafcore.org/Work" />
                    </xsl:when>
                    <xsl:when test="$work_type = 'Dokumentarfilm'">
                        <rdf:type rdf:resource="https://dev.fiafcore.org/MonographicWork" />
                    </xsl:when>
                    <xsl:when test="$work_type = 'Spielfilm'">
                        <rdf:type rdf:resource="https://dev.fiafcore.org/MonographicWork" />
                    </xsl:when>
                    <xsl:when test="$work_type = 'Film'">
                        <rdf:type rdf:resource="https://dev.fiafcore.org/MonographicWork" />
                    </xsl:when>
                    <xsl:when test="$work_type = 'Serie / Reihe'">
                        <rdf:type rdf:resource="https://dev.fiafcore.org/SerialWork" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">
                            Error: Unexpected value "<xsl:value-of select="$work_type"/>".
                        </xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>

            <!-- fiafcore:hasCountry -->

            <xsl:if test="ba:Ursprungsland">
                <xsl:for-each select="ba:Ursprungsland">
                    <xsl:variable name="country" select="translate(., ' ', ' ')" />
                    <xsl:choose>
                        <xsl:when test="$country = 'Amerika'" />
                        <xsl:when test="$country = 'unklar'" />
                        <xsl:when test="$country = 'Kosovo'" />
                        <xsl:when test="$country = 'Unbekannt'" />
                        <xsl:when test="$country = 'Jugoslawien'" />
                        <xsl:when test="$country = 'Union der Sozialistischen Sowjetrepubliken'" />
                        <xsl:when test="$country = 'Deutsches Reich (bis 1945)'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Germany" />
                        </xsl:when>
                        <xsl:when test="$country = 'Bundesrepublik Deutschland'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Germany" />
                        </xsl:when>
                        <xsl:when test="$country = 'Deutsche Demokratische Republik (1949-1990)'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Germany" />
                        </xsl:when>
                        <xsl:when test="$country = 'Vereinigte Staaten von Amerika'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/UnitedStatesOfAmerica" />
                        </xsl:when>
                        <xsl:when test="$country = 'Frankreich'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/France" />
                        </xsl:when>
                        <xsl:when test="$country = 'Österreich'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Austria" />
                        </xsl:when>
                        <xsl:when test="$country = 'Italien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Italy" />
                        </xsl:when>
                        <xsl:when test="$country = 'Vereinigtes Königreich von Großbritannien und Nordirland'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/UnitedKingdomOfGreatBritainAndNorthernIreland" />
                        </xsl:when>
                        <xsl:when test="$country = 'Schweiz'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Switzerland" />
                        </xsl:when>
                        <xsl:when test="$country = 'Deutschland, sowjetische Besatzungszone (1945-1949)'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Germany" />
                        </xsl:when>
                        <xsl:when test="$country = 'Dänemark'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Denmark" />
                        </xsl:when>
                        <xsl:when test="$country = 'Tschechoslowakei (-1993)'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Czechia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Schweden'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Sweden" />
                        </xsl:when>
                        <xsl:when test="$country = 'Ungarn'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Hungary" />
                        </xsl:when>
                        <xsl:when test="$country = 'Deutschland, französische Besatzungszone (1945-1949)'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Germany" />
                        </xsl:when>
                        <xsl:when test="$country = 'Polen'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Poland" />
                        </xsl:when>
                        <xsl:when test="$country = 'Niederlande'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/NetherlandsKingdomOfThe" />
                        </xsl:when>
                        <xsl:when test="$country = 'Norwegen'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Norway" />
                        </xsl:when>
                        <xsl:when test="$country = 'Belgien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Belgium" />
                        </xsl:when>
                        <xsl:when test="$country = 'Spanien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Spain" />
                        </xsl:when>
                        <xsl:when test="$country = 'Bulgarien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Bulgaria" />
                        </xsl:when>
                        <xsl:when test="$country = 'Japan'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Japan" />
                        </xsl:when>
                        <xsl:when test="$country = 'Russische Föderation'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/RussianFederation" />
                        </xsl:when>
                        <xsl:when test="$country = 'Israel'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Israel" />
                        </xsl:when>
                        <xsl:when test="$country = 'Kanada'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Canada" />
                        </xsl:when>
                        <xsl:when test="$country = 'Deutschland, amerikanische Besatzungszone (1945-1949)'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Germany" />
                        </xsl:when>
                        <xsl:when test="$country = 'Finnland'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Finland" />
                        </xsl:when>
                        <xsl:when test="$country = 'Berlin West (1949-1990)'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Germany" />
                        </xsl:when>
                        <xsl:when test="$country = 'Deutschland, britische Besatzungszone (1945-1949)'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Germany" />
                        </xsl:when>
                        <xsl:when test="$country = 'Tschechische Republik (ab 1993)'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Czechia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Rumänien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Romania" />
                        </xsl:when>
                        <xsl:when test="$country = 'Kroatien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Croatia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Luxemburg'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Luxembourg" />
                        </xsl:when>
                        <xsl:when test="$country = 'Irland, Republik'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Ireland" />
                        </xsl:when>
                        <xsl:when test="$country = 'Türkei'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Turkiye" />
                        </xsl:when>
                        <xsl:when test="$country = 'Kuba'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Cuba" />
                        </xsl:when>
                        <xsl:when test="$country = 'China, Volksrepublik'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/China" />
                        </xsl:when>
                        <xsl:when test="$country = 'Argentinien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Argentina" />
                        </xsl:when>
                        <xsl:when test="$country = 'Griechenland'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Greenland" />
                        </xsl:when>
                        <xsl:when test="$country = 'Island'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Iceland" />
                        </xsl:when>
                        <xsl:when test="$country = 'Australien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Australia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Palästinensische Autonomiegebiete'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/PalestineStateOf" />
                        </xsl:when>
                        <xsl:when test="$country = 'Mexiko'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Mexico" />
                        </xsl:when>
                        <xsl:when test="$country = 'Indien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/India" />
                        </xsl:when>
                        <xsl:when test="$country = 'Ukraine'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Ukraine" />
                        </xsl:when>
                        <xsl:when test="$country = 'Chile'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Chile" />
                        </xsl:when>
                        <xsl:when test="$country = 'Slowenien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Slovenia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Südafrika, Republik'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/SouthAfrica" />
                        </xsl:when>
                        <xsl:when test="$country = 'Korea, Republik'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/KoreaRepublicOf" />
                        </xsl:when>
                        <xsl:when test="$country = 'Bolivien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/BoliviaPlurinationalStateOf" />
                        </xsl:when>
                        <xsl:when test="$country = 'Estland'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Estonia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Kasachstan'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Kazakhstan" />
                        </xsl:when>
                        <xsl:when test="$country = 'Kolumbien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Colombia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Kamerun'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Cameroon" />
                        </xsl:when>
                        <xsl:when test="$country = 'Iran'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/IranIslamicRepublicOf" />
                        </xsl:when>
                        <xsl:when test="$country = 'Portugal'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Portugal" />
                        </xsl:when>
                        <xsl:when test="$country = 'Uruguay'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Uruguay" />
                        </xsl:when>
                        <xsl:when test="$country = 'Weißrussland'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Belarus" />
                        </xsl:when>
                        <xsl:when test="$country = 'Georgien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Georgia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Brasilien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Brazil" />
                        </xsl:when>
                        <xsl:when test="$country = 'Zypern, Republik'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Cyprus" />
                        </xsl:when>
                        <xsl:when test="$country = 'Vietnam'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/VietNam" />
                        </xsl:when>
                        <xsl:when test="$country = 'Afghanistan'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Afghanistan" />
                        </xsl:when>
                        <xsl:when test="$country = 'Albanien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Albania" />
                        </xsl:when>
                        <xsl:when test="$country = 'Burkina Faso'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/BurkinaFaso" />
                        </xsl:when>
                        <xsl:when test="$country = 'Deutschland - Alliierte Besatzung (1945-1949)'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Germany" />
                        </xsl:when>
                        <xsl:when test="$country = 'Guinea, Republik'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Guinea" />
                        </xsl:when>
                        <xsl:when test="$country = 'Neuseeland'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/NewZealand" />
                        </xsl:when>
                        <xsl:when test="$country = 'Ägypten'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Egypt" />
                        </xsl:when>
                        <xsl:when test="$country = 'Algerien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Algeria" />
                        </xsl:when>
                        <xsl:when test="$country = 'Deutschland, westliche Besatzungszonen (1945-1949)'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Germany" />
                        </xsl:when>
                        <xsl:when test="$country = 'Katar'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Qatar" />
                        </xsl:when>
                        <xsl:when test="$country = 'Syrien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/SyrianArabRepublic" />
                        </xsl:when>
                        <xsl:when test="$country = 'Thailand'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Thailand" />
                        </xsl:when>
                        <xsl:when test="$country = 'Lettland'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Latvia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Marokko'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Morocco" />
                        </xsl:when>
                        <xsl:when test="$country = 'Peru'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Peru" />
                        </xsl:when>
                        <xsl:when test="$country = 'Philippinen'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Philippines" />
                        </xsl:when>
                        <xsl:when test="$country = 'Litauen'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Lithuania" />
                        </xsl:when>
                        <xsl:when test="$country = 'Saudi-Arabien, Königreich'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/SaudiArabia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Kenia'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Kenya" />
                        </xsl:when>
                        <xsl:when test="$country = 'Äthiopien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Ethiopia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Nepal'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Nepal" />
                        </xsl:when>
                        <xsl:when test="$country = 'Mongolei'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Mongolia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Slowakei (ab 1993)'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Slovakia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Bosnien und Herzegowina'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/BosniaAndHerzegovina" />
                        </xsl:when>
                        <xsl:when test="$country = 'Kirgisistan'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Kyrgyzstan" />
                        </xsl:when>
                        <xsl:when test="$country = 'Monaco'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Monaco" />
                        </xsl:when>
                        <xsl:when test="$country = 'Vereinigte Arabische Emirate'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/UnitedArabEmirates" />
                        </xsl:when>
                        <xsl:when test="$country = 'Ecuador'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Ecuador" />
                        </xsl:when>
                        <xsl:when test="$country = 'Libanon'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Lebanon" />
                        </xsl:when>
                        <xsl:when test="$country = 'Ghana, Republik'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Ghana" />
                        </xsl:when>
                        <xsl:when test="$country = 'Serbien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Serbia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Hongkong'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/HongKong" />
                        </xsl:when>
                        <xsl:when test="$country = 'Indonesien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Indonesia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Tunesien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Tunisia" />
                        </xsl:when>
                        <xsl:when test="$country = 'Irak'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Iraq" />
                        </xsl:when>
                        <xsl:when test="$country = 'Jordanien'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Jordan" />
                        </xsl:when>
                        <xsl:when test="$country = 'Niger'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Niger" />
                        </xsl:when>
                        <xsl:when test="$country = 'Taiwan'">
                            <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/TaiwanProvinceOfChina" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:message terminate="yes">
                                Error: Unexpected value "<xsl:value-of select="$country"/>".
                            </xsl:message>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:if>

            <!-- fiafcore:hasEvent -->

            <fiaf:hasEvent>
                <rdf:Description>
                    <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionEvent"/>
                    <xsl:if test="ba:ProdJahrVon">
                        <fiaf:hasDate>
                            <xsl:value-of select="ba:ProdJahrVon"/>
                        </fiaf:hasDate>
                    </xsl:if>
                    <xsl:for-each select="ba:Credit/ba:Koerperschaft">
                        <fiaf:hasActivity>
                            <rdf:Description>
                                <xsl:variable name="funktion" select="ba:Funktion/@Funktion"/>
                                <xsl:choose>
                                    <xsl:when test="$funktion = 'Produktionsfirma / Produktion'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionCompany" />
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Produzent'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Producer" />
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Verleih'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Distributor"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Herkunft'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Auftraggeber'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Filmverleih'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Distributor"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Zensurantragsteller'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Co-Produktionsfirma / Produktion'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Verleih (Erstverleih)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Orchester / Chor / Ensemble'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Filmförderung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Herstellung / Herstellungsleitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'In Zusammenarbeit mit'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Produktionsleitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionManager"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Synchronstudio / Synchronisation'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Synchrontext (Deutscher Text)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Verleih (weitere Verleiher)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Tonsystem'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Vertrieb'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Co-Produzent'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Regie / Spielleitung / Realisation'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Unbekannt'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Kamera/Bild/Bildgestaltung/Fotografie'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Ton/Tonmeister'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Weitere Mitarbeit'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Darsteller'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Verleih (letzter bekannter Verleih)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Gesamtgestaltung / -ausstattung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Fachberatung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Drehbuch'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Schnitt/Montage'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Trick (im Realfilm)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/SpecialEffects" />
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Produktion'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Musik (Filmkomponist)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Produktionstechnik (allgemein)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Synchronregie'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Tonmischung/Mischton'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Redaktion'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Animation'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Animator"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Mitwirkung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Aufnahmeleitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionManager"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Kostüme'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/CostumeDesigner"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Gestaltung (Trickfilm)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Gesamtleitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Ton-Bearbeitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Geräusche'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Atelier'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Spezialkamera / Trickkamera'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Idee'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Sprecher/in (allgemein)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Narrator"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Zeichnungen'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Gesamtdrehstab'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Künstlerische Leitung / Oberleitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Literarische Vorlage (Autor)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/SourceMaterial"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Requisite'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Tanzsolist'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Musikbearbeitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/MusicEditor"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Medienhersteller'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:message terminate="yes">
                                            Error: Unexpected value "<xsl:value-of select="$funktion"/>".
                                        </xsl:message>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <fiaf:hasAgent>
                                    <rdf:Description rdf:about="bundesarchiv://resource/agent/{@uuid}">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Organisation"/>
                                        <rdfs:label>
                                            <xsl:value-of select="normalize-space(@Koerperschaftsname)"/>
                                        </rdfs:label>
                                        <fiaf:hasIdentifier>
                                            <rdf:Description rdf:about="bundesarchiv://identifier/agent/{@uuid}">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Identifier" />
                                                <fiaf:hasIdentifierValue>
                                                    <xsl:value-of select="@uuid" />
                                                </fiaf:hasIdentifierValue>
                                                <fiaf:hasIdentifierAuthority>
                                                    <rdf:Description rdf:about="bundesarchiv://resource/agent/bundesarchiv">
                                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Organisation" />
                                                    </rdf:Description>
                                                </fiaf:hasIdentifierAuthority>
                                            </rdf:Description>
                                        </fiaf:hasIdentifier>
                                    </rdf:Description>
                                </fiaf:hasAgent>
                            </rdf:Description>
                        </fiaf:hasActivity>
                    </xsl:for-each>
                    <xsl:for-each select="ba:Credit/ba:Person">
                        <fiaf:hasActivity>
                            <rdf:Description>
                                <xsl:variable name="funktion" select="ba:Funktion/@Funktion"/>
                                <xsl:choose>
                                    <xsl:when test="$funktion = 'Darsteller'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/CastMember"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Kamera/Bild/Bildgestaltung/Fotografie'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Cinematographer"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Regie / Spielleitung / Realisation'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Director"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Drehbuch'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Writer"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Kameraführung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Cinematographer"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Schnitt / Montage'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/FilmEditor"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Musik'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Composer"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Ton'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Produktionsleitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionManager"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Produzent'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Sprecher/in (allgemein)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Narrator"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Dramaturgie'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Aufnahmeleitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionManager"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Produktionsfirma / Produktion'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Dialoge / Text'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Writer"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Szenarium'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Writer"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Mitwirkung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Fachberatung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Maske'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/MakeUpArtist"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Animation'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Animator"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Weitere Mitarbeit'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Literarische Vorlage (Autor)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/SourceMaterial"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Regie-Assistenz'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/AssistantDirector"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Kamera-Assistenz'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/CameraAssistant"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Kostüme'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/CostumeDesigner"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Musikbearbeitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/MusicEditor"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Trick (im Realfilm)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/SpecialEffects" />
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Redaktion'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Bauausführung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Gestaltung (Trickfilm)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Standfotograf'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Co-Produzent'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Synchronsprecher'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Puppengestaltung / -figuren'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Auftraggeber'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Requisite'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Puppenführung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Idee'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Szenenbild (Filmarchitekt / Bühnenbildner)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Musik (Filmkomponist)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Puppenspiel'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Gesamtgestaltung / -ausstattung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Gesangssolist'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Dekoration'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Musikalische Leitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Zensurantragsteller'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Spezialkamera / Trickkamera'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Graphik / Design'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Hintergrundgestaltung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Herstellung / Herstellungsleitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Musik-, Lied-, Balletttitel (Autor)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Kommentarsprecher / Berichterstatter / Korrespondent'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Übernommene Musik'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Gesamtleitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Manuskript'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Gewandmeister'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Choreographie'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Geräusche'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Synchronmitwirkende'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Musikberatung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Scherenschnitt'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Co-Produktionsfirma / Produktion'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Zeichnungen'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Ausstattung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Ton-Mischung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Licht / Beleuchtung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Instrumentalsolist'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Filmverleih'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Distributor"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Erzählender / Vortragender'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Assistenz-Regie'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Exposé / Treatment'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Unbekannt'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Storyboard'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Set Design / Szenenausstattung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Musik-, Lied-, Balletttitel (Komponist)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Produktionstechnik (allgemein)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Spezialeffekte'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Tanzsolist'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Künstlerische Leitung / Oberleitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Synchronschnitt'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Co-Regie'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'In Zusammenarbeit mit'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Orchester / Chor / Ensemble'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Gesamtdrehstab'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Zweite Kamera'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'weitere Darsteller'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Künstlerische Mitarbeiter'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Musikzusammenstellung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Kinderdarsteller'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Synchronregie'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Musikalische Vorlage (Autor)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Dialogregie / Tonregie'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Wissenschaftliche Leitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Garderobier'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Sonstige Solisten'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Synchrontext (Deutscher Text)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Schnitt-Assistenz'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Sonstige Assistenten'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Entwürfe (Puppen und Figuren)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Titel'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Verleih (Erstverleih)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Musikredaktion'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Interviewer'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Script / Continuity'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Zweite Regie'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Drehbuch-Mitarbeit'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Recherche'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Stunts und Doubles'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Expeditionsleitung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Ballettmeister'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Übersetzer'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Filmförderung'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Tonsystem'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Deutsche Synchronsprecher'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Verleih (letzter bekannter Verleih)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Verleih (weitere Verleiher)'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Verleih'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Distributor"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Treatment'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Executive Producer'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Synchronton'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Laiendarsteller'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Titelgrafik'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Zwischentitel'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:when test="$funktion = 'Synchronstudio / Synchronisation'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Activity"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:message terminate="yes">
                                            Error: Unexpected value "<xsl:value-of select="$funktion"/>".
                                        </xsl:message>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <fiaf:hasAgent>
                                    <rdf:Description rdf:about="bundesarchiv://resource/agent/{@uuid}">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Person"/>
                                        <rdfs:label>
                                            <xsl:value-of select="normalize-space(concat(@Vorname, ' ', @Nachname))"/>
                                        </rdfs:label>
                                        <fiaf:hasIdentifier>
                                            <rdf:Description rdf:about="bundesarchiv://identifier/agent/{@uuid}">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Identifier" />
                                                <fiaf:hasIdentifierValue>
                                                    <xsl:value-of select="@uuid" />
                                                </fiaf:hasIdentifierValue>
                                                <fiaf:hasIdentifierAuthority>
                                                    <rdf:Description rdf:about="bundesarchiv://resource/agent/bundesarchiv">
                                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Organisation" />
                                                    </rdf:Description>
                                                </fiaf:hasIdentifierAuthority>
                                            </rdf:Description>
                                        </fiaf:hasIdentifier>
                                    </rdf:Description>
                                </fiaf:hasAgent>
                            </rdf:Description>
                        </fiaf:hasActivity>
                    </xsl:for-each>
                </rdf:Description>
            </fiaf:hasEvent>

            <!-- fiafcore:hasForm -->

            <xsl:if test="ba:Gattung">
                <xsl:for-each select="ba:Gattung">
                    <xsl:variable name="form" select="translate(., ' ', '_')" />
                    <xsl:choose>
                        <xsl:when test="$form = 'Wochenschau'" />
                        <xsl:when test="$form = 'NichtSpielfilm'" />
                        <xsl:when test="$form = 'Animationsfilm'" />
                        <xsl:when test="$form = 'Lehr-,_Unterrichts-_und_Informationsfilm'" />
                        <xsl:when test="$form = 'Werbefilm'" />
                        <xsl:when test="$form = 'Kulturfilm'" />
                        <xsl:when test="$form = 'Reportage'" />
                        <xsl:when test="$form = 'unbekannt'" />
                        <xsl:when test="$form = 'Dokumentarfilm_(Nichtspielfilm)'" />
                        <xsl:when test="$form = 'Fernsehfilm'" />
                        <xsl:when test="$form = 'Populärwiss._Film'" />
                        <xsl:when test="$form = 'Medizinfilm'" />
                        <xsl:when test="$form = 'Periodika'" />
                        <xsl:when test="$form = 'Magazin'" />
                        <xsl:when test="$form = 'Experimentalfilm'" />
                        <xsl:when test="$form = 'Nichtnarrativer_Film'" />
                        <xsl:when test="$form = 'Porträtfilm'" />
                        <xsl:when test="$form = 'Aufklärungsfilm'" />
                        <xsl:when test="$form = 'Sach-_und_Ereignisdokument'" />
                        <xsl:when test="$form = 'Privatfilm'" />
                        <xsl:when test="$form = 'Literaturverfilmung'" />
                        <xsl:when test="$form = 'Industriefilm'" />
                        <xsl:when test="$form = 'Lustspiel'" />
                        <xsl:when test="$form = 'Kinderfilm'" />
                        <xsl:when test="$form = 'Biografischer_Film'" />
                        <xsl:when test="$form = 'Unterrichtsfilm'" />
                        <xsl:when test="$form = 'Städte-_u.Landschaftsfilm'" />
                        <xsl:when test="$form = 'Propagandafilm'" />
                        <xsl:when test="$form = 'Expeditionsfilm'" />
                        <xsl:when test="$form = 'Interview'" />
                        <xsl:when test="$form = 'Komödie'" />
                        <xsl:when test="$form = 'Sportfilm'" />
                        <xsl:when test="$form = 'Naturfilm'" />
                        <xsl:when test="$form = 'Spot'" />
                        <xsl:when test="$form = 'Wahlfilm'" />
                        <xsl:when test="$form = 'Episodenfilm'" />
                        <xsl:when test="$form = 'Abenteuerfilm'" />
                        <xsl:when test="$form = 'Kriminalfilm'" />
                        <xsl:when test="$form = 'Operettenfilm'" />
                        <xsl:when test="$form = 'Politisch-geogr._Film'" />
                        <xsl:when test="$form = 'Militärfilm'" />
                        <xsl:when test="$form = 'Satire'" />
                        <xsl:when test="$form = 'Länderfilm'" />
                        <xsl:when test="$form = 'Autorenfilm'" />
                        <xsl:when test="$form = 'Heimatfilm'" />
                        <xsl:when test="$form = 'Dokumentarfilm'" />
                        <xsl:when test="$form = 'Land-/Forstwirtschaftsfilm'" />
                        <xsl:when test="$form = 'Kriegsfilm'" />
                        <xsl:when test="$form = 'Historischer_Film'" />
                        <xsl:when test="$form = 'Biologischer_Film'" />
                        <xsl:when test="$form = 'Gegenwartsfilm'" />
                        <xsl:when test="$form = 'Feuilleton'" />
                        <xsl:when test="$form = 'Kunstfilm'" />
                        <xsl:when test="$form = 'Verkehrsfilm'" />
                        <xsl:when test="$form = 'Ballettfilm'" />
                        <xsl:when test="$form = 'Märchenfilm'" />
                        <xsl:when test="$form = 'Philosophischer_Film'" />
                        <xsl:when test="$form = 'Hist._Ausstattungsfilm'" />
                        <xsl:when test="$form = 'Frauenfilm'" />
                        <xsl:when test="$form = 'Szenische_Dokumentation'" />
                        <xsl:when test="$form = 'Gangsterfilm'" />
                        <xsl:when test="$form = 'Spionagefilm'" />
                        <xsl:when test="$form = 'Arztfilm'" />
                        <xsl:when test="$form = 'Melodram'" />
                        <xsl:when test="$form = 'Opernfilm'" />
                        <xsl:when test="$form = 'Zirkusfilm'" />
                        <xsl:when test="$form = 'Horrorfilm'" />
                        <xsl:when test="$form = 'Politthriller'" />
                        <xsl:when test="$form = 'Fotofilm'" />
                        <xsl:when test="$form = 'Tragödie'" />
                        <xsl:when test="$form = 'Fersehspiel'" />
                        <xsl:when test="$form = 'Science_Fiction'" />
                        <xsl:when test="$form = 'Revuefilm'" />
                        <xsl:when test="$form = 'Parodie'" />
                        <xsl:when test="$form = 'Spielfilm'">
                            <fiaf:hasForm rdf:resource="https://dev.fiafcore.org/FeatureFilm" />
                        </xsl:when>
                        <xsl:when test="$form = 'Serie'">
                            <fiaf:hasForm rdf:resource="https://dev.fiafcore.org/Series" />
                        </xsl:when>
                        <xsl:when test="$form = 'Trailer'">
                            <fiaf:hasForm rdf:resource="https://dev.fiafcore.org/Trailer" />
                        </xsl:when>
                        <xsl:when test="$form = 'Amateurfilm'">
                            <fiaf:hasForm rdf:resource="https://dev.fiafcore.org/AmateurFilm" />
                        </xsl:when>
                        <xsl:when test="$form = 'Kompilationsfilm'">
                            <fiaf:hasForm rdf:resource="https://dev.fiafcore.org/CompilationFilm" />
                        </xsl:when>
                        <xsl:when test="$form = 'Kurzspielfilm'">
                            <fiaf:hasForm rdf:resource="https://dev.fiafcore.org/ShortFilm" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:message terminate="yes">
                                Error: Unexpected value "<xsl:value-of select="$form"/>".
                            </xsl:message>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:if>

            <!-- fiafcore:hasGenre -->

            <xsl:if test="ba:Genre">
                <xsl:for-each select="ba:Genre">
                    <xsl:variable name="genre" select="translate(., ' ', '_')" />
                    <xsl:choose>
                        <xsl:when test="$genre = 'Wochenschau'" />
                        <xsl:when test="$genre = 'Wochenschau_(Segment/Sujet/Ausschnitt)'" />
                        <xsl:when test="$genre = 'Sach-_und_Ereignisdokument'" />
                        <xsl:when test="$genre = 'Trailer'" />
                        <xsl:when test="$genre = 'Trickart:_Puppentrick'" />
                        <xsl:when test="$genre = 'Reportage'" />
                        <xsl:when test="$genre = 'Amateurfilm'" />
                        <xsl:when test="$genre = 'Fernsehfilm'" />
                        <xsl:when test="$genre = 'Periodika'" />
                        <xsl:when test="$genre = 'Trickart:_Legetrick/Flachfigurenfilm'" />
                        <xsl:when test="$genre = 'Lustspiel'" />
                        <xsl:when test="$genre = 'Spot'" />
                        <xsl:when test="$genre = 'Privatfilm'" />
                        <xsl:when test="$genre = 'Trickart:_Silhouettentrick'" />
                        <xsl:when test="$genre = 'Trickart:_Sach-/Realtrick'" />
                        <xsl:when test="$genre = 'Portraitfilm'" />
                        <xsl:when test="$genre = 'Personendokument'" />
                        <xsl:when test="$genre = 'Monatsschau'" />
                        <xsl:when test="$genre = 'Historischer_Film'" />
                        <xsl:when test="$genre = 'Land-/Forstwirtschadtsfilm'" />
                        <xsl:when test="$genre = 'Wahlfilm'" />
                        <xsl:when test="$genre = 'Biografischer_Film'" />
                        <xsl:when test="$genre = 'Trickart:_Realaufnahmen_im_Trickfilm'" />
                        <xsl:when test="$genre = 'Expeditionsfilm'" />
                        <xsl:when test="$genre = 'Länderfilm'" />
                        <xsl:when test="$genre = 'Naturfilm'" />
                        <xsl:when test="$genre = 'Politisch-geogr._Film'" />
                        <xsl:when test="$genre = 'Medizinfilm'" />
                        <xsl:when test="$genre = 'Kompilationsfilm'" />
                        <xsl:when test="$genre = 'Gegenwartsfilm'" />
                        <xsl:when test="$genre = 'Dokumentarischer_Spielfilm'" />
                        <xsl:when test="$genre = 'Trickart:_Drahtfigurentrick'" />
                        <xsl:when test="$genre = 'Interview'" />
                        <xsl:when test="$genre = 'Kunstfilm'" />
                        <xsl:when test="$genre = 'Trickart:_Plasteline-/Knettrick/Claymation'" />
                        <xsl:when test="$genre = 'Melodram'" />
                        <xsl:when test="$genre = 'Szenische_Dokumentation'" />
                        <xsl:when test="$genre = 'Jugendfilm'" />
                        <xsl:when test="$genre = 'Abenteuerfilm'" />
                        <xsl:when test="$genre = 'Tanzfilm'" />
                        <xsl:when test="$genre = 'Ethnografischer_Film'" />
                        <xsl:when test="$genre = 'Trickart:_Computeranimation'" />
                        <xsl:when test="$genre = 'Religionsfilm'" />
                        <xsl:when test="$genre = 'Tragödie'" />
                        <xsl:when test="$genre = 'Verkehrsfilm'" />
                        <xsl:when test="$genre = 'Operettenfilm'" />
                        <xsl:when test="$genre = 'Umweltfilm'" />
                        <xsl:when test="$genre = 'Zirkusfilm'" />
                        <xsl:when test="$genre = 'Heimatfilm'" />
                        <xsl:when test="$genre = 'Detektivfilm'" />
                        <xsl:when test="$genre = 'Trickart:_Sonstige_Trickarten'" />
                        <xsl:when test="$genre = 'Western'" />
                        <xsl:when test="$genre = 'Slapstick'" />
                        <xsl:when test="$genre = 'Biologischer_Film'" />
                        <xsl:when test="$genre = 'Bergfilm'" />
                        <xsl:when test="$genre = 'Thriller'" />
                        <xsl:when test="$genre = 'Trickart:_Mischtrick'" />
                        <xsl:when test="$genre = 'Musicalfilm'" />
                        <xsl:when test="$genre = 'Ballettfilm'" />
                        <xsl:when test="$genre = 'Feuilleton'" />
                        <xsl:when test="$genre = 'Opernfilm'" />
                        <xsl:when test="$genre = 'Antikriegsfilm'" />
                        <xsl:when test="$genre = 'Fantasyfilm'" />
                        <xsl:when test="$genre = 'Trickart:_Fototrick'" />
                        <xsl:when test="$genre = 'Frauenfilm'" />
                        <xsl:when test="$genre = 'Arztfilm'" />
                        <xsl:when test="$genre = 'Experimentalfilm'" />
                        <xsl:when test="$genre = 'Forschungsfilm'" />
                        <xsl:when test="$genre = 'Trickart:_Reliefanimation/Zeichentrick'" />
                        <xsl:when test="$genre = 'Sensationsfilm'" />
                        <xsl:when test="$genre = 'Gerichtsfilm'" />
                        <xsl:when test="$genre = 'Parodie'" />
                        <xsl:when test="$genre = 'Trickart:_Collagentrick'" />
                        <xsl:when test="$genre = 'Spionagefilm'" />
                        <xsl:when test="$genre = 'Revuefilm'" />
                        <xsl:when test="$genre = 'Science_Fiction'" />
                        <xsl:when test="$genre = 'Tragikomödie'" />
                        <xsl:when test="$genre = 'Horrofilm'" />
                        <xsl:when test="$genre = 'Magazin'" />
                        <xsl:when test="$genre = 'Erotischer_Film'" />
                        <xsl:when test="$genre = 'Trickart:_Pixilation'" />
                        <xsl:when test="$genre = 'Fotofilm'" />
                        <xsl:when test="$genre = 'Hist._Ausstattungsfilm'" />
                        <xsl:when test="$genre = 'Polithriller'" />
                        <xsl:when test="$genre = 'Indianerfilm'" />
                        <xsl:when test="$genre = 'Phantastischer_Film'" />
                        <xsl:when test="$genre = 'Gangsterfilm'" />
                        <xsl:when test="$genre = 'Gefilmtes_Theater'" />
                        <xsl:when test="$genre = 'Marionettenfilm'" />
                        <xsl:when test="$genre = 'Unterrichtsfilm'" />
                        <xsl:when test="$genre = 'Trickart:_Sandanimation'" />
                        <xsl:when test="$genre = 'Mischfilm_(Kombination_aus_Real-_u._Trickfilm)'" />
                        <xsl:when test="$genre = 'Surrealistischer_Film'" />
                        <xsl:when test="$genre = 'Trickart:_Scherenschnitt'" />
                        <xsl:when test="$genre = 'Actionfilm'" />
                        <xsl:when test="$genre = 'Absoluter_Film'" />
                        <xsl:when test="$genre = 'Abstrakter_Film'" />
                        <xsl:when test="$genre = 'Singspiel'" />
                        <xsl:when test="$genre = 'Computerfilm'" />
                        <xsl:when test="$genre = 'Discofilm'" />
                        <xsl:when test="$genre = 'Trickart:_Nonkameratrick/Direct_Animation'" />
                        <xsl:when test="$genre = 'Trickart:_Modelltrick'" />
                        <xsl:when test="$genre = 'Revolutionsfilm'" />
                        <xsl:when test="$genre = 'Road_Movie'" />
                        <xsl:when test="$genre = 'Stabpuppenfilm'" />
                        <xsl:when test="$genre = 'Materialfilm'" />
                        <xsl:when test="$genre = 'Trickart:_Folienanimation'" />
                        <xsl:when test="$genre = 'Expressionistischer_Film'" />
                        <xsl:when test="$genre = 'Philosophischer_Film'" />
                        <xsl:when test="$genre = 'Fernsehspiel'" />
                        <xsl:when test="$genre = 'Partisanenfilm'" />
                        <xsl:when test="$genre = 'Trickart:_Zeichentrick'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/AnimationFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Kinderfilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/ChildrensFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Städte-_u._Landschaftsfilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/CityAndLandscapeFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Kulturfilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/CulturalFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Propagandafilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/PropagandaFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Literaturverfilmung'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/LiteraryAdaptationFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Komödie'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/ComedyFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Industriefilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/IndustrialFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Drama'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/DramaFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Tierfilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/AnimalFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Satire'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/SatireFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Märchenfilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/FairyTaleFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Militärfilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/MilitaryFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Kriegsfilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/WarFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Populärwissenschaftlicher_Film'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/PopularScienceFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Sportfilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/SportsFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Kriminalfilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/CrimeFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Handpuppenfilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/HandPuppetFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Technikfilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/TechnicalFilm" />
                        </xsl:when>
                        <xsl:when test="$genre = 'Aufklärungsfilm'">
                            <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/EducationalFilm" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:message terminate="yes">
                                Error: Unexpected value "<xsl:value-of select="$genre"/>".
                            </xsl:message>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:if>

            <!-- fiafcore:hasIdentifier -->

            <fiaf:hasIdentifier>
                <rdf:Description rdf:about="bundesarchiv://identifier/work/{@uuid}">
                    <rdf:type rdf:resource="https://dev.fiafcore.org/Identifier" />
                    <fiaf:hasIdentifierValue>
                        <xsl:value-of select="@uuid" />
                    </fiaf:hasIdentifierValue>
                    <fiaf:hasIdentifierAuthority>
                        <rdf:Description rdf:about="bundesarchiv://resource/agent/bundesarchiv">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/Organisation" />
                        </rdf:Description>
                    </fiaf:hasIdentifierAuthority>
                </rdf:Description>
            </fiaf:hasIdentifier>

            <!-- fiafcore:hasManifestation -->

            <xsl:for-each select="ba:Manifestation">
                <fiaf:hasManifestation>
                    <rdf:Description rdf:about="bundesarchiv://resource/manifestation/{@uuid}" />
                </fiaf:hasManifestation>
            </xsl:for-each>

            <!-- fiafcore:hasTitle -->

            <xsl:for-each select="ba:IDTitel">
                <fiaf:hasTitle>
                    <rdf:Description>
                        <rdf:type rdf:resource="https://dev.fiafcore.org/IdentifiyingTitle" />
                        <fiaf:hasTitleValue>
                            <xsl:value-of select="." />
                        </fiaf:hasTitleValue>
                    </rdf:Description>
                </fiaf:hasTitle>
            </xsl:for-each>

        </rdf:Description>
    </xsl:template>

    <!-- fiafcore:Manifestation -->

    <xsl:template match="ba:Manifestation">
        <rdf:Description rdf:about="bundesarchiv://resource/manifestation/{@uuid}">

            <xsl:if test="not(ba:Manifestationstyp)">
                <rdf:type rdf:resource="https://dev.fiafcore.org/Manifestation" />
            </xsl:if>
            <xsl:if test="ba:Manifestationstyp">
                <xsl:variable name="manifestation_type" select="ba:Manifestationstyp" />
                <xsl:choose>
                    <xsl:when test="$manifestation_type = 'Standardmanifestation'">
                        <rdf:type rdf:resource="https://dev.fiafcore.org/Manifestation" />
                    </xsl:when>
                    <xsl:when test="$manifestation_type = 'Migrationsmanifestation'">
                        <rdf:type rdf:resource="https://dev.fiafcore.org/Manifestation" />
                    </xsl:when>
                    <xsl:when test="$manifestation_type = 'Weitere Manifestation'">
                        <rdf:type rdf:resource="https://dev.fiafcore.org/Manifestation" />
                    </xsl:when>
                    <xsl:when test="$manifestation_type = 'Herstellungsprozess (Pre-Release)'">
                        <rdf:type rdf:resource="https://dev.fiafcore.org/PreReleaseManifestation" />
                    </xsl:when>
                    <xsl:when test="$manifestation_type = 'Kinofassung (Theatrical distribution)'">
                        <rdf:type rdf:resource="https://dev.fiafcore.org/TheatricalManifestation" />
                    </xsl:when>
                    <xsl:when test="$manifestation_type = 'Unidentifizierte Manifestation'">
                        <rdf:type rdf:resource="https://dev.fiafcore.org/Manifestation" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">
                            Error: Unexpected value "<xsl:value-of select="$manifestation_type"/>".
                        </xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>

            <!-- fiaf:hasExtent -->

            <xsl:if test="ba:Laufzeit">
                <xsl:for-each select="ba:Laufzeit">
                    <fiaf:hasExtent>
                        <rdf:Description>
                            <rdf:type rdf:resource="https://dev.fiafcore.org/Minute" />
                            <fiaf:hasExtentValue>
                                <xsl:value-of select="." />
                            </fiaf:hasExtentValue>
                        </rdf:Description>
                    </fiaf:hasExtent>
                </xsl:for-each>
            </xsl:if>

            <xsl:if test="ba:Gesamtlaenge">
                <xsl:for-each select="ba:Gesamtlaenge">
                    <fiaf:hasExtent>
                        <rdf:Description>
                            <rdf:type rdf:resource="https://dev.fiafcore.org/Metre" />
                            <fiaf:hasExtentValue>
                                <xsl:value-of select="." />
                            </fiaf:hasExtentValue>
                        </rdf:Description>
                    </fiaf:hasExtent>
                </xsl:for-each>
            </xsl:if>

            <!-- fiafcore:hasIdentifier -->

            <fiaf:hasIdentifier>
                <rdf:Description rdf:about="bundesarchiv://identifier/manifestation/{@uuid}">
                    <rdf:type rdf:resource="https://dev.fiafcore.org/Identifier" />
                    <fiaf:hasIdentifierValue>
                        <xsl:value-of select="@uuid" />
                    </fiaf:hasIdentifierValue>
                    <fiaf:hasIdentifierAuthority>
                        <rdf:Description rdf:about="bundesarchiv://resource/agent/bundesarchiv">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/Organisation" />
                        </rdf:Description>
                    </fiaf:hasIdentifierAuthority>
                </rdf:Description>
            </fiaf:hasIdentifier>

            <!-- fiaf:hasItem -->

            <xsl:for-each select="ba:Exemplar">
                <fiaf:hasItem>
                    <rdf:Description rdf:about="bundesarchiv://resource/item/{@uuid}" />
                </fiaf:hasItem>
            </xsl:for-each>

            <!-- fiaf:hasLanguageUsage -->

            <xsl:if test="ba:Sprache">
                <xsl:for-each select="ba:Sprache">
                    <fiaf:hasLanguageUsage>
                        <rdf:Description>
                            <xsl:choose>
                                <xsl:when test="not(@sprachgebrauch) or @sprachgebrauch = ''">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Haupttitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Kommentarton'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Audio'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'unbekannt'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Synchronisation'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Blitztitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Sprache'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/SpokenLanguage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Sprache'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/SpokenLanguage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Zwischentitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Intertitles" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Vorspann'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Credits" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Untertitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Subtitles" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Abspann'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Credits" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:message terminate="yes">
                                        Error: Unexpected value "<xsl:value-of select="@sprachgebrauch"/>".
                                    </xsl:message>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="not(@sprache) or @sprache = ''" />
                                <xsl:when test="@sprache = 'Obersorbisch'" />
                                <xsl:when test="@sprache = 'Südamerikanisch'" />
                                <xsl:when test="@sprache = 'Nicht zu entscheiden'" />
                                <xsl:when test="@sprache = 'Laute / Geräusche'" />
                                <xsl:when test="@sprache = 'Einzelne andere Sprachen'" />
                                <xsl:when test="@sprache = 'Mehrere Sprachen'" />
                                <xsl:when test="@sprache = 'Stumm'" />
                                <xsl:when test="@sprache = 'Sorbisch (Andere)'" />
                                <xsl:when test="@sprache = 'Musik'" />
                                <xsl:when test="@sprache = 'Ohne'" />
                                <xsl:when test="@sprache = 'Geräusche/ Musik'" />
                                <xsl:when test="@sprache = 'unbekannt'" />
                                <xsl:when test="@sprache = 'Deutsch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/German" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Spanisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Spanish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Englisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/English" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Französisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/French" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Russisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Russian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Niederländisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Dutch" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Portugiesisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Portuguese" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Italienisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Italian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Türkisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Turkish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Griechisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Greek" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Afrikaans'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Afrikaans" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Arabisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Arabic" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Polnisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Polish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Tschechisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Czech" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Ungarisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Hungarian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Amerikanisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/English" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Dänisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Danish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Schwedisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Swedish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Lettisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Latvian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Brasilianisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Portuguese" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Ukrainisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Ukrainian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Japanisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Japanese" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Hebräisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Hebrew" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Rumänisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Romanian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Bosnisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Bosnian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Slowakisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Slovak" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Isländisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Icelandic" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Bulgarisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Bulgarian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Serbokroatisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Serbian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Persisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Persian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Kroatisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Croatian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Jiddisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Yiddish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Thaisprachen'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Thai" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Amharisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Amharic" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Norwegisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Norwegian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Hindi oder Indoarisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Hindi" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Finnisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Finnish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Serbisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Serbian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Baskisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Basque" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Belorussisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Belarusian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Swahili (= Suaheli, Kisuaheli)'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Swahili" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Estnisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Estonian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Indonesisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Indonesian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Chinesisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Chinese" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Vietnamesisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Vietnamese" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Litauisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Lithuanian" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:message terminate="yes">
                                        Error: Unexpected value "<xsl:value-of select="@sprache"/>".
                                    </xsl:message>
                                </xsl:otherwise>
                            </xsl:choose>
                        </rdf:Description>
                    </fiaf:hasLanguageUsage>
                </xsl:for-each>
            </xsl:if>

            <!-- fiaf:hasSoundCharacteristic -->

            <!-- Provided dataset may not contain this data. -->

            <!-- fiaf:hasTitle -->

            <xsl:if test="ba:Filmtitel">
                <xsl:for-each select="ba:Filmtitel">
                    <fiaf:hasTitle>
                        <rdf:Description>
                            <xsl:choose>
                                <xsl:when test="not(@typ) or @typ = ''">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Originaltitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/TitleProper" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Übernahmetitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/AcquisitionTitle" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Sonstige Titel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Arbeitstitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/WorkingTitle" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Archivtitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Zusatztitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'fremdsprachiger Originaltitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Untertitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'unbekannt'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'weiterer Originaltitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Serientitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/SeriesTitle" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Deutscher Verleihtitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'fremdsprachiger Verleihtitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Episodentitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Kopientitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Interim Record'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Büchsentitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Übersetzungstitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/TranslatedTitle" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Titel der Abgebenden Stelle'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Interim Title'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Erster Zwischentitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Verifizierter Titel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Übergeordneter Serientitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Schreibvariante'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/SearchTitle" />
                                </xsl:when>
                                <xsl:when test="@typ = 'Zensurtitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:message terminate="yes">
                                        Error: Unexpected value "<xsl:value-of select="@typ"/>".
                                    </xsl:message>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="not(@titel) or @titel = ''" />
                                <xsl:otherwise>
                                    <fiaf:hasTitleValue>
                                        <xsl:value-of select="@titel" />
                                    </fiaf:hasTitleValue>
                                </xsl:otherwise>
                            </xsl:choose>
                        </rdf:Description>
                    </fiaf:hasTitle>
                </xsl:for-each>
            </xsl:if>
        </rdf:Description>
    </xsl:template>

    <!-- Items -->

    <xsl:template match="ba:Exemplar"> -->
        <rdf:Description rdf:about="bundesarchiv://resource/item/{@uuid}">
            <rdf:type rdf:resource="https://dev.fiafcore.org/Item" />

            <!-- fiaf:hasBase -->

            <xsl:if test="ba:Aufbewahrungseinheit/ba:Traeger">
                <xsl:variable name="base" select="translate(ba:Aufbewahrungseinheit/ba:Traeger, ' ', '_')"/>
                <xsl:choose>
                    <xsl:when test="$base = 'keiner'" />
                    <xsl:when test="$base = 'Bearbeitungsspeicher'" />
                    <xsl:when test="$base = 'Ozaphan'" />
                    <xsl:when test="$base = 'Polycarbonat'" />
                    <xsl:when test="$base = 'Langzeitspeicher'" />
                    <xsl:when test="$base = 'Triazetatzellulose'">
                        <fiaf:hasBase rdf:resource="https://dev.fiafcore.org/AcetateBase" />
                    </xsl:when>
                    <xsl:when test="$base = 'Polyethylenterephtalat_(Polyester)'">
                        <fiaf:hasBase rdf:resource="https://dev.fiafcore.org/PolyesterBase" />
                    </xsl:when>
                    <xsl:when test="$base = 'Zellulosenitrat'">
                        <fiaf:hasBase rdf:resource="https://dev.fiafcore.org/NitrateBase" />
                    </xsl:when>
                    <xsl:when test="$base = 'Acetatcellulose'">
                        <fiaf:hasBase rdf:resource="https://dev.fiafcore.org/AcetateBase" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">
                            Error: Unexpected value "<xsl:value-of select="$base"/>".
                        </xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>

            <!-- fiaf:hasBroadcastStandard  -->

            <xsl:if test="ba:SDHDFernsehnorm">
                <xsl:variable name="broadcast" select="ba:SDHDFernsehnorm"/>
                <xsl:choose>
                    <xsl:when test="$broadcast = 'keine'" />
                    <xsl:when test="$broadcast = 'unbekannt'" />
                    <xsl:when test="$broadcast = 'HDTV System 2, 1080i/25'" />
                    <xsl:when test="$broadcast = 'HDTV System 3, 1080p/25'" />
                    <xsl:when test="$broadcast = 'SDTV PAL'">
                        <fiaf:hasBroadcastStandard rdf:resource="https://dev.fiafcore.org/PAL" />
                    </xsl:when>
                    <xsl:when test="$broadcast = 'SDTV NTSC'">
                        <fiaf:hasBroadcastStandard rdf:resource="https://dev.fiafcore.org/NTSC" />
                    </xsl:when>
                    <xsl:when test="$broadcast = 'SDTV SECAM'">
                        <fiaf:hasBroadcastStandard rdf:resource="https://dev.fiafcore.org/SECAM" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">
                            Error: Unexpected value "<xsl:value-of select="$broadcast"/>".
                        </xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>

            <!-- fiaf:hasCarrier -->

            <xsl:for-each select="ba:Aufbewahrungseinheit">
                <fiaf:hasCarrier>
                    <rdf:Description rdf:about="bundesarchiv://resource/carrier/{@uuid}" />
                </fiaf:hasCarrier>
            </xsl:for-each>

            <!-- fiaf:hasColourCharacteristic  -->

            <xsl:if test="ba:Aufbewahrungseinheit/ba:Farbe">
                <xsl:variable name="colourchar" select="ba:Aufbewahrungseinheit/ba:Farbe"/>
                <xsl:choose>
                    <xsl:when test="$colourchar = 'keine'" />
                    <xsl:when test="$colourchar = 'Unbekannt'" />
                    <xsl:when test="$colourchar = 'Farbe von historischer Vorlage'" />
                    <xsl:when test="$colourchar = 'Schablonenkolorierung'" />
                    <xsl:when test="$colourchar = 'Handkolorierung'" />
                    <xsl:when test="$colourchar = 'Gasparcolor'" />
                    <xsl:when test="$colourchar = 'Bipack-Aufnahmen'" />
                    <xsl:when test="$colourchar = 'Ufacolor'" />
                    <xsl:when test="$colourchar = 'schwarz-weiß'">
                        <fiaf:hasColourCharacteristic>
                            <rdf:Description>
                                <rdf:type rdf:resource="https://dev.fiafcore.org/BlackAndWhite" />
                            </rdf:Description>
                        </fiaf:hasColourCharacteristic>
                    </xsl:when>
                    <xsl:when test="$colourchar = 'Farbe'">
                        <fiaf:hasColourCharacteristic>
                            <rdf:Description>
                                <rdf:type rdf:resource="https://dev.fiafcore.org/Colour" />
                            </rdf:Description>
                        </fiaf:hasColourCharacteristic>
                    </xsl:when>
                    <xsl:when test="$colourchar = 'Virage'">
                        <fiaf:hasColourCharacteristic>
                            <rdf:Description>
                                <rdf:type rdf:resource="https://dev.fiafcore.org/Tinted" />
                            </rdf:Description>
                        </fiaf:hasColourCharacteristic>
                    </xsl:when>
                    <xsl:when test="$colourchar = 'Tonung'">
                        <fiaf:hasColourCharacteristic>
                            <rdf:Description>
                                <rdf:type rdf:resource="https://dev.fiafcore.org/Toned" />
                            </rdf:Description>
                        </fiaf:hasColourCharacteristic>
                    </xsl:when>
                    <xsl:when test="$colourchar = 'schwarz-weiß und Farbe'">
                        <fiaf:hasColourCharacteristic>
                            <rdf:Description>
                                <rdf:type rdf:resource="https://dev.fiafcore.org/BlackAndWhite" />
                                <rdf:type rdf:resource="https://dev.fiafcore.org/Colour" />
                            </rdf:Description>
                        </fiaf:hasColourCharacteristic>
                    </xsl:when>
                    <xsl:when test="$colourchar = 'Virage und Tonung'">
                        <fiaf:hasColourCharacteristic>
                            <rdf:Description>
                                <rdf:type rdf:resource="https://dev.fiafcore.org/Tinted" />
                                <rdf:type rdf:resource="https://dev.fiafcore.org/Toned" />
                            </rdf:Description>
                        </fiaf:hasColourCharacteristic>
                    </xsl:when>
                    <xsl:when test="$colourchar = 'Orwocolor'">
                        <fiaf:hasColourCharacteristic>
                            <rdf:Description>
                                <rdf:type rdf:resource="https://dev.fiafcore.org/Colour" />
                                <fiaf:hasColourStandard rdf:resource="https://dev.fiafcore.org/Orwocolor"/>
                            </rdf:Description>
                        </fiaf:hasColourCharacteristic>
                    </xsl:when>
                    <xsl:when test="$colourchar = 'Agfacolor'">
                        <fiaf:hasColourCharacteristic>
                            <rdf:Description>
                                <rdf:type rdf:resource="https://dev.fiafcore.org/Colour" />
                                <fiaf:hasColourStandard rdf:resource="https://dev.fiafcore.org/Agfacolor"/>
                            </rdf:Description>
                        </fiaf:hasColourCharacteristic>
                    </xsl:when>
                    <xsl:when test="$colourchar = 'Eastmancolor'">
                        <fiaf:hasColourCharacteristic>
                            <rdf:Description>
                                <rdf:type rdf:resource="https://dev.fiafcore.org/Colour" />
                                <fiaf:hasColourStandard rdf:resource="https://dev.fiafcore.org/Eastmancolor"/>
                            </rdf:Description>
                        </fiaf:hasColourCharacteristic>
                    </xsl:when>
                    <xsl:when test="$colourchar = 'Technicolor'">
                        <fiaf:hasColourCharacteristic>
                            <rdf:Description>
                                <rdf:type rdf:resource="https://dev.fiafcore.org/Colour" />
                                <fiaf:hasColourStandard rdf:resource="https://dev.fiafcore.org/Technicolor"/>
                            </rdf:Description>
                        </fiaf:hasColourCharacteristic>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">
                            Error: Unexpected value "<xsl:value-of select="$colourchar"/>".
                        </xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>

            <!-- fiaf:hasExtent  -->

            <xsl:if test="ba:Laenge">
                <xsl:for-each select="ba:Laenge">
                    <fiaf:hasExtent>
                        <rdf:Description>
                            <rdf:type rdf:resource="https://dev.fiafcore.org/Metre" />
                            <fiaf:hasExtentValue>
                                <xsl:value-of select="." />
                            </fiaf:hasExtentValue>
                        </rdf:Description>
                    </fiaf:hasExtent>
                </xsl:for-each>
            </xsl:if>

            <!-- fiaf:hasFormat  -->

            <xsl:if test="ba:Container">
                <xsl:variable name="format" select="translate(ba:Container, ' ', '_')"/>
                <xsl:choose>
                    <xsl:when test="$format = 'TIFF'" />
                    <xsl:when test="$format = 'WAVE'" />
                    <xsl:when test="$format = 'OHNE_Container'" />
                    <xsl:when test="$format = 'VOB'" />
                    <xsl:when test="$format = 'WebM'" />
                    <xsl:when test="$format = 'MPEG-2'" />
                    <xsl:when test="$format = 'Unbekannt'" />
                    <xsl:when test="$format = 'DCP'" />
                    <xsl:when test="$format = 'Kodak_Cineon_Format'" />
                    <xsl:when test="$format = 'Open_EXR'" />
                    <xsl:when test="$format = 'MP4'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/MP4" />
                    </xsl:when>
                    <xsl:when test="$format = 'MXF_OP-1a'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/MXF" />
                    </xsl:when>
                    <xsl:when test="$format = 'AVI'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/AVI" />
                    </xsl:when>
                    <xsl:when test="$format = 'MXF_OP-Atom'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/MXF" />
                    </xsl:when>
                    <xsl:when test="$format = 'DPX'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/DPX" />
                    </xsl:when>
                    <xsl:when test="$format = 'MOV'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/MOV" />
                    </xsl:when>
                    <xsl:when test="$format = 'MXF'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/MXF" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">
                            Error: Unexpected value "<xsl:value-of select="$format"/>".
                        </xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>

            <xsl:if test="ba:Filmbreite">
                <xsl:variable name="format" select="translate(ba:Filmbreite, ' ', '_')"/>
                <xsl:choose>
                    <xsl:when test="$format = '6,25_mm'" />
                    <xsl:when test="$format = 'Unbekannt'" />
                    <xsl:when test="$format = '35_+_16_mm'" />
                    <xsl:when test="$format = '35-8_mm'" />
                    <xsl:when test="$format = '42_mm'" />
                    <xsl:when test="$format = 'Nicht_standardisiert'" />
                    <xsl:when test="$format = '35-16_mm'" />
                    <xsl:when test="$format = '35_mm'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/35mmFilm" />
                    </xsl:when>
                    <xsl:when test="$format = '16_mm'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/16mmFilm" />
                    </xsl:when>
                    <xsl:when test="$format = '16_mm_neue_Norm'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/16mmFilm" />
                    </xsl:when>
                    <xsl:when test="$format = '16_mm_alte_Norm'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/16mmFilm" />
                    </xsl:when>
                    <xsl:when test="$format = '8_mm'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/8mmFilm" />
                    </xsl:when>
                    <xsl:when test="$format = 'S_16_mm'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/Super16mmFilm" />
                    </xsl:when>
                    <xsl:when test="$format = '17,5_mm'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/17.5mmFilm" />
                    </xsl:when>
                    <xsl:when test="$format = '9,5_mm'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/9.5mmFilm" />
                    </xsl:when>
                    <xsl:when test="$format = '70_mm'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/70mmFilm" />
                    </xsl:when>
                    <xsl:when test="$format = 'Normal_8_mm'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/8mmFilm" />
                    </xsl:when>
                    <xsl:when test="$format = 'Super_8_mm'">
                        <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/Super8mmFilm" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">
                            Error: Unexpected value "<xsl:value-of select="$format"/>".
                        </xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>

            <!-- fiaf:hasHoldingInstitution  -->

            <fiaf:hasHoldingInstitution>
                <rdf:Description rdf:about="bundesarchiv://resource/agent/bundesarchiv">
                    <rdf:type rdf:resource="https://dev.fiafcore.org/Organisation" />
                    <rdfs:label>Bundesarchiv</rdfs:label>
                </rdf:Description>
            </fiaf:hasHoldingInstitution>

            <!-- fiafcore:hasIdentifier -->

            <fiaf:hasIdentifier>
                <rdf:Description rdf:about="bundesarchiv://identifier/item/{@uuid}">
                    <rdf:type rdf:resource="https://dev.fiafcore.org/Identifier" />
                    <fiaf:hasIdentifierValue>
                        <xsl:value-of select="@uuid" />
                    </fiaf:hasIdentifierValue>
                    <fiaf:hasIdentifierAuthority>
                        <rdf:Description rdf:about="bundesarchiv://resource/agent/bundesarchiv">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/Organisation" />
                        </rdf:Description>
                    </fiaf:hasIdentifierAuthority>
                </rdf:Description>
            </fiaf:hasIdentifier>

            <!-- fiaf:hasLanguage  -->

            <xsl:if test="ba:Sprache">
                <xsl:for-each select="ba:Sprache">
                    <fiaf:hasLanguageUsage>
                        <rdf:Description>
                            <xsl:choose>
                                <xsl:when test="not(@sprachgebrauch) or @sprachgebrauch = ''">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Kommentarton'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Audiodeskription'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'geräuschbeschreibende Untertitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Dialekt'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Haupttitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Kommentarton'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Audio'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'unbekannt'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Synchronisation'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Blitztitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/LanguageUsage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Sprache'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/SpokenLanguage" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Zwischentitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Intertitles" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Vorspann'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Credits" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Untertitel'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Subtitles" />
                                </xsl:when>
                                <xsl:when test="@sprachgebrauch = 'Abspann'">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Credits" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:message terminate="yes">
                                        Error: Unexpected value "<xsl:value-of select="@sprachgebrauch"/>".
                                    </xsl:message>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="not(@sprache) or @sprache = ''" />
                                <xsl:when test="@sprache = 'Obersorbisch'" />
                                <xsl:when test="@sprache = 'Südamerikanisch'" />
                                <xsl:when test="@sprache = 'Nicht zu entscheiden'" />
                                <xsl:when test="@sprache = 'Laute / Geräusche'" />
                                <xsl:when test="@sprache = 'Einzelne andere Sprachen'" />
                                <xsl:when test="@sprache = 'Mehrere Sprachen'" />
                                <xsl:when test="@sprache = 'Stumm'" />
                                <xsl:when test="@sprache = 'Jugoslawisch'" />
                                <xsl:when test="@sprache = 'Sorbisch (Andere)'" />
                                <xsl:when test="@sprache = 'Baltische Sprachen (Andere)'" />
                                <xsl:when test="@sprache = 'Südamerikanisch'" />
                                <xsl:when test="@sprache = 'Musik'" />
                                <xsl:when test="@sprache = 'Ohne'" />
                                <xsl:when test="@sprache = 'Geräusche/ Musik'" />
                                <xsl:when test="@sprache = 'unbekannt'" />
                                <xsl:when test="@sprache = 'Indoarische Sprachen'" />
                                <xsl:when test="@sprache = 'Iranische Sprachen (Andere)'" />
                                <xsl:when test="@sprache = 'Deutsch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/German" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Spanisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Spanish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Englisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/English" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Französisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/French" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Russisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Russian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Niederländisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Dutch" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Portugiesisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Portuguese" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Italienisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Italian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Türkisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Turkish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Griechisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Greek" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Afrikaans'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Afrikaans" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Arabisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Arabic" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Polnisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Polish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Tschechisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Czech" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Ungarisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Hungarian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Amerikanisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/English" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Dänisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Danish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Schwedisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Swedish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Lettisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Latvian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Brasilianisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Portuguese" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Ukrainisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Ukrainian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Japanisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Japanese" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Hebräisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Hebrew" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Rumänisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Romanian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Bosnisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Bosnian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Slowakisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Slovak" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Isländisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Icelandic" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Bulgarisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Bulgarian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Serbokroatisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Serbian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Persisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Persian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Kroatisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Croatian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Jiddisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Yiddish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Thaisprachen'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Thai" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Amharisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Amharic" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Norwegisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Norwegian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Hindi oder Indoarisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Hindi" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Finnisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Finnish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Serbisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Serbian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Baskisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Basque" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Belorussisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Belarusian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Swahili (= Suaheli, Kisuaheli)'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Swahili" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Estnisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Estonian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Indonesisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Indonesian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Chinesisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Chinese" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Vietnamesisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Vietnamese" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Litauisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Lithuanian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Makedonisch'">
                                    <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Macedonian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Persisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Persian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Flämisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Dutch" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Georgisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Georgian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Lettisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Latvian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Serbisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Serbian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Vietnamesisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Vietnamese" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Finnisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Finnish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Nepali'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Nepali" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Schweizerdeutsch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/German" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Afrikaans'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Afrikaans" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Belorussisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Belarusian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Makedonisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Macedonian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Koreanisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Korean" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Jiddisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Yiddish" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Malaiisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Malay" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Amharisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Amharic" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Bavarian'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/German" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Burmesisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Burmese" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Kroatisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Croatian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Slowenisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Slovenian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Mongolisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Mongolian" />
                                </xsl:when>
                                <xsl:when test="@sprache = 'Armenisch'">
                                   	<fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Armenian" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:message terminate="yes">
                                        Error: Unexpected value "<xsl:value-of select="@sprache"/>".
                                    </xsl:message>
                                </xsl:otherwise>
                            </xsl:choose>
                        </rdf:Description>
                    </fiaf:hasLanguageUsage>
                </xsl:for-each>
            </xsl:if>

            <!-- fiaf:hasSoundCharacteristic  -->

            <!-- Provided dataset may not contain this data. -->

            <!-- fiaf:hasStatus  -->

            <xsl:if test="ba:ExemplarStatus">
                <xsl:variable name="status" select="translate(ba:ExemplarStatus, ' ', '_')"/>
                  <xsl:choose>
                  <xsl:when test="$status = 'Unbekannt'" />
                  <xsl:when test="$status = 'Benutzungsstück'">
                      <fiaf:hasStatus rdf:resource="https://dev.fiafcore.org/Access" />
                  </xsl:when>
                  <xsl:when test="$status = 'Sicherungsstück'">
                      <fiaf:hasStatus rdf:resource="https://dev.fiafcore.org/Preservation" />
                  </xsl:when>
                  <xsl:when test="$status = 'Digitales_Sicherungsstück'">
                      <fiaf:hasStatus rdf:resource="https://dev.fiafcore.org/Preservation" />
                  </xsl:when>
                  <xsl:otherwise>
                      <xsl:message terminate="yes">
                          Error: Unexpected value "<xsl:value-of select="$status"/>".
                      </xsl:message>
                  </xsl:otherwise>
              </xsl:choose>
            </xsl:if>

            <!-- fiaf:hasStock  -->

            <xsl:if test="ba:Aufbewahrungseinheit/ba:Rohfilmtyp">
                <xsl:variable name="stock" select="translate(ba:Aufbewahrungseinheit/ba:Rohfilmtyp, ' ', '_')"/>
                <xsl:choose>
                    <xsl:when test="$stock = 'DP_31'" />
                    <xsl:when test="$stock = 'PF2'" />
                    <xsl:when test="$stock = 'DN_21'" />
                    <xsl:when test="$stock = '2374'" />
                    <xsl:when test="$stock = 'PF2_V2'" />
                    <xsl:when test="$stock = 'ST_8'" />
                    <xsl:when test="$stock = 'Keiner'" />
                    <xsl:when test="$stock = 'TF_12d'" />
                    <xsl:when test="$stock = '2234'" />
                    <xsl:when test="$stock = '2366'" />
                    <xsl:when test="$stock = 'CP_30'" />
                    <xsl:when test="$stock = 'Sonstige'" />
                    <xsl:when test="$stock = 'Kodak'">
                        <fiaf:hasStock rdf:resource="https://dev.fiafcore.org/Kodak" />
                    </xsl:when>
                    <xsl:when test="$stock = 'Orwo'">
                        <fiaf:hasStock rdf:resource="https://dev.fiafcore.org/Orwo" />
                    </xsl:when>
                    <xsl:when test="$stock = 'Agfa'">
                        <fiaf:hasStock rdf:resource="https://dev.fiafcore.org/Agfa" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">
                            Error: Unexpected value "<xsl:value-of select="$stock"/>".
                        </xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>

            <!-- fiaf:isElement  -->

            <xsl:if test="ba:Aufbewahrungseinheit/ba:Materialart">
                <xsl:variable name="element" select="translate(ba:Aufbewahrungseinheit/ba:Materialart, ' ', '_')"/>
                <xsl:choose>
                    <xsl:when test="$element = 'Magnetband'" />
                    <xsl:when test="$element = 'Stumme_Kopie'" />
                    <xsl:when test="$element = 'FILE'" />
                    <xsl:when test="$element = 'Verschiedenes'" />
                    <xsl:when test="$element = 'DVD/BA+TC'" />
                    <xsl:when test="$element = 'VHS'" />
                    <xsl:when test="$element = 'VHS/BA_+_TC'" />
                    <xsl:when test="$element = 'DVD'" />
                    <xsl:when test="$element = 'TN_zu_Farbbildnegativ'" />
                    <xsl:when test="$element = 'Betacam_Digital'" />
                    <xsl:when test="$element = 'Internegativ'" />
                    <xsl:when test="$element = '1_Zoll_B'" />
                    <xsl:when test="$element = 'Umatic'" />
                    <xsl:when test="$element = 'Kopie_mit_Tonkasch'" />
                    <xsl:when test="$element = 'Betacam_SP'" />
                    <xsl:when test="$element = 'Stummes_Internegativ'" />
                    <xsl:when test="$element = 'Kopie_mit_Magnetton'" />
                    <xsl:when test="$element = 'DVD/BA'" />
                    <xsl:when test="$element = 'Farbmuster-stumme_Kopie'" />
                    <xsl:when test="$element = 'Stummes_Duplikatpositiv_mit_Tonkasch'" />
                    <xsl:when test="$element = 'Tonpositiv_nur_für_Tonumspielung'" />
                    <xsl:when test="$element = 'VHS/BA'" />
                    <xsl:when test="$element = 'S-VHS'" />
                    <xsl:when test="$element = 'Stummes_Positiv'" />
                    <xsl:when test="$element = 'Original_Reversal_Positive'" />
                    <xsl:when test="$element = 'DVD/TC'" />
                    <xsl:when test="$element = 'Color_Reversal_Intermediate_(Negativ)'" />
                    <xsl:when test="$element = 'Stummes_Duplikatnegativ_mit_Tonkasch'" />
                    <xsl:when test="$element = 'TP_zu_Farbfilm'" />
                    <xsl:when test="$element = 'Stummes_Negativ'" />
                    <xsl:when test="$element = 'Digital_Audio_Tape'" />
                    <xsl:when test="$element = 'Original_Color_Reversal_Positive'" />
                    <xsl:when test="$element = 'AMPEX_DCT'" />
                    <xsl:when test="$element = 'Originaltonnegativ'" />
                    <xsl:when test="$element = 'Reversal_Positive'" />
                    <xsl:when test="$element = 'VCR'" />
                    <xsl:when test="$element = 'VHS/TC'" />
                    <xsl:when test="$element = 'Stummes_Intermediate_Positve'" />
                    <xsl:when test="$element = 'U-matic-HB'" />
                    <xsl:when test="$element = 'Stumme_Kopie_mit_Tonkasch'" />
                    <xsl:when test="$element = '1_Zoll_C'" />
                    <xsl:when test="$element = 'HD_CAM_SR'" />
                    <xsl:when test="$element = 'BETA'" />
                    <xsl:when test="$element = 'Magnetic_Optical_Disc'" />
                    <xsl:when test="$element = 'Color_Reversal_Positive'" />
                    <xsl:when test="$element = 'Stummes_Original_Reversal_Positive'" />
                    <xsl:when test="$element = 'HD_CAM'" />
                    <xsl:when test="$element = 'D_1_oder_2'" />
                    <xsl:when test="$element = 'Ton_-_Dupnegativ'" />
                    <xsl:when test="$element = 'Farbmuster-_kombinierte_Kopie'" />
                    <xsl:when test="$element = '1_Zoll_A'" />
                    <xsl:when test="$element = 'Nullkopie'" />
                    <xsl:when test="$element = 'Nullkopie_kombiniert'" />
                    <xsl:when test="$element = 'Magnetband_zu_Farbe'" />
                    <xsl:when test="$element = 'LTO_5'" />
                    <xsl:when test="$element = 'Stummes_Original_Color_Reversal_Positive'" />
                    <xsl:when test="$element = 'Stummes_Intermediate_Negative'" />
                    <xsl:when test="$element = 'Blu-ray_Disc'" />
                    <xsl:when test="$element = 'Arbeitskopie/Schnittkopie'" />
                    <xsl:when test="$element = 'Korrekturkopie'" />
                    <xsl:when test="$element = 'Mini_DV'" />
                    <xsl:when test="$element = 'S-VHS/BA'" />
                    <xsl:when test="$element = 'XDCAM_PFD_50DLA'" />
                    <xsl:when test="$element = 'Stummes_Color_Reversal_Intermediate'" />
                    <xsl:when test="$element = 'Stummes_Reversal_Positive'" />
                    <xsl:when test="$element = 'LTO_2'" />
                    <xsl:when test="$element = 'Betacam_Digital/BA'" />
                    <xsl:when test="$element = 'S-VHS/BA+TC'" />
                    <xsl:when test="$element = 'LTO_4'" />
                    <xsl:when test="$element = 'Stummes_Internegativ_mit_Tonkasch'" />
                    <xsl:when test="$element = 'Betacam_SP/TC'" />
                    <xsl:when test="$element = 'Stummes_Color_Reversal_Positive'" />
                    <xsl:when test="$element = 'U-matic-LB'" />
                    <xsl:when test="$element = 'HDD'" />
                    <xsl:when test="$element = 'Bildplatte'" />
                    <xsl:when test="$element = 'LTO_3'" />
                    <xsl:when test="$element = 'S-VHS/TC'" />
                    <xsl:when test="$element = 'Stumme_Korrekturkopie'" />
                    <xsl:when test="$element = 'MAZ'" />
                    <xsl:when test="$element = 'U-matic-LB/BA'" />
                    <xsl:when test="$element = 'DA-88'" />
                    <xsl:when test="$element = 'Stumme_Footage_(Positiv_und_Negativ)'" />
                    <xsl:when test="$element = 'U-matic-HB/BA+TC'" />
                    <xsl:when test="$element = 'HDD_mit_USB3'" />
                    <xsl:when test="$element = 'High_8/8mm'" />
                    <xsl:when test="$element = 'U-matic-HB/BA'" />
                    <xsl:when test="$element = 'Betamax'" />
                    <xsl:when test="$element = 'Kombinierte_Footage_(Positiv_und_Negativ)'" />
                    <xsl:when test="$element = 'VIDEO_2000'" />
                    <xsl:when test="$element = 'Kombinierte_Kopie'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReleasePrint" />
                    </xsl:when>
                    <xsl:when test="$element = 'Tonnegativ'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/SoundNegative" />
                    </xsl:when>
                    <xsl:when test="$element = 'kombiniertes_Duplikatpositiv'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                    </xsl:when>
                    <xsl:when test="$element = 'Bildduplikatnegativ'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                    </xsl:when>
                    <xsl:when test="$element = 'Originalbildnegativ'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/OriginalNegative" />
                    </xsl:when>
                    <xsl:when test="$element = 'kombiniertes_Duplikatnegativ'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                    </xsl:when>
                    <xsl:when test="$element = 'Bildnegativ'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                    </xsl:when>
                    <xsl:when test="$element = 'Stummes_Duplikatnegativ'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                    </xsl:when>
                    <xsl:when test="$element = 'Bildduplikatpositiv'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                    </xsl:when>
                    <xsl:when test="$element = 'Stummes_Duplikatpositiv'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                    </xsl:when>
                    <xsl:when test="$element = 'Bildpositiv'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                    </xsl:when>
                    <xsl:when test="$element = 'Tonpositiv'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/SoundPositive" />
                    </xsl:when>
                    <xsl:when test="$element = 'Intermediate_Positive'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                    </xsl:when>
                    <xsl:when test="$element = 'Intermediate_Negative'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                    </xsl:when>
                    <xsl:when test="$element = 'Stummes_Originalnegativ'">
                        <fiaf:isElement rdf:resource="https://dev.fiafcore.org/OriginalNegative" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">
                            Error: Unexpected value "<xsl:value-of select="$element"/>".
                        </xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>

        </rdf:Description>
    </xsl:template>

    <!-- fiafcore:Carrier -->

    <xsl:template match="ba:Aufbewahrungseinheit"> -->
        <rdf:Description rdf:about="bundesarchiv://resource/carrier/{@uuid}">
            <rdf:type rdf:resource="https://dev.fiafcore.org/Carrier" />

            <!-- fiafcore:hasIdentifier -->

            <fiaf:hasIdentifier>
                <rdf:Description rdf:about="bundesarchiv://identifier/carrier/{@uuid}">
                    <rdf:type rdf:resource="https://dev.fiafcore.org/Identifier" />
                    <fiaf:hasIdentifierValue>
                        <xsl:value-of select="@uuid" />
                    </fiaf:hasIdentifierValue>
                    <fiaf:hasIdentifierAuthority>
                        <rdf:Description rdf:about="bundesarchiv://resource/agent/bundesarchiv">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/Organisation" />
                        </rdf:Description>
                    </fiaf:hasIdentifierAuthority>
                </rdf:Description>
            </fiaf:hasIdentifier>

        </rdf:Description>
    </xsl:template>

</xsl:stylesheet>
