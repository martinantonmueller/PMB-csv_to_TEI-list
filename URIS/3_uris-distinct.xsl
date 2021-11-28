<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:foo="whatever"
    xmlns:uuid="java:java.util.UUID"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
   
    <!-- Dieses XSLT sortiert Dubletten aus
    
    Beispiel für die Eingangsdatei:
    
<entity id="45359">
      <idno type="geonames">https://www.geonames.org/686254</idno>
      <idno type="geonames">https://www.geonames.org/686254/</idno>
      <idno type="geonames">https://www.geonames.org/686254/</idno>
      <idno type="gnd">https://d-nb.info/gnd/4079813-6</idno>
   </entity>
    
    -->
    
    <xsl:template match="entity">
        <xsl:element name="entity">
            <xsl:copy select="@*"/>
            <xsl:for-each-group select="idno" group-by="@type">
                <xsl:element name="idno" inherit-namespaces="true">
                    <xsl:attribute name="type">
                <xsl:value-of select="current-grouping-key()"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each-group>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>
