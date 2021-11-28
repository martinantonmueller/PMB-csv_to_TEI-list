<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:number="http://dummy/" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all"
    xmlns:functx="http://www.functx.com" version="3.0"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
   <!-- Dieses XSL auf schnitzler-briefe-refs angewendet, sollte alle Entitäten aus der PMB holen -->
    
    <xsl:template match="tei:list">
        <xsl:element name="list" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:listPerson">
        <xsl:element name="listPerson" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:listOrg">
        <xsl:element name="listOrg" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
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
                <xsl:copy-of select="document($eintrag)/descendant::tei:body/tei:listPlace/tei:place"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:person">
        <xsl:variable name="nummer" select="@n"/>
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
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:org">
        <xsl:variable name="nummer" select="@n"/>
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
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <xsl:variable name="nummer" select="@n"/>
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
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- ALTE VERSION, AUF RS angewandt -->
  <!--  <xsl:template match="tei:TEI">
        <xsl:apply-templates/>
        <xsl:element name="back">
            <xsl:element name="listPerson" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:for-each select="distinct-values(descendant::tei:rs[@type='person']/@ref/tokenize(., '#pmb'))">
                    <xsl:if test="not(. = '#')">
                        <xsl:variable name="nummer" select="substring(., 2)"/>
                        <xsl:variable name="tei-ende" select="'/?format=tei'" as="xs:string"/>
                        <xsl:variable name="eintrag"
                            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/entity/', $nummer, $tei-ende))"
                            as="xs:string"/>
                        <xsl:choose>
                            <xsl:when test="doc-available($eintrag)">
                                <xsl:variable name="entry" select="document($eintrag)/descendant::tei:body/tei:listPerson/tei:person" as="node()"/>
                                <xsl:copy-of select="$entry"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:element name="error">
                                    <xsl:value-of select="$nummer"/>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </xsl:for-each>
            </xsl:element>
            <xsl:element name="listWork" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:for-each select="distinct-values(descendant::tei:rs[@type='work']/@ref/tokenize(., '#pmb'))">
                    <xsl:if test="not(. = '#')">
                        <xsl:variable name="nummer" select="substring(., 2)"/>
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
                                    <xsl:value-of select="$nummer"/>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </xsl:for-each>
            </xsl:element>
            <xsl:element name="listPlace" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:for-each select="distinct-values(descendant::tei:rs[@type='place']/@ref/tokenize(., '#pmb'))">
                    <xsl:if test="not(. = '#')">
                        <xsl:variable name="nummer" select="substring(., 2)"/>
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
                                    <xsl:value-of select="$nummer"/>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </xsl:for-each>
            </xsl:element>
            <xsl:element name="listOrg" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:for-each select="distinct-values(descendant::tei:rs[@type='org']/@ref/tokenize(., '#pmb'))">
                    <xsl:if test="not(. = '#')">
                        <xsl:variable name="nummer" select="substring(., 2)"/>
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
                                    <xsl:value-of select="$nummer"/>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </xsl:for-each>
            </xsl:element>
        </xsl:element>
    </xsl:template>-->
</xsl:stylesheet>
