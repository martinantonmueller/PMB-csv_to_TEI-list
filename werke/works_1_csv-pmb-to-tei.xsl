<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:foo="whatever" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.0">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:strip-space elements="*"/>
    <!-- Diese Transformation erzeugt eine listwork.xml Datei aus einem csv-Download der PMB. 
    Davor sind folgende Schritte nötig: 
    1) PMB -> Download, tab-separated
    2) CSV-Datei in textSoap bearbeiten: jeglicher Inhalt in spitzer Klammer löschen, & durch &amp; ersetzen
    3) mit xCSV als XML speichern
    
    Alternativ ist auch möglich, in gDrive eine Tabelle anzulegen, die CSV zu importieren (ohne Daten erkennen zu lassen), 
    als Excel-Datei zu speichen und in Oxygen Datei->Importieren->Excel zu importieren. In diesem Fall ist das Topelement "root" statt "Items"
    und die einzelne Tabellenzeile heißt "row" statt "item". Beide Varianten sind vorgesehen und sollten funktionieren,
    wenngleich ich nur mehr die erstere verwende.
    
    
    -->
    <xsl:template match="root | Items">
        <xsl:element name="TEI" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:namespace name="tei">
                <xsl:text>http://www.tei-c.org/ns/1.0</xsl:text>
            </xsl:namespace>
            <xsl:namespace name="xsi">
                <xsl:text>http://www.w3.org/2001/XMLSchema-instance</xsl:text>
            </xsl:namespace>
            <xsl:element name="teiHeader" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="fileDesc"  namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="titleStmt"  namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="level">
                                <xsl:text>s</xsl:text>
                            </xsl:attribute>
                            <xsl:text>Arthur Schnitzler: Briefwechsel mit Autorinnen und Autoren</xsl:text>
                        </xsl:element>
                        <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="level">
                                <xsl:text>a</xsl:text>
                            </xsl:attribute>
                            <xsl:text>Liste der Werke</xsl:text>
                        </xsl:element>
                        <xsl:element name="respStmt" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:element name="resp" namespace="http://www.tei-c.org/ns/1.0">providing the content</xsl:element>
                            <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0">Martin Anton Müller</xsl:element>
                            <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0">PMB</xsl:element>
                        </xsl:element>
                        <xsl:element name="respStmt" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:element name="resp" namespace="http://www.tei-c.org/ns/1.0">converted to XML encoding</xsl:element>
                            <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0">Martin Anton Müller</xsl:element>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="publicationStmt" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="publisher" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>ACDH-CH</xsl:text>
                        </xsl:element>
                        <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of
                                select="format-date(fn:current-date(), '[D01].[M01].[Y0001]')"/>
                        </xsl:element>
                        <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:text>URI</xsl:text>
                            </xsl:attribute>
                            <xsl:text>https://id.acdh.oeaw.ac.at/arthur-schnitzler-briefe/v1/indices/listwork.xml</xsl:text>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="sourceDesc" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>Werke der Schnitzler-Briefe.</xsl:text>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            <xsl:element name="text" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="body" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="xml:id" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:text>listwork</xsl:text>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
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
    <xsl:template match="row[preceding-sibling::row/child::ID = ID]|item[preceding-sibling::item/child::ID = ID]"/>
    <xsl:template match="row[not(preceding-sibling::row/child::ID = ID) and not(ID='')]|item[not(preceding-sibling::item/child::ID = ID) and not(ID='')]">
        <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('pmb', ID)"/>
            </xsl:attribute>
            <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:value-of select="title"/>
            </xsl:element>
            <xsl:choose>
                <xsl:when
                    test="start_date_written[fn:string-length(text()) &gt; 0] and foo:date-check(start_date_written) = foo:date-check(end_date_written)">
                    <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:if test="fn:string-length(start_date) &gt; 0">
                            <xsl:attribute name="when">
                                <xsl:value-of select="start_date"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:attribute name="when-custom">
                            <xsl:value-of select="start_date_written"/>
                        </xsl:attribute>
                        <xsl:value-of select="foo:date-check(start_date_written)"/>
                    </xsl:element>
                </xsl:when>
                <xsl:when
                    test="start_date_written[fn:string-length(text()) &gt; 0] and end_date_written[fn:string-length(text()) &gt; 0]">
                    <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:choose>
                            <xsl:when
                                test="number(start_date_written) &gt; 999 and fn:string-length(start_date_written) = 4">
                                <xsl:attribute name="from">
                                    <xsl:value-of select="start_date_written"/>
                                    <xsl:text>-01-01</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="from-custom">
                                    <xsl:value-of select="start_date_written"/>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="fn:string-length(start_date) &gt; 0">
                                    <xsl:attribute name="from">
                                        <xsl:value-of select="start_date"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:attribute name="from-custom">
                                    <xsl:value-of select="start_date_written"/>
                                </xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                            <xsl:when
                                test="number(end_date_written) &gt; 999 and fn:string-length(end_date_written) = 4">
                                <xsl:attribute name="to">
                                    <xsl:value-of select="end_date_written"/>
                                    <xsl:text>-01-01</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="to-custom">
                                    <xsl:value-of select="end_date_written"/>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="fn:string-length(end_date) &gt; 0">
                                    <xsl:attribute name="to">
                                        <xsl:value-of select="end_date"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:attribute name="to-custom">
                                    <xsl:value-of select="end_date_written"/>
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
                    <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:choose>
                            <xsl:when
                                test="number(start_date_written) &gt; 999 and fn:string-length(start_date_written) = 4">
                                <xsl:attribute name="from">
                                    <xsl:value-of select="start_date_written"/>
                                    <xsl:text>-01-01</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="from-custom">
                                    <xsl:value-of select="start_date_written"/>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="fn:string-length(start_date) &gt; 0">
                                    <xsl:attribute name="from">
                                        <xsl:value-of select="start_date"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:attribute name="from-custom">
                                    <xsl:value-of select="start_date_written"/>
                                </xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:value-of select="foo:date-check(start_date_written)"/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="end_date_written[fn:string-length(text()) &gt; 0]">
                    <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:choose>
                            <xsl:when
                                test="number(end_date_written) &gt; 999 and fn:string-length(end_date_written) = 4">
                                <xsl:attribute name="to">
                                    <xsl:value-of select="end_date_written"/>
                                    <xsl:text>-01-01</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="to-custom">
                                    <xsl:value-of select="end_date_written"/>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="fn:string-length(end_date) &gt; 0">
                                    <xsl:attribute name="to">
                                        <xsl:value-of select="end_date"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:attribute name="to-custom">
                                    <xsl:value-of select="end_date_written"/>
                                </xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:value-of select="foo:date-check(end_date_written)"/>
                    </xsl:element>
                </xsl:when>
            </xsl:choose>
            <xsl:if test="kind[fn:string-length(text()) &gt; 0]">
                <xsl:element name="gloss" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:choose>
                        <xsl:when test="ends-with(kind, '.0')">
                            <xsl:value-of select="substring-before(kind, '.0')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="kind"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
            </xsl:if>
            <xsl:if test="label[fn:string-length(text()) &gt; 0]">
                <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:choose>
                        <xsl:when test="ends-with(label, '.0')">
                            <xsl:value-of select="substring-before(label, '.0')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="label"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
                <xsl:variable name="EID" select="ID"/>
                <xsl:for-each select="following-sibling::row[ID = $EID]/label">
                    <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:choose>
                            <xsl:when test="ends-with(., '.0')">
                                <xsl:value-of select="substring-before(., '.0')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="."/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:for-each>
                <xsl:for-each select="following-sibling::item[ID = $EID]/label">
                    <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:choose>
                            <xsl:when test="ends-with(., '.0')">
                                <xsl:value-of select="substring-before(., '.0')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="."/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:for-each>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    <xsl:template match="item[ID='']"/>
</xsl:stylesheet>
