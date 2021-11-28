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
  
    <xsl:param name="place-refs" select="document('institution-place/institutionPlace.xml')"/>
    <xsl:key name="ref-lookup" match="item" use="related_institution"/>  
    
    <xsl:param name="place-name-refs" select="document('../orte/listplace-pmb.xml')"/>
    <xsl:key name="ref-place-lookup" match="tei:place" use="@xml:id"/>  
    
<xsl:template match="tei:listOrg">
    <xsl:element name="tei:listOrg">
        <xsl:attribute name="xml:id">
            <xsl:text>listorg</xsl:text>
        </xsl:attribute>
    <xsl:for-each select="tei:org" >
       <xsl:sort select="tei:orgName" order="ascending" data-type="text" lang="de"/>
        <xsl:element name="tei:org">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        <xsl:variable name="ref" select="substring-after(@xml:id, 'pmb')"/>
            <xsl:variable name="ref-place" select="key('ref-lookup', $ref, $place-refs)[1]/related_place"/>
        <xsl:choose>
        <xsl:when test="key('ref-lookup', $ref, $place-refs)[1]/related_place">
            <xsl:for-each select="key('ref-lookup', $ref, $place-refs)/related_place">
                <xsl:element name="tei:place">
                    <xsl:attribute name="corresp">
                        <xsl:value-of select="concat('pmb', normalize-space(.))"/>
                    </xsl:attribute>
                    <xsl:variable name="place-key" select="key('ref-place-lookup', concat('pmb', .), $place-name-refs)" as="node()?"/>
                    <xsl:element name="tei:placeName">
                        <xsl:value-of select="$place-key/tei:placeName"/>
                    </xsl:element>
                    <xsl:if test="string-length($place-key/tei:location/tei:geo) &gt; 1">
                    <xsl:element name="tei:location">
                        <xsl:element name="tei:geo">
                           <xsl:attribute name="decls">
                               <xsl:text>LatLng</xsl:text>
                           </xsl:attribute>
                            <xsl:value-of select="$place-key/tei:location/tei:geo"/>
                        </xsl:element>   
                    </xsl:element>
                    </xsl:if>
                </xsl:element>
            </xsl:for-each>
        </xsl:when>
       </xsl:choose>
        </xsl:element>
    </xsl:for-each>
    </xsl:element>
</xsl:template>
    
    <xsl:template match="tei:place"/> 


</xsl:stylesheet>