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
  
  <!-- Problem: Derzeit sind in PMB mehrere gleichlautende Relationen zwischen
      Entitäten vorhanden, die aber unterschiedliche Nummern haben. Dieses XSLT, angewandt auf 
      einen CSV-Export, der mit xCSV als XML gespeichert wurde, führt die unterschiedlichen Typen 
      von relationtypes auf Normangaben zurück.
  -->
  
  
  
  <xsl:template match="relation_type[not(.='')]">
      <xsl:element name="relation_type">
          <xsl:attribute name="n">
              <xsl:value-of select="."/>
          </xsl:attribute>
      <xsl:choose>
          <xsl:when test=".=88 or .=1510 or .=1398 or .=1147 or .=1657">birth</xsl:when>
          <xsl:when test=".=1148 or .=89">death</xsl:when>
          <xsl:when test=".=1294">deportation</xsl:when>
          <xsl:when test=".=1187">burial</xsl:when>
          <xsl:when test=".=1181 or .=1140">living</xsl:when>
          <xsl:when test=".=1150">owns</xsl:when>
          <xsl:otherwise>
              <xsl:text>XXXX</xsl:text><xsl:value-of select="."/>
          </xsl:otherwise>
      </xsl:choose>
      </xsl:element>
  </xsl:template>
    
    <xsl:template match="item[relation_type[.='']]"/>
    

</xsl:stylesheet>