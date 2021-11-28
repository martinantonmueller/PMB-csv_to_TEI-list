<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:foo="whatever"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    version="3.0">
    <xsl:output method="text" indent="false"/>
    <xsl:mode on-no-match="shallow-skip" />
  
  <!-- Dieses XSLT erstellt eine Liste der Werke, die nur "Text" als Werktyp haben-->
  
  <xsl:template match="tei:listBibl">
      <xsl:element name="root">
          <xsl:apply-templates select="tei:bibl[tei:gloss ='Text']"/>
      </xsl:element>
  </xsl:template>
  
    <xsl:template match="tei:bibl[tei:gloss ='Text']">
        <xsl:value-of select="normalize-space(tei:title)"/><xsl:text>&#9;</xsl:text><xsl:value-of select="normalize-space(tei:author[1]/tei:surname[1])"/><xsl:text>&#9;</xsl:text><xsl:value-of select="concat(replace(@xml:id, 'pmb', 'https://pmb.acdh.oeaw.ac.at/apis/entities/entity/work/'), '/edit')"/><xsl:text>&#9;</xsl:text><xsl:value-of select="concat(replace(@xml:id, 'pmb', 'https://schnitzler-briefe.acdh.oeaw.ac.at/pages/hits.html?searchkey=pmb'), '#_')"/><xsl:text>&#10;</xsl:text></xsl:template>
</xsl:stylesheet>