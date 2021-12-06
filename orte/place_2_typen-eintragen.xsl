<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:foo="whatever"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    version="3.0">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy" />
    
    <!-- Dieses XSLT trägt die Werktypen in die Werkliste ein -->
    
    <xsl:param name="ptype-refs" select="document('ortslabels/ortslabels.xml')"/>
    <xsl:key name="ref-lookup" match="item" use="ID"/>  
    
    
    <xsl:template match="tei:gloss[not(@ana)]">
        <xsl:variable name="typ-nr">
            <xsl:choose>
                <xsl:when test="contains(., '.0')">
                    <xsl:value-of select="substring-before(.,'.0')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:element name="tei:gloss" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="ana">
                <xsl:value-of select="concat('i',$typ-nr)"/>
            </xsl:attribute>
            <xsl:value-of select="key('ref-lookup', $typ-nr, $ptype-refs)/label-type"/>
        </xsl:element>
    </xsl:template>
    
    <!-- Die Unterscheidung: Wenn @ana vorhanden ist, dann findet sich die 
    Nummer im @ana-->
    <xsl:template match="tei:gloss[@ana]">
        <xsl:variable name="typ-nr" select="substring(@ana, 2)"/>
        <xsl:element name="tei:gloss" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="ana">
                <xsl:value-of select="concat('i',$typ-nr)"/>
            </xsl:attribute>
            <xsl:value-of select="key('ref-lookup', $typ-nr, $ptype-refs)/label-type"/>
        </xsl:element>
        
    </xsl:template>
    
</xsl:stylesheet>