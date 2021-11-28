<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:number="http://dummy/" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all"
    xmlns:functx="http://www.functx.com" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    version="3.0"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
   <!-- Dieses XSL auf refs-aus-pmb angewendet, sollte die vier Datein listPerson etc schreiben -->
    
    <xsl:template match="tei:listPerson">
        <xsl:result-document href="lostPerson.xml">
            <TEI xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.tei-c.org/ns/1.0        http://diglib.hab.de/rules/schema/tei/P5/v2.3.0/tei-p5-transcr.xsd">
            
                <xsl:element name="teiHeader" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fileDesc" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="titleStmt">
                            <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="title"><xsl:text>Personenverzeichnis</xsl:text></xsl:element>
                       <xsl:element name="respStmt" namespace="http://www.tei-c.org/ns/1.0">
                           <xsl:element name="resp" namespace="http://www.tei-c.org/ns/1.0"><xsl:text>providing the content</xsl:text></xsl:element>
                           <xsl:element name="name"><xsl:text>Martin Anton Müller</xsl:text></xsl:element>
                           <xsl:element name="name"><xsl:text>PMB – Personen der Moderne Basis</xsl:text></xsl:element>
                       </xsl:element>
                        </xsl:element>
                     
                        <xsl:element name="publicationStmt" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="fn:current-date()"/>
                            </xsl:element>
                            <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:text>URI</xsl:text>
                                </xsl:attribute>
                                <xsl:text>https://id.acdh.oeaw.ac.at/arthur-schnitzler-briefe/v1/indices/listperson.xml</xsl:text>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="sourceDesc" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:text>Personenverzeichnis der Schnitzler-Briefe.</xsl:text>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                    </xsl:element>
                <xsl:element name="text" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="body" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0"/>
                        <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:element name="listPerson" namespace="http://www.tei-c.org/ns/1.0">
                            
                                <xsl:apply-templates/>
                            
                            </xsl:element></xsl:element></xsl:element></xsl:element></TEI>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="tei:persName">
        <xsl:copy-of select="."></xsl:copy-of>
    </xsl:template>
    
    <xsl:template match="tei:birth">
        <xsl:element name="birth" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="when">
                    <xsl:value-of select="@when"/>
                </xsl:attribute>
                <xsl:value-of select="tokenize(., '&lt;')[1]"/>
            </xsl:element>
            <xsl:choose>
                <xsl:when test="parent::tei:person/tei:note[@type='places']/tei:ptr[@type='geboren-in']">
                <xsl:element name="placeName" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:variable name="nummer" select="tokenize(parent::tei:person/tei:note[@type='places']/tei:ptr[@type='geboren-in']/@target, '/')[last()]"/>
                    <xsl:variable name="tei-ende" select="'/?format=tei'" as="xs:string"/>
                    <xsl:variable name="eintrag"
                        select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/entity/', $nummer, $tei-ende))"
                        as="xs:string"/>
                    <xsl:choose>
                        <xsl:when test="doc-available($eintrag)">
                            <xsl:value-of select="document($eintrag)/descendant::tei:body/tei:listPlace/tei:place/tei:placeName[1]"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="error">
                                <xsl:value-of select="$nummer"/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
                </xsl:when>
                <xsl:when test="parent::tei:person/tei:note[@type='places']/tei:ptr[@type='born-in']">
                <xsl:element name="placeName" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:variable name="nummer" select="tokenize(parent::tei:person/tei:note[@type='places']/tei:ptr[@type='born-in']/@target, '/')[last()]"/>
                    <xsl:variable name="tei-ende" select="'/?format=tei'" as="xs:string"/>
                    <xsl:variable name="eintrag"
                        select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/entity/', $nummer, $tei-ende))"
                        as="xs:string"/>
                    <xsl:choose>
                        <xsl:when test="doc-available($eintrag)">
                            <xsl:value-of select="document($eintrag)/descendant::tei:body/tei:listPlace/tei:place/tei:placeName[1]"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="error">
                                <xsl:value-of select="$nummer"/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
                </xsl:when></xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:death">
        <xsl:element name="death" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="when">
                    <xsl:value-of select="@when"/>
                </xsl:attribute>
                <xsl:value-of select="tokenize(., '&lt;')[1]"/>
            </xsl:element>
            <xsl:choose>
                <xsl:when test="parent::tei:person/tei:note[@type='places']/tei:ptr[@type='gestorben-in']">
                <xsl:element name="placeName" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:variable name="nummer" select="tokenize(parent::tei:person/tei:note[@type='places']/tei:ptr[@type='gestorben-in']/@target, '/')[last()]"/>
                    <xsl:variable name="tei-ende" select="'/?format=tei'" as="xs:string"/>
                    <xsl:variable name="eintrag"
                        select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/entity/', $nummer, $tei-ende))"
                        as="xs:string"/>
                    <xsl:choose>
                        <xsl:when test="doc-available($eintrag)">
                            <xsl:value-of select="document($eintrag)/descendant::tei:body/tei:listPlace/tei:place/tei:placeName[1]"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="error">
                                <xsl:value-of select="$nummer"/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
                </xsl:when>
                <xsl:when test="parent::tei:person/tei:note[@type='places']/tei:ptr[@type='died-in']">
                <xsl:element name="placeName" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:variable name="nummer" select="tokenize(parent::tei:person/tei:note[@type='places']/tei:ptr[@type='died-in']/@target, '/')[last()]"/>
                    <xsl:variable name="tei-ende" select="'/?format=tei'" as="xs:string"/>
                    <xsl:variable name="eintrag"
                        select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/entity/', $nummer, $tei-ende))"
                        as="xs:string"/>
                    <xsl:choose>
                        <xsl:when test="doc-available($eintrag)">
                            <xsl:value-of select="document($eintrag)/descendant::tei:body/tei:listPlace/tei:place/tei:placeName[1]"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="error">
                                <xsl:value-of select="$nummer"/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
                </xsl:when></xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:note[not(parent::tei:body)]">
        <xsl:apply-templates/>
    </xsl:template>
    
        
    <xsl:template match="tei:ptr"/>
        
    
   
   <xsl:template match="tei:idno[@subtype]">
       <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
           <xsl:attribute name="type">
               <xsl:value-of select="concat(@type,'_',@subtype)"/>
           </xsl:attribute>
           <xsl:value-of select="."/>
       </xsl:element>
   </xsl:template>
    
    <xsl:template match="tei:listOrg">
        <xsl:element name="listOrg" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:listPlace">
        <xsl:element name="listPlace" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:place">
        <xsl:element name="place" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('pmb', substring-after(@id, 'place__'))"/>
            </xsl:attribute>
            <xsl:apply-templates select="tei:placeName[not(@type='alt')]"/>
            <xsl:if test="tei:location">
            <xsl:element name="location" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="geo">
                    <xsl:attribute name="decls">
                        <xsl:text>LatLng</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="tei:location/tei:geo"/>
                </xsl:element>
            </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template match="tei:org">
        <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
        <xsl:attribute name="xml:id">
            <xsl:value-of select="concat('pmb', substring-after(@id, 'org__'))"/>
        </xsl:attribute>
            <xsl:apply-templates select="tei:orgName[not(@type='alt')]"/>
                
            
        </xsl:element>
    </xsl:template>
    
   
</xsl:stylesheet>
