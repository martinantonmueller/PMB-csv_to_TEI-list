<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:foo="whatever" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.0">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:strip-space elements="*"/>
    <!-- Diese Transformation erzeugt eine listplace.xml Datei aus einem csv-Download der PMB. 
    Davor sind folgende Schritte nötig: 
    1) PMB -> Download, tab-separated
    2) CSV-Datei in textSoap bearbeiten: jeglicher Inhalt in spitzer Klammer löschen, & durch &amp; ersetzen
    3) mit xCSV als XML speichern
    
    Alternativ ist auch möglich, in gDrive eine Tabelle anzulegen, die CSV zu importieren (ohne Daten erkennen zu lassen), 
    als Excel-Datei zu speichen und in Oxygen Datei->Importieren->Excel zu importieren. In diesem Fall ist das Topelement "root" statt "Items"
    und die einzelne Tabellenzeile heißt "row" statt "item". Beide Varianten sind vorgesehen und sollten funktionieren,
    wenngleich ich nur mehr die erstere verwende.
    
    
    -->
    <xsl:template match="Items | root">
        <xsl:element name="TEI" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:namespace name="tei">
                <xsl:text>http://www.tei-c.org/ns/1.0</xsl:text>
            </xsl:namespace>
            <xsl:namespace name="xsi">
                <xsl:text>http://www.w3.org/2001/XMLSchema-instance</xsl:text>
            </xsl:namespace>
            <xsl:element name="tei:teiHeader">
                <xsl:element name="tei:fileDesc">
                    <xsl:element name="tei:titleStmt">
                        <xsl:element name="tei:title">
                            <xsl:attribute name="level">
                                <xsl:text>s</xsl:text>
                            </xsl:attribute>
                            <xsl:text>Arthur Schnitzler: Briefwechsel mit Autorinnen und Autoren</xsl:text>
                        </xsl:element>
                        <xsl:element name="tei:title">
                            <xsl:attribute name="level">
                                <xsl:text>a</xsl:text>
                            </xsl:attribute>
                            <xsl:text>Liste der Orte</xsl:text>
                        </xsl:element>
                        <xsl:element name="tei:respStmt">
                            <xsl:element name="tei:resp">providing the content</xsl:element>
                            <xsl:element name="tei:name">Martin Anton Müller</xsl:element>
                            <xsl:element name="tei:name">PMB</xsl:element>
                        </xsl:element>
                        <xsl:element name="tei:respStmt">
                            <xsl:element name="tei:resp">converted to XML encoding</xsl:element>
                            <xsl:element name="tei:name">Martin Anton Müller</xsl:element>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="tei:publicationStmt">
                        <xsl:element name="tei:publisher">
                            <xsl:text>ACDH-CH</xsl:text>
                        </xsl:element>
                        <xsl:element name="tei:date">
                            <xsl:value-of select="format-date(fn:current-date(),'[D01].[M01].[Y0001]')"/>
                        </xsl:element>
                        <xsl:element name="tei:idno">
                            <xsl:attribute name="type">
                                <xsl:text>URI</xsl:text>
                            </xsl:attribute>
                            <xsl:text>https://id.acdh.oeaw.ac.at/arthur-schnitzler-briefe/v1/indices/listplace.xml</xsl:text>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="tei:sourceDesc">
                        <xsl:element name="tei:p">
                            <xsl:text>Orte der Schnitzler-Briefe.</xsl:text>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            <xsl:element name="tei:text">
                <xsl:element name="tei:body">
                    <xsl:element name="tei:div">
                        <xsl:attribute name="type">
                            <xsl:text>index_places</xsl:text>
                        </xsl:attribute>
                        <xsl:element name="tei:listPlace">
                            <xsl:attribute name="xml:id">
                                <xsl:text>listplace</xsl:text>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <!-- Das hier gibt ISO-Daten als DD. MM. YYYY. aus. Am 
    Anfang noch eine Kürzung, damit keine spitzen Klammern im Datum vorhanden sind (CSV-Export über
    Google Sheets) -->
    <xsl:function name="foo:date-check">
        <xsl:param name="date-string" as="xs:string"/>
        <xsl:variable name="date-string-ohne">
            <xsl:choose>
                <xsl:when test="contains($date-string, '&lt;')">
                    <xsl:value-of select="substring-before($date-string, '&lt;')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$date-string"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:analyze-string select="$date-string-ohne" regex="^(\d{{4}})(-)(\d{{2}})(-)(\d{{2}})$">
            <xsl:matching-substring>
                <xsl:variable name="year" select="xs:integer(regex-group(1))"/>
                <xsl:variable name="month">
                    <xsl:choose>
                        <xsl:when test="substring(regex-group(3), 1, 1) = '0'">
                            <xsl:value-of select="substring(regex-group(3), 2)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="regex-group(3)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="day">
                    <xsl:choose>
                        <xsl:when test="substring(regex-group(5), 1, 1) = '0'">
                            <xsl:value-of select="substring(regex-group(5), 2)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="regex-group(5)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="date-normal"
                    select="fn:concat($day, '.&#160;', $month, '.&#160;', $year)"/>
                <xsl:choose>
                    <xsl:when test="$date-string-ohne castable as xs:date">
                        <xsl:value-of select="$date-normal"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- $date-string was in YYYYMMDD format, but values for some of components were incorrect (e.g. February 31). -->
                        <xsl:text>FEHLER</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:analyze-string select="$date-string-ohne"
                    regex="^(\d{{1,2}})(\.)(\d{{1,2}})(\.)(\d{{4}})$">
                    <xsl:matching-substring>
                        <xsl:variable name="year" select="xs:integer(regex-group(5))"/>
                        <xsl:variable name="month">
                            <xsl:choose>
                                <xsl:when test="substring(regex-group(3), 1, 1) = '0'">
                                    <xsl:value-of select="substring(regex-group(3), 2)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="regex-group(3)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="day">
                            <xsl:choose>
                                <xsl:when test="substring(regex-group(1), 1, 1) = '0'">
                                    <xsl:value-of select="substring(regex-group(1), 2)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="regex-group(1)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="date-normal"
                            select="fn:concat($day, '.&#160;', $month, '.&#160;', $year)"/>
                        <xsl:value-of select="$date-normal"/>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:value-of select="$date-string-ohne"/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:function>
    <!-- Das hier erweitert kurze ISO-Daten auf YYYY-MM-DD -->
    <xsl:function name="foo:iso-date-expand">
        <xsl:param name="iso-string" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="string-length($iso-string) = 4">
                <xsl:value-of select="concat($iso-string, '-01-01')"/>
            </xsl:when>
            <xsl:when test="string-length($iso-string) = 7">
                <xsl:value-of select="concat($iso-string, '-01')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$iso-string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <xsl:template
        match="item[preceding-sibling::item/child::ID = ID] | row[preceding-sibling::row/child::ID = ID]"/>
    <xsl:template
        match="item[not(preceding-sibling::item/child::ID = ID)] | row[not(preceding-sibling::row/child::ID = ID)]">
        <xsl:element name="tei:place">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('pmb', ID)"/>
            </xsl:attribute>
            <xsl:element name="tei:placeName">
                <xsl:value-of select="placeName"/>
            </xsl:element>
            <xsl:element name="tei:desc">
                <!-- Kein Datum vorhanden: -->
                <xsl:variable name="KEIN_datum" as="xs:boolean" select="
                        string-length(start_date_written) = 0 and string-length(start_date) = 0
                        and string-length(end_date_written) = 0 and string-length(end_date) = 0"/>
                <!-- das nicht ISO-formatierte Datum stimmt mit dem Enddatum überein, wir haben also einen Tag, keine Zeitspanne: -->
                <xsl:variable name="start_date_written-EQUALS_end_date_written" as="xs:boolean">
                    <xsl:choose>
                        <xsl:when
                            test="string-length(start_date_written) &gt; 0 and start_date_written = end_date_written">
                            <xsl:value-of select="true()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="false()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- das ISO-formatierte Datum stimmt mit dem Enddatum überein, wir haben also einen Tag, keine Zeitspanne: -->
                <xsl:variable name="start_date-EQUALS_end_date" as="xs:boolean">
                    <xsl:choose>
                        <xsl:when test="string-length(start_date) &gt; 0 and start_date = end_date">
                            <xsl:value-of select="true()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="false()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- es gibt nur ein ein Startdatum zu berücksichtigen -->
                <xsl:variable name="start_date_NO_enddate" as="xs:boolean">
                    <xsl:choose>
                        <xsl:when
                            test="string-length(end_date) = 0 and string-length(end_date_written) = 0 and not($KEIN_datum)">
                            <xsl:value-of select="true()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="false()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- es gibt nur ein ein Enddatum zu berücksichtigen -->
                <xsl:variable name="end_date_NO_startdate" as="xs:boolean">
                    <xsl:choose>
                        <xsl:when
                            test="string-length(start_date) = 0 and string-length(start_date_written) = 0 and not($KEIN_datum)">
                            <xsl:value-of select="true()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="false()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:if test="not($KEIN_datum)">
                    <xsl:element name="tei:date">
                        <xsl:choose>
                            <!-- Einzelne Daten bzw. Zeitspannen, die auf einen Tag gehen, zuerst -->
                            <xsl:when
                                test="$start_date_NO_enddate or $start_date-EQUALS_end_date or $start_date_written-EQUALS_end_date_written">
                                <xsl:choose>
                                    <xsl:when test="fn:string-length(start_date) &gt; 0 and start_date_written=''">
                                        <!-- Falls das ISO-Datum zu kurz ist, kommen zwei Attribute heraus, ein erweitertes when und
                                        ein when-custom-->
                                        <xsl:attribute name="when">
                                            <xsl:value-of select="start_date"/>
                                        </xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="when">
                                            <xsl:value-of select="start_date"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="when-custom">
                                            <xsl:value-of select="start_date_written"/>
                                        </xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:choose>
                                    <xsl:when test="string-length(start_date_written) &gt; 0">
                                        <xsl:value-of select="normalize-space(start_date_written)"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="foo:date-check(start_date)"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <!-- Nur ein Enddatum vorhanden -->
                            <xsl:when test="$end_date_NO_startdate">
                                <xsl:choose>
                                        <xsl:when test="fn:string-length(end_date) &gt; 0 and end_date_written=''">
                                            <!-- Falls das ISO-Datum zu kurz ist, kommen zwei Attribute heraus, ein erweitertes when und
                                        ein when-custom-->
                                            <xsl:attribute name="when">
                                                <xsl:value-of select="end_date"/>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:attribute name="when">
                                                <xsl:value-of select="end_date"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="when-custom">
                                                <xsl:value-of select="end_date_written"/>
                                            </xsl:attribute>
                                        </xsl:otherwise>
                                </xsl:choose>
                                <xsl:choose>
                                    <xsl:when test="string-length(end_date_written) &gt; 0">
                                        <xsl:value-of
                                            select="concat('bis ', normalize-space(end_date_written))"
                                        />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of
                                            select="concat('bis', foo:date-check(end_date))"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <!-- Zeitraum -->
                            <xsl:otherwise>
                                <xsl:variable name="start-written"
                                    select="string-length(start_date_written) &gt; 0"
                                    as="xs:boolean"/>
                                <xsl:variable name="end-written"
                                    select="string-length(end_date_written) &gt; 0" as="xs:boolean"/>
                                <xsl:choose>
                                        <xsl:when test="fn:string-length(start_date) &gt; 0 and start_date_written=''">
                                            <!-- Falls das ISO-Datum zu kurz ist, kommen zwei Attribute heraus, ein erweitertes when und
                                        ein when-custom-->
                                            <xsl:attribute name="from">
                                                <xsl:value-of select="start_date"/>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:attribute name="from">
                                                <xsl:value-of select="start_date"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="from-custom">
                                                <xsl:value-of select="start_date_written"/>
                                            </xsl:attribute>
                                        </xsl:otherwise>
                                </xsl:choose>
                                <xsl:choose>
                                    <xsl:when test="fn:string-length(end_date) &gt; 0 and end_date_written=''">
                                        <!-- Falls das ISO-Datum zu kurz ist, kommen zwei Attribute heraus, ein erweitertes when und
                                        ein when-custom-->
                                        <xsl:attribute name="when">
                                            <xsl:value-of select="end_date"/>
                                        </xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="when">
                                            <xsl:value-of select="end_date"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="when-custom">
                                            <xsl:value-of select="end_date_written"/>
                                        </xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:choose>
                                    <xsl:when test="$start-written and $end-written">
                                        <xsl:choose>
                                            <xsl:when
                                                test="contains(start_date_written, ' ') or contains(end_date_written, ' ')">
                                                <xsl:value-of
                                                  select="concat(normalize-space(start_date_written), ' – ', normalize-space(end_date_written))"
                                                />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of
                                                  select="concat(normalize-space(start_date_written), '–', normalize-space(end_date_written))"
                                                />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:when test="$start-written">
                                        <xsl:choose>
                                            <xsl:when
                                                test="contains(start_date_written, ' ') or contains(end_date, '-')">
                                                <xsl:value-of
                                                  select="concat(normalize-space(start_date_written), ' – ', foo:date-check(end_date))"
                                                />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of
                                                  select="concat(normalize-space(start_date_written), '–', foo:date-check(end_date))"
                                                />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:when test="$end-written">
                                        <xsl:choose>
                                            <xsl:when
                                                test="contains(end_date_written, ' ') or contains(start_date, '-')">
                                                <xsl:value-of
                                                  select="concat(foo:date-check(start_date), ' – ', normalize-space(end_date_written))"
                                                />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of
                                                  select="concat(foo:date-check(start_date), '–', normalize-space(end_date_written))"
                                                />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when
                                                test="contains(end_date, '-') or contains(start_date, '-')">
                                                <xsl:value-of
                                                  select="concat(foo:date-check(start_date), ' – ', foo:date-check(end_date))"
                                                />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of
                                                  select="concat(foo:date-check(start_date), '–', foo:date-check(end_date))"
                                                />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:if>
                <!--<xsl:choose>
                    <xsl:when
                        test="start_date[fn:string-length(text()) &gt; 0] and start_date = end_date">
                        <xsl:element name="tei:date">
                            <xsl:if test="fn:string-length(start_date) &gt; 0">
                                <xsl:attribute name="when">
                                    <xsl:value-of select="start_date"/>
                                </xsl:attribute>
                            </xsl:if>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when
                        test="start_date[fn:string-length(text()) &gt; 0] and end_date[fn:string-length(text()) &gt; 0]">
                        <xsl:element name="tei:date">
                            <xsl:choose>
                                <xsl:when
                                    test="number(start_date) &gt; 999 and fn:string-length(start_date) = 4">
                                    <xsl:attribute name="from">
                                        <xsl:value-of select="start_date"/>
                                        <xsl:text>-01-01</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="from-custom">
                                        <xsl:value-of select="start_date"/>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:if test="fn:string-length(start_date) &gt; 0">
                                        <xsl:attribute name="from">
                                            <xsl:value-of select="start_date"/>
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="from-custom">
                                        <xsl:value-of select="start_date"/>
                                    </xsl:attribute>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when
                                    test="number(end_date) &gt; 999 and fn:string-length(end_date) = 4">
                                    <xsl:attribute name="to">
                                        <xsl:value-of select="end_date"/>
                                        <xsl:text>-01-01</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="to-custom">
                                        <xsl:value-of select="end_date"/>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:if test="fn:string-length(end_date) &gt; 0">
                                        <xsl:attribute name="to">
                                            <xsl:value-of select="end_date"/>
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="to-custom">
                                        <xsl:value-of select="end_date"/>
                                    </xsl:attribute>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:value-of select="foo:date-check(start_date_written)"/>
                            <xsl:choose>
                                <xsl:when
                                    test="contains(start_date_written, ' ') or contains(end_date_written, ' ')">
                                    <xsl:text> – </xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>–</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:value-of select="foo:date-check(end_date_written)"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="start_date_written[fn:string-length(text()) &gt; 0]">
                        <xsl:element name="tei:date">
                            <xsl:choose>
                                <xsl:when
                                    test="number(start_date) &gt; 999 and fn:string-length(start_date) = 4">
                                    <xsl:attribute name="from">
                                        <xsl:value-of select="start_date"/>
                                        <xsl:text>-01-01</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="from-custom">
                                        <xsl:value-of select="start_date"/>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:if test="fn:string-length(start_date) &gt; 0">
                                        <xsl:attribute name="from">
                                            <xsl:value-of select="start_date"/>
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="from-custom">
                                        <xsl:value-of select="start_date"/>
                                    </xsl:attribute>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:value-of select="foo:date-check(start_date_written)"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="start_date[fn:string-length(text()) &gt; 0]">
                        <xsl:element name="tei:date">
                            <xsl:choose>
                                <xsl:when
                                    test="number(start_date) &gt; 999 and fn:string-length(start_date) = 4">
                                    <xsl:attribute name="from">
                                        <xsl:value-of select="start_date"/>
                                        <xsl:text>-01-01</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="from-custom">
                                        <xsl:value-of select="start_date"/>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:if test="fn:string-length(start_date) &gt; 0">
                                        <xsl:attribute name="from">
                                            <xsl:value-of select="start_date"/>
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="from-custom">
                                        <xsl:value-of select="start_date"/>
                                    </xsl:attribute>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:value-of select="foo:date-check(start_date)"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="end_date[fn:string-length(text()) &gt; 0]">
                        <xsl:element name="tei:date">
                            <xsl:choose>
                                <xsl:when
                                    test="number(end_date) &gt; 999 and fn:string-length(end_date) = 4">
                                    <xsl:attribute name="to">
                                        <xsl:value-of select="end_date"/>
                                        <xsl:text>-01-01</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="to-custom">
                                        <xsl:value-of select="end_date"/>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:if test="fn:string-length(end_date) &gt; 0">
                                        <xsl:attribute name="to">
                                            <xsl:value-of select="end_date"/>
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="to-custom">
                                        <xsl:value-of select="end_date"/>
                                    </xsl:attribute>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:value-of select="foo:date-check(end_date)"/>
                        </xsl:element>
                    </xsl:when>
                </xsl:choose>-->
                <xsl:if test="kind[fn:string-length(text()) &gt; 0]">
                    <xsl:element name="tei:gloss">
                        <xsl:value-of select="kind"/>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="label[fn:string-length(text()) &gt; 0]">
                    <!-- <xsl:element name="tei:note">
                        <xsl:value-of select="label"/>
                    </xsl:element>
                    <xsl:variable name="EID" select="ID"/>
                    <xsl:for-each select="following-sibling::item[ID = $EID]/label">
                        <xsl:element name="tei:note">
                            <xsl:value-of select="."/>
                        </xsl:element>
                    </xsl:for-each>-->
                </xsl:if>
            </xsl:element>
            <xsl:if test="string-length(lat) &gt; 0">
                <xsl:element name="tei:location">
                    <xsl:element name="tei:geo">
                        <xsl:attribute name="decls">
                            <xsl:text>LatLng</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="lat"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="lng"/>
                    </xsl:element>
                </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
