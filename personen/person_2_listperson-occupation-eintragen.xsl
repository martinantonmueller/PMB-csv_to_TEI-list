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
  
    <xsl:param name="ptype-refs" select="document('professions/professionTypes.xml')"/>
    <xsl:key name="ref-lookup" match="item" use="id"/>  
    
    
    <xsl:template match="tei:occupation">
        <xsl:variable name="gender" select="parent::tei:person/tei:sex[1]" as="xs:string?"/>
        <xsl:element name="occupation" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="code">
                <xsl:value-of select="."/>
            </xsl:attribute>
            <xsl:variable name="beruf" as="xs:string?" select="key('ref-lookup', ., $ptype-refs)/name"/>
            <xsl:choose>
                <xsl:when test="$gender='male' and contains($beruf, '/')">
                    <xsl:value-of select="tokenize($beruf,'/')[1]"/>
                </xsl:when>
                <xsl:when test="$gender='female' and contains($beruf, '/')">
                    <xsl:value-of select="tokenize($beruf,'/')[2]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$beruf"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>