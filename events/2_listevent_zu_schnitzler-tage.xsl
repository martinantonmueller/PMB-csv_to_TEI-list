<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all"
    xmlns:functx="http://www.functx.com" version="3.0"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <!-- Dieses XSL wandelt die aus der PMB geholten events in das
        format von schnitzler-tage um
    -->
    <xsl:param name="tei-ende" select="fn:escape-html-uri('/?data-view=true&amp;format=tei')"
        as="xs:string"/>
    <xsl:param name="tei-anfang" select="fn:escape-html-uri('https://pmb.acdh.oeaw.ac.at/entity/')"
        as="xs:string"/>
    <xsl:template match="tei:listEvent">
        <xsl:element name="listEvent" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates
                select="tei:event[descendant::tei:note[@type = 'persons']/tei:ptr/@target = 'https://pmb.acdh.oeaw.ac.at/entity/2121']"/>
            <!-- nur
            Ereignisse mit Beteiligung Schnitzlers-->
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:event">
        <xsl:element name="event" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="when-iso">
                <xsl:value-of select="@notBefore"/>
            </xsl:attribute>
            <xsl:element name="head" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:value-of select="fn:normalize-space(tei:label)"/>
            </xsl:element>
            <xsl:element name="desc" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:if test="tei:note[@type = 'works'][1]/tei:ptr[1]">
                    <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:for-each select="tei:note[@type = 'works']/tei:ptr">
                            <xsl:element name="bibl">
                                <xsl:variable name="getName" select="replace(@target, 'https://pmb.acdh.oeaw.ac.at/entity/', 'https://pmb.acdh.oeaw.ac.at/apis/entities/tei/work/')"/>
                                <xsl:choose>
                                    <xsl:when test="doc-available($getName)">
                                        <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:attribute name="ref">
                                                <xsl:value-of select="concat('pmb', substring-after(@target, 'https://pmb.acdh.oeaw.ac.at/entity/'))"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="type">
                                                <xsl:value-of select="@type"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="document($getName)/descendant::title[@type='main']"/>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:element name="error">
                                            <xsl:attribute name="ref">
                                                <xsl:value-of select="concat('pmb', substring-after(@target, 'https://pmb.acdh.oeaw.ac.at/entity/'))"/>
                                            </xsl:attribute>
                                        </xsl:element>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="tei:note[@type = 'persons'][1]/tei:ptr[2]">
                    <!-- 1 wär ja nur Schnitzler -->
                    <xsl:element name="listPerson" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:for-each
                            select="tei:note[@type = 'persons']/tei:ptr[not(@target = 'https://pmb.acdh.oeaw.ac.at/entity/2121')]">
                            <xsl:element name="person">
                                <xsl:variable name="getName" select="replace(@target, 'https://pmb.acdh.oeaw.ac.at/entity/', 'https://pmb.acdh.oeaw.ac.at/apis/entities/tei/person/')"/>
                                <xsl:choose>
                                    <xsl:when test="doc-available($getName)">
                                        <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:attribute name="ref">
                                                <xsl:value-of select="concat('pmb', substring-after(@target, 'https://pmb.acdh.oeaw.ac.at/entity/'))"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="type">
                                                <xsl:value-of select="@type"/>
                                            </xsl:attribute>
                                            <xsl:variable name="persName" select="document($getName)/descendant::persName[1]" as="node()"/>
                                            <xsl:choose>
                                                <xsl:when test="$persName/forename and $persName/surname">
                                                    <xsl:value-of select="concat($persName/forename, ' ', $persName/surname)"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="normalize-space($persName)"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:element name="error">
                                            <xsl:attribute name="ref">
                                                <xsl:value-of select="concat('pmb', substring-after(@target, 'https://pmb.acdh.oeaw.ac.at/entity/'))"/>
                                            </xsl:attribute>
                                        </xsl:element>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="tei:note[@type = 'places'][1]/tei:ptr[1]">
                    <xsl:element name="listPlace" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:for-each select="tei:note[@type = 'places']/tei:ptr">
                            <xsl:element name="place">
                                <xsl:variable name="getName" select="replace(@target, 'https://pmb.acdh.oeaw.ac.at/entity/', 'https://pmb.acdh.oeaw.ac.at/apis/entities/tei/place/')"/>
                                <xsl:choose>
                                    <xsl:when test="doc-available($getName)">
                                        <xsl:element name="placeName" namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:attribute name="ref">
                                                <xsl:value-of select="concat('pmb', substring-after(@target, 'https://pmb.acdh.oeaw.ac.at/entity/'))"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="type">
                                                <xsl:value-of select="@type"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="document($getName)/descendant::placeName[1]"/>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:element name="error">
                                            <xsl:attribute name="ref">
                                                <xsl:value-of select="concat('pmb', substring-after(@target, 'https://pmb.acdh.oeaw.ac.at/entity/'))"/>
                                            </xsl:attribute>
                                        </xsl:element>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="tei:note[@type = 'institutions'][1]/tei:ptr[1]">
                    <xsl:element name="listOrg" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:for-each select="tei:note[@type = 'institutions']/tei:ptr">
                            <xsl:element name="org">
                                <xsl:variable name="getName" select="replace(@target, 'https://pmb.acdh.oeaw.ac.at/entity/', 'https://pmb.acdh.oeaw.ac.at/apis/entities/tei/org/')"/>
                                <xsl:choose>
                                    <xsl:when test="doc-available($getName)">
                                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:attribute name="ref">
                                                <xsl:value-of select="concat('pmb', substring-after(@target, 'https://pmb.acdh.oeaw.ac.at/entity/'))"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="type">
                                                <xsl:value-of select="@type"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="document($getName)/descendant::orgName[1]"/>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:element name="error">
                                            <xsl:attribute name="ref">
                                                <xsl:value-of select="concat('pmb', substring-after(@target, 'https://pmb.acdh.oeaw.ac.at/entity/'))"/>
                                            </xsl:attribute>
                                        </xsl:element>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
            </xsl:element>
            <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">
                    <xsl:text>pmb</xsl:text>
                </xsl:attribute>
                <xsl:value-of
                    select="concat(fn:escape-html-uri('https://pmb.acdh.oeaw.ac.at/entity/'), replace(@xml:id, 'event__', ''), '/')"
                />
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="item/id">
        <xsl:variable name="nummer" select="."/>
        <xsl:variable name="tei-ende" select="'/?data-view=true&amp;format=tei'" as="xs:string"/>
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/entity/', $nummer, $tei-ende))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:copy-of
                    select="document($eintrag)/descendant::tei:body/tei:listEvent/tei:event"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>event</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="teiheader" as="node()">
        <xsl:param name="listenname"/>
        <xsl:element name="teiHeader" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:element name="fileDesc" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="titleStmt" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="level">
                            <xsl:text>s</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Arthur Schnitzler: Briefwechsel mit Autorinnen und
                        Autoren</xsl:text>
                    </xsl:element>
                    <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="level">
                            <xsl:text>a</xsl:text>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="$listenname = 'listPerson'">
                                <xsl:text>Verzeichnis der vorkommenden Personen</xsl:text>
                            </xsl:when>
                            <xsl:when test="$listenname = 'listPlace'">
                                <xsl:text>Verzeichnis der vorkommenden Orte</xsl:text>
                            </xsl:when>
                            <xsl:when test="$listenname = 'listOrg'">
                                <xsl:text>Verzeichnis der vorkommenden Institutionen</xsl:text>
                            </xsl:when>
                            <xsl:when test="$listenname = 'listBibl'">
                                <xsl:text>Verzeichnis der vorkommenden Werke</xsl:text>
                            </xsl:when>
                            <xsl:when test="$listenname = 'listEvent'">
                                <xsl:text>Verzeichnis der Ereignisse</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:element>
                    <xsl:element name="respStmt" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="resp" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>providing the content</xsl:text>
                        </xsl:element>
                        <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>Martin Anton Müller</xsl:text>
                        </xsl:element>
                        <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>Gerd-Hermann Susen</xsl:text>
                        </xsl:element>
                        <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>Laura Untner</xsl:text>
                        </xsl:element>
                        <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>PMB (Personen der Moderne Basis)</xsl:text>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="respStmt" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="resp" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>converted to XML encoding</xsl:text>
                        </xsl:element>
                        <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>Martin Anton Müller</xsl:text>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="publicationStmt" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="publisher" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:text>Austrian Centre for Digital Humanities and Cultural Heritage (ACDH-CH)</xsl:text>
                    </xsl:element>
                    <xsl:element name="pubPlace" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:text>Vienna, Austria</xsl:text>
                    </xsl:element>
                    <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:value-of select="fn:current-date()"/>
                    </xsl:element>
                    <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="type">
                            <xsl:text>URI</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of
                            select="concat('https://id.acdh.oeaw.ac.at/arthur-schnitzler-briefe/v1/indices/', $listenname)"
                        />
                    </xsl:element>
                    <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="type">
                            <xsl:text>handle</xsl:text>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="$listenname = 'listPerson'">
                                <xsl:text>https://hdl.handle.net/21.11115/0000-000E-753F-9</xsl:text>
                            </xsl:when>
                            <xsl:when test="$listenname = 'listPlace'">
                                <xsl:text>https://hdl.handle.net/21.11115/0000-000E-753E-A</xsl:text>
                            </xsl:when>
                            <xsl:when test="$listenname = 'listOrg'">
                                <xsl:text>https://hdl.handle.net/21.11115/0000-000E-753D-B</xsl:text>
                            </xsl:when>
                            <xsl:when test="$listenname = 'listBibl'">
                                <xsl:text>https://hdl.handle.net/21.11115/0000-000E-7542-4</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>XXXX</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="sourceDesc" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:text>Entitäten für die Edition der beruflichen Korrespondenz Schnitzlers</xsl:text>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
