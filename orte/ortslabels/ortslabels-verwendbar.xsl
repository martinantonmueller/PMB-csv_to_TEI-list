<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:foo="whatever" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    version="3.0">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:strip-space elements="*"/>
  <!-- Hier mache ich aus dem CSV->XSLX-Import der ortstypen eine Fassung, die ich für listplace als Typen verwenden kann. -->
   
   
        
    
  
    <xsl:template match="LABEL|pmb-type">
        <xsl:element name="pmb-type">
            <xsl:value-of select="."/>
        </xsl:element>
        <xsl:element name="label-type">
        <xsl:choose>
            <xsl:when test="contains(., ' (')">
                <xsl:value-of select="normalize-space(substring-before(., ' ('))"/>
            </xsl:when>
            <xsl:when test="contains(., 'geonames.org/ontology')">
                <xsl:choose>
                    <xsl:when test="ends-with(., '#P.PPLC')">
                        <xsl:text>Hauptstadt</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.ADM4')">
                        <xsl:text>Gemeinde</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.PCLI')">
                        <xsl:text>Land</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#P.PPLA')">
                        <xsl:text>Land</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#P.PPL')">
                        <xsl:text>Besiedelter Ort</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.ADM3')">
                        <xsl:text>Ort</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#P.PPLA3')">
                        <xsl:text>Besiedelter Ort</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#P.PPLA2')">
                        <xsl:text>Besiedelter Ort</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.ADM2')">
                        <xsl:text>Region</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.ADM1')">
                        <xsl:text>Region</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#T.VAL')">
                        <xsl:text>Tal</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#P.PPLA4')">
                        <xsl:text>Besiedelter Ort</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#P.PPLX')">
                        <xsl:text>Ortsteil</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#S.UNIV')">
                        <xsl:text>Hochschule</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#L.RGNE')">
                        <xsl:text>Region</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.PCLD')">
                        <xsl:text>Gegend</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#L.RGN')">
                        <xsl:text>Landschaft</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.ADM3H')">
                        <xsl:text>Ehemaliger Ort</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.PCLH')">
                        <xsl:text>Ehemaliges Land</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.ADMD')">
                        <xsl:text>Gegend</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#P.PPLA3')">
                        <xsl:text>Besiedelter Ort</xsl:text>
                    </xsl:when>
                    
                    <xsl:when test="ends-with(., '#A.ADM3')">
                        <xsl:text>A.ADM3</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.ADM2')">
                        <xsl:text>A.ADM2</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.PCLS')">
                        <xsl:text>Ort</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#P.PPLA4')">
                        <xsl:text>P.PPLA4</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.ADM1')">
                        <xsl:text>A.ADM1</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.ADMD')">
                        <xsl:text>A.ADMD</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#P.PPLX')">
                        <xsl:text>P.PPLX</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#T.VAL')">
                        <xsl:text>T.VAL</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.PCLD')">
                        <xsl:text>A.PCLD</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#L.RGN')">
                        <xsl:text>L.RGN</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#S.ANS')">
                        <xsl:text>Archäologische Ausgrabungsstätte</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#L.CONT')">
                        <xsl:text>Kontinent</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.ADM4H')">
                        <xsl:text>Ehemaliger Ort</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#S.MSTY')">
                        <xsl:text>Kloster</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#T.ISL')">
                        <xsl:text>Insel</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#H.STM')">
                        <xsl:text>Fluss</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#S.HSE')">
                        <xsl:text>Gebäude</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.ADM4')">
                        <xsl:text>A.ADM4</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#S.CSTL')">
                        <xsl:text>Schloss</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.PCL')">
                        <xsl:text>Ort</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#S.FRM')">
                        <xsl:text>Bauernhof</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#T.ISLS')">
                        <xsl:text>Inseln</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#T.VLC')">
                        <xsl:text>Vulkan</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.PCLIX')">
                        <xsl:text>Ortsteil</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#T.CAPE')">
                        <xsl:text>Kapp</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#H.LK')">
                        <xsl:text>See</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#T.MTS')">
                        <xsl:text>Berge</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#T.PK')">
                        <xsl:text>Berggipfel</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#T.MT')">
                        <xsl:text>Berg</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#H.OCN')">
                        <xsl:text>Ozean</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#A.TERR')">
                        <xsl:text>Territorium</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#L.RGNH')">
                        <xsl:text>Ehemalige Region</xsl:text>
                    </xsl:when>
                    <xsl:when test="ends-with(., '#S.RUIN')">
                        <xsl:text>Ruine</xsl:text>
                    </xsl:when>
                    
                    <xsl:otherwise>
                        <xsl:value-of select="substring-after(., 'geonames.org/ontology')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="label-type"/>
    
</xsl:stylesheet>
