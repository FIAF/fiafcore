<?xml version="1.0" encoding="UTF-8"?>

<!-- BFI XML Manifestation data to FIAFcore -->
<!-- Paul Duchesne -->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:fiaf="https://dev.fiafcore.org/">

    <xsl:output method="xml" indent="yes" />

    <!-- Manifestations -->

    <xsl:template match="/">
        <rdf:RDF>
            <xsl:for-each select="record">
                <rdf:Description rdf:about="bfi://resource/manifestation/{@priref}">

                    <!-- fiaf:Manifestation -->

                    <xsl:variable name="manifest_type" select=".//manifestationlevel_type_specific/value[@lang='0']"/>
                    <xsl:choose>
                        <xsl:when test="not($manifest_type)">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/Manifestation" />
                        </xsl:when>
                        <xsl:when test="$manifest_type = ''">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/Manifestation" />
                        </xsl:when>
                        <xsl:when test="$manifest_type = 'Unknown'">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/Manifestation" />
                        </xsl:when>
                        <xsl:when test="$manifest_type = 'Theatrical (country unknown)'">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/TheatricalManifestation" />
                        </xsl:when>
                        <xsl:when test="$manifest_type = 'Non-Theatrical'">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/NonTheatricalManifestation" />
                        </xsl:when>
                        <xsl:when test="$manifest_type = 'Home Viewing'">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/HomeViewingManifestation" />
                        </xsl:when>
                        <xsl:when test="$manifest_type = 'Theatrical (main country of origin)'">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/TheatricalManifestation" />
                        </xsl:when>
                        <xsl:when test="$manifest_type = 'Theatrical (outside main country of origin)'">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/TheatricalManifestation" />
                        </xsl:when>
                        <xsl:when test="$manifest_type = 'Restoration'">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/RestorationManifestation" />
                        </xsl:when>
                        <xsl:when test="$manifest_type = 'Pre-Release'">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/PreReleaseManifestation" />
                        </xsl:when>
                        <xsl:when test="$manifest_type = 'Unreleased'">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/UnreleasedManifestation" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:message terminate="yes">
                                Error: Unexpected value "<xsl:value-of select="$manifest_type"/>".
                            </xsl:message>
                        </xsl:otherwise>
                    </xsl:choose>

                    <!-- fiaf:hasColourCharacteristic -->

                    <xsl:variable name="colour_manifestation" select=".//colour_manifestation/value[@lang='0']"/>
                    <xsl:variable name="colour_standard" select="translate(.//colour_code_manifestation, '&amp;', '')"/>
                    <xsl:if test="$colour_manifestation">
                        <fiaf:hasColourCharacteristic>
                            <rdf:Description>
                                <xsl:choose>
                                    <xsl:when test="$colour_manifestation = 'Colour'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Colour"/>
                                    </xsl:when>
                                    <xsl:when test="$colour_manifestation = 'Black and White'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/BlackAndWhite"/>
                                    </xsl:when>
                                    <xsl:when test="$colour_manifestation = 'Colour and Black and White'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Colour"/>
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/BlackAndWhite"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:message terminate="yes">
                                            Error: Unexpected value "<xsl:value-of select="$colour_manifestation"/>".
                                        </xsl:message>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="$colour_standard">
                                    <xsl:choose>
                                        <xsl:when test="$colour_standard = ''"/>
                                        <xsl:when test="$colour_standard = 'Avala Color'"/>
                                        <xsl:when test="$colour_standard = 'CFI Color'"/>
                                        <xsl:when test="$colour_standard = 'Movielabcolor'"/>
                                        <xsl:when test="$colour_standard = 'Rankcolor'"/>
                                        <xsl:when test="$colour_standard = 'Foto-Kem'"/>
                                        <xsl:when test="$colour_standard = 'Warnercolor'"/>
                                        <xsl:when test="$colour_standard = 'Sovcolor'"/>
                                        <xsl:when test="$colour_standard = 'Pathécolor'"/>
                                        <xsl:when test="$colour_standard = 'TVC Color'"/>
                                        <xsl:when test="$colour_standard = 'Trucolor'"/>
                                        <xsl:when test="$colour_standard = 'Cinecolor'"/>
                                        <xsl:when test="$colour_standard = 'Film House color'"/>
                                        <xsl:when test="$colour_standard = 'Cinefotocolor'"/>
                                        <xsl:when test="$colour_standard = 'Atlab Color'"/>
                                        <xsl:when test="$colour_standard = 'Telecolor'"/>
                                        <xsl:when test="$colour_standard = 'Gevacolour'"/>
                                        <xsl:when test="$colour_standard = 'Astro colour'"/>
                                        <xsl:when test="$colour_standard = 'Ferraniacolor'"/>
                                        <xsl:when test="$colour_standard = 'Panavision Color'"/>
                                        <xsl:when test="$colour_standard = 'Alpha Cine Color'"/>
                                        <xsl:when test="$colour_standard = 'Kodacolor'"/>
                                        <xsl:when test="$colour_standard = 'MGM Color'"/>
                                        <xsl:when test="$colour_standard = 'Eclair Color'"/>
                                        <xsl:when test="$colour_standard = 'Anscocolor'"/>
                                        <xsl:when test="$colour_standard = 'Kodachrome'"/>
                                        <xsl:when test="$colour_standard = 'Medallioncolor'"/>
                                        <xsl:when test="$colour_standard = 'Scope Colour'"/>
                                        <xsl:when test="$colour_standard = 'Cinecittà Color'"/>
                                        <xsl:when test="$colour_standard = 'United Color'"/>
                                        <xsl:when test="$colour_standard = 'Consolidated Film Industries'"/>
                                        <xsl:when test="$colour_standard = 'Supercinecolor'"/>
                                        <xsl:when test="$colour_standard = 'Monaco colour'"/>
                                        <xsl:when test="$colour_standard = 'Daieicolor'"/>
                                        <xsl:when test="$colour_standard = 'Ektachrome'"/>
                                        <xsl:when test="$colour_standard = 'Cinevexcolour'"/>
                                        <xsl:when test="$colour_standard = 'Prizma Color'"/>
                                        <xsl:when test="$colour_standard = 'Kinemacolour'"/>
                                        <xsl:when test="$colour_standard = 'Luciano Vittori colour'"/>
                                        <xsl:when test="$colour_standard = 'Dufay'"/>
                                        <xsl:when test="$colour_standard = 'Image Transform'"/>
                                        <xsl:when test="$colour_standard = 'Cinefilm Color'"/>
                                        <xsl:when test="$colour_standard = 'Cinecocolor'"/>
                                        <xsl:when test="$colour_standard = 'Telcocolor'"/>
                                        <xsl:when test="$colour_standard = 'Technochrome'"/>
                                        <xsl:when test="$colour_standard = 'Getty colour'"/>
                                        <xsl:when test="$colour_standard = 'Panacolor'"/>
                                        <xsl:when test="$colour_standard = 'Perfect'"/>
                                        <xsl:when test="$colour_standard = 'Spot Film  Continental color'"/>
                                        <xsl:when test="$colour_standard = 'Magicolor'"/>
                                        <xsl:when test="$colour_standard = 'Sonolab colour'"/>
                                        <xsl:when test="$colour_standard = 'Colorfilm Color'"/>
                                        <xsl:when test="$colour_standard = 'Astral Bellvue Pathé Color'"/>
                                        <xsl:when test="$colour_standard = 'Monochrome'"/>
                                        <xsl:when test="$colour_standard = 'Avala Color'"/>
                                        <xsl:when test="$colour_standard = 'Technicolor'" >
                                            <fiaf:hasColourStandard rdf:resource="https://dev.fiafcore.org/Technicolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Eastmancolor'" >
                                            <fiaf:hasColourStandard rdf:resource="https://dev.fiafcore.org/Eastmancolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'DeLuxe'" >
                                            <fiaf:hasColourStandard rdf:resource="https://dev.fiafcore.org/DeLuxe"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Metrocolor'" >
                                            <fiaf:hasColourStandard rdf:resource="https://dev.fiafcore.org/Metrocolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Duartcolor'" >
                                            <fiaf:hasColourStandard rdf:resource="https://dev.fiafcore.org/Duartcolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Fujicolor'" >
                                            <fiaf:hasColourStandard rdf:resource="https://dev.fiafcore.org/Fujicolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Agfacolor'" >
                                            <fiaf:hasColourStandard rdf:resource="https://dev.fiafcore.org/Agfacolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Orwocolor'" >
                                            <fiaf:hasColourStandard rdf:resource="https://dev.fiafcore.org/Orwocolor"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:message terminate="yes">
                                                Error: Unexpected value "<xsl:value-of select="$colour_standard"/>".
                                            </xsl:message>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </rdf:Description>
                        </fiaf:hasColourCharacteristic>
                    </xsl:if>

                    <!-- fiaf:hasEvent -->

                    <!-- fiaf:hasExtent -->

                    <!-- fiaf:hasFormat -->

                    <xsl:variable name="format" select="translate(.//format_low_level, '&quot;', '')" />
                    <xsl:if test="$format">
                        <xsl:choose>
                            <xsl:when test="$format = 'VHS Videocassette'"/>
                            <xsl:when test="$format = 'Videocassette'"/>
                            <xsl:when test="$format = 'Digital Cinema Package (DCP)'"/>
                            <xsl:when test="$format = 'Digital Video'"/>
                            <xsl:when test="$format = 'Digital Media'"/>
                            <xsl:when test="$format = 'Phase Alternate Line (PAL)'"/>
                            <xsl:when test="$format = 'U-Matic Videocassette'"/>
                            <xsl:when test="$format = 'High-Definition Video'"/>
                            <xsl:when test="$format = 'DVD-ROM'"/>
                            <xsl:when test="$format = '3-D (Un-specified)'"/>
                            <xsl:when test="$format = 'Imax'"/>
                            <xsl:when test="$format = 'Betamax Videocassette'"/>
                            <xsl:when test="$format = 'IMF Package (IMP)'"/>
                            <xsl:when test="$format = 'Mini-DV'"/>
                            <xsl:when test="$format = '65mm film'"/>
                            <xsl:when test="$format = 'HD Digital'"/>
                            <xsl:when test="$format = 'Apple ProRes 422 HQ'"/>
                            <xsl:when test="$format = '25mm Film'"/>
                            <xsl:when test="$format = 'Betacam Videocassette'"/>
                            <xsl:when test="$format = 'VHS Compact'"/>
                            <xsl:when test="$format = '2 Videotape'"/>
                            <xsl:when test="$format = 'V2000 Videocassette'"/>
                            <xsl:when test="$format = 'Super-VHS'"/>
                            <xsl:when test="$format = 'Reel to reel tape'"/>
                            <xsl:when test="$format = 'Scope (Un-specified)'"/>
                            <xsl:when test="$format = 'QuickTime'"/>
                            <xsl:when test="$format = 'D2 Digital'"/>
                            <xsl:when test="$format = 'D5-HD'"/>
                            <xsl:when test="$format = '1 Videotape'"/>
                            <xsl:when test="$format = 'Super-35'"/>
                            <xsl:when test="$format = '35mm Film'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/35mmFilm" />
                            </xsl:when>
                            <xsl:when test="$format = '16mm Film'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/16mmFilm" />
                            </xsl:when>
                            <xsl:when test="$format = 'DVD (Digital Versatile Disc)'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/DVD" />
                            </xsl:when>
                            <xsl:when test="$format = 'Digital Betacam'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/DigitalBetacam" />
                            </xsl:when>
                            <xsl:when test="$format = '70mm Film'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/70mmFilm" />
                            </xsl:when>
                            <xsl:when test="$format = 'Blu-ray'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/BluRay" />
                            </xsl:when>
                            <xsl:when test="$format = '8mm Film'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/8mmFilm" />
                            </xsl:when>
                            <xsl:when test="$format = 'HDCAM'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/HDCAMSR" />
                            </xsl:when>
                            <xsl:when test="$format = '9.5mm Film'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/9.5mmFilm" />
                            </xsl:when>
                            <xsl:when test="$format = 'Super-16'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/Super16mmFilm" />
                            </xsl:when>
                            <xsl:when test="$format = 'Betacam SP'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/BetacamSP" />
                            </xsl:when>
                            <xsl:when test="$format = 'Super 8mm Film'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/Super8mmFilm" />
                            </xsl:when>
                            <xsl:when test="$format = 'ProRes QuickTime'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/Quicktime" />
                            </xsl:when>
                            <xsl:when test="$format = 'Laser-Disc'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/LaserDisc" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:message terminate="yes">
                                    Error: Unexpected value "<xsl:value-of select="$format"/>".
                                </xsl:message>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>

                    <!-- fiaf:hasIdentifier -->

                    <fiaf:hasIdentifier>
                        <rdf:Description rdf:about="bfi://identifier/manifestation/{@priref}">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/Identifier" />
                            <fiaf:hasIdentifierValue>
                                <xsl:value-of select="@priref" />
                            </fiaf:hasIdentifierValue>
                            <fiaf:hasIdentifierAuthority>
                                <rdf:Description rdf:about="bfi://resource/agent/bfi">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Organisation" />
                                </rdf:Description>
                            </fiaf:hasIdentifierAuthority>
                        </rdf:Description>
                    </fiaf:hasIdentifier>

                    <!-- fiaf:hasItem -->

                    <xsl:for-each select="Parts">
                        <fiaf:hasItem rdf:resource="bfi://resource/item/{parts_reference.lref}" />
                    </xsl:for-each>

                    <!-- fiaf:hasLanguageUsage -->

                    <xsl:for-each select="language">
                        <xsl:variable name="language_usage" select="./language.type/value[@lang='0']" />
                        <xsl:variable name="language" select="language" />
                        <xsl:if test="$language_usage">
                            <fiaf:hasLanguageUsage>
                                <rdf:Description>
                                    <xsl:choose>
                                        <xsl:when test="$language_usage = 'Dialogue (original)'">
                                            <rdf:type rdf:resource="https://dev.fiafcore.org/SpokenLanguage" />
                                        </xsl:when>
                                        <xsl:when test="$language_usage = 'Subtitles'">
                                            <rdf:type rdf:resource="https://dev.fiafcore.org/Subtitles" />
                                        </xsl:when>
                                        <xsl:when test="$language_usage = 'Intertitles'">
                                            <rdf:type rdf:resource="https://dev.fiafcore.org/Intertitles" />
                                        </xsl:when>
                                        <xsl:when test="$language_usage = 'Credits'">
                                            <rdf:type rdf:resource="https://dev.fiafcore.org/Credits" />
                                        </xsl:when>
                                        <xsl:when test="$language_usage = 'Dialogue (dubbed)'">
                                            <rdf:type rdf:resource="https://dev.fiafcore.org/SpokenLanguage" />
                                        </xsl:when>
                                        <xsl:when test="$language_usage = 'No Dialogue'">
                                            <rdf:type rdf:resource="https://dev.fiafcore.org/NoDialogue" />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:message terminate="yes">
                                                Error: Unexpected value "<xsl:value-of select="$language_usage"/>".
                                            </xsl:message>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:if test="$language">
                                        <xsl:choose>
                                            <xsl:when test="$language = ''"/>
                                            <xsl:when test="$language = 'Artificial language'"/>
                                            <xsl:when test="$language = 'Bantu'"/>
                                            <xsl:when test="$language = 'Bodo'"/>
                                            <xsl:when test="$language = 'British Sign Language'"/>
                                            <xsl:when test="$language = 'Rajasthani'"/>
                                            <xsl:when test="$language = 'English'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/English" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'French'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/French" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Italian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Italian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'German'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/German" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Russian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Russian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Japanese'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Japanese" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Spanish'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Spanish" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Hindi'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Hindi" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Czech'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Czech" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Swedish'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Swedish" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Chinese, Mandarin'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Chinese" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Arabic'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Arabic" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Polish'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Polish" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Chinese'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Chinese" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Hungarian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Hungarian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Portuguese'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Portuguese" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Dutch'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Dutch" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Urdu'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Urdu" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Chinese, Cantonese'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Chinese" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Bengali'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Bengali" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Modern Greek'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Greek" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Danish'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Danish" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Korean'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Korean" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Persian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Persian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Turkish'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Turkish" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Slovak'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Slovak" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Wolof'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Wolof" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Panjabi'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Punjabi" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Welsh'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Welsh" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Thai'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Thai" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Catalan'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Catalan" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Bulgarian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Bulgarian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Scottish Gaelic'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Gaelic" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Vietnamese'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Vietnamese" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Finnish'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Finnish" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Norwegian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Norwegian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Serbo-Croatian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Serbian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Estonian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Estonian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Hebrew'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Hebrew" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Malayalam'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Malayalam" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Tamil'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Tamil" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Georgian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Georgian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Romanian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Romanian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Kurdish'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Kurdish" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Latin'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Latin" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Sinhalese'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Sinhala" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Maori'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Maori" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Irish'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Irish" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Tagalog'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Tagalog" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Yiddish'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Yiddish" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Armenian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Armenian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Afrikaans'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Afrikaans" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Ukrainian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Ukrainian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Swahili'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Swahili" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Zulu'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Zulu" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Greek'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Greek" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Lithuanian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Lithuanian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Bambara'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Bambara" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Icelandic'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Icelandic" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Gujarati'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Gujarati" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Flemish'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Dutch" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Esperanto'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Esperanto" /></xsl:when>
                                            <xsl:when test="$language = 'Egyptian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Arabic" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Assamese'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Assamese" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Azerbaijani'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Azerbaijani" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Tibetan'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Tibetan" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Cornish'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Cornish" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Mongolian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Mongolian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Macedonian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Macedonian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Spanish, Castilian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Spanish" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Slovenian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Slovenian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Iranian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Persian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Kannada'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Kannada" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Albanian'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Albanian" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Kirghiz'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Kyrgyz" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Pushto'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Pashto" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Kazakh'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Kazakh" />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:message terminate="yes">
                                                    Error: Unexpected value "<xsl:value-of select="$language"/>".
                                                </xsl:message>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                </rdf:Description>
                            </fiaf:hasLanguageUsage>
                        </xsl:if>
                    </xsl:for-each>

                    <!-- fiaf:hasSoundCharacteristic -->

                    <xsl:variable name="sound_manifestation" select=".//sound_manifestation/value[@lang='0']"/>
                    <xsl:variable name="sound_standard" select=".//sound_system_manifestation"/>
                    <xsl:if test="$sound_manifestation">
                        <fiaf:hasSoundCharacteristic>
                            <rdf:Description>
                                <xsl:choose>
                                    <xsl:when test="$sound_manifestation = 'Sound'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Sound" />
                                    </xsl:when>
                                    <xsl:when test="$sound_manifestation = 'Mute'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Mute" />
                                    </xsl:when>
                                    <xsl:when test="$sound_manifestation = 'Silent'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Silent" />
                                    </xsl:when>
                                    <xsl:when test="$sound_manifestation = 'Combined as Mute'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Mute" />
                                    </xsl:when>
                                    <xsl:when test="$sound_manifestation = 'Combined as Sound'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Sound" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:message terminate="yes">
                                            Error: Unexpected value "<xsl:value-of select="$sound_manifestation"/>".
                                        </xsl:message>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="$sound_standard">
                                    <xsl:choose>
                                        <xsl:when test="$sound_standard = 'Dolby'"/>
                                        <xsl:when test="$sound_standard = 'Mono'"/>
                                        <xsl:when test="$sound_standard = 'Stereo'"/>
                                        <xsl:when test="$sound_standard = 'Dolby SR'"/>
                                        <xsl:when test="$sound_standard = 'Ultra-Stereo'"/>
                                        <xsl:when test="$sound_standard = 'DataSat'"/>
                                        <xsl:when test="$sound_standard = 'Combined Optical Sound'"/>
                                        <xsl:when test="$sound_standard = 'Dolby Digital Surround EX'"/>
                                        <xsl:when test="$sound_standard = 'DTS Sound (Optical)'"/>
                                        <xsl:when test="$sound_standard = 'Dolby Atmos'"/>
                                        <xsl:when test="$sound_standard = 'Surround Stereo'"/>
                                        <xsl:when test="$sound_standard = 'Dolby Digital'" >
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/DolbyDigital"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'SDDS'" >
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/SDDS"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'DTS (sound)'" >
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/DTS"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'Dolby Stereo SR'" >
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/DolbyStereo"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'Digital Stereo'" >
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/DolbyStereo"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'Separate Magnetic Sound'" >
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/Magnetic"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'Combined Magnetic Sound'" >
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/Magnetic"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:message terminate="yes">
                                                Error: Unexpected value "<xsl:value-of select="$sound_standard"/>".
                                            </xsl:message>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </rdf:Description>
                        </fiaf:hasSoundCharacteristic>
                    </xsl:if>

                </rdf:Description>
            </xsl:for-each>
        </rdf:RDF>
    </xsl:template>

</xsl:stylesheet>
