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
                            <xsl:when test="$base = 'PVC'">
                                <fiaf:hasBase rdf:resource="https://dev.fiafcore.org/PVCBase" />
                            </xsl:when>
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

                    <xsl:for-each select="physical_description[normalize-space(.)]">
                        <xsl:variable name="desc" select="." />
                        <xsl:variable name="is_separation_or_matrix" select="
                            contains($desc, 'Separation') or
                            contains($desc, 'Matrix') or
                            contains($desc, 'Successive frame') or
                            $desc = 'Tri Negative' or
                            $desc = 'Cyan Promaster' or
                            $desc = 'Magenta Promaster' or
                            $desc = 'Yellow Promaster' or
                            $desc = 'Cyan Colour Promaster' or
                            $desc = 'Magenta Colour Promaster' or
                            $desc = 'Master Cyan Promaster' or
                            $desc = 'Cyan Negative' or
                            $desc = 'Magenta Negative' or
                            $desc = 'Yellow Negative' or
                            $desc = 'Red Negative' or
                            $desc = 'Blue Negative' or
                            $desc = 'Dupe Blue Negative' or
                            $desc = 'Dupe Magenta Negative' or
                            $desc = 'Dupe Red Negative' or
                            $desc = 'Magenta Colour Negative'
                        " />
                        <xsl:choose>
                            <xsl:when test="$is_separation_or_matrix">
                                <fiaf:hasColourCharacteristic>
                                    <rdf:Description>
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/BlackAndWhite" />
                                    </rdf:Description>
                                </fiaf:hasColourCharacteristic>
                            </xsl:when>
                            <xsl:when test="contains($desc, 'BW') or contains($desc, 'Colour') or contains($desc, 'Tinted') or contains($desc, 'Toned') or contains($desc, 'Sepia') or contains($desc, 'Stencil')">
                                <fiaf:hasColourCharacteristic>
                                    <rdf:Description>
                                        <xsl:choose>
                                            <xsl:when test="contains($desc, 'BW and Colour')">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/BlackAndWhite" />
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Colour" />
                                            </xsl:when>
                                            <xsl:when test="contains($desc, 'BW')">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/BlackAndWhite" />
                                            </xsl:when>
                                            <xsl:when test="contains($desc, 'Colour')">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Colour" />
                                            </xsl:when>
                                        </xsl:choose>
                                        <xsl:if test="contains($desc, 'Tinted')">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Tinted" />
                                        </xsl:if>
                                        <xsl:if test="contains($desc, 'Toned') or contains($desc, 'Sepia')">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/Toned" />
                                        </xsl:if>
                                        <xsl:if test="contains($desc, 'Stencil')">
                                            <fiaf:hasColourProcess rdf:resource="https://dev.fiafcore.org/StencilColouring" />
                                        </xsl:if>
                                    </rdf:Description>
                                </fiaf:hasColourCharacteristic>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>

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

                    <xsl:for-each select="physical_description[normalize-space(.)]">
                        <xsl:variable name="format" select="." />
                        <xsl:choose>
                            <xsl:when test="$format = 'Laserdisc'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/LaserDisc" />
                            </xsl:when>
                            <xsl:when test="$format = 'DAT'">
                                <fiaf:hasFormat rdf:resource="https://dev.fiafcore.org/DAT" />
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>

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

                    <xsl:variable name="sound_item" select=".//sound_item/value[@lang='0'][normalize-space(.)]" />
                    <xsl:variable name="phys_sound" select="physical_description[contains(., 'Magnetic') or contains(., 'X-Mods') or contains(., 'Re-recorded') or contains(., 'DTS') or . = 'Digital Theater Systems']" />
                    <xsl:if test="($sound_item and $sound_item != 'Mixed') or $phys_sound">
                        <fiaf:hasSoundCharacteristic>
                            <rdf:Description>
                                <xsl:choose>
                                    <xsl:when test="$sound_item = 'Sound' or $sound_item = 'Combined' or $sound_item = 'Combined as Sound'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Sound" />
                                    </xsl:when>
                                    <xsl:when test="$sound_item = 'Mute' or $sound_item = 'Combined as Mute'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Mute" />
                                    </xsl:when>
                                    <xsl:when test="$sound_item = 'Silent'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Silent" />
                                    </xsl:when>
                                    <xsl:when test="$sound_item = 'Mixed' or not($sound_item)">
                                        <xsl:if test="$phys_sound">
                                            <rdf:type rdf:resource="https://dev.fiafcore.org/Sound" />
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:message terminate="yes">
                                            Error: Unexpected value "<xsl:value-of select="$sound_item"/>".
                                        </xsl:message>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:for-each select="physical_description[normalize-space(.)]">
                                    <xsl:variable name="sdesc" select="." />
                                    <xsl:choose>
                                        <xsl:when test="$sdesc = 'Magnetic Recording 3 Track Stereophonic'">
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/Magnetic" />
                                            <fiaf:hasSoundChannelConfiguration rdf:resource="https://dev.fiafcore.org/Stereo" />
                                        </xsl:when>
                                        <xsl:when test="contains($sdesc, 'Magnetic')">
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/Magnetic" />
                                        </xsl:when>
                                        <xsl:when test="contains($sdesc, 'X-Mods') or contains($sdesc, 'Re-recorded')">
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/AnalogueOpticalSound" />
                                        </xsl:when>
                                        <xsl:when test="contains($sdesc, 'DTS') or $sdesc = 'Digital Theater Systems'">
                                            <fiaf:hasSoundStandard rdf:resource="https://dev.fiafcore.org/DTS" />
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:for-each>
                            </rdf:Description>
                        </fiaf:hasSoundCharacteristic>
                    </xsl:if>

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
                        <xsl:variable name="stock" select="translate(., '&amp;', '')" />
                        <!-- Build the type first: recognised but unmapped values must not emit empty stock nodes. -->
                        <xsl:variable name="stock_term">
                                <xsl:choose>
                                    <xsl:when test="$stock = 'Unidentified-Eastern European'"/>
                                    <xsl:when test="$stock = 'Kodak Canada'">
                                        <xsl:text>Kodak</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Unmarked'"/>
                                    <xsl:when test="$stock = 'Unidentified manufacturer'"/>
                                    <xsl:when test="$stock = 'Eastmancolor'"/>
                                    <xsl:when test="$stock = 'Pathe Cinema France'"><xsl:text>Pathe</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Selo'"/>
                                    <xsl:when test="$stock = 'Eastmancolor'"/>
                                    <xsl:when test="$stock = 'Unidentified-Russian'"/>
                                    <xsl:when test="$stock = 'Cbema'"/>
                                    <xsl:when test="$stock = 'Unidentified manufacturer'"/>
                                    <xsl:when test="$stock = 'SONY'"><xsl:text>Sony</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Ampex'"><xsl:text>Ampex</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Pyral'"><xsl:text>Pyral</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Maxell'">
                                        <xsl:text>Maxell</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'BASF'">
                                        <xsl:text>BASF</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'MIXED'"/>
                                    <xsl:when test="$stock = 'unknown credit activity'"/>
                                    <xsl:when test="$stock = 'Zonal'"><xsl:text>Zonal</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Deko'"><xsl:text>Deko</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Kodak France'"><xsl:text>Kodak</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Technicolor'"/>
                                    <xsl:when test="$stock = '?'"/>
                                    <xsl:when test="$stock = 'Perutz'"><xsl:text>Perutz</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'FTON'"/>
                                    <xsl:when test="$stock = 'BLNX'"/>
                                    <xsl:when test="$stock = 'Unidentified-Eastern European'"/>
                                    <xsl:when test="$stock = 'Estar'"/>
                                    <xsl:when test="$stock = 'OBS'"/>
                                    <xsl:when test="$stock = 'Dupont Pathe'"/>
                                    <xsl:when test="$stock = 'Kodak AG (German Kodak)'"><xsl:text>Kodak</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Goerz-Tenax'"><xsl:text>GoerzTenax</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Turkish'"/>
                                    <xsl:when test="$stock = 'Mafe'"><xsl:text>Mafe</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Ansco'"><xsl:text>Ansco</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Lignose'"><xsl:text>Lignose</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'D94L'"/>
                                    <xsl:when test="$stock = 'Unidentified-Indu'"/>
                                    <xsl:when test="$stock = 'DA8-113'"/>
                                    <xsl:when test="$stock = 'UNMARKED'"/>
                                    <xsl:when test="$stock = 'DVD-R'"/>
                                    <xsl:when test="$stock = 'SVMA'"/>
                                    <xsl:when test="$stock = 'DA8113'"/>
                                    <xsl:when test="$stock = 'TDK'">
                                        <xsl:text>TDK</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'T C FOX'"/>
                                    <xsl:when test="$stock = 'T AUET(USSR)'"/>
                                    <xsl:when test="$stock = 'VA RCA DUPLEX'"/>
                                    <xsl:when test="$stock = 'VUS'"/>
                                    <xsl:when test="$stock = 'Sakura'"><xsl:text>Sakura</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Pathe France'"><xsl:text>Pathe</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'E180'"/>
                                    <xsl:when test="$stock = 'E90'"/>
                                    <xsl:when test="$stock = 'IXD'"/>
                                    <xsl:when test="$stock = 'D124L'"/>
                                    <xsl:when test="$stock = 'Indu'"><xsl:text>Indu</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'JVC'"><xsl:text>JVC</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'KANS'"/>
                                    <xsl:when test="$stock = 'KCA'"/>
                                    <xsl:when test="$stock = 'D22'"/>
                                    <xsl:when test="$stock = 'Memorex'"><xsl:text>Memorex</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'EMTEC'"><xsl:text>EMTEC</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Svema'"><xsl:text>Svema</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'EACO'"/>
                                    <xsl:when test="$stock = 'D124'"/>
                                    <xsl:when test="$stock = 'Pathe Freres'"><xsl:text>Pathe</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Pathe Paris'"><xsl:text>Pathe</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'Pathe Vincennes Paris'"><xsl:text>Pathe</xsl:text></xsl:when>
                                    <xsl:when test="$stock = 'D64L'"/>
                                    <xsl:when test="$stock = 'Kodak  ESTM'"/>
                                    <xsl:when test="$stock = 'Kodak'">
                                        <xsl:text>Kodak</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Eastman'">
                                        <xsl:text>Eastman</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Agfa Gevaert'">
                                        <xsl:text>AgfaGevaert</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Fuji'">
                                        <xsl:text>Fuji</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Agfa'">
                                        <xsl:text>Agfa</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Ilford'">
                                        <xsl:text>Ilford</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Eastman Kodak'">
                                        <xsl:text>EastmanKodak</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Gevaert Belgium'">
                                        <xsl:text>GevaertBelgium</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Pathe'">
                                        <xsl:text>Pathe</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Gevaert'">
                                        <xsl:text>Gevaert</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = '3M'">
                                        <xsl:text>3M</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Orwo'">
                                        <xsl:text>Orwo</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Sony'">
                                        <xsl:text>Sony</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Dupont'">
                                        <xsl:text>Dupont</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Ferrania'">
                                        <xsl:text>Ferrania</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'Panasonic'">
                                        <xsl:text>Panasonic</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="$stock = 'EASTMAN'">
                                        <xsl:text>Eastman</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:message terminate="yes">
                                            Error: Unexpected value "<xsl:value-of select="$stock"/>".
                                        </xsl:message>
                                    </xsl:otherwise>
                                </xsl:choose>
                        </xsl:variable>
                        <xsl:if test="normalize-space($stock_term)">
                            <fiaf:hasStock>
                                <rdf:Description>
                                    <rdf:type rdf:resource="https://dev.fiafcore.org/{normalize-space($stock_term)}" />
                                </rdf:Description>
                            </fiaf:hasStock>
                        </xsl:if>
                    </xsl:for-each>

                    <!-- fiaf:isElement -->

                    <xsl:for-each select="physical_description[normalize-space(.)]">
                        <xsl:variable name="element" select="." />
                        <xsl:choose>
                            <xsl:when test="$element = 'Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magnetic'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master'"/>
                            <xsl:when test="$element = 'Master Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Negative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magnetic recording'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Cyan Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Yellow Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'BW Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Negative" />
                            </xsl:when>
                            <xsl:when test="$element = 'BW and Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Tinted Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'BW and Tinted Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Cyan Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Yellow Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Re-recorded Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/SoundNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Reversal Colour Internegative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourReversalIntermediate" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe'"/>
                            <xsl:when test="$element = 'Cyan Separation Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Yellow Separation Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta Separation Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Disc'"/>
                            <xsl:when test="$element = 'Re-recorded'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Yellow Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Cyan Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Magenta Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Interpositive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'DTS Disc'"/>
                            <xsl:when test="$element = 'Original BW Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/OriginalNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original / Dupe Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Negative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating'"/>
                            <xsl:when test="$element = 'Original Magenta Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Cyan Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Yellow Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Digital Theater Systems'"/>
                            <xsl:when test="$element = 'Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master'"/>
                            <xsl:when test="$element = 'Original'"/>
                            <xsl:when test="$element = 'Duplicating Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Tinted and Toned Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Yellow Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Cyan Colour Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta Colour Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Magnetic Recording'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'TV (low contrast)'"/>
                            <xsl:when test="$element = 'Colour Reversal Internegative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourReversalIntermediate" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Finegrain Dupe Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Yellow Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Red Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Blue Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Reversal Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReversalPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'TV (low contrast) BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'BW and Tinted and Toned Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Lavender Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Cyan Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Magenta Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original / Dupe Yellow Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Reversal BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReversalPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Yellow Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta Separation Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original / Dupe Cyan Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original / Dupe Magenta Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'BW Dupe Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Cyan Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Reversal Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReversalPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'TV (low contrast) Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Colour Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Reversal Internegative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourReversalIntermediate" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Tinted Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Yellow Separation Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Magenta Separation Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magnetic Tape'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Recording'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe BW Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Successive frame Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Red Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Cyan Separation Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Cyan Colour Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Yellow Separation Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Cyan Separation Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Colour Positive Technovision'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'BW Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Reversal Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReversalPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Red Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Lavender'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Green Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Blue Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Reversal Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Colour Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Reversal BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original / Dupe Colour Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Negative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Colour Internegative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta Colour Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Blue Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Colour Reversal Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReversalPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Reversal Colour Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Negative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Telerecorded Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'DAT'"/>
                            <xsl:when test="$element = 'Re-recorded Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/SoundPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta'"/>
                            <xsl:when test="$element = 'X-Mods'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'BW Television Print'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'X-Mods Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/SoundPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original / Dupe BW Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Negative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating BW Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Sepia BW and Tinted and Toned Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = '2 Colour Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Magenta'"/>
                            <xsl:when test="$element = 'Original Colour'"/>
                            <xsl:when test="$element = 'Sepia Toned Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Recording'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioMaster" />
                            </xsl:when>
                            <xsl:when test="$element = 'Separation Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Reversal Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReversalPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Cyan'"/>
                            <xsl:when test="$element = 'Yellow Tinted Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'TV (low contrast) Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'BW Tinted and Toned Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Yellow'"/>
                            <xsl:when test="$element = 'Successive frame Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Colour Negative Technovision'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/OriginalNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Magenta Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating BW'"/>
                            <xsl:when test="$element = 'Reversal BW'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReversalPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Tinted and Toned'"/>
                            <xsl:when test="$element = 'Master Yellow'"/>
                            <xsl:when test="$element = 'Dupe X-Mods'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Cyan Tape'"/>
                            <xsl:when test="$element = 'Dupe Separation Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Separation Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Reversal Colour Internegative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourReversalIntermediate" />
                            </xsl:when>
                            <xsl:when test="$element = 'Orange Tinted Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original BW and Colour Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/OriginalNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Lavender Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Cyan'"/>
                            <xsl:when test="$element = 'Original Magenta Separation Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Colour Check Print'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AnswerPrint" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Yellow Separation Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'TV (low contrast) BW'"/>
                            <xsl:when test="$element = 'Original Magenta Separation Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Cyan Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'X-Mods Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/SoundNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Answer Print'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AnswerPrint" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Colour Internegative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Blue Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'BW Tinted Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'BW and Colour Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Negative" />
                            </xsl:when>
                            <xsl:when test="$element = 'BW and Tinted and Toned'"/>
                            <xsl:when test="$element = 'Yellow Separation'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Blue Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Reversal Colour Positive Monopack'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReversalPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Colour Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Blue Separation Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Reversal Colour Internegative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourReversalIntermediate" />
                            </xsl:when>
                            <xsl:when test="$element = 'Blue Tape'"/>
                            <xsl:when test="$element = 'Original Cyan Separation Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Cyan Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Reversal'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReversalPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Yellow Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Red Separation Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Colour Answer Print'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AnswerPrint" />
                            </xsl:when>
                            <xsl:when test="$element = 'Reversal Disc'"/>
                            <xsl:when test="$element = 'Original Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Green Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Tinted and Tinted and Toned Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta Separation'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Successive frame Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Lavender Duplicating Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Laserdisc'"/>
                            <xsl:when test="$element = 'Magnetic Recording 3 Track Stereophonic'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Sepia Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Reversal'"/>
                            <xsl:when test="$element = 'Duplicating Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Lavender Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Lavender Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Cyan Separation'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Magenta Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Separation'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master X-Mods Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/SoundPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original / Dupe BW Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original / Dupe'"/>
                            <xsl:when test="$element = 'Master Yellow Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Red Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Tinted and Stencil Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'TV (low contrast) BW and Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Re-recorded Internegative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/SoundNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Successive frame Colour Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Reversal Colour Interpositive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Successive frame Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Yellow BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Reversal Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Negative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Toned Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Red'"/>
                            <xsl:when test="$element = 'Reversal'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReversalPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Red Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Toned'"/>
                            <xsl:when test="$element = 'Sepia Internegative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Telerecorded BW and Tinted Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Sepia BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Tinted'"/>
                            <xsl:when test="$element = 'Tinted Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Separation Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Tri Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = '2 Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Pink'"/>
                            <xsl:when test="$element = 'Dupe Successive frame Colour Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Tape'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Reversal Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Reversal BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Lavender Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Lavender BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Colour Interpositive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Blue Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating BW and Tinted Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating BW Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Amber Tinted Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Yellow and Magenta Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe X-Mods Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/SoundNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Successive frame Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Green Separation Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Internegative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Cyan Separation'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Copper Separation Matrix'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DyeTransferMatrix" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe Colour Reversal Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Dupe BW Reversal Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'DTS Colour'"/>
                            <xsl:when test="$element = 'Cyan Separation'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Cyan BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Blue Toned Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Blue Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Blue BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Blue'"/>
                            <xsl:when test="$element = 'BW and Tinted'"/>
                            <xsl:when test="$element = 'BW Interpositive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Duplicating Tinted and Toned Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Lavender BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Yellow Separation Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original / Dupe Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original X-Mods Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/SoundNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Separation Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Reversal Colour Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Negative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Reversal Colour'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReversalPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Reversal BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ReversalPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Red Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Grey base Colour Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/OriginalNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Grey base Colour Internegative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicateNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Cyan Separation Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Colour Interpositive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original Blue Separation Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original BW and Colour Interpositive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Original BW Negative and Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Orange Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Lavender BW and Tinted Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Orange BW and Tinted Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Orange BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Yellow Separation'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Magnetic Recording'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioMaster" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Magenta Separation'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/FilmElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Cyan Separation Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Cyan Promaster'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationPositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Colour Interpositive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/DuplicatePositive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Master Colour'"/>
                            <xsl:when test="$element = 'Master BW'"/>
                            <xsl:when test="$element = 'Magnetic Recording Loop'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta Colour Negative'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/ColourSeparationNegative" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magenta BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Magnetic Cassette Recording'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/AudioElement" />
                            </xsl:when>
                            <xsl:when test="$element = 'BW Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
                            </xsl:when>
                            <xsl:when test="$element = 'Colour Positive'">
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Positive" />
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
                                <fiaf:isElement rdf:resource="https://dev.fiafcore.org/Negative" />
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
