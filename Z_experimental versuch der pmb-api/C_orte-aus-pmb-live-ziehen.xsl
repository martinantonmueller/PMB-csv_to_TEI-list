<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:number="http://dummy/" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all"
    xmlns:functx="http://www.functx.com" version="3.0"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <!-- Dieses XSL auf schnitzler-briefe-refs angewendet, sollte alle ORTE-Entitäten aus der PMB holen -->
    <xsl:template match="tei:list | tei:listPerson | tei:listOrg"/>
    <xsl:template match="tei:listPlace">
        <xsl:element name="listPlace" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:place">
        <xsl:variable name="nummer" select="@n"/>
        <xsl:variable name="tei-ende" select="'/?format=tei'" as="xs:string"/>
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/entity/', $nummer, $tei-ende))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:copy-of
                    select="document($eintrag)/descendant::tei:body/tei:listPlace/tei:place" copy-namespaces="no"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>place</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
