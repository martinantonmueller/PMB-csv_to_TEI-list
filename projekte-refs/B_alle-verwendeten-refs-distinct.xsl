<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:foo="whatever"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xsl:output method="xml" indent="true" />
    <xsl:mode on-no-match="shallow-copy" />
    
    <!-- Dieses XSLT, auf die liste aller refs angewendet, macht alle refs distinct -->
    
  
    <xsl:template match="tei:listPlace">
        <xsl:element name="listPlace" namespace="http://www.tei-c.org/ns/1.0">
        <xsl:for-each select="distinct-values(tei:place/@n)">
            <xsl:sort select="number(.)"/>
            <xsl:element name="place" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="n">
                <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:element>
        </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:listPerson">
        <xsl:element name="listPerson" namespace="http://www.tei-c.org/ns/1.0">
        <xsl:for-each select="distinct-values(tei:person/@n)">
            <xsl:sort select="number(.)"/>
            <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="n">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:element>
        </xsl:for-each>
        </xsl:element>
            
    </xsl:template>
    
    <xsl:template match="tei:listOrg">
        <xsl:element name="listOrg" namespace="http://www.tei-c.org/ns/1.0">
        <xsl:for-each select="distinct-values(tei:org/@n)">
            <xsl:sort select="number(.)"/>
            <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="n">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:element>
        </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <xsl:element name="list" namespace="http://www.tei-c.org/ns/1.0">
        <xsl:for-each select="distinct-values(tei:item/@n)">
            <xsl:sort select="number(.)"/>
            <xsl:element name="item" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="n">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:element>
        </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
   <!-- <xsl:template match="tei:TEI">
        
      <xsl:element name="root">
          <xsl:for-each select="distinct-values(person)">
           <xsl:sort select="number(.)"/>
           <xsl:element name="person">
               <xsl:value-of select="."/>
           </xsl:element>
       </xsl:for-each>
        <xsl:for-each select="distinct-values(work)">
            <xsl:sort select="number(.)"/>
            <xsl:element name="work">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
        <xsl:for-each select="distinct-values(organisation)">
            <xsl:sort select="number(.)"/>
            <xsl:element name="organisation">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
       </xsl:element>
    </xsl:template>-->
  
    
</xsl:stylesheet>