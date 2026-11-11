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
                    <xsl:if test="$colour_manifestation or $colour_standard">
                        <fiaf:hasColourCharacteristic>
                            <rdf:Description>
                                <xsl:if test="$colour_manifestation">
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
                                        <xsl:when test="$colour_manifestation = 'Sepia'">
                                            <xsl:if test="not($colour_standard = 'Sepia')">
                                                <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Toned"/>
                                            </xsl:if>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:message terminate="yes">
                                                Error: Unexpected value "<xsl:value-of select="$colour_manifestation"/>".
                                            </xsl:message>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                                <xsl:if test="$colour_standard">
                                    <xsl:choose>
                                        <xsl:when test="$colour_standard = ''"/>
                                        <xsl:when test="$colour_standard = 'Avala Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'CFI Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Movielabcolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Rankcolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Foto-Kem'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'TVC Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Trucolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Trucolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Cinecolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Cinecolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Film House color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Cinefotocolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Atlab Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Telecolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Gevacolour'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Gevacolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Astro colour'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Panavision Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Alpha Cine Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Kodacolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Kodacolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'MGM Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Metrocolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Eclair Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Medallioncolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Scope Colour'"/>
                                        <xsl:when test="$colour_standard = 'Cinecittà Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'United Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Consolidated Film Industries'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Supercinecolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Supercinecolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Monaco colour'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Daieicolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Ektachrome'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Ektachrome"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Cinevexcolour'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Prizma Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/MimeticColourProcess"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Luciano Vittori colour'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Dufay'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Dufaycolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Image Transform'"/>
                                        <xsl:when test="$colour_standard = 'Cinefilm Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Cinecocolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Telcocolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Technochrome'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/MimeticColourProcess"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Getty colour'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Panacolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/PrintingDyeTransferPigment"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Perfect'"/>
                                        <xsl:when test="$colour_standard = 'Spot Film  Continental color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Magicolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/MimeticColourProcess"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Sonolab colour'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Colorfilm Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Astral Bellvue Pathé Color'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/ChromogenicMonopack"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Monochrome'">
                                            <xsl:if test="not($colour_manifestation)">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/BlackAndWhite"/>
                                            </xsl:if>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Technicolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Technicolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Eastmancolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Eastmancolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'DeLuxe'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/DeLuxe"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Metrocolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Metrocolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Duartcolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Duartcolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Fujicolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Fujicolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Agfacolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Agfacolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Orwocolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Orwocolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Warnercolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Warnercolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Sovcolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Sovcolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Pathécolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Pathecolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Ferraniacolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Ferraniacolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Anscocolor'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Anscocolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Kodachrome'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Kodachrome"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Kinemacolour'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Kinemacolor"/>
                                        </xsl:when>
                                        <xsl:when test="$colour_standard = 'Sepia'">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Toned"/>
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
                            <xsl:when test="$format = 'VHS Videocassette'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/VHS" />
                            </xsl:when>
                            <xsl:when test="$format = 'Videocassette'"/>
                            <xsl:when test="$format = 'Digital Cinema Package (DCP)'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/DCP" />
                            </xsl:when>
                            <xsl:when test="$format = 'Digital Video'"/>
                            <xsl:when test="$format = 'Digital Media'"/>
                            <xsl:when test="$format = 'Phase Alternate Line (PAL)'">
                                <fiaf:hasBroadcastStandard rdf:resource="https://dev.fiafcore.org/PAL" />
                            </xsl:when>
                            <xsl:when test="$format = 'U-Matic Videocassette'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/Umatic" />
                            </xsl:when>
                            <xsl:when test="$format = 'High-Definition Video'"/>
                            <xsl:when test="$format = 'DVD-ROM'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/DVDROM" />
                            </xsl:when>
                            <xsl:when test="$format = '3-D (Un-specified)'"/>
                            <xsl:when test="$format = 'Imax'"/>
                            <xsl:when test="$format = 'Betamax Videocassette'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/Betamax" />
                            </xsl:when>
                            <xsl:when test="$format = 'IMF Package (IMP)'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/IMF" />
                            </xsl:when>
                            <xsl:when test="$format = 'Mini-DV'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/MiniDV" />
                            </xsl:when>
                            <xsl:when test="$format = '65mm film'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/65mmFilm" />
                            </xsl:when>
                            <xsl:when test="$format = 'HD Digital'"/>
                            <xsl:when test="$format = 'Apple ProRes 422 HQ'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/ProRes422HQ" />
                            </xsl:when>
                            <xsl:when test="$format = '25mm Film'"/>
                            <xsl:when test="$format = 'Betacam Videocassette'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/Betacam" />
                            </xsl:when>
                            <xsl:when test="$format = 'VHS Compact'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/VHS" />
                            </xsl:when>
                            <xsl:when test="$format = '2 Videotape'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/TwoInchVideotape" />
                            </xsl:when>
                            <xsl:when test="$format = 'V2000 Videocassette'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/Video2000" />
                            </xsl:when>
                            <xsl:when test="$format = 'Super-VHS'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/SuperVHS" />
                            </xsl:when>
                            <xsl:when test="$format = 'Reel to reel tape'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/OpenReelAudiotape" />
                            </xsl:when>
                            <xsl:when test="$format = 'Scope (Un-specified)'"/>
                            <xsl:when test="$format = 'QuickTime'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/Quicktime" />
                            </xsl:when>
                            <xsl:when test="$format = 'D2 Digital'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/D2" />
                            </xsl:when>
                            <xsl:when test="$format = 'D5-HD'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/D5" />
                            </xsl:when>
                            <xsl:when test="$format = '1 Videotape'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/OneInchVideotape" />
                            </xsl:when>
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
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/HDCAM" />
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
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/ProRes" />
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
                                            <xsl:when test="$language = 'Bodo'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Bodo" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'British Sign Language'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/BritishSignLanguage" />
                                            </xsl:when>
                                            <xsl:when test="$language = 'Rajasthani'">
                                                <fiaf:hasLanguage rdf:resource="https://dev.fiafcore.org/Rajasthani" />
                                            </xsl:when>
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
                    <xsl:if test="$sound_manifestation or $sound_standard">
                        <fiaf:hasSoundCharacteristic>
                            <rdf:Description>
                                <xsl:if test="$sound_manifestation">
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
                                </xsl:if>
                                <xsl:if test="$sound_standard and not($sound_manifestation)">
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/Sound" />
                                </xsl:if>
                                <xsl:if test="$sound_standard">
                                    <xsl:choose>
                                        <xsl:when test="$sound_standard = 'Dolby'" >
                                            <fiaf:hasNoiseReduction rdf:resource="https://dev.fiafcore.org/Dolby"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'Mono'" >
                                            <fiaf:hasSoundChannelConfiguration rdf:resource="https://dev.fiafcore.org/Mono"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'Stereo'" >
                                            <fiaf:hasSoundChannelConfiguration rdf:resource="https://dev.fiafcore.org/Stereo"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'Dolby SR'" >
                                            <fiaf:hasNoiseReduction rdf:resource="https://dev.fiafcore.org/DolbySR"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'Ultra-Stereo'" >
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/UltraStereo"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'DataSat'" >
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/Datasat"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'Combined Optical Sound'" >
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/AnalogueOpticalSound"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'Dolby Digital Surround EX'" >
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/DolbyDigitalSurroundEX"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'DTS Sound (Optical)'" >
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/DTS"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'Dolby Atmos'" >
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/DolbyAtmos"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'Surround Stereo'" >
                                            <fiaf:hasSoundChannelConfiguration rdf:resource="https://dev.fiafcore.org/Surround"/>
                                        </xsl:when>
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
                                            <fiaf:hasNoiseReduction rdf:resource="https://dev.fiafcore.org/DolbySR"/>
                                        </xsl:when>
                                        <xsl:when test="$sound_standard = 'Digital Stereo'" >
                                            <fiaf:hasSoundChannelConfiguration rdf:resource="https://dev.fiafcore.org/Stereo"/>
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
