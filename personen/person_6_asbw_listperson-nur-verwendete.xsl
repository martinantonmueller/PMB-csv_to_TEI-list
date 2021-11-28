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
  
  <!-- Dieses XSLT nimmt die komplette listperson mit allen Personen in PMB und schaut nach, ob 
  eine Person in der Liste der verwendeten @refs vorkommt -->
    
    <!-- HANDLE -->
    <xsl:param name="projektkuerzel" as="xs:string" select="'asbw'"/>
    <xsl:param name="handle-refs" select="document('../handles/project-handles.xml')"/>
    <xsl:key name="handle-lookup" match="project" use="@ana"/>
    <xsl:param name="handle" as="xs:string?"
        select="key('handle-lookup', $projektkuerzel, $handle-refs)/list/item[@type = 'listperson'][1]"/>
    <xsl:template match="tei:publicationStmt">
        <xsl:element name="publicationStmt" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="tei:publisher"/>
            <xsl:copy-of select="tei:date"/>
            <xsl:if test="string-length($handle) &gt; 0">
                <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="type">
                        <xsl:text>URI</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="$handle"/>
                </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    
  <!-- PERSON -->
    <xsl:param name="verwendete-refs" select="document('../projekte-refs/schnitzler-briefe-refs.xml')"/>
    <xsl:key name="ref-lookup" match="tei:person" use="@n"/>  
    
<xsl:template match="tei:listPerson">
    <xsl:element name="tei:listPerson">
        <xsl:attribute name="xml:id">
            <xsl:text>listperson</xsl:text>
        </xsl:attribute>
        
    <xsl:for-each select="tei:person" >
       <xsl:sort select="tei:persName/tei:surname" order="ascending" data-type="text" lang="de"/>
        <xsl:sort select="tei:persName/tei:forename" order="ascending" data-type="text" lang="de"/>
        <xsl:variable name="ref" select="substring-after(@xml:id, 'pmb')"/>
       <xsl:choose>
        <xsl:when test="key('ref-lookup', $ref, $verwendete-refs)">
                <xsl:copy-of select="."/>
        </xsl:when>
       </xsl:choose>
        
    </xsl:for-each>
        
    </xsl:element>
    
</xsl:template>


</xsl:stylesheet>