<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:foo="whatever"
    xmlns:uuid="java:java.util.UUID"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
   
    <!-- Dieses XSLT ordnet die IDNOS den URIS zu 
    
    Beispiel für die Ausgangsdatei:
    <Items>
    <item>
      <URL type="geonames">https://www.geonames.org/2764581/</URL>
      <Entity_ID>17</Entity_ID>
      <Entity>Steiermark</Entity>
   </item>
   </root>

    -->
    
    <xsl:template match="item[not(preceding-sibling::item/Entity_ID=Entity_ID)]">
        <xsl:variable name="enti-id" select="Entity_ID" as="xs:integer"/>
        <xsl:element name="entity">
            <xsl:attribute name="id">
                <xsl:value-of select="$enti-id"/>
            </xsl:attribute>
            <xsl:element name="idno">
                <xsl:attribute name="type">
                    <xsl:value-of select="URL/@type"/>
                </xsl:attribute>
                <xsl:value-of select="URL"/>
            </xsl:element>
            <xsl:for-each select="following-sibling::item[Entity_ID=$enti-id]">
                <xsl:element name="idno">
                    <xsl:attribute name="type">
                        <xsl:value-of select="URL/@type"/>
                    </xsl:attribute>
                    <xsl:value-of select="URL"/>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    <xsl:template match="item[(preceding-sibling::item/Entity_ID=Entity_ID)]"/>
  
</xsl:stylesheet>
