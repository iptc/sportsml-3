<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xts="http://www.xmlteam.com" xmlns:nitf="http://iptc.org/std/NITF/2006-10-18/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:bbc="http://www.bbc.co.uk/sport/sports-data"
    xmlns:sportsml="http://iptc.org/std/SportsML/2008-04-01/" version="1.0">

  <xsl:include href="2.2-to-3.0-includes/common.xsl"/>

    <!-- In this template we put the NewsML G2 metadata wrapper around the SportsML and then hand off to the templates that operate on the inline SportsML. The files are converted into a NewsML-G2 "newsItem" comprising item metadata (itemMeta), content metadata (contentMeta) and the content itself (the SportsML as child of contentSet/inlineXML). -->

    <!-- Begin the auto-generation process -->
    <xsl:template match="/">
                <xsl:apply-templates/>
    </xsl:template>

    <!-- the following templates operate on the inlineXML (SportsML). Most of the markup is passed through intact except for a few cses where modifications are needed for NAR compliance. These are: key values, datestamps, and names, as explained below. -->
    <xsl:template match="sportsml:sports-content">
                    <sports-content xmlns="http://iptc.org/std/nar/2006-10-01/">
                        <xsl:attribute name="xsi:schemaLocation">
                            <xsl:value-of
                                select="concat('http://iptc.org/std/nar/2006-10-01/',' ',$SportsML-schemaLocation)"
                            />
                        </xsl:attribute>
                                <xsl:apply-templates/>
                    </sports-content>
    </xsl:template>

    <!-- pass all remaining elements through -->
    <xsl:template match="*">
        <xsl:element xmlns="http://iptc.org/std/nar/2006-10-01/" name="{name()}">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="@date-coverage-type[parent::sportsml:player-stats]">
        <xsl:attribute name="temporal-unit-type"><xsl:value-of select="concat('spct:',.)"/></xsl:attribute>
    </xsl:template>

</xsl:stylesheet>
