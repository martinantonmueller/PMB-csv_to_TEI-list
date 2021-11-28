<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:number="http://dummy/" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all"
    xmlns:functx="http://www.functx.com" version="3.0"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
   <!-- Dieses XSL refs-aus-pmb angewandt, sollte nochmals die Fehler aus der PMB holen -->
    
    <xsl:template match="error[@type='place']">
        <xsl:variable name="nummer" select="."/>
        <xsl:variable name="tei-ende" select="'/?format=tei'" as="xs:string"/>
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/entity/', $nummer, $tei-ende))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:copy-of select="document($eintrag)/descendant::tei:body/tei:listPlace/tei:place"/>
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
    
    <xsl:template match="error[@type='person']">
        <xsl:variable name="nummer" select="."/>
        <xsl:variable name="tei-ende" select="'/?format=tei'" as="xs:string"/>
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/entity/', $nummer, $tei-ende))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:variable name="entry" select="document($eintrag)/descendant::tei:body/tei:listPerson/tei:person"/>
                <xsl:copy-of select="$entry"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>person</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="error[@type='org']">
        <xsl:variable name="nummer" select="."/>
        <xsl:variable name="tei-ende" select="'/?format=tei'" as="xs:string"/>
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/entity/', $nummer, $tei-ende))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:copy-of select="document($eintrag)/descendant::tei:body/tei:listOrg/tei:org"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>org</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="error[@type='item']">
        <xsl:variable name="nummer" select="."/>
        <xsl:variable name="tei-ende" select="'/?format=tei'" as="xs:string"/>
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/entity/', $nummer, $tei-ende))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:copy-of select="document($eintrag)/descendant::tei:body/tei:list/tei:item"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>item</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
   
</xsl:stylesheet>
