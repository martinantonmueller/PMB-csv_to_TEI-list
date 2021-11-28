<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:foo="whatever"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    version="3.0">
    <xsl:output method="xml" indent="true"/>
    <xsl:strip-space elements="root"/>
    
    <!-- Dieses XSLT schaut, angewandt auf schnitzler-briefe-refs.xml, ob in der Liste der verwendeten @refs Nummern drin
    sind, die nicht in der listperson sind --> 
  
    <xsl:param name="verwendete-refs" select="document('listperson.xml')"/>
    <xsl:key name="ref-lookup" match="tei:person" use="@xml:id"/>  
    
    
    
<xsl:template match="tei:listPerson">
    <xsl:element name="root">
    <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="tei:person">
    <xsl:variable name="treffer" select="key('ref-lookup', concat('pmb', @n), $verwendete-refs)/tei:persName"/>
    <xsl:if test="string-length($treffer)=0">
        <xsl:element name="offen">
            <xsl:value-of select="@n"/>
        </xsl:element>
    </xsl:if>
</xsl:template>

<xsl:template match="tei:list|tei:listOrg|tei:listPlace"/>



</xsl:stylesheet>