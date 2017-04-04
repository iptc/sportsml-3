<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:newsml="http://iptc.org/std/nar/2006-10-01/" version="1.0"
>

	<xsl:output method="xml" indent="yes"/>

        <xsl:variable name="sport-key">
                       <xsl:choose>
                            <xsl:when test="newsml:sports-content">
                            <xsl:value-of select="substring-after(newsml:sports-content/newsml:sports-metadata/newsml:sports-content-codes/newsml:sports-content-code[@code-type='spct:sport']/@code-key,':')"/>
							</xsl:when>
                            <xsl:when test="newsml:newsItem">
                            <xsl:value-of select="substring-after(newsml:newsItem/newsml:contentMeta/newsml:subject[newsml:broader/@qcode='subj:15000000']/@qcode,':')"/>
							</xsl:when>
                            <xsl:otherwise>unknown</xsl:otherwise>
                        </xsl:choose>
	    </xsl:variable>

        <xsl:variable name="sport-name-code">
                       <xsl:choose>
                            <xsl:when test="$sport-key = '15003000'">american-football</xsl:when>
                            <xsl:when test="$sport-key = '15054000'">soccer</xsl:when>
                            <xsl:when test="$sport-key = '15017000'">cricket</xsl:when>
                            <xsl:when test="$sport-key = '15049000'">rugby</xsl:when>
                            <xsl:when test="$sport-key = '15048000'">rugby</xsl:when>
                            <xsl:when test="$sport-key = '15031000'">ice-hockey</xsl:when>
                            <xsl:when test="$sport-key = '15007000'">baseball</xsl:when>
                            <xsl:when test="$sport-key = '15008000'">basketball</xsl:when>
                            <xsl:when test="$sport-key = '15018000'">curling</xsl:when>
                            <xsl:when test="$sport-key = '15027000'">golf</xsl:when>
                            <xsl:otherwise>unknown</xsl:otherwise>
                        </xsl:choose>
	    </xsl:variable>
        <xsl:variable name="sport-name-short">
                       <xsl:choose>
                            <xsl:when test="$sport-key = '15003000'">amf</xsl:when>
                            <xsl:when test="$sport-key = '15054000'">soc</xsl:when>
                            <xsl:when test="$sport-key = '15017000'">cri</xsl:when>
                            <xsl:when test="$sport-key = '15049000'">rgx</xsl:when>
                            <xsl:when test="$sport-key = '15048000'">rgx</xsl:when>
                            <xsl:when test="$sport-key = '15031000'">ich</xsl:when>
                            <xsl:when test="$sport-key = '15007000'">bbl</xsl:when>
                            <xsl:when test="$sport-key = '15008000'">bkb</xsl:when>
                            <xsl:when test="$sport-key = '15018000'">cur</xsl:when>
                            <xsl:when test="$sport-key = '15027000'">gol</xsl:when>
                            <xsl:otherwise>unknown</xsl:otherwise>
                        </xsl:choose>
	    </xsl:variable>

        <xsl:variable name="publisher-code">
                       <xsl:choose>
                            <xsl:when test="newsml:sports-content">
                            <xsl:value-of select="substring-after(newsml:sports-content/newsml:sports-metadata/newsml:sports-content-codes/newsml:sports-content-code[@code-type='spct:publisher']/@code-key,':')"/>
							</xsl:when>
                            <xsl:when test="newsml:newsItem">
                            <xsl:value-of select="substring-after(newsml:newsItem/newsml:contentMeta/newsml:creator/@qcode,':')"/>
							</xsl:when>
                            <xsl:otherwise>unknown</xsl:otherwise>
                        </xsl:choose>
	    </xsl:variable>
    
        
        <!-- change to local path to schema files -->
	    <xsl:variable name="schema-core">PATH_TO_SCHEMA/3.0/specification/sportsml.xsd</xsl:variable>
	    <xsl:variable name="schema-specific">
	        <xsl:value-of select="concat('PATH_TO_SCHEMA/3.0/specification/sportsml-specific-',$sport-name-code,'.xsd')"/>
	    </xsl:variable>


	<!-- pass all elements through -->
	<xsl:template match="*" xmlns="http://iptc.org/std/nar/2006-10-01/">
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

	<!-- pass all values through -->
	<xsl:template match="text()">
		<xsl:if test="normalize-space()">
			<xsl:value-of select="."/>
		</xsl:if>
	</xsl:template>

    <xsl:template match="newsml:team-stats">
    <team-stats xmlns="http://iptc.org/std/nar/2006-10-01/">
        <xsl:for-each select="newsml:outcome-totals">
        <outcome-totals>
        <xsl:apply-templates select="@* | node()"/>
        </outcome-totals>
        </xsl:for-each>
        <xsl:for-each select="newsml:award[not(@award-type='league-championship-winner' or @award-type='relegation' or @award-type='league-championship-runner-up' or @award-type='title-qualification' or @award-type='playoff-qualifier' or @award-type='playoff-relegation')]">
            <award award-type="{concat('vendor:',@award-type)}">
                <name><xsl:value-of select="@name"/></name>
            </award>
        </xsl:for-each>
        <xsl:if test="not(ancestor::newsml:standing)">
    <stats>
    	<xsl:if test="@date-coverage-type">
        	<xsl:attribute name="temporal-unit-type">
        	        <xsl:choose>
            <xsl:when test="@date-coverage-type='season'">sptemporalunit:season</xsl:when>
            <xsl:when test="@date-coverage-type='event'">sptemporalunit:single-event</xsl:when>
            <xsl:when test="@date-coverage-type='season-regular'">sptemporalunit:season-regular</xsl:when>
            <xsl:when test="@date-coverage-type='season-exhibition'">sptemporalunit:pre-season</xsl:when>
            <xsl:otherwise>
			</xsl:otherwise>
        </xsl:choose>
			</xsl:attribute>
       	</xsl:if>
    	<xsl:if test="@team-coverage">
        	<xsl:attribute name="team">
        	<xsl:choose>
            <xsl:when test="@team-coverage='single-team'"><xsl:value-of select="concat('spteam:',ancestor::newsml:team/newsml:team-metadata/@key)"/></xsl:when>
            <xsl:otherwise>
			</xsl:otherwise>
        	</xsl:choose>
			</xsl:attribute>
       	</xsl:if>
       	<xsl:for-each select="./@*[not(contains(name(),'coverage'))][not(name()='scoping-label')]">
        	<xsl:variable name="stat-name">
        <xsl:call-template name="stat-name">
            <xsl:with-param name="stat-name" select="name()"/>
        </xsl:call-template>
			</xsl:variable>
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    ><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:when>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spstat</xsl:when>
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
        	<xsl:variable name="stat-name">
        <xsl:call-template name="stat-name">
            <xsl:with-param name="stat-name" select="name()"/>
        </xsl:call-template>
			</xsl:variable>
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    ><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:when>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spstat</xsl:when>
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
        	<xsl:variable name="stat-name">
        <xsl:call-template name="stat-name">
            <xsl:with-param name="stat-name" select="name()"/>
        </xsl:call-template>
			</xsl:variable>
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    ><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:when>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spstat</xsl:when>
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
            <xsl:when test="contains($name,'offensive')">spct:offense</xsl:when>
            <xsl:when test="contains($name,'defensive')">spct:defense</xsl:when>
            <xsl:when test="contains($name,'foul')">spct:infraction</xsl:when>
            <xsl:when test="contains($name,'scoring')">spct:scoring</xsl:when>
            <xsl:when test="contains($name,'special-teams')">spct:special-teams</xsl:when>
            <xsl:when test="contains($name,'passing')">spct:passing</xsl:when>
            <xsl:when test="contains($name,'rushing')">spct:rushing</xsl:when>
            <xsl:when test="contains($name,'down-progress')">spct:down-progress</xsl:when>
            <xsl:when test="contains($name,'sacks-against')">spct:sacks-against</xsl:when>
            <xsl:when test="contains($name,'fumbles')">spct:fumbles</xsl:when>
            <xsl:when test="contains($name,'penalties')">spct:penalty</xsl:when>
            <xsl:when test="contains($name,'pitching')">spct:pitching</xsl:when>
            <xsl:when test="contains($name,'faceoffs')">spct:faceoff</xsl:when>
            <xsl:when test="contains($name,'time-on-ice')">spct:time-on-ice</xsl:when>
            <xsl:when test="contains($name,'rebounding')">spct:rebounding</xsl:when>
            <xsl:otherwise></xsl:otherwise>
        	</xsl:choose>
			</xsl:attribute>
        	    <xsl:attribute name="stat-type"><xsl:value-of select="concat($stat-prefix,':',$stat-name)"/></xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        	</stat>
    	</xsl:for-each>

    	        	<xsl:for-each select="*">
        	<xsl:variable name="sub-name" select="name(.)"/>
        	<xsl:choose>
            <xsl:when test="$sub-name='stats-american-football-field-goals'">


        	<stat>
        	<xsl:if test="@maximum-distance">
        			<xsl:attribute name="distance-maximum"><xsl:value-of select="@maximum-distance"/></xsl:attribute>
        	</xsl:if>
        	<xsl:if test="@minimum-distance">
        			<xsl:attribute name="distance-minimum"><xsl:value-of select="@minimum-distance"/></xsl:attribute>
        	</xsl:if>
        	<xsl:attribute name="class">spct:scoring</xsl:attribute>
        	    <xsl:attribute name="stat-type">spamfstat:field-goal-attempts</xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="@attempts"/></xsl:attribute>
        	<xsl:attribute name="measurement-units">yards</xsl:attribute>
        	</stat>

        	<stat>
        	<xsl:if test="@maximum-distance">
        			<xsl:attribute name="distance-maximum"><xsl:value-of select="@maximum-distance"/></xsl:attribute>
        	</xsl:if>
        	<xsl:if test="@minimum-distance">
        			<xsl:attribute name="distance-minimum"><xsl:value-of select="@minimum-distance"/></xsl:attribute>
        	</xsl:if>
        	<xsl:attribute name="class">spct:scoring</xsl:attribute>
        	    <xsl:attribute name="stat-type">spamfstat:field-goals-made</xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="@made"/></xsl:attribute>
        	<xsl:attribute name="measurement-units">yards</xsl:attribute>
        	</stat>


            </xsl:when>
            <xsl:otherwise>
        	
        	<xsl:for-each select="./@*[not(contains(name(),'coverage'))][not(name()='scoping-label')]">
        	<xsl:variable name="stat-name">
        <xsl:call-template name="stat-name">
            <xsl:with-param name="stat-name" select="name()"/>
        </xsl:call-template>
			</xsl:variable>
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    ><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:when>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spstat</xsl:when>
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
            <xsl:when test="contains($sub-name,'field-goals')">spct:scoring</xsl:when>
            <xsl:when test="contains($sub-name,'passing')">spct:passing</xsl:when>
            <xsl:when test="contains($sub-name,'rushing')">spct:rushing</xsl:when>
            <xsl:when test="contains($sub-name,'down-progress')">spct:down-progress</xsl:when>
            <xsl:when test="contains($sub-name,'sacks-against')">spct:sacks-against</xsl:when>
            <xsl:otherwise>
			</xsl:otherwise>
        	</xsl:choose>
			</xsl:attribute>
        	    <xsl:attribute name="stat-type"><xsl:value-of select="concat($stat-prefix,':',$stat-name)"/></xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        	</stat>
    	</xsl:for-each>
            </xsl:otherwise>
            </xsl:choose>
	    	</xsl:for-each>

	    	</xsl:for-each>

	    	</xsl:for-each>
    </stats>
       	</xsl:if>
        <xsl:for-each select="newsml:sub-score">
       	<sub-score period-value="{@period-value}" score="{@score}"/>
    	</xsl:for-each>
        <xsl:for-each select="newsml:rank">
            <rank>
            	<xsl:if test="@type">
        	    <xsl:attribute name="type"><xsl:value-of select="concat('vendor:',@type)"/></xsl:attribute>
		       	</xsl:if>
        	    <xsl:attribute name="value"><xsl:value-of select="@value"/></xsl:attribute>
            </rank>
        </xsl:for-each>
    </team-stats>
    </xsl:template>
    
    <!-- where attribute names differ between 2.2 and 3.0 -->
        <xsl:template name="stat-name">
        <xsl:param name="stat-name"/>
        	<xsl:choose>
            <xsl:when test="$stat-name = 'tackles' and parent::newsml:stats-american-football-offensive">tackles-offense</xsl:when>
            <xsl:when test="$stat-name = 'tackles-assists' and parent::newsml:stats-american-football-offensive">tackles-assists-offense</xsl:when>
            <xsl:when test="$stat-name = 'tackles' and parent::newsml:stats-american-football-special-teams">tackles-special-teams</xsl:when>
            <xsl:when test="$stat-name = 'tackles-assists' and parent::newsml:stats-american-football-special-teams">tackles-assists-special-teams</xsl:when>
            <xsl:otherwise><xsl:value-of select="$stat-name"/></xsl:otherwise>
        	</xsl:choose>
	    </xsl:template>


    <xsl:template match="newsml:player-stats" xmlns="http://iptc.org/std/nar/2006-10-01/">
    <player-stats>
    <stats>
    	<xsl:if test="@date-coverage-type">
    	    <xsl:attribute name="temporal-unit-type">
        	        <xsl:choose>
            <xsl:when test="@date-coverage-type='season'">sptemporalunit:season</xsl:when>
            <xsl:when test="@date-coverage-type='event'">sptemporalunit:single-event</xsl:when>
            <xsl:when test="@date-coverage-type='period'">sptemporalunit:period</xsl:when>
            <xsl:otherwise>
			</xsl:otherwise>
        </xsl:choose>
			</xsl:attribute>
       	</xsl:if>
    	<xsl:if test="@team-coverage">
        	<xsl:attribute name="team">
        	<xsl:choose>
            <xsl:when test="@team-coverage='single-team'"><xsl:value-of select="concat('spteam:',ancestor::newsml:team/newsml:team-metadata/@key)"/></xsl:when>
            <xsl:otherwise>
			</xsl:otherwise>
        	</xsl:choose>
			</xsl:attribute>
       	</xsl:if>
       	<xsl:for-each select="./@*[not(contains(name(),'coverage'))][not(name()='scoping-label')]">
        	<xsl:variable name="stat-name">
        <xsl:call-template name="stat-name">
            <xsl:with-param name="stat-name" select="name()"/>
        </xsl:call-template>
			</xsl:variable>
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    >
                    <xsl:value-of select="concat('sp',$sport-name-short,'stat')"/>
                </xsl:when>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spstat</xsl:when>
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
        	<xsl:variable name="stat-name">
        <xsl:call-template name="stat-name">
            <xsl:with-param name="stat-name" select="name()"/>
        </xsl:call-template>
			</xsl:variable>
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    ><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:when>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spstat</xsl:when>
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
        	<xsl:variable name="stat-name">
        <xsl:call-template name="stat-name">
            <xsl:with-param name="stat-name" select="name()"/>
        </xsl:call-template>
			</xsl:variable>
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    ><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:when>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spstat</xsl:when>
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
            <xsl:when test="contains($name,'offensive')">spct:offense</xsl:when>
            <xsl:when test="contains($name,'defensive')">spct:defense</xsl:when>
            <xsl:when test="contains($name,'foul')">spct:infraction</xsl:when>
            <xsl:when test="contains($name,'scoring')">spct:scoring</xsl:when>
            <xsl:when test="contains($name,'special-teams')">spct:special-teams</xsl:when>
            <xsl:when test="contains($name,'fumbles')">spct:fumble</xsl:when>
            <xsl:when test="contains($name,'penalties')">spct:infraction</xsl:when>
            <xsl:when test="contains($name,'pitching')">spct:pitching</xsl:when>
            <xsl:when test="contains($name,'faceoffs')">spct:faceoff</xsl:when>
            <xsl:when test="contains($name,'time-on-ice')">spct:time-on-ice</xsl:when>
            <xsl:when test="contains($name,'rebounding')">spct:rebounding</xsl:when>
            <xsl:otherwise>
			</xsl:otherwise>
        	</xsl:choose>
			</xsl:attribute>
        	    <xsl:attribute name="stat-type"><xsl:value-of select="concat($stat-prefix,':',$stat-name)"/></xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        	</stat>
    	</xsl:for-each>

    	        	<xsl:for-each select="*">
        	<xsl:variable name="sub-name" select="name(.)"/>
        	<xsl:choose>
            <xsl:when test="$sub-name='stats-american-football-field-goals'">


        	<stat>
        	<xsl:if test="@maximum-distance">
        			<xsl:attribute name="distance-maximum"><xsl:value-of select="@maximum-distance"/></xsl:attribute>
        	</xsl:if>
        	<xsl:if test="@minimum-distance">
        			<xsl:attribute name="distance-minimum"><xsl:value-of select="@minimum-distance"/></xsl:attribute>
        	</xsl:if>
        	<xsl:attribute name="class">spct:scoring</xsl:attribute>
        	    <xsl:attribute name="stat-type">spamfstat:field-goal-attempts</xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="@attempts"/></xsl:attribute>
        	<xsl:attribute name="measurement-units">yards</xsl:attribute>
        	</stat>

        	<stat>
        	<xsl:if test="@maximum-distance">
        			<xsl:attribute name="distance-maximum"><xsl:value-of select="@maximum-distance"/></xsl:attribute>
        	</xsl:if>
        	<xsl:if test="@minimum-distance">
        			<xsl:attribute name="distance-minimum"><xsl:value-of select="@minimum-distance"/></xsl:attribute>
        	</xsl:if>
        	<xsl:attribute name="class">spct:scoring</xsl:attribute>
        	    <xsl:attribute name="stat-type">spamfstat:field-goals-made</xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="@made"/></xsl:attribute>
        	<xsl:attribute name="measurement-units">yards</xsl:attribute>
        	</stat>


            </xsl:when>
            <xsl:otherwise>
        	
        	<xsl:for-each select="./@*[not(contains(name(),'coverage'))][not(name()='scoping-label')]">
        	<xsl:variable name="stat-name">
        <xsl:call-template name="stat-name">
            <xsl:with-param name="stat-name" select="name()"/>
        </xsl:call-template>
			</xsl:variable>
       	<xsl:variable name="stat-prefix">
            <xsl:choose>
                <xsl:when test="document($schema-specific)//xs:attribute[@name=$stat-name]"
                    ><xsl:value-of select="concat('sp',$sport-name-short,'stat')"/></xsl:when>
                <xsl:when test="document($schema-core)//xs:attribute[@name=$stat-name]"
                    >spstat</xsl:when>
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
            <xsl:when test="contains($sub-name,'field-goals')">spct:scoring</xsl:when>
            <xsl:when test="contains($sub-name,'passing')">spct:passing</xsl:when>
            <xsl:when test="contains($sub-name,'rushing')">spct:rushing</xsl:when>
            <xsl:when test="contains($sub-name,'down-progress')">spct:down-progress</xsl:when>
            <xsl:when test="contains($sub-name,'sacks-against')">spct:sacks-against</xsl:when>
            <xsl:otherwise>
			</xsl:otherwise>
        	</xsl:choose>
			</xsl:attribute>
        	    <xsl:attribute name="stat-type"><xsl:value-of select="concat($stat-prefix,':',$stat-name)"/></xsl:attribute>
        	    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        	</stat>
    	</xsl:for-each>
            </xsl:otherwise>
            </xsl:choose>
	    	</xsl:for-each>

	    	</xsl:for-each>


	    	</xsl:for-each>
   	</stats>
   	</player-stats>
    </xsl:template>

</xsl:stylesheet>
