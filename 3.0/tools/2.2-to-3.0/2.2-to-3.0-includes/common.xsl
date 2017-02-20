<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xts="http://www.xmlteam.com" xmlns:nitf="http://iptc.org/std/NITF/2006-10-18/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:bbc="http://www.bbc.co.uk/sport/sports-data"
    xmlns:sportsml="http://iptc.org/std/SportsML/2008-04-01/" version="1.0">

    <!-- The following variables are set by the user -->
    
    <!-- Path on local system to sportsml.xsd -->
    <xsl:variable name="userSchemaPath"
        >/Users/paul/xmlteam/iptc/sportsml-dev/git-sportsml-3/3.0/specification/sportsml.xsd</xsl:variable>
    <!-- Path on local system to nitf schema -->
    <xsl:variable name="userNitfPath"
        >/Users/paul/xmlteam/iptc/specs/LATEST/NITF/3.4/specification/schema/nitf-3-4.xsd</xsl:variable>

    
    <xsl:variable name="SportsML-schemaLocation"
        ><xsl:value-of select="$userSchemaPath"/></xsl:variable>
    <xsl:variable name="Nitf-schemaLocation"
        ><xsl:value-of select="$userNitfPath"/></xsl:variable>
    <xsl:variable name="lang">en-US</xsl:variable>
    <xsl:variable name="slug-separator">-</xsl:variable>
        <xsl:variable name="sport-key"
            select="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='sport']/@code-key"/>
        <xsl:variable name="sport-name"
            select="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='sport']/@code-name"/>
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
    <xsl:variable name="schema-core">/Users/paul/xmlteam/iptc/sportsml-dev/git-sportsml-3/3.0/specification/sportsml.xsd</xsl:variable>
	    <xsl:variable name="schema-specific">

                                <xsl:choose>
                            <xsl:when
                                test="$sport-name-code = 'unknown'"
                                >
                                <xsl:value-of select="$SportsML-schemaLocation"/>
                                </xsl:when>
                            <xsl:otherwise>
                            <xsl:value-of select="concat('/Users/paul/xmlteam/iptc/sportsml-dev/git-sportsml-3/3.0/specification/sportsml-specific-',$sport-name-code,'.xsd')"/>
                            </xsl:otherwise>
                        </xsl:choose>

	    	
	    </xsl:variable>

        <xsl:variable name="publisher"
            select="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-key"/>
        <xsl:variable name="publisher-code">
        
                                <xsl:choose>
                            <xsl:when
                                test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-key = 'anyvendor'"
                                >anyvendor</xsl:when>
                            <xsl:otherwise>vend</xsl:otherwise>
                        </xsl:choose>
	    </xsl:variable>

        <xsl:variable name="doc-id" select="sportsml:sports-content/sportsml:sports-metadata/@doc-id"/>
        <xsl:variable name="league-key"
            select="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='league']/@code-key"/>
        <xsl:variable name="league-name"
            select="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='league']/@code-name"/>
        <xsl:variable name="pub-status">
            <xsl:choose>
                <xsl:when
                    test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='priority']/@code-key = 'high'"
                    >high</xsl:when>
                <xsl:otherwise>usable</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="fixture-key">
            <xsl:choose>
                <xsl:when test="string(sportsml:sports-content/sportsml:sports-metadata/@fixture-key)">
                    <xsl:value-of select="sportsml:sports-content/sportsml:sports-metadata/@fixture-key"/>
                </xsl:when>
                <xsl:otherwise>tbd</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="document-class">
            <xsl:choose>
                <xsl:when test="string(sportsml:sports-content/sportsml:sports-metadata/@document-class)">
                    <xsl:value-of select="sportsml:sports-content/sportsml:sports-metadata/@document-class"/>
                </xsl:when>
                <xsl:otherwise>tbd</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>


    <!-- add "full" attribute to name in addition to "first" and "last". The latter two are not NAR compliant and will likely be namespaced in future -->
    <xsl:template match="sportsml:name">
        <xsl:choose>
            <xsl:when test="parent::sportsml:player-metadata">
                <xsl:element xmlns="http://iptc.org/std/nar/2006-10-01/" name="{name()}">
                    <xsl:attribute name="role">nrol:full</xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="@full">
                            <xsl:value-of select="@full"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@first"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="@last"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
            </xsl:when>
            <xsl:when test="parent::sportsml:official-metadata">
                <xsl:element xmlns="http://iptc.org/std/nar/2006-10-01/" name="{name()}">
                    <xsl:attribute name="role">nrol:full</xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="@full">
                            <xsl:value-of select="@full"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@first"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="@last"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
            </xsl:when>
            <xsl:when test="parent::sportsml:associate-metadata">
                <xsl:element xmlns="http://iptc.org/std/nar/2006-10-01/" name="{name()}">
                    <xsl:attribute name="role">nrol:full</xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="@full">
                            <xsl:value-of select="@full"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@first"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="@last"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element xmlns="http://iptc.org/std/nar/2006-10-01/" name="{name()}">
                    <xsl:attribute name="role">nrol:full</xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="@full">
                            <xsl:value-of select="@full"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@first"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="@last"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
                <xsl:if test="@first">
                    <xsl:element xmlns="http://iptc.org/std/nar/2006-10-01/" name="{name()}">
                        <xsl:attribute name="part">nprt:common</xsl:attribute>
                        <xsl:value-of select="@first"/>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="@last">
                    <xsl:element xmlns="http://iptc.org/std/nar/2006-10-01/" name="{name()}">
                        <xsl:attribute name="part">nprt:nickname</xsl:attribute>
                        <xsl:value-of select="@last"/>
                    </xsl:element>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- convert to NAR location structure -->

    <xsl:template match="@name">
                <xsl:element xmlns="http://iptc.org/std/nar/2006-10-01/" name="{name()}"><xsl:value-of select="."/></xsl:element>
    </xsl:template>
    
    <xsl:template match="sportsml:home-location">
                                <home-location xmlns="http://iptc.org/std/nar/2006-10-01/">
                                    <POIDetails>
                                        <address>
                                        <xsl:if test="@country">
                                        <country><name><xsl:value-of select="@country"/></name></country>
                                        </xsl:if>
</address>
                                    </POIDetails>
                                </home-location>
    </xsl:template>

    <!-- get rid of empty elements as they pop up -->

    <xsl:template match="sportsml:sports-content-codes[not(*)]"/>
    <xsl:template match="sportsml:event-metadata-american-football[not(*)]"/>
    
    <!-- deprecated things that need to be moved to a better place or renamed -->

    <xsl:template match="sportsml:team-stats">
        <xsl:element xmlns="http://iptc.org/std/nar/2006-10-01/" name="team-stats">
        <xsl:if test="sportsml:team-stats-american-football/@time-of-possession">
        	    <xsl:attribute name="time-of-possession"><xsl:value-of select="sportsml:team-stats-american-football/@time-of-possession"/></xsl:attribute>
        </xsl:if>        
             <xsl:apply-templates select="@* | node()"/>
		</xsl:element>
    </xsl:template>

    <xsl:template match="sportsml:stats-american-football-scoring">
        <xsl:element xmlns="http://iptc.org/std/nar/2006-10-01/" name="stats-american-football-scoring">
        <xsl:if test="preceding-sibling::sportsml:stats-american-football-offensive/sportsml:stats-american-football-passing/@passes-touchdowns">
        	    <xsl:attribute name="touchdowns-passing"><xsl:value-of select="preceding-sibling::sportsml:stats-american-football-offensive/sportsml:stats-american-football-passing/@passes-touchdowns"/></xsl:attribute>
        </xsl:if>        
        <xsl:if test="preceding-sibling::sportsml:stats-american-football-offensive/sportsml:stats-american-football-passing/@receptions-touchdowns">
        	    <xsl:attribute name="touchdowns-receptions"><xsl:value-of select="preceding-sibling::sportsml:stats-american-football-offensive/sportsml:stats-american-football-passing/@receptions-touchdowns"/></xsl:attribute>
        </xsl:if>        
        <xsl:if test="preceding-sibling::sportsml:stats-american-football-offensive/sportsml:stats-american-football-rushing/@rushes-touchdowns">
        	    <xsl:attribute name="touchdowns-rushing"><xsl:value-of select="preceding-sibling::sportsml:stats-american-football-offensive/sportsml:stats-american-football-rushing/@rushes-touchdowns"/></xsl:attribute>
        </xsl:if>        
             <xsl:apply-templates select="@* | node()"/>
		</xsl:element>
    </xsl:template>
    
    <xsl:template match="@tackles[parent::sportsml:stats-american-football-defensive]">
        <xsl:attribute name="tackles-total">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@tackles[parent::sportsml:stats-american-football-offensive]">
        <xsl:attribute name="tackles-offense">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@tackles-assists[parent::sportsml:stats-american-football-offensive]">
        <xsl:attribute name="tackles-assists-offense">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@tackles[parent::sportsml:stats-american-football-special-teams]">
        <xsl:attribute name="tackles-special-teams">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@tackles-assists[parent::sportsml:stats-american-football-special-teams]">
        <xsl:attribute name="tackles-assists-special-teams">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@strikeouts[parent::sportsml:stats-baseball-offensive]">
        <xsl:attribute name="strikeouts-against">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@stolen-bases[parent::sportsml:stats-baseball-defensive]">
        <xsl:attribute name="stolen-bases-against">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@stolen-bases-caught[parent::sportsml:stats-baseball-defensive]">
        <xsl:attribute name="stolen-bases-caught-defense">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@stolen-bases-average[parent::sportsml:stats-baseball-defensive]">
        <xsl:attribute name="stolen-bases-average-defense">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@hits[parent::sportsml:stats-baseball-pitching]">
        <xsl:attribute name="hits-allowed">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@bases-on-balls[parent::sportsml:stats-baseball-pitching]">
        <xsl:attribute name="bases-on-balls-allowed">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@bases-on-balls-intentional[parent::sportsml:stats-baseball-pitching]">
        <xsl:attribute name="bases-on-balls-intentional-pitcher">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@period" name="period-value">
        <xsl:attribute name="period-value">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    

    <!-- generic actions -->
    <xsl:template match="sportsml:event-actions">
        <actions xmlns="http://iptc.org/std/nar/2006-10-01/">
            <xsl:apply-templates select="@* | node()"/>
        </actions>
    </xsl:template>
    
    <xsl:template match="sportsml:plays">
        <actions xmlns="http://iptc.org/std/nar/2006-10-01/">
            <xsl:apply-templates select="@* | node()"/>
        </actions>
    </xsl:template>
    
    <xsl:template match="sportsml:event-actions-ice-hockey">
        <xsl:apply-templates select="@* | node()"/>
    </xsl:template>
    
    <xsl:template match="sportsml:event-actions-soccer">
        <xsl:apply-templates select="@* | node()"/>
    </xsl:template>
    
    <xsl:template match="sportsml:event-actions-baseball">
        <xsl:apply-templates select="@* | node()"/>
    </xsl:template>
    
    <xsl:template match="sportsml:event-actions-basketball">
        <xsl:apply-templates select="@* | node()"/>
    </xsl:template>
    
    <xsl:template match="sportsml:event-actions-american-football">
            <xsl:apply-templates select="@* | node()"/>
    </xsl:template>

    <xsl:template match="sportsml:action-ice-hockey-play">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'play'"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="sportsml:action-soccer-play">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'play'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="sportsml:action-american-football-play">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'play'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="sportsml:action-ice-hockey-score">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'score'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="sportsml:action-soccer-score">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'score'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="sportsml:action-american-football-score">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'score'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="sportsml:action-basketball-score">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'score'"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="sportsml:action-ice-hockey-penalty">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'infraction'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="sportsml:action-soccer-penalty">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'infraction'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="sportsml:action-american-football-penalty">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'infraction'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="sportsml:action-basketball-penalty">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'infraction'"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="sportsml:action-soccer-substitution">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'substitution'"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="sportsml:action-basketball-substitution">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'substitution'"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="sportsml:action-american-football-drive"/>

    <xsl:template match="sportsml:play">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="substring-after(@class,'spactionclass:')"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="sportsml:action-baseball-play">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'play'"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="sportsml:action-basketball-play">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'play'"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="sportsml:action-baseball-pitch">
        <xsl:call-template name="action">
            <xsl:with-param name="action-class" select="'play'"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="action">
    <xsl:param name="action-class"/>
        	<action xmlns="http://iptc.org/std/nar/2006-10-01/">
        	    <xsl:attribute name="class"><xsl:value-of select="concat('spactionclass:',$action-class)"/></xsl:attribute>
        	    <xsl:if test="self::sportsml:action-baseball-pitch">
        	    <xsl:attribute name="type">spbblaction:pitch</xsl:attribute>
        	    </xsl:if>
        	    <xsl:apply-templates select="@*"/>
        	    <xsl:for-each select="sportsml:action/@*">
                    <xsl:choose>
                        <xsl:when test="name()='infraction-level'">
                            <xsl:call-template name="infraction-level"/>
                        </xsl:when>
                        <xsl:when test="name()='period'">
                            <xsl:call-template name="period-value"/>
                        </xsl:when>
                        <xsl:otherwise>
		        	        <xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
        	    </xsl:for-each>
        	    <xsl:apply-templates select="node()[not(self::sportsml:action)]"/>
        	    <xsl:for-each select="sportsml:action/sportsml:participant">
        	        <xsl:call-template name="action-participant"/>
        	    </xsl:for-each>
        	</action>
    </xsl:template>
    
    <xsl:template match="sportsml:action-ice-hockey-play-participant">
        <xsl:call-template name="action-participant"/>
    </xsl:template>

    <xsl:template match="sportsml:action-soccer-play-participant">
        <xsl:call-template name="action-participant"/>
    </xsl:template>
    
    <xsl:template match="sportsml:action-baseball-play-participant">
        <xsl:call-template name="action-participant"/>
    </xsl:template>
    
    <xsl:template match="sportsml:action-basketball-play-participant">
        <xsl:call-template name="action-participant"/>
    </xsl:template>
    
    <xsl:template match="sportsml:action-american-football-play-participant">
        <xsl:call-template name="action-participant"/>
    </xsl:template>
    
    <xsl:template name="action-participant">
        	<participant xmlns="http://iptc.org/std/nar/2006-10-01/">
            <xsl:apply-templates select="@* | node()"/>
            </participant>
    </xsl:template>

    <xsl:template match="@play-type">
        <xsl:attribute name="type">
            <xsl:value-of select="concat('sp',$sport-name-short,'action:',.)"/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@player-idref">
        <xsl:attribute name="idref">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@player-idref[parent::sportsml:action-ice-hockey-score]"/>

    <xsl:template match="@player-idref[parent::sportsml:action-basketball-score]"/>

    <xsl:template match="@hit-type">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('sp',$sport-name-short,'hittype:',.)"/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@role">
        <xsl:attribute name="{name()}">
                    <xsl:choose>
                        <xsl:when test="contains(.,':')">
                            <xsl:value-of select="."/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat('sp',$sport-name-short,'role:',.)"/>
                        </xsl:otherwise>
                    </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@score-type[parent::sportsml:action-american-football-score]">
        <xsl:call-template name="score-attempt-type">
            <xsl:with-param name="action-class" select="'play'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="@score-attempt-type[parent::sportsml:action-ice-hockey-score]">
        <xsl:call-template name="score-attempt-type">
            <xsl:with-param name="action-class" select="'play'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="@score-attempt-type[parent::sportsml:action-ice-hockey-play]">
        <xsl:call-template name="score-attempt-type">
            <xsl:with-param name="action-class" select="'play'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="@score-attempt-type[parent::sportsml:action-basketball-score]">
        <xsl:call-template name="score-attempt-type">
            <xsl:with-param name="action-class" select="'play'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="@score-attempt-type[parent::sportsml:action-basketball-play]">
        <xsl:call-template name="score-attempt-type">
            <xsl:with-param name="action-class" select="'play'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="@score-attempt-type[parent::sportsml:action-soccer-score]">
        <xsl:call-template name="score-attempt-type">
            <xsl:with-param name="action-class" select="'play'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="score-attempt-type">
        	<xsl:attribute name="score-attempt-type">
				<xsl:value-of select="concat('sp',$sport-name-short,'score:',.)"/>
			</xsl:attribute>
    </xsl:template>

    <xsl:template match="@touchdown-type">
        	<xsl:attribute name="{name()}">
				<xsl:value-of select="concat('sp',$sport-name-short,'touchdown:',.)"/>
			</xsl:attribute>
    </xsl:template>

    <xsl:template match="@zone">
        	<xsl:attribute name="{name()}">
				<xsl:value-of select="concat('sp',$sport-name-short,'fieldzone:',.)"/>
			</xsl:attribute>
    </xsl:template>

    <xsl:template match="@strength">
        	<xsl:attribute name="{name()}">
				<xsl:value-of select="concat('sp',$sport-name-short,'strength:',.)"/>
			</xsl:attribute>
    </xsl:template>

    <xsl:template match="@shot-type">
        	<xsl:attribute name="{name()}">
				<xsl:value-of select="concat($publisher-code,'shot:',.)"/>
			</xsl:attribute>
    </xsl:template>

    <xsl:template match="@penalty-type">
        	<xsl:attribute name="{name()}">
				<xsl:value-of select="concat($publisher-code,'penalty:',translate(.,' ','-'))"/>
			</xsl:attribute>
    </xsl:template>

    <xsl:template match="@goal-zone">
        	<xsl:attribute name="{name()}">
				<xsl:value-of select="concat($publisher-code,'goalzone:',.)"/>
			</xsl:attribute>
    </xsl:template>

    <xsl:template match="@recipient-idref[parent::sportsml:action-ice-hockey-penalty]"/>

    <xsl:template match="@recipient-type">
        	<xsl:attribute name="recipient-type">
                    <xsl:choose>
                        <xsl:when test="contains(.,'-p.')">player</xsl:when>
                        <xsl:when test="contains(.,'-t.')">team</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="."/>
                        </xsl:otherwise>
                    </xsl:choose>
			</xsl:attribute>
    </xsl:template>

    <xsl:template match="@location">
        	<xsl:attribute name="field-location">
				<xsl:value-of select="."/>
			</xsl:attribute>
    </xsl:template>

    <xsl:template match="@pitcher-idref"/>
    <xsl:template match="@batter-idref"/>
    <xsl:template match="@umpire-call[.='hit']"/>
    <xsl:template match="@shot-distance[.='']"/>
    <xsl:template match="@goal-zone[.='']"/>

    <!-- pass all remaining elements through -->
    <xsl:template match="*">
        <xsl:element xmlns="http://iptc.org/std/nar/2006-10-01/" name="{name()}">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>
    

    <!-- re-arrange content in these elements -->
    <xsl:template match="sportsml:event-metadata">
    	<event-metadata xmlns="http://iptc.org/std/nar/2006-10-01/">
        <xsl:apply-templates select="@*"/>
        <xsl:if test="*/@period-value">
        <xsl:attribute name="period-value">
            <xsl:value-of select="*/@period-value"/>
        </xsl:attribute>
        </xsl:if>
        <xsl:if test="*/@period-time-remaining">
        <xsl:attribute name="period-time-remaining">
            <xsl:value-of select="*/@period-time-remaining"/>
        </xsl:attribute>
        </xsl:if>
        <xsl:if test="*/@period-time-elapsed">
        <xsl:attribute name="period-time-elapsed">
            <xsl:value-of select="*/@period-time-elapsed"/>
        </xsl:attribute>
        </xsl:if>
        <xsl:if test="*/@minutes-elapsed">
        <xsl:attribute name="minutes-elapsed">
            <xsl:value-of select="*/@minutes-elapsed"/>
        </xsl:attribute>
        </xsl:if>
		<xsl:apply-templates select="node()[name()='sports-content-codes']"/>
		<xsl:apply-templates select="node()[name()='site']"/>
		<xsl:apply-templates select="node()[not(name()='site')][not(name()='sports-content-codes')]"/>
		</event-metadata>

    </xsl:template>

    <!-- employ new outcome-result element for some award -->

    <xsl:template match="sportsml:award[@award-type='league-championship-winner' or @award-type='relegation' or @award-type='league-championship-runner-up' or @award-type='title-qualification' or @award-type='playoff-qualifier' or @award-type='playoff-relegation']">
    	<outcome-result xmlns="http://iptc.org/std/nar/2006-10-01/">
        <xsl:attribute name="type">
        	<xsl:variable name="outcomeresult" select="'spresulteffect'"/>
                    <xsl:choose>
                        <xsl:when test="@award-type='league-championship-winner'">
                        	<xsl:value-of select="concat($outcomeresult,':','promotion')"/>
                        </xsl:when>
                        <xsl:when test="@award-type='relegation'">
                        	<xsl:value-of select="concat($outcomeresult,':','demotion')"/>
                        </xsl:when>
                        <xsl:when test="@award-type='league-championship-runner-up'">
                        	<xsl:value-of select="concat($outcomeresult,':','promotion')"/>
                        </xsl:when>
                        <xsl:when test="@award-type='title-qualification'">
                        	<xsl:value-of select="concat($outcomeresult,':','qualification')"/>
                        </xsl:when>
                        <xsl:when test="@award-type='playoff-qualifier'">
                        	<xsl:value-of select="concat($outcomeresult,':','qualification')"/>
                        </xsl:when>
                        <xsl:when test="@award-type='playoff-relegation'">
                        	<xsl:value-of select="concat($outcomeresult,':','demotion')"/>
                        </xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="key">
                    <xsl:choose>
                        <xsl:when test="@name='Champions_League'">league:l.uefa.org.champions</xsl:when>
                        <xsl:when test="@name='Champions_League_Qualifying'">league:l.uefa.champions.qualifying</xsl:when>
                        <xsl:when test="@name='Europa_Cup'">league:l.uefa.org.cup</xsl:when>
                        <xsl:when test="$league-key='l.bundesliga.de' and @name='Relegation'">league:l.2-bundesliga.de</xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="comment"><xsl:value-of select="@name"/></xsl:attribute>
		</outcome-result>
    </xsl:template>

    <!-- tournament conversion -->

    <xsl:template match="sportsml:tournament-stage">
    	<tournament-part xmlns="http://iptc.org/std/nar/2006-10-01/">
			<xsl:apply-templates select="@* | node()"/>
		</tournament-part>

    </xsl:template>

    <xsl:template match="sportsml:tournament-stage-metadata">
    	<tournament-part-metadata xmlns="http://iptc.org/std/nar/2006-10-01/">
			<xsl:apply-templates select="@* | node()"/>
		</tournament-part-metadata>
    </xsl:template>

    <xsl:template match="sportsml:tournament-round">
    	<tournament-part xmlns="http://iptc.org/std/nar/2006-10-01/">
			<xsl:apply-templates select="@* | node()"/>
		</tournament-part>

    </xsl:template>

    <xsl:template match="sportsml:tournament-round-metadata">
    	<tournament-part-metadata xmlns="http://iptc.org/std/nar/2006-10-01/">
			<xsl:apply-templates select="@* | node()"/>
		</tournament-part-metadata>
    </xsl:template>

    <xsl:template match="@stage-type">
        <xsl:attribute name="type">
            <xsl:value-of select="concat('sptournamentpart:',.)"/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@stage-key">
        <xsl:attribute name="key">
            <xsl:value-of select="concat($publisher-code,':',.)"/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@stage-number">
        <xsl:attribute name="number">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@round-type">
        <xsl:attribute name="type">
            <xsl:value-of select="concat('sptournamentpart:',.)"/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@round-key">
        <xsl:attribute name="key">
            <xsl:value-of select="concat($publisher-code,':',.)"/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@round-number">
        <xsl:attribute name="number">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@maximum-stage-number">
        <xsl:attribute name="maximum-subparts">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@maximum-round-number">
        <xsl:attribute name="maximum-subparts">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@maximum-event-number">
        <xsl:attribute name="maximum-subparts">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@minimum-stage-number">
        <xsl:attribute name="minimum-subparts">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@minimum-round-number">
        <xsl:attribute name="minimum-subparts">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@minimum-event-number">
        <xsl:attribute name="minimum-subparts">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="sportsml:player[@id = following-sibling::sportsml:player/@id]"/>  

    <!-- the following take all key values and turn them into qcodes -->
    <xsl:template match="@code-key">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="parent::sportsml:sports-content-code/@code-type"/>:<xsl:value-of select="."
            />
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@code-type">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('spct:',.)"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@group-key">
        <xsl:attribute name="key">
            <xsl:text>group:</xsl:text>
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@membership-key">
        <xsl:attribute name="key">
            <xsl:text>membership:</xsl:text>
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@event-key">
        <xsl:attribute name="key">
            <xsl:value-of select="concat($publisher-code,'event:',.)"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@team-key">
        <xsl:attribute name="key">
            <xsl:value-of select="concat($publisher-code,'team:',.)"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@phase-caliber-key">
        <xsl:attribute name="key">
            <xsl:value-of select="concat($publisher-code,'team:',.)"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@player-key">
        <xsl:attribute name="key">
            <xsl:value-of select="concat($publisher-code,'person:',.)"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@site-key">
        <xsl:attribute name="key">
            <xsl:value-of select="concat($publisher-code,'site:',.)"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@official-key">
        <xsl:attribute name="key">
            <xsl:value-of select="concat($publisher-code,'person:',.)"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@tournament-key">
        <xsl:attribute name="key">
            <xsl:value-of select="concat($publisher-code,'comp:',.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@associate-key">
        <xsl:attribute name="key">
            <xsl:value-of select="concat($publisher-code,'person:',.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@fixture-key">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat($publisher-code,'doc:',.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <!-- specify associate or official position -->
    <xsl:template match="@position[parent::sportsml:associate-metadata]">
        	<xsl:choose>
            <xsl:when test="ancestor::sportsml:sports-event">
                    <xsl:attribute name="position-event">
						<xsl:value-of select="concat('sp',$sport-name-short,'ascpos:',.)"/>
					</xsl:attribute>
</xsl:when>
            <xsl:otherwise>
                    <xsl:attribute name="position-regular">
						<xsl:value-of select="concat('sp',$sport-name-short,'ascpos:',.)"/>
					</xsl:attribute>
			</xsl:otherwise>
        	</xsl:choose>
    </xsl:template>
    
    <xsl:template match="@position[parent::sportsml:official-metadata]">
        	<xsl:choose>
            <xsl:when test="ancestor::sportsml:sports-event">
            <xsl:attribute name="position-event">
            	<xsl:value-of select="concat('vendoffpos:',translate(.,' ','-'))"/>
            </xsl:attribute>
</xsl:when>
            <xsl:otherwise>
                    <xsl:attribute name="position-regular">
            <xsl:value-of select="concat('vendoffpos:',translate(.,' ','-'))"/>
            </xsl:attribute>
			</xsl:otherwise>
        	</xsl:choose>
    </xsl:template>
    
    <!-- convert doc date-time and event start-date-time into XML dateTime -->
    <xsl:template match="@date-time">
        <xsl:call-template name="xml-date-time">
            <xsl:with-param name="date-time" select="."/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template match="@start-date-time">
        <xsl:call-template name="xml-date-time">
            <xsl:with-param name="date-time" select="."/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template match="@date-coverage-value[parent::schedule-metadata]">
        <xsl:attribute name="temporal-unit-value">
            <xsl:call-template name="xml-date-time">
                <xsl:with-param name="date-time" select="."/>
            </xsl:call-template>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@date-of-birth">
        <xsl:call-template name="xml-date-time">
            <xsl:with-param name="date-time" select="."/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- convert attribute values to qcode -->
    <xsl:template match="@date-coverage-type[parent::sportsml:event-metadata]">
        <xsl:choose>
            <xsl:when test=".='event'">
                <xsl:attribute name="temporal-unit-type"><xsl:value-of select="concat('cpnat:',.)"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="temporal-unit-type"><xsl:value-of select="concat('spct:',.)"/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@date-coverage-type">
        <xsl:attribute name="temporal-unit-type"><xsl:value-of select="concat('spct:',.)"/></xsl:attribute>
    </xsl:template>
    <xsl:template match="@competition-scope">
        <xsl:variable name="att-name">
            <xsl:choose>
                <xsl:when test=". = 'tournament'">competition</xsl:when>
                <xsl:when test=". = 'league'">competition</xsl:when>
                <xsl:when test=". = 'division'">unit-type</xsl:when>
                <xsl:when test=". = 'conference'">unit-type</xsl:when>
                <xsl:otherwise>unknown</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:attribute name="{$att-name}"><xsl:value-of select="concat('spct:',.)"/></xsl:attribute>
    </xsl:template>
    <xsl:template match="@event-status">
        	<xsl:attribute name="{name()}"><xsl:value-of select="concat('speventstatus:',.)"/></xsl:attribute>
    </xsl:template>
    <xsl:template match="@position-regular">
        	<xsl:attribute name="{name()}"><xsl:value-of select="concat('sp',$sport-name-short,'pos:',.)"/></xsl:attribute>
    </xsl:template>
    <xsl:template match="@position-event">
        	<xsl:attribute name="{name()}"><xsl:value-of select="concat('sp',$sport-name-short,'position:',.)"/></xsl:attribute>
    </xsl:template>
    <xsl:template match="@status[parent::sportsml:player-metadata]">
        	<xsl:attribute name="{name()}"><xsl:value-of select="concat('spperstatus:',.)"/></xsl:attribute>
    </xsl:template>
    <xsl:template match="@temporal-unit">
        	<xsl:attribute name="{name()}"><xsl:value-of select="concat('sptunit:',.)"/></xsl:attribute>
    </xsl:template>
    <xsl:template match="@date-coverage-value">
        <xsl:attribute name="temporal-unit-value">
            <xsl:value-of select="concat('vendor:',.)"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@type[parent::sportsml:rank]">
        <xsl:attribute name="type">
            <xsl:value-of select="concat('vendor:',.)"/>
        </xsl:attribute>
    </xsl:template>
        <xsl:template match="@health[parent::sportsml:player-metadata]">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('sphealth:',.)"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@event-outcome">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('speventoutcome:',.)"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@event-outcome-type">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('speventoutcometype:',.)"/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@award-type">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat($publisher-code,':',.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@phase-type">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('spphase:',.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@phase-caliber">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('spct:',.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@phase-status">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('spphasestatus:',.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@subphase-type">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('spsubphase:',.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@infraction-level" name="infraction-level">
        <xsl:attribute name="{name()}">
			<xsl:value-of select="concat('sp',$sport-name-short,'infract:',.)"/>
		</xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@sub-score-type">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('scoretype:',.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@stats-coverage">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('spstatscoverage:',.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@recipient-type">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('sprecipienttype:',.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@streak-type">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('spstreaktype:',.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@duration-scope">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="concat('spdurationscope:',.)"/>
        </xsl:attribute>
    </xsl:template>
    
    
    
    <!-- remove these attributes -->
    <xsl:template match="@code-source"/>
    <xsl:template match="@fixture-name"/>
    <xsl:template match="@event-name"/>
    <xsl:template match="@position-source"/>
    <xsl:template match="@stage-name"/>
    <xsl:template match="@round-name"/>
    <xsl:template match="@alignment[.='none']"/>
	<xsl:template match="@bbc:*"/>
    <xsl:template match="sportsml:team-stats-american-football/@time-of-possession"/>
    <xsl:template match="sportsml:stats-american-football-passing/@passes-touchdowns"/>
    <xsl:template match="sportsml:stats-american-football-passing/@receptions-touchdowns"/>
    <xsl:template match="sportsml:stats-american-football-rushing/@rushes-touchdowns"/>
    <xsl:template match="sportsml:event-metadata-baseball/@period-value"/>
    <xsl:template match="sportsml:event-metadata-american-football/@period-value"/>
    <xsl:template match="sportsml:event-metadata-ice-hockey/@period-value"/>
    <xsl:template match="sportsml:event-metadata-soccer/@period-value"/>
    <xsl:template match="sportsml:event-metadata-rugby/@period-value"/>
    <xsl:template match="sportsml:event-metadata-cricket/@period-value"/>
    <xsl:template match="sportsml:event-metadata-american-football/@period-time-remaining"/>
    <xsl:template match="sportsml:event-metadata-ice-hockey/@period-time-remaining"/>
    <xsl:template match="sportsml:event-metadata-soccer/@period-time-remaining"/>
    <xsl:template match="sportsml:event-metadata-rugby/@period-time-remaining"/>
    <xsl:template match="sportsml:event-metadata-american-football/@period-time-elapsed"/>
    <xsl:template match="sportsml:event-metadata-ice-hockey/@period-time-elapsed"/>
    <xsl:template match="sportsml:event-metadata-soccer/@period-time-elapsed"/>
    <xsl:template match="sportsml:event-metadata-rugby/@period-time-elapsed"/>
    <xsl:template match="sportsml:event-metadata-soccer/@minutes-elapsed"/>
        
    <!-- remove these elements -->
    <xsl:template match="sportsml:sports-title"/>
    <xsl:template match="sportsml:event-metadata-basketball"/>
    
    <!-- pass all remaining attributes through -->
    <xsl:template match="@*">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <!-- pass all remaining values through -->
    <xsl:template match="text()">
        <xsl:if test="normalize-space()">
            <xsl:value-of select="."/>
        </xsl:if>
    </xsl:template>

    <!-- Utilities -->
    <!-- the date-time conversion template -->
    <xsl:template name="xml-date-time">
        <xsl:param name="date-time"/>
        <xsl:param name="not-att"/>
        <xsl:choose>
        <xsl:when test="contains($date-time,'/')">
        <xsl:variable name="year" select="substring-after(substring-after($date-time,'/'),'/')"/>
        <xsl:variable name="day" select="substring-before(substring-after($date-time,'/'),'/')"/>
        <xsl:variable name="month" select="substring-before($date-time,'/')"/>

                <xsl:attribute name="{name()}">
                    <xsl:value-of select="$year"/>-<xsl:value-of select="format-number($month,'00')"/>-<xsl:value-of
                        select="format-number($day,'00')"/>
                </xsl:attribute>

        </xsl:when>
        <xsl:when test="contains($date-time,'-')">
        <xsl:choose>
            <xsl:when test="$not-att='yes'">
        <xsl:value-of select="$date-time"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="{name()}">
        <xsl:value-of select="$date-time"/>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
        <xsl:variable name="year" select="substring($date-time,0,5)"/>
        <xsl:variable name="month" select="substring($date-time,5,2)"/>
        <xsl:variable name="day" select="substring($date-time,7,2)"/>
        <xsl:variable name="hour" select="substring($date-time,10,2)"/>
        <xsl:variable name="minute" select="substring($date-time,12,2)"/>
        <xsl:variable name="second" select="substring($date-time,14,2)"/>
        <xsl:variable name="zone-hour" select="substring($date-time,16,3)"/>
        <xsl:variable name="zone-minute" select="substring($date-time,19)"/>
        <xsl:choose>
            <xsl:when test="$not-att='yes'">
                <xsl:value-of select="$year"/>-<xsl:value-of select="$month"/>-<xsl:value-of
                    select="$day"/>T<xsl:value-of select="$hour"/>:<xsl:value-of select="$minute"
                    />:<xsl:value-of select="$second"/>
                <xsl:value-of select="$zone-hour"/>:<xsl:value-of select="$zone-minute"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="{name()}">
                    <xsl:value-of select="$year"/>-<xsl:value-of select="$month"/>-<xsl:value-of
                        select="$day"/>T<xsl:value-of select="$hour"/>:<xsl:value-of
                        select="$minute"/>:<xsl:value-of select="$second"/>
                    <xsl:value-of select="$zone-hour"/>:<xsl:value-of select="$zone-minute"/>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
