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
  
  <!-- Dieses XSLT schreibt die idno/@xml:id des tagebuchs in person/@xml:id  -->
  
   <xsl:template match="tei:person">
       <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
           <xsl:attribute name="xml:id">
               <xsl:value-of select="substring-after(child::tei:idno[@type='schnitzler-tagebuch'][1]/text(),'https://schnitzler-tagebuch.acdh.oeaw.ac.at/entity/')"/>
           </xsl:attribute>
           <xsl:copy-of select="child::*"/>
       </xsl:element>
   </xsl:template>
    
    



</xsl:stylesheet>