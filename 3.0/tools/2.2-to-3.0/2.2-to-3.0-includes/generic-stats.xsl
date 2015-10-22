<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xts="http://www.xmlteam.com" xmlns:nitf="http://iptc.org/std/NITF/2006-10-18/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:bbc="http://www.bbc.co.uk/sport/sports-data"
    xmlns:sportsml="http://iptc.org/std/SportsML/2008-04-01/" version="1.0">

    <xsl:template match="sportsml:player-stats">
    <player-stats xmlns="http://iptc.org/std/nar/2006-10-01/">
    <stats>
    	<xsl:if test="@date-coverage-type">
    	    <xsl:attribute name="temporal-unit-type">
        	        <xsl:choose>
            <xsl:when test="@date-coverage-type='event'">sptunit:single-event</xsl:when>
            <xsl:when test="@date-coverage-type='period'">sptunit:period</xsl:when>
            <xsl:otherwise>
			</xsl:otherwise>
        </xsl:choose>
			</xsl:attribute>
       	</xsl:if>
    	<xsl:if test="@team-coverage">
        	<xsl:attribute name="team">
        	<xsl:choose>
            <xsl:when test="@team-coverage='single-team'"><xsl:value-of select="concat('spteam:',ancestor::sportsml:team/sportsml:team-metadata/@team-key)"/></xsl:when>
            <xsl:otherwise>
			</xsl:otherwise>
        	</xsl:choose>
			</xsl:attribute>
       	</xsl:if>
       	<xsl:for-each select="./@*[not(contains(name(),'coverage'))][not(name()='scoping-label')]">
       	<xsl:variable name="stat-name" select="name()"/>       	
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spcorstat</xsl:when>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    >
                    <xsl:value-of select="concat('sp',$sport-name-short,'stat')"/>
                </xsl:when>
                <xsl:otherwise>none</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        	<stat>
        	    <xsl:attribute name="stat-type"><xsl:value-of select="concat($stat-prefix,':',$stat-name)"/></xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        	</stat>
    	</xsl:for-each>
        	<xsl:for-each select="*">
        	<xsl:for-each select="./@*[not(contains(name(),'coverage'))][not(name()='scoping-label')]">
       	<xsl:variable name="stat-name" select="name()"/>       	
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spcorstat</xsl:when>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    ><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        	<stat>
        	    <xsl:attribute name="stat-type"><xsl:value-of select="concat($stat-prefix,':',$stat-name)"/></xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        	</stat>
        	


    	</xsl:for-each>

        	<xsl:for-each select="*">
        	<xsl:variable name="name" select="name(.)"/>
        	<xsl:for-each select="./@*[not(contains(name(),'coverage'))][not(name()='scoping-label')]">
       	<xsl:variable name="stat-name" select="name()"/>       	
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spcorstat</xsl:when>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    ><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        	<stat>
        	<xsl:if test="../@scoping-label">
            <xsl:choose>
                <xsl:when test="substring-before(../@scoping-label,':')='strength'">
        			<xsl:attribute name="situation"><xsl:value-of 	select="concat($publisher-code,../@scoping-label)"/></xsl:attribute>
                </xsl:when>
                <xsl:when test="substring-before(../@scoping-label,':')='period'">
        			<xsl:attribute name="temporal-unit-value"><xsl:value-of 	select="concat($publisher-code,../@scoping-label)"/></xsl:attribute>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        	</xsl:if>
        	<xsl:attribute name="class">
        	<xsl:choose>
            <xsl:when test="contains($name,'offensive')">spstatclass:offensive</xsl:when>
            <xsl:when test="contains($name,'defensive')">spstatclass:defensive</xsl:when>
            <xsl:when test="contains($name,'foul')">spstatclass:foul</xsl:when>
            <xsl:when test="contains($name,'scoring')">spstatclass:scoring</xsl:when>
            <xsl:when test="contains($name,'special-teams')">spstatclass:special-teams</xsl:when>
            <xsl:when test="contains($name,'passing')">spstatclass:passing</xsl:when>
            <xsl:when test="contains($name,'rushing')">spstatclass:rushing</xsl:when>
            <xsl:when test="contains($name,'down-progress')">spstatclass:down-progress</xsl:when>
            <xsl:when test="contains($name,'sacks-against')">spstatclass:sacks-against</xsl:when>
            <xsl:when test="contains($name,'fumbles')">spstatclass:fumbles</xsl:when>
            <xsl:when test="contains($name,'penalties')">spstatclass:penalties</xsl:when>
            <xsl:when test="contains($name,'pitching')">spstatclass:pitching</xsl:when>
            <xsl:when test="contains($name,'faceoffs')">spstatclass:faceoffs</xsl:when>
            <xsl:when test="contains($name,'time-on-ice')">spstatclass:time-on-ice</xsl:when>
            <xsl:when test="contains($name,'rebounding')">spstatclass:rebounding</xsl:when>
            <xsl:otherwise>
			</xsl:otherwise>
        	</xsl:choose>
			</xsl:attribute>
        	    <xsl:attribute name="stat-type"><xsl:value-of select="concat($stat-prefix,':',$stat-name)"/></xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        	</stat>
    	</xsl:for-each>
	    	</xsl:for-each>

	    	</xsl:for-each>
   	</stats>
   	</player-stats>
    </xsl:template>

    <xsl:template match="sportsml:team-stats">
    <team-stats xmlns="http://iptc.org/std/nar/2006-10-01/">
        <xsl:for-each select="sportsml:outcome-totals">
        <outcome-totals>
        <xsl:apply-templates select="@* | node()"/>
        </outcome-totals>
        </xsl:for-each>
        <xsl:for-each select="sportsml:award[not(@award-type='league-championship-winner' or @award-type='relegation' or @award-type='league-championship-runner-up' or @award-type='title-qualification' or @award-type='playoff-qualifier' or @award-type='playoff-relegation')]">
            <award award-type="{concat('vendor:',@award-type)}">
                <name><xsl:value-of select="@name"/></name>
            </award>
        </xsl:for-each>
        <xsl:if test="not(ancestor::sportsml:standing)">
    <stats>
    	<xsl:if test="@date-coverage-type">
        	<xsl:attribute name="temporal-unit-type">
        	        <xsl:choose>
            <xsl:when test="@date-coverage-type='event'">sptunit:single-event</xsl:when>
            <xsl:when test="@date-coverage-type='season-regular'">sptunit:season-regular</xsl:when>
            <xsl:when test="@date-coverage-type='season-exhibition'">sptunit:pre-season</xsl:when>
            <xsl:otherwise>
			</xsl:otherwise>
        </xsl:choose>
			</xsl:attribute>
       	</xsl:if>
    	<xsl:if test="@team-coverage">
        	<xsl:attribute name="team">
        	<xsl:choose>
            <xsl:when test="@team-coverage='single-team'"><xsl:value-of select="concat('spteam:',ancestor::sportsml:team/sportsml:team-metadata/@team-key)"/></xsl:when>
            <xsl:otherwise>
			</xsl:otherwise>
        	</xsl:choose>
			</xsl:attribute>
       	</xsl:if>
       	<xsl:for-each select="./@*[not(contains(name(),'coverage'))][not(name()='scoping-label')]">
       	<xsl:variable name="stat-name" select="name()"/>       	
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spcorstat</xsl:when>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    ><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:when>
                <xsl:otherwise>none</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        	<stat>
        	    <xsl:attribute name="stat-type"><xsl:value-of select="concat($stat-prefix,':',$stat-name)"/></xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        	</stat>
    	</xsl:for-each>
        	<xsl:for-each select="*[contains(name(),'stats')][not(name()='scoping-label')]">
        	<xsl:for-each select="./@*[not(contains(name(),'coverage'))]">
       	<xsl:variable name="stat-name" select="name()"/>       	
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spcorstat</xsl:when>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    ><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:when>
                <xsl:otherwise>none</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        	<stat>
        	    <xsl:attribute name="stat-type"><xsl:value-of select="concat($stat-prefix,':',$stat-name)"/></xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        	</stat>
        	


    	</xsl:for-each>

        	<xsl:for-each select="*">
        	<xsl:variable name="name" select="name(.)"/>
        	<xsl:for-each select="./@*[not(contains(name(),'coverage'))][not(name()='scoping-label')]">
       	<xsl:variable name="stat-name" select="name()"/>       	
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spcorstat</xsl:when>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    ><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        	<stat>
        	<xsl:if test="../@scoping-label">
            <xsl:choose>
                <xsl:when test="substring-before(../@scoping-label,':')='strength'">
        			<xsl:attribute name="situation"><xsl:value-of 	select="concat($publisher-code,../@scoping-label)"/></xsl:attribute>
                </xsl:when>
                <xsl:when test="substring-before(../@scoping-label,':')='period'">
        			<xsl:attribute name="temporal-unit-value"><xsl:value-of 	select="concat($publisher-code,../@scoping-label)"/></xsl:attribute>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        	</xsl:if>
        	<xsl:attribute name="class">
        	<xsl:choose>
            <xsl:when test="contains($name,'offensive')">spstatclass:offensive</xsl:when>
            <xsl:when test="contains($name,'defensive')">spstatclass:defensive</xsl:when>
            <xsl:when test="contains($name,'foul')">spstatclass:foul</xsl:when>
            <xsl:when test="contains($name,'scoring')">spstatclass:scoring</xsl:when>
            <xsl:when test="contains($name,'special-teams')">spstatclass:special-teams</xsl:when>
            <xsl:when test="contains($name,'passing')">spstatclass:passing</xsl:when>
            <xsl:when test="contains($name,'rushing')">spstatclass:rushing</xsl:when>
            <xsl:when test="contains($name,'down-progress')">spstatclass:down-progress</xsl:when>
            <xsl:when test="contains($name,'sacks-against')">spstatclass:sacks-against</xsl:when>
            <xsl:when test="contains($name,'fumbles')">spstatclass:fumbles</xsl:when>
            <xsl:when test="contains($name,'penalties')">spstatclass:penalties</xsl:when>
            <xsl:when test="contains($name,'pitching')">spstatclass:pitching</xsl:when>
            <xsl:when test="contains($name,'faceoffs')">spstatclass:faceoffs</xsl:when>
            <xsl:when test="contains($name,'time-on-ice')">spstatclass:time-on-ice</xsl:when>
            <xsl:when test="contains($name,'rebounding')">spstatclass:rebounding</xsl:when>
            <xsl:otherwise></xsl:otherwise>
        	</xsl:choose>
			</xsl:attribute>
        	    <xsl:attribute name="stat-type"><xsl:value-of select="concat($stat-prefix,':',$stat-name)"/></xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        	</stat>
    	</xsl:for-each>
	    	</xsl:for-each>

	    	</xsl:for-each>
    </stats>
       	</xsl:if>
        <xsl:for-each select="sportsml:sub-score">
       	<sub-score period-value="{@period-value}" score="{@score}"/>
    	</xsl:for-each>
        <xsl:for-each select="sportsml:rank">
            <rank>
            	<xsl:if test="@type">
        	    <xsl:attribute name="type"><xsl:value-of select="concat('vendor:',@type)"/></xsl:attribute>
		       	</xsl:if>
        	    <xsl:attribute name="value"><xsl:value-of select="@value"/></xsl:attribute>
            </rank>
        </xsl:for-each>
    </team-stats>
    </xsl:template>

</xsl:stylesheet>
