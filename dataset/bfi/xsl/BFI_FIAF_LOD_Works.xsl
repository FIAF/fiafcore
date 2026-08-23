<?xml version="1.0" encoding="UTF-8"?>

<!-- BFI XML Work data to FIAFcore -->
<!-- Paul Duchesne -->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:fiaf="https://dev.fiafcore.org/">

    <xsl:output method="xml" indent="yes" />

    <xsl:template match="/">
        <rdf:RDF>
            <xsl:for-each select="record">
                <rdf:Description rdf:about="bfi://resource/work/{@priref}">

                    <!-- fiaf:Work -->

                    <rdf:type rdf:resource="https://dev.fiafcore.org/Work" />

                    <!-- fiaf:hasCountry -->

                    <xsl:for-each select="production_country[normalize-space(.)]">
                    <xsl:variable name="apos">'</xsl:variable>
                    <xsl:variable name="country" select="translate(., $apos, '')" />
                        <xsl:choose>
                            <xsl:when test="$country = 'USSR'"/>
                            <xsl:when test="$country = 'Yugoslavia'"/>
                            <xsl:when test="$country = 'USA'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/UnitedStatesOfAmerica" />
                            </xsl:when>
                            <xsl:when test="$country = 'United Kingdom'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/UnitedKingdomOfGreatBritainAndNorthernIreland" />
                            </xsl:when>
                            <xsl:when test="$country = 'France'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/France" />
                            </xsl:when>
                            <xsl:when test="$country = 'Italy'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Italy" />
                            </xsl:when>
                            <xsl:when test="$country = 'Germany'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Germany" />
                            </xsl:when>
                            <xsl:when test="$country = 'Federal Republic of Germany'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Germany" />
                            </xsl:when>
                            <xsl:when test="$country = 'Canada'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Canada" />
                            </xsl:when>
                            <xsl:when test="$country = 'Spain'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Spain" />
                            </xsl:when>
                            <xsl:when test="$country = 'Russian SFSR'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/RussianFederation" />
                            </xsl:when>
                            <xsl:when test="$country = 'Japan'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Japan" />
                            </xsl:when>
                            <xsl:when test="$country = 'Australia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Australia" />
                            </xsl:when>
                            <xsl:when test="$country = 'India'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/India" />
                            </xsl:when>
                            <xsl:when test="$country = 'Sweden'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Sweden" />
                            </xsl:when>
                            <xsl:when test="$country = 'Ireland'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Ireland" />
                            </xsl:when>
                            <xsl:when test="$country = 'Switzerland'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Switzerland" />
                            </xsl:when>
                            <xsl:when test="$country = 'Czechoslovakia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Czechia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Netherlands'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/NetherlandsKingdomOfThe" />
                            </xsl:when>
                            <xsl:when test="$country = 'Mexico'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Mexico" />
                            </xsl:when>
                            <xsl:when test="$country = 'Peoples Republic of China'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/China" />
                            </xsl:when>
                            <xsl:when test="$country = 'Belgium'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Belgium" />
                            </xsl:when>
                            <xsl:when test="$country = 'Hong Kong'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/HongKong" />
                            </xsl:when>
                            <xsl:when test="$country = 'Hungary'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Hungary" />
                            </xsl:when>
                            <xsl:when test="$country = 'Poland'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Poland" />
                            </xsl:when>
                            <xsl:when test="$country = 'Denmark'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Denmark" />
                            </xsl:when>
                            <xsl:when test="$country = 'Austria'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Austria" />
                            </xsl:when>
                            <xsl:when test="$country = 'Greece'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Greece" />
                            </xsl:when>
                            <xsl:when test="$country = 'South Africa'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/SouthAfrica" />
                            </xsl:when>
                            <xsl:when test="$country = 'Argentina'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Argentina" />
                            </xsl:when>
                            <xsl:when test="$country = 'New Zealand'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/NewZealand" />
                            </xsl:when>
                            <xsl:when test="$country = 'Taiwan'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/TaiwanProvinceOfChina" />
                            </xsl:when>
                            <xsl:when test="$country = 'Norway'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Norway" />
                            </xsl:when>
                            <xsl:when test="$country = 'Ukrainian SSR'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Ukraine" />
                            </xsl:when>
                            <xsl:when test="$country = 'Brazil'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Brazil" />
                            </xsl:when>
                            <xsl:when test="$country = 'Israel'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Israel" />
                            </xsl:when>
                            <xsl:when test="$country = 'Portugal'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Portugal" />
                            </xsl:when>
                            <xsl:when test="$country = 'Luxembourg'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Luxembourg" />
                            </xsl:when>
                            <xsl:when test="$country = 'Finland'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Finland" />
                            </xsl:when>
                            <xsl:when test="$country = 'German Democratic Republic'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Germany" />
                            </xsl:when>
                            <xsl:when test="$country = 'Turkey'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Turkiye" />
                            </xsl:when>
                            <xsl:when test="$country = 'Pakistan'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Pakistan" />
                            </xsl:when>
                            <xsl:when test="$country = 'Russian Federation'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/RussianFederation" />
                            </xsl:when>
                            <xsl:when test="$country = 'Czech Republic'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Czechia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Iran'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/IranIslamicRepublicOf" />
                            </xsl:when>
                            <xsl:when test="$country = 'Philippines'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Philippines" />
                            </xsl:when>
                            <xsl:when test="$country = 'Canada (Quebec)'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Canada" />
                            </xsl:when>
                            <xsl:when test="$country = 'Republic of Korea'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/KoreaRepublicOf" />
                            </xsl:when>
                            <xsl:when test="$country = 'Cuba'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Cuba" />
                            </xsl:when>
                            <xsl:when test="$country = 'Bulgaria'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Bulgaria" />
                            </xsl:when>
                            <xsl:when test="$country = 'Romania'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Romania" />
                            </xsl:when>
                            <xsl:when test="$country = 'Burkina Faso'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/BurkinaFaso" />
                            </xsl:when>
                            <xsl:when test="$country = 'Tunisia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Tunisia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Georgian SSR'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Georgia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Senegal'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Senegal" />
                            </xsl:when>
                            <xsl:when test="$country = 'Egypt'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Egypt" />
                            </xsl:when>
                            <xsl:when test="$country = 'Cayman Islands'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/CaymanIslands" />
                            </xsl:when>
                            <xsl:when test="$country = 'Venezuela'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/VenezuelaBolivarianRepublicOf" />
                            </xsl:when>
                            <xsl:when test="$country = 'Scotland'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/UnitedKingdomOfGreatBritainAndNorthernIreland" />
                            </xsl:when>
                            <xsl:when test="$country = 'Thailand'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Thailand" />
                            </xsl:when>
                            <xsl:when test="$country = 'England'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/UnitedKingdomOfGreatBritainAndNorthernIreland" />
                            </xsl:when>
                            <xsl:when test="$country = 'Chile'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Chile" />
                            </xsl:when>
                            <xsl:when test="$country = 'Peru'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Peru" />
                            </xsl:when>
                            <xsl:when test="$country = 'Sri Lanka'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/SriLanka" />
                            </xsl:when>
                            <xsl:when test="$country = 'Estonia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Estonia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Uzbek SSR'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Uzbekistan" />
                            </xsl:when>
                            <xsl:when test="$country = 'Iceland'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Iceland" />
                            </xsl:when>
                            <xsl:when test="$country = 'Morocco'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Morocco" />
                            </xsl:when>
                            <xsl:when test="$country = 'Armenian SSR'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Armenia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Panama'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Panama" />
                            </xsl:when>
                            <xsl:when test="$country = 'Cyprus'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Cyprus" />
                            </xsl:when>
                            <xsl:when test="$country = 'Algeria'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Algeria" />
                            </xsl:when>
                            <xsl:when test="$country = 'Liechtenstein'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Liechtenstein" />
                            </xsl:when>
                            <xsl:when test="$country = 'Lebanon'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Lebanon" />
                            </xsl:when>
                            <xsl:when test="$country = 'Singapore'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Singapore" />
                            </xsl:when>
                            <xsl:when test="$country = 'United Arab Emirates'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/UnitedArabEmirates" />
                            </xsl:when>
                            <xsl:when test="$country = 'Wales'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/UnitedKingdomOfGreatBritainAndNorthernIreland" />
                            </xsl:when>
                            <xsl:when test="$country = 'Palestinian territories'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/PalestineStateOf" />
                            </xsl:when>
                            <xsl:when test="$country = 'Qatar'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Qatar" />
                            </xsl:when>
                            <xsl:when test="$country = 'Slovenia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Slovenia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Socialist Republic of Vietnam'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/VietNam" />
                            </xsl:when>
                            <xsl:when test="$country = 'Zimbabwe'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Zimbabwe" />
                            </xsl:when>
                            <xsl:when test="$country = 'Kazakhstan'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Kazakhstan" />
                            </xsl:when>
                            <xsl:when test="$country = 'Byelorussian SSR'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Belarus" />
                            </xsl:when>
                            <xsl:when test="$country = 'Democratic Republic of Vietnam'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/VietNam" />
                            </xsl:when>
                            <xsl:when test="$country = 'Ghana'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Ghana" />
                            </xsl:when>
                            <xsl:when test="$country = 'North Macedonia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/NorthMacedonia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Indonesia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Indonesia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Serbia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Serbia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Latvia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Latvia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Malta'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Malta" />
                            </xsl:when>
                            <xsl:when test="$country = 'Tajik SSR'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Tajikistan" />
                            </xsl:when>
                            <xsl:when test="$country = 'Cameroon'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Cameroon" />
                            </xsl:when>
                            <xsl:when test="$country = 'Turkmen SSR'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Turkmenistan" />
                            </xsl:when>
                            <xsl:when test="$country = 'Kazakh SSR'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Kazakhstan" />
                            </xsl:when>
                            <xsl:when test="$country = 'Syria'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/SyrianArabRepublic" />
                            </xsl:when>
                            <xsl:when test="$country = 'Russian Empire (pre 1917)'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/RussianFederation" />
                            </xsl:when>
                            <xsl:when test="$country = 'Colombia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Colombia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Croatia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Croatia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Ethiopia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Ethiopia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Bolivia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/BoliviaPlurinationalStateOf" />
                            </xsl:when>
                            <xsl:when test="$country = 'Bermuda'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Bermuda" />
                            </xsl:when>
                            <xsl:when test="$country = 'Saudi Arabia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/SaudiArabia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Uruguay'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Uruguay" />
                            </xsl:when>
                            <xsl:when test="$country = 'Isle of Man'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/IsleOfMan" />
                            </xsl:when>
                            <xsl:when test="$country = 'Montenegro'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Montenegro" />
                            </xsl:when>
                            <xsl:when test="$country = 'Lithuania'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Lithuania" />
                            </xsl:when>
                            <xsl:when test="$country = 'Kenya'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Kenya" />
                            </xsl:when>
                            <xsl:when test="$country = 'Nigeria'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Nigeria" />
                            </xsl:when>
                            <xsl:when test="$country = 'Kyrgyzstan'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Kyrgyzstan" />
                            </xsl:when>
                            <xsl:when test="$country = 'Northern Ireland'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/UnitedKingdomOfGreatBritainAndNorthernIreland" />
                            </xsl:when>
                            <xsl:when test="$country = 'Madagascar'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Madagascar" />
                            </xsl:when>
                            <xsl:when test="$country = 'Moldavian SSR'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/MoldovaRepublicOf" />
                            </xsl:when>
                            <xsl:when test="$country = 'Nicaragua'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Nicaragua" />
                            </xsl:when>
                            <xsl:when test="$country = 'Jamaica'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Jamaica" />
                            </xsl:when>
                            <xsl:when test="$country = 'Burma'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Myanmar" />
                            </xsl:when>
                            <xsl:when test="$country = 'Bosnia and Herzegovina'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/BosniaAndHerzegovina" />
                            </xsl:when>
                            <xsl:when test="$country = 'Ukraine'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Ukraine" />
                            </xsl:when>
                            <xsl:when test="$country = 'Namibia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Namibia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Mozambique'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Mozambique" />
                            </xsl:when>
                            <xsl:when test="$country = 'Benin'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Benin" />
                            </xsl:when>
                            <xsl:when test="$country = 'Bangladesh'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Bangladesh" />
                            </xsl:when>
                            <xsl:when test="$country = 'Uzbekistan'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Uzbekistan" />
                            </xsl:when>
                            <xsl:when test="$country = 'Bahamas'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Bahamas" />
                            </xsl:when>
                            <xsl:when test="$country = 'Azerbaijan'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Azerbaijan" />
                            </xsl:when>
                            <xsl:when test="$country = 'Angola'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Angola" />
                            </xsl:when>
                            <xsl:when test="$country = 'Zambia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Zambia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Zaïre'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/CongoDemocraticRepublicOfThe" />
                            </xsl:when>
                            <xsl:when test="$country = 'Martinique'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Martinique" />
                            </xsl:when>
                            <xsl:when test="$country = 'Cape Verde'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/CaboVerde" />
                            </xsl:when>
                            <xsl:when test="$country = 'Niger'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Niger" />
                            </xsl:when>
                            <xsl:when test="$country = 'Trinidad and Tobago'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/TrinidadAndTobago" />
                            </xsl:when>
                            <xsl:when test="$country = 'Jordan'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Jordan" />
                            </xsl:when>
                            <xsl:when test="$country = 'Chad'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Chad" />
                            </xsl:when>
                            <xsl:when test="$country = 'Costa Rica'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/CostaRica" />
                            </xsl:when>
                            <xsl:when test="$country = 'Palestine'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/PalestineStateOf" />
                            </xsl:when>
                            <xsl:when test="$country = 'Dominican Republic'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/DominicanRepublic" />
                            </xsl:when>
                            <xsl:when test="$country = 'Lesotho'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Lesotho" />
                            </xsl:when>
                            <xsl:when test="$country = 'Georgia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Georgia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Slovakia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Slovakia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Mongolia'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Mongolia" />
                            </xsl:when>
                            <xsl:when test="$country = 'Guinea-Bissau'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/GuineaBissau" />
                            </xsl:when>
                            <xsl:when test="$country = 'Kuwait'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Kuwait" />
                            </xsl:when>
                            <xsl:when test="$country = 'Iraq'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Iraq" />
                            </xsl:when>
                            <xsl:when test="$country = 'Puerto Rico'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/PuertoRico" />
                            </xsl:when>
                            <xsl:when test="$country = 'Afghanistan'">
                                <fiaf:hasCountry rdf:resource="https://dev.fiafcore.org/Afghanistan" />
                            </xsl:when>
                            <xsl:otherwise>
                               <xsl:message terminate="yes">
                                   Error: Unexpected value "<xsl:value-of select="$country"/>".
                               </xsl:message>
                           </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>

                    <!-- fiaf:hasEvent -->

                    <fiaf:hasEvent>
                        <rdf:Description>
                            <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionEvent"/>
                            <xsl:for-each select="credits">
                                <fiaf:hasActivity>
                                    <rdf:Description>
                                        <xsl:variable name="activity" select="translate(credit.type, '&amp;', '')" />
                                        <xsl:choose>
                                            <xsl:when test="not($activity)">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = ''">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Photography'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Photographer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Studio'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Presents'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '©'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Costumes'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Script Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '2nd Unit Photographer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Re-recording'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Recording'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Opticals'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Stunts'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Video Operator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dialogue'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Draughtsperson'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'music performance'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Clapper'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Executive'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Effects Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Technical Adviser'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Special Make-up Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Conductor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Storyboard Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '2nd Assistant Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Special Effects Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Line Producer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Paint  Trace'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '1st Assistant Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Special Photographic Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animation Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Design'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Recordist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Producer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'ADR Recordist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Script Collaborator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Stunt Double'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Additional Photography'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Arranger'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'ADR Mixer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Graphics'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Team'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Lyricist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Re-recording Mixer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Helicopter Pilot'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dialogue Coach'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Colour Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Screenplay by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Armourer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound System'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Foley Recordist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Foley'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '3rd Assistant Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects 1'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Foley Mixer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Lighting'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Written by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'voice'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Matte Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'ADR Loop Group'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Layout Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Supervising Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Miniatures'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Illustrator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Artwork'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Continuity'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Associate'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Property Master'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Photographer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Controller'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Make-up Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Background Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Digital Intermediate'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Associate Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Location Assistant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Thanks'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Sound Mixer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Make-up Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sculptures'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'music performance'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Director of Animation'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dubbing'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sponsor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Casting Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Puppeteer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Computer Graphics'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Aerial Photographer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Producer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Hairdresser'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Administration'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant to Producer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Unit Publicist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Post-production'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Researcher'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Unit Manager'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Buyer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Camera Equipment'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Secretary'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '1st Assistant Camera'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '2nd Assistant Camera'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Designer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'narrator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Clapper/Loader'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dubbing Mixer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Special Optical Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Associate Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '1st Assistant Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'International Sales'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'On-line Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Script Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Co-director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Colour by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Subtitles'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Matte Photographer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Additional Dialogue'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'ADR Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Distributor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Conceptual Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Underwater Photographer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Colourist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Laboratory'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dubbing Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Costume Assistant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Based on the novel by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animation Checker'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Best Boy'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'ADR'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '2nd Assistant Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Special Effects Technician'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Script Adviser'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Translator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Wardrobe Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects 2'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'ADR Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Photographic Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Art Department Assistant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Standby Props'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Story'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Cel Painter'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Engineer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Carpenter'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Supervising ADR Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'In association with'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Extras Casting'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dressing Props'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Post-synchronization'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Digital Imaging Technician'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Hair and Make-up Designer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Hair Stylist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Graphic Designer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Costumer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Driver'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Prosthetics'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Make-up Assistant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Location Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'EPK [Electronic Press Kit]'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Foley Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Mixer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Casting Assistant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Standby Art Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'B Camera Operator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Motion Control'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Lighting Equipment'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Wardrobe Mistress'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Computer Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Designer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'on-screen participant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animal Wrangler'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Costume Designer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Assistant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Film Stock'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Maintenance'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Key Make-up'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Make-up Designer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Equipment'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Processing'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Post-production Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Painter'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Recorded at'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Martial Arts Instructor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Technical Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Supervising Electrician'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Scenario'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Casting Associate'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animatronics'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Supervising Art Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant to the Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Construction Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Sound Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Services'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Supervising Foley Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animation Photographer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Catering'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '2nd Unit Director of Photography'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '[Subject of Film]'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Lenses'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Re-recordist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Genny Operator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Technical Assistant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Runner'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'With the support of'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Story by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Mixer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Draughtsman'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Video Assist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Negative Cutter'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Art Department Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Key Hair Stylist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Completion Bond'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Props'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects Producer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Additional Music'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Rigging Gaffer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Accountant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Location Manager'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Wardrobe Master'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Composed and Conducted by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Special Effects Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Foley Walker'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Optical Photographer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'World Revenues Collected and Distributed by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Runner'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Based on the play by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Composer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'activity not known'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Original Music'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Adapter'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Location Scout'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Film Industry Visitor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '2nd 2nd Assistant Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Transportation Captain'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Developed by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dialect Coach'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '1st Assistant B Camera'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Pyrotechnics'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'A Camera Operator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Chief Lighting Technician'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Compositor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Prints by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects Photography'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Loader'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Art Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Location Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Camera'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Consultant Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Horsemaster'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects 3'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '2nd Assistant B Camera'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Colour Timer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Camera Operator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animation 1'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Floor Runner'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Action Vehicles Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'With the participation of'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Additional Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Rigging'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Script Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Technical Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '1st Assistant A Camera'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Orchestra Contractor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Electronic Special Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dolby Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Crowd Assistant Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Orchestra Leader'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '2nd Assistant A Camera'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Digital Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Construction Foreperson'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Post-production Accountant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Rostrum Photography'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Story Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assembly Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Transportation Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animation 5'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Trainee Camera'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Cinematographer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Leadman'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Lighting Cameraman'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Production Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Preparation'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Commentary Writer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'In Memoriam'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Hair Design'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Historical Adviser'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Department Head Make-up'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Plasterer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dialogue Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Rigging Grip'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Best Boy Electrician'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Story Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animation Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Audio Commentary'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Medical Adviser'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects 4'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'ADR Voice Casting'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Lighting Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Commissioning Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Location Adviser'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Department Head Hair'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animation 7'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Aerial Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Recordist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dolly Grip'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Compositing'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Stop Motion'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Colour Grader'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animation 2'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Creator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'commentator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Best Boy Grip'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Inbetweener'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Post-production Manager'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Movement Coach'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Programming'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Stunt Arranger'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Animator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'In co-production with'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Mixed at'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Crane Operator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Archive Researcher'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Chief Electrician'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Marine Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animation 6'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Section 1'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'dancer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Acknowledgement'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animation 4'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects 5'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Special Effects Foreperson'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Voice Casting'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animation 3'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Archive Footage'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Compositing Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dialogue Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Systems'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Executive in Charge of Production'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Additional Visual Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Cameraman'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Production Accountant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Commissioning Company'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Fight Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '[Produced] For'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'C Camera Operator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Business Affairs'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Associate Art Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Additional Visual Effects1'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Aerial Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Supervising Dialogue Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '1st Assistant C Camera'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '2nd Assistant C Camera'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects Art Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Lighting Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Score Recordist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'On-set Dresser'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'With the financial support of'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'CG Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'interviewee'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Technical Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Transmission Company'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '3D Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects 6'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Theatrical Distributor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Historical Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Fight Arranger'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Additional Camera'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Script Development'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Cel Animator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Effects Recordist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Crowd Marshall'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Archive Producer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Rights Holder'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'unknown credit activity'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Colour and Prints by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Rigging Best Boy'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Friend/Family Visitor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Medical Authority'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'introduction'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Matte Painter'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Off-line Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Digital Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Score Mixer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Story Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Additional Visual Effects3'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dedicated to'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Publicity Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Tailor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '[International Sales]'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Stage Manager'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Military Adviser'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dresses'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Cable'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Mens Wardrobe'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animation Lead'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects 7'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Modelling'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Intimacy Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Incidental Music'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Gowns'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Tax'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Lighting Technical Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Womens Wardrobe'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Casting Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Medical Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '2nd Company Grip'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dialogue Recordist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Archive Stills'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'presenter'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Publicity Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Action Choreographer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects 8'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Project Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '3D Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Additional 2nd Assistant Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Orchestra Conductor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Stereographer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Stunt Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Making Of - Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Cashier'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '24 Frame Playback'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Orchestra'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Rostrum Camera'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Fight Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Footage courtesy of'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'CG Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'VTR Operator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Additional Visual Effects2'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Effects 9'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Pyrotechnics Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Front Projection Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Fur'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Special Effects Shop Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Textures'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Technology'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Wire Arranger'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Section 2'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Supervising Producer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Effects Designer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Head of Production'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Pre-visualisation'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Making Of - Photography'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Playback Singer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Floor Manager'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Layout Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Electrical Equipment'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visual Development'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Score Recorded at'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visiting Press'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Character Designer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Prop Modelling'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'CG Lead'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Soundtrack Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Creative Consultant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Compositing Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Compiler'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Making Of'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Series Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Payroll'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Studio Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Weapons'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Teleplay'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Pre-vis'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animation Technical Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '1st Company Grip'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'D Camera Operator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Pyrotechnics Technician'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Videotape Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Vision Mixer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Motion Graphics'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Motion Capture'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Lighting Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '2D Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Matte Camera'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'CG Technical Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Making Of - Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Clean-up'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Additional Digital Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Set Modelling'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Set Lighting Technician'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Series Producer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Jib Operator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Website Designer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Weapons Handler'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Telecine'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Score Mixed at'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animatics'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Scientific Adviser'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Crowds'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Additional Visual Effects4'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Resources'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Visiting Statesmen'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Company'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionCompany" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/AssistantDirector" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Director" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Composer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Producer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Producer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Screenplay'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Writer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Art Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/ArtDirector" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/FilmEditor" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Special Visual Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/VisualEffects" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Make-up'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/MakeUpArtist" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Special Effects'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/SpecialEffects" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Author of the Original Work'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/SourceMaterial" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Director of Photography'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Cinematographer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Executive Producer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/ExecutiveProducer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Assistant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionAssistant" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Recording'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/SoundRecorderMixer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Camera Operator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/CameraOperator" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/SoundActivity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Manager'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionManager" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Casting'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/CastingDirector" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Sound Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/SoundEditor" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Script'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Writer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Performed by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/MusicPerformer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Set Decorator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/SetDecorator" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Wardrobe'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/WardrobeSupervisor" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Hair'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/HairStylist" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Associate Producer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/AssociateProducer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Costume Designer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/CostumeDesigner" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Location Manager'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/LocationManager" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/AssistantFilmEditor" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Animator" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Designer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionDesigner" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Properties'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/PropertyMaster" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionCoordinator" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Focus Puller'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/FocusPuller" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Stills Photography'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/StillPhotographer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Unit Production Manager'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionManager" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Construction Manager'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/ConstructionCoordinator" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Boom Operator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/BoomOperator" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Titles'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/TitleDesigner" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Stunt Co-ordinator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/StuntArranger" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Set Dresser'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/SetDecorator" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Production Accountant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/ProductionAccountant" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Grip'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Grip" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Gaffer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/GafferLighting" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Orchestrations'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/MusicArranger" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Publicity'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Publicist" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Film Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/FilmEditor" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Assistant Art Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/AssistantArtDirector" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Electrician'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Electrician" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/MusicEditor" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Animal Trainer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/AnimalTrainer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Co-producer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Coproducer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Foley Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/FoleyArtist" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Post-production Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/PostProductionSupervisor" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Choreography'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Choreographer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Dialogue Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/DialogueEditor" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Produced by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Producer" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Supervising Sound Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/SupervisingSoundEditor" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Music Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/MusicSupervisor" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Title Design'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/TitleDesigner" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Set Designer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/SetDesigner" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Scenic Artist'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/ScenicArtist" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'ADR Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/DubbingEditor" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '2nd Unit Director'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/SecondUnitDirector" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Foley Editor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/FoleyArtist" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Camera Assistant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/CameraAssistant" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Directed by'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Director" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Costume Supervisor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/CostumeSupervisor" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Steadicam Operator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/SteadicamOperator" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Models'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/ModelMaker" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Stand-in'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/StandIn" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Adaptation'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Adaptation" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Key Grip'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Grip" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'Conductor'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/MusicConductor" />
                                            </xsl:when>
                                             <xsl:otherwise>
                                                <xsl:message terminate="yes">
                                                    Error: Unexpected value "<xsl:value-of select="$activity"/>".
                                                </xsl:message>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        <fiaf:hasAgent>
                                            <rdf:Description rdf:about="bfi://resource/agent/{credit.name.lref}">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Agent" />
                                                <rdfs:label>
                                                    <xsl:value-of select="credit.name"/>
                                                </rdfs:label>
                                                <fiaf:hasIdentifier>
                                                    <rdf:Description rdf:about="bfi://identifier/agent/{credit.name.lref}">
                                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Identifier" />
                                                        <fiaf:hasIdentifierValue>
                                                            <xsl:value-of select="credit.name.lref"/>
                                                        </fiaf:hasIdentifierValue>
                                                        <fiaf:hasIdentifierAuthority rdf:resource="bfi://resource/agent/bfi" />
                                                    </rdf:Description>
                                                </fiaf:hasIdentifier>
                                            </rdf:Description>
                                        </fiaf:hasAgent>
                                    </rdf:Description>
                                </fiaf:hasActivity>
                            </xsl:for-each>
                            <xsl:for-each select="cast">
                                <fiaf:hasActivity>
                                    <rdf:Description>
                                        <xsl:variable name="activity" select="translate(cast.credit_type, '&amp;', '')" />
                                        <xsl:choose>
                                            <xsl:when test="$activity = 'voice'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'on-screen participant'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'commentator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'dancer'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'interviewee'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'introduction'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'presenter'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = '[Subject of Film]'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'music performance'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Activity" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'narrator'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Narrator" />
                                            </xsl:when>
                                            <xsl:when test="$activity = 'cast member'">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/CastMember" />
                                            </xsl:when>
                                            <xsl:otherwise>
                                               <xsl:message terminate="yes">
                                                   Error: Unexpected value "<xsl:value-of select="$activity"/>".
                                               </xsl:message>
                                           </xsl:otherwise>
                                        </xsl:choose>
                                        <fiaf:hasAgent>
                                            <rdf:Description rdf:about="bfi://resource/agent/{cast.name.lref}">
                                                <rdf:type rdf:resource="https://dev.fiafcore.org/Agent"/>
                                                <rdfs:label>
                                                    <xsl:value-of select="cast.name"/>
                                                </rdfs:label>
                                                <fiaf:hasIdentifier>
                                                    <rdf:Description rdf:about="bfi://identifier/agent/{cast.name.lref}">
                                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Identifier"/>
                                                        <fiaf:hasIdentifierValue>
                                                            <xsl:value-of select="cast.name.lref"/>
                                                        </fiaf:hasIdentifierValue>
                                                        <fiaf:hasIdentifierAuthority rdf:resource="bfi://resource/agent/bfi"/>
                                                    </rdf:Description>
                                                </fiaf:hasIdentifier>
                                            </rdf:Description>
                                        </fiaf:hasAgent>
                                    </rdf:Description>
                                </fiaf:hasActivity>
                            </xsl:for-each>
                        </rdf:Description>
                    </fiaf:hasEvent>

                    <!-- fiaf:hasForm -->

                    <!-- Provided dataset may not contain this data. -->

                    <!-- fiaf:hasGenre -->

                    <xsl:for-each select="Content_genre/content.genre[normalize-space(.)]">
                        <xsl:variable name="apos">'</xsl:variable>
                        <xsl:variable name="genre" select="translate(., $apos, '')" />
                        <xsl:choose>
                            <xsl:when test="$genre = 'Film noir'"/>
                            <xsl:when test="$genre = 'Police drama'"/>
                            <xsl:when test="$genre = 'Artists Moving Image'"/>
                            <xsl:when test="$genre = 'Anthology'"/>
                            <xsl:when test="$genre = 'Swashbuckling'"/>
                            <xsl:when test="$genre = 'Martial arts'"/>
                            <xsl:when test="$genre = 'Sex comedy'"/>
                            <xsl:when test="$genre = 'Road movie'"/>
                            <xsl:when test="$genre = 'Spaghetti western'"/>
                            <xsl:when test="$genre = 'Disaster'"/>
                            <xsl:when test="$genre = 'Performance'"/>
                            <xsl:when test="$genre = 'Fairy tale'"/>
                            <xsl:when test="$genre = 'Documentary'"/>
                            <xsl:when test="$genre = 'Amateur film'"/>
                            <xsl:when test="$genre = 'School programme and Educational film'"/>
                            <xsl:when test="$genre = 'Drama-documentary'"/>
                            <xsl:when test="$genre = 'Documentary drama'"/>
                            <xsl:when test="$genre = 'Parody'"/>
                            <xsl:when test="$genre = 'Blaxploitation'"/>
                            <xsl:when test="$genre = 'Industry sponsored film'"/>
                            <xsl:when test="$genre = 'Variety show'"/>
                            <xsl:when test="$genre = 'Promotional'"/>
                            <xsl:when test="$genre = 'Pornography'"/>
                            <xsl:when test="$genre = 'Student film'"/>
                            <xsl:when test="$genre = 'Farce'"/>
                            <xsl:when test="$genre = 'Public Information Filler'"/>
                            <xsl:when test="$genre = 'Home movie'"/>
                            <xsl:when test="$genre = 'Government sponsored film'"/>
                            <xsl:when test="$genre = 'Film serial'"/>
                            <xsl:when test="$genre = 'Performance music video'"/>
                            <xsl:when test="$genre = 'Training'"/>
                            <xsl:when test="$genre = 'Advert'"/>
                            <xsl:when test="$genre = 'Trick film'"/>
                            <xsl:when test="$genre = 'Sketch show'"/>
                            <xsl:when test="$genre = 'Adventure'"/>
                            <xsl:when test="$genre = 'Music video'"/>
                            <xsl:when test="$genre = 'Puppet (live-action)'"/>
                            <xsl:when test="$genre = 'Australian western'"/>
                            <xsl:when test="$genre = 'Action and Adventure'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/ActionFilm" />
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/AdventureFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Drama'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/DramaFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Comedy'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/ComedyFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Crime'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/CrimeFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Musical'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/MusicalFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'War'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/WarFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Thriller'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/ThrillerFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Romance'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/RomanticFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Western'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/WesternFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Horror'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/HorrorFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Period drama'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/HistoricalFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Science Fiction'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/ScienceFictionFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Fantasy'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/FantasyFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Biopic'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/BiographicalFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Historical drama'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/HistoricalFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Melodrama'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/MelodramaFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Detective drama'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/DetectiveFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Childrens'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/ChildrensFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Sport'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/SportsFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Gangster'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/GangsterFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Animation'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/AnimationFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Action'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/ActionFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Adventure'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/AdventureFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Medical drama'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/MedicalFilm" />
                            </xsl:when>
                            <xsl:when test="$genre = 'Legal and Courtroom drama'">
                                <fiaf:hasGenre rdf:resource="https://dev.fiafcore.org/CourtroomFilm" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:message terminate="yes">
                                    Error: Unexpected value "<xsl:value-of select="$genre"/>".
                                </xsl:message>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>

                    <!-- fiaf:hasIdentifier -->

                    <fiaf:hasIdentifier>
                        <rdf:Description rdf:about="bfi://identifier/work/{@priref}">
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

                    <!-- fiaf:hasManifestation -->

                    <xsl:for-each select="Parts">
                        <fiaf:hasManifestation rdf:resource="bfi://resource/manifestation/{parts_reference.lref}" />
                    </xsl:for-each>

                    <!-- fiaf:hasTitle -->

                    <xsl:for-each select="Title">
                        <fiaf:hasTitle>
                            <rdf:Description>
                                <xsl:variable name="title_type" select="title.type/value[@lang='0']" />
                                <xsl:choose>
                                    <xsl:when test="not($title_type)">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                    </xsl:when>
                                    <xsl:when test="$title_type = 'Archive'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                    </xsl:when>
                                    <xsl:when test="$title_type = ''">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                    </xsl:when>
                                    <xsl:when test="$title_type = 'Alternative'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/AlternativeTitle" />
                                    </xsl:when>
                                    <xsl:when test="$title_type = 'Original'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/TitleProper" />
                                    </xsl:when>
                                    <xsl:when test="$title_type = 'Working'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/WorkingTitle" />
                                    </xsl:when>
                                    <xsl:when test="$title_type = 'Help search'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/SearchTitle" />
                                    </xsl:when>
                                    <xsl:when test="$title_type = 'Acquisition'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/AcquisitionTitle" />
                                    </xsl:when>
                                    <xsl:when test="$title_type = 'Title'">
                                        <rdf:type rdf:resource="https://dev.fiafcore.org/Title" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:message terminate="yes">
                                            Error: Unexpected value "<xsl:value-of select="$title_type"/>".
                                        </xsl:message>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <fiaf:hasTitleValue>
                                    <xsl:value-of select="normalize-space(concat(title.article, ' ', title))" />
                                </fiaf:hasTitleValue>
                            </rdf:Description>
                        </fiaf:hasTitle>
                    </xsl:for-each>

                    <!-- fiaf:hasVariant -->

                    <!-- Provided dataset may not contain this data. -->

                    <!-- fiaf:hasWork -->

                    <!-- Provided dataset may not contain this data. -->

                </rdf:Description>
            </xsl:for-each>
        </rdf:RDF>
    </xsl:template>

</xsl:stylesheet>
