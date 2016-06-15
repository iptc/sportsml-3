<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xts="http://www.xmlteam.com"
    xmlns:sportsml="http://iptc.org/std/nar/2006-10-01/" xmlns:bbc="http://www.bbc.co.uk/sport/sports-data" version="1.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="sport-name">
            <xsl:choose>
                <xsl:when test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='spct:sport']/@code-key='sport:15054000'">soccer</xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
    </xsl:variable>

    <!-- passes an xml thru xsl with no significant changes -->

    <!-- fix the comment -->
    <xsl:template match="commment">
        <xsl:value-of select="."/>
    </xsl:template>

    <!-- pass all elements through -->
    <xsl:template match="*">
        <xsl:element name="{name()}">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <!-- pass all attributes through -->
    <xsl:template match="@*">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <!-- pass all content through -->
    <xsl:template match="text()">
        <xsl:if test="normalize-space()">
            <xsl:value-of select="."/>
        </xsl:if>
    </xsl:template>

    <!-- add namespace and remove @path-id -->
    <xsl:template match="sportsml:stats">
            <xsl:choose>
                <xsl:when test="parent::sportsml:team-stats">
                <xsl:if test="sportsml:stat[not(@class)]">
        	<xsl:for-each select="sportsml:stat[@class='spct:general'] | sportsml:stat[not(@class)]">
        <xsl:attribute name="{substring-after(@stat-type,':')}">
        <xsl:call-template name="att-values">
            <xsl:with-param name="att-value" select="@value"/>
            <xsl:with-param name="type-value" select="substring-after(@stat-type,':')"/>
        </xsl:call-template>
        </xsl:attribute>
        	</xsl:for-each>
        		</xsl:if>

                <xsl:if test="sportsml:stat[@class='spct:offense']">
        <xsl:element name="{concat('stats-',$sport-name,'-offensive')}">
        	<xsl:for-each select="sportsml:stat[@class='spct:offense']">
        <xsl:attribute name="{substring-after(@stat-type,':')}">
            <xsl:value-of select="@value"/>
        </xsl:attribute>
        	</xsl:for-each>
        </xsl:element>
        		</xsl:if>

                	
                </xsl:when>
                <xsl:when test="parent::sportsml:player-stats">
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
    

    </xsl:template>

	<xsl:template name="att-values">
        <xsl:param name="type-value"/>
        <xsl:param name="att-value"/>
            <xsl:choose>
                <xsl:when test="number($att-value)">
					<xsl:value-of select="$att-value"/>
                </xsl:when>
                <xsl:otherwise>
                <xsl:variable name="cv-alias">
        <xsl:call-template name="cv-alias">
            <xsl:with-param name="type-value" select="$type-value"/>
        </xsl:call-template>
    </xsl:variable>

					<xsl:value-of select="concat($cv-alias,':',$att-value)"/>
                </xsl:otherwise>
            </xsl:choose>

	</xsl:template>

	<xsl:template name="cv-alias">
        <xsl:param name="type-value"/>
            <xsl:choose>
                <xsl:when test="$type-value='event-outcome'">speventoutcome</xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
	</xsl:template>

</xsl:stylesheet>
