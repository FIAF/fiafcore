<?xml version="1.0" encoding="UTF-8"?>

<!-- BFI XML Item data to FIAFcore -->
<!-- Paul Duchesne -->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:fiaf="https://dev.fiafcore.org/">

    <xsl:output method="xml" indent="yes" />

    <!-- Items -->

    <xsl:template match="/">
        <rdf:RDF>
            <xsl:for-each select="record">
                <rdf:Description rdf:about="bfi://resource/item/{@priref}">
                    <rdf:type rdf:resource="https://dev.fiafcore.org/Item" />

                    <!-- fiaf:hasBase -->

                    <xsl:for-each select="base/value[@lang='0'][normalize-space(.)]">
                        <xsl:variable name="base" select="." />
                        <xsl:choose>
                            <xsl:when test="$base = 'Acrylic'"/>
                            <xsl:when test="$base = 'Mixed'"/>
                            <xsl:when test="$base = 'PVC'"/>
                            <xsl:when test="$base = 'Safety'">
                                <fiaf:hasBase rdf:resource="https://dev.fiafcore.org/AcetateBase" />
                            </xsl:when>
                            <xsl:when test="$base = 'Video'">
                                <fiaf:hasBase rdf:resource="https://dev.fiafcore.org/PolyesterBase" />
                            </xsl:when>
                            <xsl:when test="$base = 'Nitrate'">
                                <fiaf:hasBase rdf:resource="https://dev.fiafcore.org/NitrateBase" />
                            </xsl:when>
                            <xsl:when test="$base = 'CTA'">
                                <fiaf:hasBase rdf:resource="https://dev.fiafcore.org/AcetateBase" />
                            </xsl:when>
                            <xsl:when test="$base = 'Polyester'">
                                <fiaf:hasBase rdf:resource="https://dev.fiafcore.org/PolyesterBase" />
                            </xsl:when>
                            <xsl:when test="$base = 'Acetate'">
                                <fiaf:hasBase rdf:resource="https://dev.fiafcore.org/AcetateBase" />
                            </xsl:when>
                            <xsl:when test="$base = 'Mainly safety'">
                                <fiaf:hasBase rdf:resource="https://dev.fiafcore.org/AcetateBase" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:message terminate="yes">
                                    Error: Unexpected value "<xsl:value-of select="$base"/>".
                                </xsl:message>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>

                    <!-- fiaf:hasBroadcastStandard -->

                    <!-- Provided dataset may not contain this data. -->

                    <!-- fiaf:hasCarrier -->

                    <!-- Provided dataset may not contain this data. -->

                    <!-- fiaf:hasColourCharacteristic -->

                    <!-- fiaf:hasEvent -->

                    <!-- fiaf:hasExtent -->

                    <!-- <xsl:for-each select="Dimension/dimension.value">
                        <fiaf:hasExtent>
                            <rdf:Description>
                                <rdf:type rdf:resource="bfi://ontology/extent/feet"/>
                                <fiaf:hasExtentValue>
                                    <xsl:value-of select="."/>
                                </fiaf:hasExtentValue>
                            </rdf:Description>
                        </fiaf:hasExtent>
                    </xsl:for-each> -->

                    <!-- fiaf:hasFormat -->

                    <!-- <xsl:for-each select="gauge_film/value[@lang='0']">
                        <xsl:variable name="gauge_film" select="translate(., ' ', '')"/>
                        <fiaf:hasFormat rdf:resource="bfi://vocabulary/filmformat/{$gauge_film}"/>
                    </xsl:for-each> -->

                    <!-- fiaf:hasHoldingInstitution -->

                    <fiaf:hasHoldingInstitution>
                        <rdf:Description rdf:about="bfi://resource/agent/bfi">
                            <rdf:type rdf:resource="https://dev.fiafcore.org/Organisation" />
                            <rdfs:label>British Film Institute</rdfs:label>
                        </rdf:Description>
                    </fiaf:hasHoldingInstitution>

                    <!-- fiaf:hasIdentifier -->

                    <fiaf:hasIdentifier>
                        <rdf:Description rdf:about="bfi://identifier/item/{@priref}">
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

                    <!-- fiaf:hasSoundCharacteristic -->

                    <xsl:for-each select=".//sound_item/value[@lang='0'][normalize-space(.)]">
                        <xsl:variable name="soundcharacteristic" select="translate(., ' ', ' ')" />
                        <xsl:if test="$soundcharacteristic">
                            <fiaf:hasSoundCharacteristic>
                                <rdf:Description>
                                    <xsl:choose>
                                        <!-- TODO: if it is not a known sound char, you want to skip it -->
                                        <xsl:when test="$soundcharacteristic = 'Combined'"/>
                                        <xsl:when test="$soundcharacteristic = 'Mixed'"/>
                                        <xsl:when test="$soundcharacteristic = 'Sound'">
                                            <rdf:type rdf:resource="https://dev.fiafcore.org/Sound" />
                                        </xsl:when>
                                        <xsl:when test="$soundcharacteristic = 'Mute'">
                                            <rdf:type rdf:resource="https://dev.fiafcore.org/Mute" />
                                        </xsl:when>
                                        <xsl:when test="$soundcharacteristic = 'Silent'">
                                            <rdf:type rdf:resource="https://dev.fiafcore.org/Silent" />
                                        </xsl:when>
                                        <xsl:when test="$soundcharacteristic = 'Combined as Mute'">
                                            <rdf:type rdf:resource="https://dev.fiafcore.org/Mute" />
                                        </xsl:when>
                                        <xsl:when test="$soundcharacteristic = 'Combined as Sound'">
                                            <rdf:type rdf:resource="https://dev.fiafcore.org/Sound" />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:message terminate="yes">
                                                Error: Unexpected value "<xsl:value-of select="$soundcharacteristic"/>".
                                            </xsl:message>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </rdf:Description>
                            </fiaf:hasSoundCharacteristic>
                        </xsl:if>
                    </xsl:for-each>

                    <!-- fiaf:hasStatus -->

                    <xsl:for-each select=".//copy_status/value[@lang='0'][normalize-space(.)]">
                        <xsl:variable name="status" select="." />
                        <xsl:choose>
                            <xsl:when test="$status = 'Status pending'"/>
                            <xsl:when test="$status = 'Viewing'">
                                <fiaf:hasStatus rdf:resource="https://dev.fiafcore.org/Access" />
                            </xsl:when>
                            <xsl:when test="$status = 'Master'">
                                <fiaf:hasStatus rdf:resource="https://dev.fiafcore.org/Preservation" />
                            </xsl:when>
                             <xsl:otherwise>
                                <xsl:message terminate="yes">
                                    Error: Unexpected value "<xsl:value-of select="$status"/>".
                                </xsl:message>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>

                    <!-- fiaf:hasStock -->

                    <xsl:for-each select="stock/stock_film[normalize-space(.)]">
                        <fiaf:hasStock>
                            <rdf:Description>
                                <xsl:variable name="stock" select="translate(., '&amp;', '')" />
                                <xsl:choose>
                                    <xsl:when test="$stock = 'Unidentified-Eastern European'"/>
                                    <xsl:when test="$stock = 'Kodak Canada'"/>
                                    <xsl:when test="$stock = 'Unmarked'"/>
                                    <xsl:when test="$stock = 'Unidentified manufacturer'"/>
                                    <xsl:when test="$stock = 'Eastmancolor'"/>
                                    <xsl:when test="$stock = 'Pathe Cinema France'"/>
                                    <xsl:when test="$stock = 'Selo'"/>
                                    <xsl:when test="$stock = 'Eastmancolor'"/>
                                    <xsl:when test="$stock = 'Unidentified-Russian'"/>
                                    <xsl:when test="$stock = 'Cbema'"/>
                                    <xsl:when test="$stock = 'Unidentified manufacturer'"/>
                                    <xsl:when test="$stock = 'SONY'"/>
                                    <xsl:when test="$stock = 'Ampex'"/>
                                    <xsl:when test="$stock = 'Pyral'"/>
                                    <xsl:when test="$stock = 'Maxell'"/>
                                    <xsl:when test="$stock = 'BASF'"/>
                                    <xsl:when test="$stock = 'MIXED'"/>
                                    <xsl:when test="$stock = 'unknown credit activity'"/>
                                    <xsl:when test="$stock = 'Zonal'"/>
                                    <xsl:when test="$stock = 'Deko'"/>
                                    <xsl:when test="$stock = 'Kodak France'"/>
                                    <xsl:when test="$stock = 'Pathe Cinema France'"/>
                                    <xsl:when test="$stock = 'Technicolor'"/>
                                    <xsl:when test="$stock = '?'"/>
                                    <xsl:when test="$stock = 'Perutz'"/>
                                    <xsl:when test="$stock = 'Kodak Canada'"/>
                                    <xsl:when test="$stock = 'FTON'"/>
                                    <xsl:when test="$stock = 'BLNX'"/>
                                    <xsl:when test="$stock = 'Unidentified-Eastern European'"/>
                                    <xsl:when test="$stock = 'Estar'"/>
                                    <xsl:when test="$stock = 'OBS'"/>
                                    <xsl:when test="$stock = 'Dupont Pathe'"/>
                                    <xsl:when test="$stock = 'Kodak AG (German Kodak)'"/>
                                    <xsl:when test="$stock = 'Goerz-Tenax'"/>
                                    <xsl:when test="$stock = 'Turkish'"/>
                                    <xsl:when test="$stock = 'Mafe'"/>
                                    <xsl:when test="$stock = 'Ansco'"/>
                                    <xsl:when test="$stock = 'Lignose'"/>
                                    <xsl:when test="$stock = 'D94L'"/>
                                    <xsl:when test="$stock = 'Unidentified-Indu'"/>
                                    <xsl:when test="$stock = 'DA8-113'"/>
                                    <xsl:when test="$stock = 'UNMARKED'"/>
                                    <xsl:when test="$stock = 'DVD-R'"/>
                                    <xsl:when test="$stock = 'SVMA'"/>
                                    <xsl:when test="$stock = 'DA8113'"/>
                                    <xsl:when test="$stock = 'TDK'"/>
                                    <xsl:when test="$stock = 'T C FOX'"/>
                                    <xsl:when test="$stock = 'T AUET(USSR)'"/>
                                    <xsl:when test="$stock = 'VA RCA DUPLEX'"/>
                                    <xsl:when test="$stock = 'VUS'"/>
                                    <xsl:when test="$stock = 'Sakura'"/>
                                    <xsl:when test="$stock = 'Pathe France'"/>
                                    <xsl:when test="$stock = 'E180'"/>
                                    <xsl:when test="$stock = 'E90'"/>
                                    <xsl:when test="$stock = 'IXD'"/>
                                    <xsl:when test="$stock = 'D124L'"/>
                                    <xsl:when test="$stock = 'Indu'"/>
                                    <xsl:when test="$stock = 'JVC'"/>
                                    <xsl:when test="$stock = 'KANS'"/>
                                    <xsl:when test="$stock = 'KCA'"/>
                                    <xsl:when test="$stock = 'D22'"/>
                                    <xsl:when test="$stock = 'Memorex'"/>
                                    <xsl:when test="$stock = 'EMTEC'"/>
                                    <xsl:when test="$stock = 'EACO'"/>
                                    <xsl:when test="$stock = 'D124'"/>
                                    <xsl:when test="$stock = 'Pathe Freres'"/>
                                    <xsl:when test="$stock = 'Pathe Paris'"/>
                                    <xsl:when test="$stock = 'Pathe Vincennes Paris'"/>
                                    <xsl:when test="$stock = 'D64L'"/>
                                    <xsl:when test="$stock = 'Kodak  ESTM'"/>
                                    <xsl:when test="$stock = 'Kodak'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Kodak" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Eastman'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Eastman" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Agfa Gevaert'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/AgfaGevaert" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Fuji'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Fuji" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Agfa'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Agfa" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Ilford'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Ilford" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Eastman Kodak'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/EastmanKodak" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Gevaert Belgium'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/GevaertBelgium" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Pathe'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Pathe" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Gevaert'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Gevaert" />
                                    </xsl:when>
                                    <xsl:when test="$stock = '3M'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/3M" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Orwo'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Orwo" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Sony'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Sony" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Dupont'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Dupont" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Ferrania'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Ferrania" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Panasonic'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Panasonic" />
                                    </xsl:when>
                                    <xsl:when test="$stock = 'EASTMAN'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Eastman" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:message terminate="yes">
                                            Error: Unexpected value "<xsl:value-of select="$stock"/>".
                                        </xsl:message>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </rdf:Description>
                        </fiaf:hasStock>
                    </xsl:for-each>

                    <!-- fiaf:isElement -->

                    <xsl:for-each select="physical_description[normalize-space(.)]">
                        <xsl:variable name="element" select="." />
                        <xsl:choose>
                            <xsl:when test="$element = 'Positive'"/>
                            <xsl:when test="$element = 'Magnetic'"/>
                            <xsl:when test="$element = 'Master'"/>
                            <xsl:when test="$element = 'Master Positive'"/>
                            <xsl:when test="$element = 'Negative'"/>
                            <xsl:when test="$element = 'Magnetic recording'"/>
                            <xsl:when test="$element = 'Cyan Separation Promaster'"/>
                            <xsl:when test="$element = 'Yellow Separation Promaster'"/>
                            <xsl:when test="$element = 'Magenta Separation Promaster'"/>
                            <xsl:when test="$element = 'BW Negative'"/>
                            <xsl:when test="$element = 'BW and Colour Positive'"/>
                            <xsl:when test="$element = 'Tinted Positive'"/>
                            <xsl:when test="$element = 'BW and Tinted Positive'"/>
                            <xsl:when test="$element = 'Cyan Separation Negative'"/>
                            <xsl:when test="$element = 'Magenta Separation Negative'"/>
                            <xsl:when test="$element = 'Yellow Separation Negative'"/>
                            <xsl:when test="$element = 'Re-recorded Negative'"/>
                            <xsl:when test="$element = 'Reversal Colour Internegative'"/>
                            <xsl:when test="$element = 'Dupe'"/>
                            <xsl:when test="$element = 'Cyan Separation Matrix'"/>
                            <xsl:when test="$element = 'Yellow Separation Matrix'"/>
                            <xsl:when test="$element = 'Magenta Separation Matrix'"/>
                            <xsl:when test="$element = 'Disc'"/>
                            <xsl:when test="$element = 'Re-recorded'"/>
                            <xsl:when test="$element = 'Dupe Yellow Separation Negative'"/>
                            <xsl:when test="$element = 'Dupe Cyan Separation Negative'"/>
                            <xsl:when test="$element = 'Dupe Magenta Separation Negative'"/>
                            <xsl:when test="$element = 'Interpositive'"/>
                            <xsl:when test="$element = 'Duplicating BW Positive'"/>
                            <xsl:when test="$element = 'DTS Disc'"/>
                            <xsl:when test="$element = 'Original BW Negative'"/>
                            <xsl:when test="$element = 'Original / Dupe Negative'"/>
                            <xsl:when test="$element = 'Duplicating'"/>
                            <xsl:when test="$element = 'Original Magenta Separation Negative'"/>
                            <xsl:when test="$element = 'Original Cyan Separation Negative'"/>
                            <xsl:when test="$element = 'Original Yellow Separation Negative'"/>
                            <xsl:when test="$element = 'Digital Theater Systems'"/>
                            <xsl:when test="$element = 'Separation Promaster'"/>
                            <xsl:when test="$element = 'Master'"/>
                            <xsl:when test="$element = 'Original'"/>
                            <xsl:when test="$element = 'Duplicating Negative'"/>
                            <xsl:when test="$element = 'Tinted and Toned Positive'"/>
                            <xsl:when test="$element = 'Yellow Matrix'"/>
                            <xsl:when test="$element = 'Cyan Colour Matrix'"/>
                            <xsl:when test="$element = 'Magenta Colour Matrix'"/>
                            <xsl:when test="$element = 'Negative and Positive'"/>
                            <xsl:when test="$element = 'Dupe Magnetic Recording'"/>
                            <xsl:when test="$element = 'TV (low contrast)'"/>
                            <xsl:when test="$element = 'Colour Reversal Internegative'"/>
                            <xsl:when test="$element = 'Original Separation Negative'"/>
                            <xsl:when test="$element = 'Promaster'"/>
                            <xsl:when test="$element = 'Separation Negative'"/>
                            <xsl:when test="$element = 'Dupe Separation Negative'"/>
                            <xsl:when test="$element = 'Finegrain Dupe Positive'"/>
                            <xsl:when test="$element = 'Yellow Promaster'"/>
                            <xsl:when test="$element = 'Magenta Promaster'"/>
                            <xsl:when test="$element = 'Red Separation Negative'"/>
                            <xsl:when test="$element = 'Blue Separation Negative'"/>
                            <xsl:when test="$element = 'Reversal Positive'"/>
                            <xsl:when test="$element = 'TV (low contrast) BW Positive'"/>
                            <xsl:when test="$element = 'BW and Tinted and Toned Positive'"/>
                            <xsl:when test="$element = 'Lavender Positive'"/>
                            <xsl:when test="$element = 'Dupe Cyan Separation Promaster'"/>
                            <xsl:when test="$element = 'Dupe Magenta Separation Promaster'"/>
                            <xsl:when test="$element = 'Original / Dupe Yellow Separation Negative'"/>
                            <xsl:when test="$element = 'Reversal BW Positive'"/>
                            <xsl:when test="$element = 'Dupe Yellow Separation Promaster'"/>
                            <xsl:when test="$element = 'Magenta Separation Positive'"/>
                            <xsl:when test="$element = 'Original / Dupe Cyan Separation Negative'"/>
                            <xsl:when test="$element = 'Original / Dupe Magenta Separation Negative'"/>
                            <xsl:when test="$element = 'BW Dupe Negative'"/>
                            <xsl:when test="$element = 'Cyan Promaster'"/>
                            <xsl:when test="$element = 'Original Reversal Colour Positive'"/>
                            <xsl:when test="$element = 'TV (low contrast) Positive'"/>
                            <xsl:when test="$element = 'Dupe Colour Negative'"/>
                            <xsl:when test="$element = 'Dupe BW Positive'"/>
                            <xsl:when test="$element = 'Reversal Internegative'"/>
                            <xsl:when test="$element = 'Duplicating Tinted Positive'"/>
                            <xsl:when test="$element = 'Yellow Separation Positive'"/>
                            <xsl:when test="$element = 'Dupe Magenta Separation Matrix'"/>
                            <xsl:when test="$element = 'Magnetic Tape'"/>
                            <xsl:when test="$element = 'Dupe Colour Positive'"/>
                            <xsl:when test="$element = 'Recording'"/>
                            <xsl:when test="$element = 'Dupe BW Negative and Positive'"/>
                            <xsl:when test="$element = 'Successive frame Separation Negative'"/>
                            <xsl:when test="$element = 'Dupe Red Separation Negative'"/>
                            <xsl:when test="$element = 'Cyan Separation Positive'"/>
                            <xsl:when test="$element = 'Cyan Colour Promaster'"/>
                            <xsl:when test="$element = 'Dupe Yellow Separation Matrix'"/>
                            <xsl:when test="$element = 'Dupe Cyan Separation Matrix'"/>
                            <xsl:when test="$element = 'Colour Positive Technovision'"/>
                            <xsl:when test="$element = 'BW Negative and Positive'"/>
                            <xsl:when test="$element = 'Reversal Colour Positive'"/>
                            <xsl:when test="$element = 'Red Separation Promaster'"/>
                            <xsl:when test="$element = 'Lavender'"/>
                            <xsl:when test="$element = 'Master BW Positive'"/>
                            <xsl:when test="$element = 'Green Separation Promaster'"/>
                            <xsl:when test="$element = 'Blue Separation Promaster'"/>
                            <xsl:when test="$element = 'Dupe Reversal Colour Positive'"/>
                            <xsl:when test="$element = 'Colour Promaster'"/>
                            <xsl:when test="$element = 'Dupe Reversal BW Positive'"/>
                            <xsl:when test="$element = 'Original / Dupe Colour Negative'"/>
                            <xsl:when test="$element = 'Original Colour Internegative'"/>
                            <xsl:when test="$element = 'Magenta Colour Promaster'"/>
                            <xsl:when test="$element = 'Dupe Blue Separation Negative'"/>
                            <xsl:when test="$element = 'Colour Reversal Positive'"/>
                            <xsl:when test="$element = 'Original Positive'"/>
                            <xsl:when test="$element = 'Reversal Colour Negative'"/>
                            <xsl:when test="$element = 'Telerecorded Negative'"/>
                            <xsl:when test="$element = 'DAT'"/>
                            <xsl:when test="$element = 'Re-recorded Positive'"/>
                            <xsl:when test="$element = 'Magenta'"/>
                            <xsl:when test="$element = 'X-Mods'"/>
                            <xsl:when test="$element = 'BW Television Print'"/>
                            <xsl:when test="$element = 'X-Mods Positive'"/>
                            <xsl:when test="$element = 'Original / Dupe BW Negative'"/>
                            <xsl:when test="$element = 'Duplicating BW Negative'"/>
                            <xsl:when test="$element = 'Master Negative'"/>
                            <xsl:when test="$element = 'Sepia BW and Tinted and Toned Positive'"/>
                            <xsl:when test="$element = '2 Colour Separation Negative'"/>
                            <xsl:when test="$element = 'Master Magenta'"/>
                            <xsl:when test="$element = 'Original Colour'"/>
                            <xsl:when test="$element = 'Sepia Toned Positive'"/>
                            <xsl:when test="$element = 'Master Recording'"/>
                            <xsl:when test="$element = 'Separation Matrix'"/>
                            <xsl:when test="$element = 'Original Reversal Positive'"/>
                            <xsl:when test="$element = 'Master Cyan'"/>
                            <xsl:when test="$element = 'Yellow Tinted Positive'"/>
                            <xsl:when test="$element = 'TV (low contrast) Colour Positive'"/>
                            <xsl:when test="$element = 'BW Tinted and Toned Positive'"/>
                            <xsl:when test="$element = 'Yellow'"/>
                            <xsl:when test="$element = 'Successive frame Promaster'"/>
                            <xsl:when test="$element = 'Original Colour Negative Technovision'"/>
                            <xsl:when test="$element = 'Master Magenta Separation Promaster'"/>
                            <xsl:when test="$element = 'Duplicating BW'"/>
                            <xsl:when test="$element = 'Reversal BW'"/>
                            <xsl:when test="$element = 'Tinted and Toned'"/>
                            <xsl:when test="$element = 'Master Yellow'"/>
                            <xsl:when test="$element = 'Dupe X-Mods'"/>
                            <xsl:when test="$element = 'Original Colour Positive'"/>
                            <xsl:when test="$element = 'Cyan Tape'"/>
                            <xsl:when test="$element = 'Dupe Separation Matrix'"/>
                            <xsl:when test="$element = 'Separation Positive'"/>
                            <xsl:when test="$element = 'Dupe Reversal Colour Internegative'"/>
                            <xsl:when test="$element = 'Orange Tinted Positive'"/>
                            <xsl:when test="$element = 'Original BW and Colour Negative'"/>
                            <xsl:when test="$element = 'Dupe Negative and Positive'"/>
                            <xsl:when test="$element = 'Dupe Lavender Positive'"/>
                            <xsl:when test="$element = 'Cyan'"/>
                            <xsl:when test="$element = 'Original Magenta Separation Matrix'"/>
                            <xsl:when test="$element = 'Colour Check Print'"/>
                            <xsl:when test="$element = 'Original Yellow Separation Matrix'"/>
                            <xsl:when test="$element = 'TV (low contrast) BW'"/>
                            <xsl:when test="$element = 'Original Magenta Separation Positive'"/>
                            <xsl:when test="$element = 'Cyan Negative'"/>
                            <xsl:when test="$element = 'X-Mods Negative'"/>
                            <xsl:when test="$element = 'Answer Print'"/>
                            <xsl:when test="$element = 'Dupe Colour Internegative'"/>
                            <xsl:when test="$element = 'Dupe Blue Negative'"/>
                            <xsl:when test="$element = 'BW Tinted Positive'"/>
                            <xsl:when test="$element = 'BW and Colour Negative'"/>
                            <xsl:when test="$element = 'BW and Tinted and Toned'"/>
                            <xsl:when test="$element = 'Yellow Separation'"/>
                            <xsl:when test="$element = 'Blue Positive'"/>
                            <xsl:when test="$element = 'Original Reversal Colour Positive Monopack'"/>
                            <xsl:when test="$element = 'Colour Negative and Positive'"/>
                            <xsl:when test="$element = 'Blue Separation Positive'"/>
                            <xsl:when test="$element = 'Original Reversal Colour Internegative'"/>
                            <xsl:when test="$element = 'Blue Tape'"/>
                            <xsl:when test="$element = 'Original Cyan Separation Matrix'"/>
                            <xsl:when test="$element = 'Cyan Matrix'"/>
                            <xsl:when test="$element = 'Original Reversal'"/>
                            <xsl:when test="$element = 'Yellow Negative'"/>
                            <xsl:when test="$element = 'Red Separation Positive'"/>
                            <xsl:when test="$element = 'Colour Answer Print'"/>
                            <xsl:when test="$element = 'Reversal Disc'"/>
                            <xsl:when test="$element = 'Original Negative and Positive'"/>
                            <xsl:when test="$element = 'Dupe Green Separation Negative'"/>
                            <xsl:when test="$element = 'Magenta Matrix'"/>
                            <xsl:when test="$element = 'Duplicating Colour Positive'"/>
                            <xsl:when test="$element = 'Tinted and Tinted and Toned Positive'"/>
                            <xsl:when test="$element = 'Magenta Positive'"/>
                            <xsl:when test="$element = 'Magenta Separation'"/>
                            <xsl:when test="$element = 'Successive frame Negative'"/>
                            <xsl:when test="$element = 'Lavender Duplicating Positive'"/>
                            <xsl:when test="$element = 'Laserdisc'"/>
                            <xsl:when test="$element = 'Magnetic Recording 3 Track Stereophonic'"/>
                            <xsl:when test="$element = 'Sepia Positive'"/>
                            <xsl:when test="$element = 'Duplicating Reversal'"/>
                            <xsl:when test="$element = 'Duplicating Negative and Positive'"/>
                            <xsl:when test="$element = 'Duplicating Lavender Negative and Positive'"/>
                            <xsl:when test="$element = 'Dupe Lavender Negative'"/>
                            <xsl:when test="$element = 'Master Cyan Separation'"/>
                            <xsl:when test="$element = 'Dupe Magenta Negative'"/>
                            <xsl:when test="$element = 'Magenta Negative'"/>
                            <xsl:when test="$element = 'Master Separation'"/>
                            <xsl:when test="$element = 'Master X-Mods Positive'"/>
                            <xsl:when test="$element = 'Original / Dupe BW Negative and Positive'"/>
                            <xsl:when test="$element = 'Original / Dupe'"/>
                            <xsl:when test="$element = 'Master Yellow Separation Promaster'"/>
                            <xsl:when test="$element = 'Dupe Red Negative'"/>
                            <xsl:when test="$element = 'Tinted and Stencil Positive'"/>
                            <xsl:when test="$element = 'TV (low contrast) BW and Colour Positive'"/>
                            <xsl:when test="$element = 'Re-recorded Internegative'"/>
                            <xsl:when test="$element = 'Successive frame Colour Promaster'"/>
                            <xsl:when test="$element = 'Reversal Colour Interpositive'"/>
                            <xsl:when test="$element = 'Successive frame Separation Promaster'"/>
                            <xsl:when test="$element = 'Yellow BW Positive'"/>
                            <xsl:when test="$element = 'Reversal Negative'"/>
                            <xsl:when test="$element = 'Toned Positive'"/>
                            <xsl:when test="$element = 'Red'"/>
                            <xsl:when test="$element = 'Reversal'"/>
                            <xsl:when test="$element = 'Red Negative'"/>
                            <xsl:when test="$element = 'Toned'"/>
                            <xsl:when test="$element = 'Sepia Internegative'"/>
                            <xsl:when test="$element = 'Telerecorded BW and Tinted Positive'"/>
                            <xsl:when test="$element = 'Sepia BW Positive'"/>
                            <xsl:when test="$element = 'Tinted'"/>
                            <xsl:when test="$element = 'Tinted Negative and Positive'"/>
                            <xsl:when test="$element = 'Separation Negative and Positive'"/>
                            <xsl:when test="$element = 'Tri Negative'"/>
                            <xsl:when test="$element = '2 Colour Positive'"/>
                            <xsl:when test="$element = 'Pink'"/>
                            <xsl:when test="$element = 'Dupe Successive frame Colour Negative'"/>
                            <xsl:when test="$element = 'Duplicating Tape'"/>
                            <xsl:when test="$element = 'Duplicating Reversal Colour Positive'"/>
                            <xsl:when test="$element = 'Duplicating Reversal BW Positive'"/>
                            <xsl:when test="$element = 'Duplicating Promaster'"/>
                            <xsl:when test="$element = 'Duplicating Lavender Colour Positive'"/>
                            <xsl:when test="$element = 'Duplicating Lavender BW Positive'"/>
                            <xsl:when test="$element = 'Duplicating Colour Interpositive'"/>
                            <xsl:when test="$element = 'Duplicating Blue Colour Positive'"/>
                            <xsl:when test="$element = 'Duplicating BW and Tinted Positive'"/>
                            <xsl:when test="$element = 'Duplicating BW Negative and Positive'"/>
                            <xsl:when test="$element = 'Duplicating Amber Tinted Positive'"/>
                            <xsl:when test="$element = 'Dupe Yellow and Magenta Separation Negative'"/>
                            <xsl:when test="$element = 'Dupe X-Mods Negative'"/>
                            <xsl:when test="$element = 'Dupe Successive frame Separation Negative'"/>
                            <xsl:when test="$element = 'Dupe Separation Promaster'"/>
                            <xsl:when test="$element = 'Green Separation Positive'"/>
                            <xsl:when test="$element = 'Dupe Internegative'"/>
                            <xsl:when test="$element = 'Dupe Cyan Separation'"/>
                            <xsl:when test="$element = 'Dupe Copper Separation Matrix'"/>
                            <xsl:when test="$element = 'Dupe Colour Reversal Positive'"/>
                            <xsl:when test="$element = 'Dupe BW Reversal Positive'"/>
                            <xsl:when test="$element = 'DTS Colour'"/>
                            <xsl:when test="$element = 'Cyan Separation'"/>
                            <xsl:when test="$element = 'Cyan BW Positive'"/>
                            <xsl:when test="$element = 'Blue Toned Positive'"/>
                            <xsl:when test="$element = 'Blue Negative'"/>
                            <xsl:when test="$element = 'Blue BW Positive'"/>
                            <xsl:when test="$element = 'Blue'"/>
                            <xsl:when test="$element = 'BW and Tinted'"/>
                            <xsl:when test="$element = 'BW Interpositive'"/>
                            <xsl:when test="$element = 'Duplicating Tinted and Toned Positive'"/>
                            <xsl:when test="$element = 'Lavender BW Positive'"/>
                            <xsl:when test="$element = 'Original Yellow Separation Positive'"/>
                            <xsl:when test="$element = 'Original / Dupe Positive'"/>
                            <xsl:when test="$element = 'Original X-Mods Negative'"/>
                            <xsl:when test="$element = 'Original Separation Negative and Positive'"/>
                            <xsl:when test="$element = 'Original Reversal Colour Negative'"/>
                            <xsl:when test="$element = 'Original Reversal Colour'"/>
                            <xsl:when test="$element = 'Original Reversal BW Positive'"/>
                            <xsl:when test="$element = 'Original Red Separation Negative'"/>
                            <xsl:when test="$element = 'Original Promaster'"/>
                            <xsl:when test="$element = 'Original Grey base Colour Negative'"/>
                            <xsl:when test="$element = 'Original Grey base Colour Internegative'"/>
                            <xsl:when test="$element = 'Original Cyan Separation Positive'"/>
                            <xsl:when test="$element = 'Original Colour Interpositive'"/>
                            <xsl:when test="$element = 'Original Blue Separation Negative'"/>
                            <xsl:when test="$element = 'Original BW and Colour Interpositive'"/>
                            <xsl:when test="$element = 'Original BW Negative and Positive'"/>
                            <xsl:when test="$element = 'Orange Colour Positive'"/>
                            <xsl:when test="$element = 'Lavender BW and Tinted Positive'"/>
                            <xsl:when test="$element = 'Orange BW and Tinted Positive'"/>
                            <xsl:when test="$element = 'Orange BW Positive'"/>
                            <xsl:when test="$element = 'Master Yellow Separation'"/>
                            <xsl:when test="$element = 'Master Magnetic Recording'"/>
                            <xsl:when test="$element = 'Master Magenta Separation'"/>
                            <xsl:when test="$element = 'Master Cyan Separation Promaster'"/>
                            <xsl:when test="$element = 'Master Cyan Promaster'"/>
                            <xsl:when test="$element = 'Master Colour Interpositive'"/>
                            <xsl:when test="$element = 'Master Colour'"/>
                            <xsl:when test="$element = 'Master BW'"/>
                            <xsl:when test="$element = 'Magnetic Recording Loop'"/>
                            <xsl:when test="$element = 'Magenta Colour Positive'"/>
                            <xsl:when test="$element = 'Magenta Colour Negative'"/>
                            <xsl:when test="$element = 'Magenta BW Positive'"/>
                            <xsl:when test="$element = 'Magnetic Cassette Recording'"/>
                            <xsl:when test="$element = 'BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReleasePrint" />
                            </xsl:when>
                            <xsl:when test="$element = 'Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReleasePrint" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/OriginalNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Colour Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/OriginalNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Colour Internegative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Colour Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Colour Interpositive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Lavender Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe BW negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Internegative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:message terminate="yes">
                                    Error: Unexpected value "<xsl:value-of select="$element"/>".
                                </xsl:message>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>

                </rdf:Description>
            </xsl:for-each>
        </rdf:RDF>
    </xsl:template>

</xsl:stylesheet>
