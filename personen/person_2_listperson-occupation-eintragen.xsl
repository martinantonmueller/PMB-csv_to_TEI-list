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
       
        <xsl:element name="occupation" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="code">
                <xsl:value-of select="."/>
            </xsl:attribute>
            <xsl:value-of select="key('ref-lookup', ., $ptype-refs)/name"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>