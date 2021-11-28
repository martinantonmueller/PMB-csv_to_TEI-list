<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:uuid="java:java.util.UUID">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:param name="uris" select="document('../URIS/uris_gnd_geonames_wikidata.xml')"/>
    <xsl:key name="uri-lookup" match="entity" use="@id"/>
    
    
   <xsl:template match="tei:bibl">
       <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
           <xsl:variable name="id" select="substring-after(@xml:id, 'pmb')"/>
           <xsl:copy-of select="@*"/>
           <xsl:copy-of select="node()[not(name()='idno')]"/>
           <xsl:for-each select="key('uri-lookup', $id, $uris)/idno">
               <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                   <xsl:attribute name="type">
                       <xsl:value-of select="./@type"/>
                   </xsl:attribute>
                   <xsl:value-of select="."/>
               </xsl:element>
           </xsl:for-each>
       </xsl:element>
   </xsl:template> 
</xsl:stylesheet>
