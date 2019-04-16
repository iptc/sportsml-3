<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xts="http://www.xmlteam.com" xmlns:nitf="http://iptc.org/std/NITF/2006-10-18/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:bbc="http://www.bbc.co.uk/sport/sports-data"
    xmlns:sportsml="http://iptc.org/std/SportsML/2008-04-01/" version="1.0">

  <xsl:include href="2.2-to-3.0-includes/common.xsl"/>
  <xsl:include href="2.2-to-3.0-includes/generic-stats.xsl"/>
  <xsl:include href="2.2-to-3.0-includes/g2-structure.xsl"/>

    <!-- In this template we put the NewsML G2 metadata wrapper around the SportsML and then hand off to the templates that operate on the inline SportsML. The files are converted into a NewsML-G2 "newsItem" comprising item metadata (itemMeta), content metadata (contentMeta) and the content itself (the SportsML as child of contentSet/inlineXML). -->

    <!-- Begin the auto-generation process -->
    <xsl:template match="/">
    	<xsl:call-template name="g2-structure"/>
    </xsl:template>

    <!-- the following templates operate on the inlineXML (SportsML). Most of the markup is passed through intact except for a few cses where modifications are needed for NAR compliance. These are: key values, datestamps, and names, as explained below. -->
    <xsl:template match="sportsml:sports-content">
        <xsl:choose>
            <xsl:when test="sportsml:article">
                <inlineXML xmlns="http://iptc.org/std/nar/2006-10-01/">
                    <xsl:attribute name="contenttype">application/nitf+xml</xsl:attribute>
                    <nitf xmlns="http://iptc.org/std/NITF/2006-10-18/">
                        <xsl:attribute name="xsi:schemaLocation">
                            <xsl:value-of
                                select="concat('http://iptc.org/std/NITF/2006-10-18/',' ',$Nitf-schemaLocation)"
                            />
                        </xsl:attribute>
                        <xsl:apply-templates select="article/nitf:nitf/nitf:*"/>
                    </nitf>
                </inlineXML>
            </xsl:when>
            <xsl:otherwise>
                <inlineXML xmlns="http://iptc.org/std/nar/2006-10-01/">
                    <xsl:attribute name="contenttype">application/sportsml+xml</xsl:attribute>
                    <sports-content xmlns="http://iptc.org/std/nar/2006-10-01/">
                        <xsl:attribute name="xsi:schemaLocation">
                            <xsl:value-of
                                select="concat('http://iptc.org/std/nar/2006-10-01/',' ',$SportsML-schemaLocation)"
                            />
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="sportsml:sports-event">
                                <xsl:apply-templates select="sportsml:sports-event"/>
                            </xsl:when>
                            <xsl:when test="sportsml:sports-content/sportsml:schedule">
                                <xsl:apply-templates select="sportsml:schedule"/>
                            </xsl:when>
                            <xsl:when test="sportsml:statistic">
                                <xsl:apply-templates select="sportsml:statistic"/>
                            </xsl:when>
                            <xsl:when test="sportsml:standing">
                                <xsl:apply-templates select="sportsml:standing"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </sports-content>
                </inlineXML>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- pass all remaining elements through -->
    <xsl:template match="*">
        <xsl:element xmlns="http://iptc.org/std/nar/2006-10-01/" name="{name()}">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
