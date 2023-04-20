<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:foo="whatever"
    xmlns:uuid="java:java.util.UUID"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
   
    <!-- Dieses XSLT auf:
        PMB -> CSV 
        -> TextSoap (replace & als &amp; wenn ein Leerzeichen davor bzw. 
        als %26 wenn ein Buchstabe davor (also in URL)
        -> xCSV
        -> XML
    normalisiert die unterschiedlichen Fassungen von GND, Wikidata und GEONAMES und
    löscht die anderen URIS raus. Aus der Datei uris-aus-pmb
    wird die relevante Datei 
    
    Beispiel für die Ausgangsdatei:
    
    <Items>
    <item>
        <URI_ID>11</URI_ID>
        <URL>https://www.wikidata.org/wiki/Q703955</URL>
        <Entity>Deutsches Theater Berlin</Entity>
        <Entity_ID>3</Entity_ID>
    </item>
    </Items>
    
    -->
   <xsl:function name="foo:geonames-normalize">
       <xsl:param name="entry" as="xs:string"/>
       <xsl:choose>
           <xsl:when test="contains($entry,'geonames.org')">
               <xsl:variable name="kuerzel">
                   <xsl:choose>
                       <xsl:when test="ends-with($entry, '/')">
                           <xsl:value-of select="substring-after($entry, 'geonames.org/')"/>
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:value-of select="concat(substring-after($entry, 'geonames.org/'), '/')"/>
                       </xsl:otherwise>
                   </xsl:choose>
               </xsl:variable>
               <xsl:value-of select="concat('https://www.geonames.org/', $kuerzel)"/>
           </xsl:when>
           <xsl:otherwise>
               <xsl:text>ERROR</xsl:text>
               <xsl:value-of select="$entry"/>
           </xsl:otherwise>
       </xsl:choose>
   </xsl:function>
    <xsl:function name="foo:wikidata-normalize">
        <xsl:param name="entry" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="contains($entry,'www.wikidata.org/wiki/')">
                <xsl:variable name="kuerzel">
                    <xsl:choose>
                        <xsl:when test="ends-with($entry, '/')">
                            <xsl:value-of select="substring-after($entry, 'www.wikidata.org/wiki/')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat(substring-after($entry, 'www.wikidata.org/wiki/'), '/')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:value-of select="concat('https://www.wikidata.org/wiki/', $kuerzel)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>ERROR</xsl:text>
                <xsl:value-of select="$entry"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <xsl:function name="foo:gnd-normalize">
        <xsl:param name="entry" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="contains($entry,'/gnd/')">
                <xsl:variable name="kuerzel">
                    <xsl:choose>
                        <xsl:when test="ends-with($entry, '/')">
                            <xsl:value-of select="substring-after($entry, '/gnd/')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat(substring-after($entry, '/gnd/'), '/')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:value-of select="concat('https://d-nb.info/gnd/', $kuerzel)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>ERROR</xsl:text>
                <xsl:value-of select="$entry"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
   
   
    <xsl:template match="Items">
        <xsl:element name="Items">
            <xsl:for-each select="item[contains(URL/.,'geonames')]">
                <xsl:element name="item">
                    <xsl:element name="URL">
                        <xsl:attribute name="type">
                            <xsl:text>geonames</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="foo:geonames-normalize(URL)"/>
                    </xsl:element>
                    <xsl:element name="Entity_ID">
                        <xsl:value-of select="Entity_ID"/>
                    </xsl:element>
                    <xsl:element name="Entity">
                        <xsl:value-of select="Entity"/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="item[contains(URL/.,'wikidata')]">
                <xsl:element name="item">
                    <xsl:element name="URL">
                        <xsl:attribute name="type">
                            <xsl:text>wikidata</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="foo:wikidata-normalize(URL)"/>
                    </xsl:element>
                    <xsl:element name="Entity_ID">
                        <xsl:value-of select="Entity_ID"/>
                    </xsl:element>
                    <xsl:element name="Entity">
                        <xsl:value-of select="Entity"/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="item[contains(URL/.,'/gnd/')]">
                <xsl:element name="item">
                    <xsl:element name="URL">
                        <xsl:attribute name="type">
                            <xsl:text>gnd</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="foo:gnd-normalize(URL)"/>
                    </xsl:element>
                    <xsl:element name="Entity_ID">
                        <xsl:value-of select="Entity_ID"/>
                    </xsl:element>
                    <xsl:element name="Entity">
                        <xsl:value-of select="Entity"/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="item[contains(URL/.,'schnitzler-tagebuch.acdh')]">
                <xsl:element name="item">
                    <xsl:element name="URL">
                        <xsl:attribute name="type">
                            <xsl:text>schnitzler-tagebuch</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="URL"/>
                    </xsl:element>
                    <xsl:element name="Entity_ID">
                        <xsl:value-of select="Entity_ID"/>
                    </xsl:element>
                    <xsl:element name="Entity">
                        <xsl:value-of select="Entity"/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="item[starts-with(URL/.,'https://schnitzler-briefe.acdh.oeaw.ac.at/')]">
                <xsl:element name="item">
                    <xsl:element name="URL">
                        <xsl:attribute name="type">
                            <xsl:text>schnitzler-briefe</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="URL"/>
                    </xsl:element>
                    <xsl:element name="Entity_ID">
                        <xsl:value-of select="Entity_ID"/>
                    </xsl:element>
                    <xsl:element name="Entity">
                        <xsl:value-of select="Entity"/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            
            <xsl:for-each select="item[starts-with(URL/.,'https://bahrschnitzler.acdh.oeaw.ac.at/')]">
                <xsl:element name="item">
                    <xsl:element name="URL">
                        <xsl:attribute name="type">
                            <xsl:text>bahrschnitzler</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="URL"/>
                    </xsl:element>
                    <xsl:element name="Entity_ID">
                        <xsl:value-of select="Entity_ID"/>
                    </xsl:element>
                    <xsl:element name="Entity">
                        <xsl:value-of select="Entity"/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="item[starts-with(URL/.,'https://schnitzler-lektueren')]">
                <xsl:element name="item">
                    <xsl:element name="URL">
                        <xsl:attribute name="type">
                            <xsl:text>schnitzler-lektueren</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="URL"/>
                    </xsl:element>
                    <xsl:element name="Entity_ID">
                        <xsl:value-of select="Entity_ID"/>
                    </xsl:element>
                    <xsl:element name="Entity">
                        <xsl:value-of select="Entity"/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="item[starts-with(URL/.,'https://pmb.')]">
                <xsl:element name="item">
                    <xsl:element name="URL">
                        <xsl:attribute name="type">
                            <xsl:text>pmb</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="URL"/>
                    </xsl:element>
                    <xsl:element name="Entity_ID">
                        <xsl:value-of select="Entity_ID"/>
                    </xsl:element>
                    <xsl:element name="Entity">
                        <xsl:value-of select="Entity"/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
