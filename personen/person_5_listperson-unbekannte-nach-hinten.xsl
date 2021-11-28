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
  
  <!-- Dieses XSLT nimmt listperson und ordnet personen nur mit Vornamen und solche mit ?? an das Ende der listperson -->
  
   <xsl:template match="tei:listPerson">
       <xsl:element name="tei:listPerson" namespace="http://www.tei-c.org/ns/1.0">
           <xsl:attribute name="xml:id">
               <xsl:text>listperson</xsl:text>
           </xsl:attribute>
           <xsl:apply-templates select="tei:person[not(starts-with(tei:persName/tei:surname, '??') or tei:persName/tei:surname='')]">
               <xsl:sort select="tei:persName/tei:surname"/>
               <xsl:sort select="tei:persName/tei:forename"/>
           </xsl:apply-templates>
           <xsl:apply-templates select="tei:person[tei:persName/tei:surname='']">
               <xsl:sort select="tei:persName/tei:forename"/>
           </xsl:apply-templates>
           <xsl:apply-templates select="tei:person[(starts-with(tei:persName/tei:surname, '??'))]">
               <xsl:sort select="tei:persName/tei:surname"/>
               <xsl:sort select="tei:persName/tei:forename"/>
           </xsl:apply-templates>
       </xsl:element>
       
       
   </xsl:template>



</xsl:stylesheet>