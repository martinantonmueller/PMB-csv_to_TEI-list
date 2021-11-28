<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:foo="whatever" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.0">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <!-- Dieses XSLT trägt Geburts-, Sterbe-. Deportationsort etc. in die Werkliste ein -->
    <xsl:param name="relation-refs" select="document('personplace-relation/0_personplace.xml')"/>
    <xsl:key name="relation-lookup" match="item" use="concat(related_person_id, relation_type)"/>
    <xsl:param name="place-name-refs" select="document('../orte/listplace-pmb.xml')"/>
    <xsl:key name="ref-place-lookup" match="tei:place" use="(@xml:id)"/>
    
    
    <xsl:template match="tei:birth">
        <xsl:element name="tei:birth" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*|*"/>
            <xsl:variable name="person-id"
                select="substring-after(ancestor::tei:person/@xml:id, 'pmb')"/>
            <xsl:if test="key('relation-lookup', concat($person-id, 'birth'), $relation-refs)">
                <xsl:variable name="relation"
                    select="key('relation-lookup', concat($person-id, 'birth'), $relation-refs)[1]/related_place_id"/>
                <xsl:element name="tei:placeName" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:variable name="ort-eintrag" as="node()" select="key('ref-place-lookup', concat('pmb', $relation), $place-name-refs)"/>
                    <xsl:element name="settlement" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:value-of select="$ort-eintrag/tei:placeName[1]"/>
                    </xsl:element>
                    <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="type">
                            <xsl:text>PMB</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="concat('#pmb', $relation)"/>
                    </xsl:element>
                    <xsl:variable name="geonames-lookup" select="$ort-eintrag/tei:idno[@type='geonames'][1]"/>
                    <xsl:if test="not($geonames-lookup='')">
                        <xsl:element name="idno"  namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:text>geonames</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of
                                select="$geonames-lookup"
                            />
                        </xsl:element>
                    </xsl:if>
                </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:death">
        <xsl:element name="tei:death" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@* | *"/>
            <xsl:variable name="person-id"
                select="substring-after(ancestor::tei:person/@xml:id, 'pmb')"/>
            <xsl:choose>
                <xsl:when test="key('relation-lookup', concat($person-id, 'death'), $relation-refs)">
                    <xsl:variable name="relation"
                        select="key('relation-lookup', concat($person-id, 'death'), $relation-refs)[1]/related_place_id"/>
                    <xsl:element name="tei:placeName" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:variable name="ort-eintrag" as="node()" select="key('ref-place-lookup', concat('pmb', $relation), $place-name-refs)"/>
                        <xsl:element name="settlement" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$ort-eintrag/tei:placeName[1]"/>
                        </xsl:element>
                        <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:text>PMB</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="concat('#pmb', $relation)"/>
                        </xsl:element>
                        <xsl:variable name="geonames-lookup" select="$ort-eintrag/tei:idno[@type='geonames'][1]"/>
                        <xsl:if test="not($geonames-lookup='')">
                            <xsl:element name="idno"  namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:text>geonames</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of
                                    select="$geonames-lookup"
                                />
                            </xsl:element>
                        </xsl:if>
                    </xsl:element>
                </xsl:when>
                <xsl:when
                    test="key('relation-lookup', concat($person-id, 'deportation'), $relation-refs)">
                    <xsl:variable name="relation"
                        select="key('relation-lookup', concat($person-id, 'deportation'), $relation-refs)[1]/related_place_id"/>
                    <xsl:element name="placeName" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="type">
                            <xsl:text>deportation</xsl:text>
                        </xsl:attribute>
                        <xsl:variable name="ort-eintrag" as="node()" select="key('ref-place-lookup', concat('pmb', $relation), $place-name-refs)"/>
                        <xsl:element name="settlement" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$ort-eintrag/tei:placeName[1]"/>
                        </xsl:element>
                        <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:text>PMB</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="concat('#pmb', $relation)"/>
                        </xsl:element>
                        <xsl:variable name="geonames-lookup" select="$ort-eintrag/tei:idno[@type='geonames'][1]"/>
                        <xsl:if test="not($geonames-lookup='')">
                            <xsl:element name="idno"  namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:text>geonames</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of
                                    select="$geonames-lookup"
                                />
                            </xsl:element>
                        </xsl:if>
                    </xsl:element>
                </xsl:when>
                <xsl:when
                    test="key('relation-lookup', concat($person-id, 'burial'), $relation-refs)">
                    <xsl:variable name="relation"
                        select="key('relation-lookup', concat($person-id, 'burial'), $relation-refs)[1]/related_place_id"/>
                    <xsl:element name="placeName" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="type">
                            <xsl:text>burial</xsl:text>
                        </xsl:attribute>
                        <xsl:variable name="ort-eintrag" as="node()" select="key('ref-place-lookup', concat('pmb', $relation), $place-name-refs)"/>
                        <xsl:element name="settlement" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$ort-eintrag/tei:placeName[1]"/>
                        </xsl:element>
                        <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:text>PMB</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="concat('#pmb', $relation)"/>
                        </xsl:element>
                        <xsl:variable name="geonames-lookup" select="$ort-eintrag/tei:idno[@type='geonames'][1]"/>
                        <xsl:if test="not($geonames-lookup='')">
                            <xsl:element name="idno"  namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:text>geonames</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of
                                    select="$geonames-lookup"
                                />
                            </xsl:element>
                        </xsl:if>
                    </xsl:element>
                </xsl:when>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
