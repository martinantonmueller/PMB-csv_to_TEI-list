<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:number="http://dummy/" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all"
    xmlns:functx="http://www.functx.com" version="3.0"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <!-- Dieses XSL auf den id-download event-ids.xml (csv, umgewandelt als xml) angewandt, 
        sollte alle events-Entitäten aus der PMB holen. 
    -->
    <xsl:template match="Items">
        <xsl:variable name="listenname" select="'listEvent'" as="xs:string"/>
        <xsl:element name="TEI" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:call-template name="teiheader">
                <xsl:with-param name="listenname" select="$listenname"/>
            </xsl:call-template>
            <xsl:element name="text" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="body" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="listEvent" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:apply-templates select="item/id"/>
                    </xsl:element>
                </xsl:element>
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
