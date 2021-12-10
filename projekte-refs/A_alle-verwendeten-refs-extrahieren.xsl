<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:foo="whatever" xmlns:tei="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:output method="xml" indent="true"/>
    <!-- Dieses XSLT, auf asbw gesamt.xml angewendet, holt alle refs heraus. Gespeichert
    wird das Ergebnis in schnitzler-briefe-refs-->
    <xsl:template match="root">
        <xsl:element name="TEI" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:element name="teiHeader" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="fileDesc" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="titleStmt">
                        <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="title">
                            <xsl:text>In den Briefen verwendete PMB-Entitäten</xsl:text>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="publicationStmt" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>Nothing much to say</xsl:text>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="sourceDesc" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:text>Nothing much to say</xsl:text>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            <xsl:element name="text" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="body" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="listPerson" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:for-each
                                select="descendant::rs[@type = 'person']/tokenize(@ref, ' ')">
                                <xsl:sort select="number(.)"/>
                                <xsl:choose>
                                    <xsl:when test="contains(.,'#pmb')">
                                        <xsl:if test="string-length(substring-after(., '#pmb')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'pmb')">
                                        <xsl:if test="string-length(substring-after(., 'pmb')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., 'pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'#')">
                                        <xsl:if test="string-length(substring-after(., '#')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>
                            <xsl:for-each select="descendant::author[@ref]/@ref">
                                <xsl:sort select="number(substring-after(., '#'))"/>
                                <xsl:choose>
                                    <xsl:when test="contains(.,'#pmb')">
                                        <xsl:if test="string-length(substring-after(., '#pmb')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'pmb')">
                                        <xsl:if test="string-length(substring-after(., 'pmb')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., 'pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'#')">
                                        <xsl:if test="string-length(substring-after(., '#')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>
                            <xsl:for-each select="descendant::persName[@ref]/@ref">
                                <xsl:sort select="number(substring-after(., '#'))"/>
                                <xsl:choose>
                                    <xsl:when test="contains(.,'#pmb')">
                                        <xsl:if test="string-length(substring-after(., '#pmb')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'pmb')">
                                        <xsl:if test="string-length(substring-after(., 'pmb')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., 'pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'#')">
                                        <xsl:if test="string-length(substring-after(., '#')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>
                            <xsl:for-each select="descendant::handShift[@scribe]/@scribe">
                                <xsl:sort select="number(substring-after(., '#'))"/>
                                <xsl:choose>
                                    <xsl:when test="contains(.,'#pmb')">
                                        <xsl:if test="string-length(substring-after(., '#pmb')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'pmb')">
                                        <xsl:if test="string-length(substring-after(., 'pmb')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., 'pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'#')">
                                        <xsl:if test="string-length(substring-after(., '#')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>
                            <xsl:for-each
                                select="descendant::handNote[@corresp and not(@corresp = 'Schreibkraft')]/@corresp">
                                <xsl:sort select="number(substring-after(., '#'))"/>
                                <xsl:choose>
                                    <xsl:when test="contains(.,'#pmb')">
                                        <xsl:if test="string-length(substring-after(., '#pmb')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'pmb')">
                                        <xsl:if test="string-length(substring-after(., 'pmb')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., 'pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'#')">
                                        <xsl:if test="string-length(substring-after(., '#')) &gt; 1">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="person">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="list" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:for-each
                                select="descendant::rs[@type = 'work']/tokenize(@ref, ' ')">
                                <xsl:sort select="number(.)"/>
                                <xsl:choose>
                                    <xsl:when test="contains(.,'#pmb')">
                                        <xsl:if test="string-length(substring-after(., '#pmb')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="item">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'pmb')">
                                        <xsl:if test="string-length(substring-after(., 'pmb')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="item">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., 'pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'#')">
                                        <xsl:if test="string-length(substring-after(., '#')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="item">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                </xsl:choose>
                                
                                
                                
                            </xsl:for-each>
                            <xsl:for-each
                                select="descendant::biblStruct//title[@ref]/tokenize(@ref, ' ')">
                                <xsl:sort select="number(.)"/>
                                <xsl:choose>
                                    <xsl:when test="contains(.,'#pmb')">
                                        <xsl:if test="string-length(substring-after(., '#pmb')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="item">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'pmb')">
                                        <xsl:if test="string-length(substring-after(., 'pmb')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="item">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., 'pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'#')">
                                        <xsl:if test="string-length(substring-after(., '#')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="item">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="listOrg" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:for-each select="descendant::rs[@type = 'org']/tokenize(@ref, ' ')">
                                <xsl:sort select="number(.)"/>
                                <xsl:choose>
                                    <xsl:when test="contains(.,'#pmb')">
                                        <xsl:if test="string-length(substring-after(., '#pmb')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="org">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'pmb')">
                                        <xsl:if test="string-length(substring-after(., 'pmb')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="org">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., 'pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'#')">
                                        <xsl:if test="string-length(substring-after(., '#')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="org">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                </xsl:choose>
                                
                                
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="listPlace" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:for-each
                                select="descendant::rs[@type = 'place']/tokenize(@ref, ' ')">
                                <xsl:sort select="number(.)"/>
                                <xsl:choose>
                                    <xsl:when test="contains(.,'#pmb')">
                                        <xsl:if test="string-length(substring-after(., '#pmb')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="place">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'pmb')">
                                        <xsl:if test="string-length(substring-after(., 'pmb')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="place">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., 'pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'#')">
                                        <xsl:if test="string-length(substring-after(., '#')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="place">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                </xsl:choose>
                                
                                
                            </xsl:for-each>
                            <xsl:for-each select="descendant::placeName[@ref]/tokenize(@ref, ' ')">
                                <xsl:sort select="number(substring-after(., '#'))"/>
                                <xsl:choose>
                                    <xsl:when test="contains(.,'#pmb')">
                                        <xsl:if test="string-length(substring-after(., '#pmb')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="place">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'pmb')">
                                        <xsl:if test="string-length(substring-after(., 'pmb')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="place">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., 'pmb'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:when test="contains(.,'#')">
                                        <xsl:if test="string-length(substring-after(., '#')) &gt; 0">
                                            <xsl:element namespace="http://www.tei-c.org/ns/1.0"
                                                name="place">
                                                <xsl:attribute name="n">
                                                    <xsl:value-of
                                                        select="normalize-space(substring-after(., '#'))"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0"/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
