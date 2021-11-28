<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:foo="whatever" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.0">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <!-- Dieses XSLT nimmt die komplette listperson mit allen Personen in PMB und schaut nach, ob 
  eine Person in der Liste der verwendeten @refs vorkommt -->
    <xsl:param name="author-refs" select="document('person-work/personWork.xml')"/>
    <xsl:key name="ref-lookup" match="item" use="workID"/>
    <xsl:param name="author-name-refs" select="document('../personen/listperson-pmb.xml')"/>
    <xsl:key name="ref-author-lookup" match="tei:person" use="@xml:id"/>
    <xsl:template match="tei:listBibl">
        <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="xml:id">
                <xsl:text>listwork</xsl:text>
            </xsl:attribute>
            <xsl:for-each select="tei:bibl">
                <xsl:sort select="tei:title" order="ascending" data-type="text" lang="de"/>
                <xsl:element name="bibl"  namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:variable name="ref" select="substring-after(@xml:id, 'pmb')"/>
                    <xsl:choose>
                        <xsl:when test="key('ref-lookup', $ref, $author-refs)[1]/personID">
                            <!-- Beziehung 1048 ist nur eine allgemeine Beziehung, die wird übergangen -->
                            <xsl:for-each
                                select="key('ref-lookup', $ref, $author-refs)[not(relation_type = '1048')]">
                                <xsl:element name="author" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:variable name="author-key"
                                        select="key('ref-author-lookup', concat('pmb', personID/.), $author-name-refs)"
                                        as="node()?"/>
                                    <xsl:variable name="author-persName"
                                        select="$author-key/tei:persName" as="node()?"/>
                                    
                                    <xsl:attribute name="role">
                                        <xsl:choose>
                                            <xsl:when test="./relation_type = '1335'">
                                                <xsl:text>author-suggested</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="./relation_type = '1224'">
                                                <xsl:text>contributor</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="./relation_type = '1217'">
                                                <xsl:text>composer</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="./relation_type = '1144'">
                                                <xsl:text>contributor</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="./relation_type = '1053'">
                                                <xsl:text>editor</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="./relation_type = '1052'">
                                                <xsl:text>translator</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="./relation_type = '1051'">
                                                <xsl:text>author</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="./relation_type = '1050'">
                                                <xsl:text>author</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="./relation_type = '1049'">
                                                <xsl:text>author</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="./relation_type = '1553'">
                                                <xsl:text>illustrator</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="./relation_type = '1587'">
                                                <xsl:text>abbreviated-name</xsl:text>
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:attribute>
                                    <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:if test="string-length($author-persName/tei:surname) &gt; 0">
                                        <xsl:element name="surname" namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:value-of select="$author-persName/tei:surname"/>
                                        </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="string-length($author-persName/tei:forename) &gt; 0">
                                        <xsl:element name="forename" namespace="http://www.tei-c.org/ns/1.0">
                                            <xsl:value-of select="$author-persName/tei:forename"/>
                                        </xsl:element>
                                    </xsl:if>
                                    </xsl:element>
                                    <xsl:choose>
                                        <xsl:when test="./relation_type = '1335'">
                                            <xsl:element name="term"  namespace="http://www.tei-c.org/ns/1.0">
                                                <xsl:text>[mutmaßlich]</xsl:text>
                                            </xsl:element>
                                        </xsl:when>
                                        <xsl:when test="./relation_type = '1217'">
                                            <xsl:element name="term"  namespace="http://www.tei-c.org/ns/1.0">
                                                <xsl:text>[Vertonung]</xsl:text>
                                            </xsl:element>
                                        </xsl:when>
                                        <xsl:when test="./relation_type = '1144'">
                                            <xsl:element name="term"  namespace="http://www.tei-c.org/ns/1.0">
                                                <xsl:text>[Beitrag]</xsl:text>
                                            </xsl:element>
                                        </xsl:when>
                                        <xsl:when test="./relation_type = '1053'">
                                            <xsl:element name="term"  namespace="http://www.tei-c.org/ns/1.0">
                                                <xsl:text>[Herausgeber*in]</xsl:text>
                                            </xsl:element>
                                        </xsl:when>
                                        <xsl:when test="./relation_type = '1052'">
                                            <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                                                <xsl:text>[Übersetzung]</xsl:text>
                                            </xsl:element>
                                        </xsl:when>
                                        <xsl:when test="./relation_type = '1553'">
                                            <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                                                <xsl:text>[Illustrationen]</xsl:text>
                                            </xsl:element>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                                        <xsl:attribute name="type">
                                            <xsl:text>pmb</xsl:text>
                                        </xsl:attribute>
                                        <xsl:value-of select="concat('pmb', ./personID)"/>
                                    </xsl:element>
                                    <xsl:copy-of select="$author-key/tei:idno"/>
                                </xsl:element>
                            </xsl:for-each>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:bibl/tei:author"/>
</xsl:stylesheet>
