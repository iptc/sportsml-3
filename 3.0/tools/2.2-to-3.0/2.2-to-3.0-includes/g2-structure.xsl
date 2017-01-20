<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xts="http://www.xmlteam.com" xmlns:nitf="http://iptc.org/std/NITF/2006-10-18/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:bbc="http://www.bbc.co.uk/sport/sports-data"
    xmlns:sportsml="http://iptc.org/std/SportsML/2008-04-01/" version="1.0">

    <xsl:template name="g2-structure">

        <!-- Begin the newItem wrapper built by extracting values from the SportsML, either with explicit xpaths or using the variables declared above -->
        <newsItem xmlns="http://iptc.org/std/nar/2006-10-01/">
            <xsl:attribute name="standard">NewsML-G2</xsl:attribute>
            <xsl:attribute name="standardversion">2.22</xsl:attribute>
            <xsl:attribute name="version">1</xsl:attribute>
            <xsl:attribute name="conformance">power</xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="$lang"/>
            </xsl:attribute>
            <!-- xsl:attribute name="xsi:schemaLocation">
                <xsl:value-of
                    select="concat('http://iptc.org/std/nar/2006-10-01/',' ',$NewsML-schemaLocation)"
                />
            </xsl:attribute -->
            <xsl:attribute name="guid">
                <xsl:value-of select="concat('urn:newsml:sportsml.org:',translate(substring-before(sportsml:sports-content/sportsml:sports-metadata/@date-time,'T'),'-',''),':',$doc-id)"/>
            </xsl:attribute>
            <catalogRef href="http://www.iptc.org/std/catalog/catalog.IPTC-G2-Standards_27.xml"/>
            <catalogRef href="http://www.iptc.org/std/catalog/catalog.IPTC-Sports_1.xml"/>
            <itemMeta>
                <itemClass qcode="ninat:text"/>
                <provider qcode="web:xmlteam.com">
                    <name>XML Team Solutions, Inc.</name>
                </provider>
                <versionCreated>
                    <xsl:call-template name="xml-date-time">
                        <xsl:with-param name="date-time"
                            select="sportsml:sports-content/sportsml:sports-metadata/@date-time"/>
                        <xsl:with-param name="not-att" select="'yes'"/>
                    </xsl:call-template>
                </versionCreated>
                <pubStatus>
                    <xsl:attribute name="qcode">
                        <xsl:value-of select="concat('stat:',$pub-status)"/>
                    </xsl:attribute>
                </pubStatus>
                <fileName>
                    <xsl:value-of select="$doc-id"/>
                </fileName>
            </itemMeta>
            <contentMeta>
                <contentCreated>
                    <xsl:call-template name="xml-date-time">
                        <xsl:with-param name="date-time"
                            select="sportsml:sports-content/sportsml:sports-metadata/@date-time"/>
                        <xsl:with-param name="not-att" select="'yes'"/>
                    </xsl:call-template>
                </contentCreated>
                <located>
                    <xsl:attribute name="qcode">
                        <xsl:choose>
                            <xsl:when
                                test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-key = 'sportsnetwork.com'"
                                >city:Philadelphia</xsl:when>
                            <xsl:when
                                test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-key = 'rotoworld.com'"
                                >city:Stamford</xsl:when>
                            <xsl:when
                                test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-key = 'optasports.com'"
                                >city:Leeds</xsl:when>
                            <xsl:when
                                test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-key = 'fantasysports.ca'"
                                >city:Toronto</xsl:when>
                            <xsl:otherwise>city:Toronto</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <broader>
                        <xsl:attribute name="qcode">
                            <xsl:choose>
                                <xsl:when
                                    test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-key = 'sportsnetwork.com'"
                                    >reg:Pennsylvania</xsl:when>
                                <xsl:when
                                    test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-key = 'rotoworld.com'"
                                    >reg:Connecticut</xsl:when>
                                <xsl:when
                                    test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-key = 'optasports.com'"
                                    >reg:England</xsl:when>
                                <xsl:when
                                    test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-key = 'fantasysports.ca'"
                                    >reg:Ontario</xsl:when>
                                <xsl:otherwise>reg:Ontario</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </broader>
                    <broader>
                        <xsl:attribute name="qcode">
                            <xsl:choose>
                                <xsl:when
                                    test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-key = 'optasports.com'"
                                    >cntry:UK</xsl:when>
                                <xsl:when
                                    test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-key = 'fantasysports.ca'"
                                    >cntry:CA</xsl:when>
                                <xsl:otherwise>cntry:CA</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </broader>
                </located>
                <creator
                    qcode="{concat('web:',sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-key)}">
                    <name>
                        <xsl:value-of
                            select="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='publisher']/@code-name"
                        />
                    </name>
                </creator>
                <xsl:if test="sportsml:sports-content/sportsml:sports-metadata/@revision-id">
                    <altId type="idtype:revision-id">
                        <xsl:attribute name="id">
                            <xsl:value-of select="sportsml:sports-content/sportsml:sports-metadata/@revision-id"/>
                        </xsl:attribute>
                    </altId>
                </xsl:if>
                <genre>
                    <xsl:attribute name="qcode">spfixt:<xsl:value-of select="$fixture-key"/>
                    </xsl:attribute>
                    <name xml:lang="{$lang}">
                        <xsl:value-of select="sportsml:sports-content/sportsml:sports-metadata/@fixture-name"/>
                    </name>
                    <broader>
                        <xsl:attribute name="qcode">
                            <xsl:value-of select="concat('spct:',$document-class)"/>
                        </xsl:attribute>
                    </broader>
                </genre>
                <genre>
                    <xsl:attribute name="qcode">spct:<xsl:value-of select="$document-class"/>
                    </xsl:attribute>
                </genre>
                <language>
                    <xsl:attribute name="tag">
                        <xsl:value-of select="$lang"/>
                    </xsl:attribute>
                </language>
                <xsl:if
					test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='season']">
					<subject>
                        <xsl:attribute name="type">spct:season</xsl:attribute>
						<xsl:attribute name="literal">
							<xsl:value-of select="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='season']/@code-key"
							/>
						</xsl:attribute>
					</subject>
				</xsl:if>
				<xsl:if test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='season-type']">
					<subject>
					    <xsl:attribute name="type">spct:season-type</xsl:attribute>
					    <xsl:attribute name="qcode">
					        <xsl:value-of select="concat('spct:',sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='season-type']/@code-key)"/>
						</xsl:attribute>
					</subject>
				</xsl:if>
                <subject qcode="subj:15000000">
                    <name xml:lang="{$lang}">sport</name>
                </subject>
                <subject qcode="subj:{$sport-key}">
                    <name xml:lang="{$lang}">
                        <xsl:value-of select="$sport-name"/>
                    </name>
                    <broader qcode="subj:15000000"/>
                </subject>
                <subject qcode="vendleague:{$league-key}">
                    <xsl:attribute name="type">spct:league</xsl:attribute>
                    <name xml:lang="{$lang}">
                        <xsl:value-of select="$league-name"/>
                    </name>
                    <broader qcode="subj:{$sport-key}"/>
                    <xsl:if test="$league-key='l.mlb.com' or $league-key='l.nhl.com' or $league-key='l.nba.com' or $league-key='l.nfl.com' or $league-key='l.cfl.com'">
                    <sameAs>
                        <xsl:attribute name="qcode">
                            <xsl:text>subj:</xsl:text>
                            <xsl:choose>
                                <xsl:when test="$league-key = 'l.mlb.com'">15007001</xsl:when>
                                <xsl:when test="$league-key = 'l.nhl.com'">15031001</xsl:when>
                                <xsl:when test="$league-key = 'l.nba.com'">15008001</xsl:when>
                                <xsl:when test="$league-key = 'l.nfl.com'">15003001</xsl:when>
                                <xsl:when test="$league-key = 'l.cfl.ca'">15003002</xsl:when>
                                <xsl:otherwise>tbd</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </sameAs>
                    </xsl:if>
                </subject>
                <xsl:if
                    test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='conference']">
                    <subject>
                        <xsl:attribute name="type">spct:conference</xsl:attribute>
                        <xsl:attribute name="qcode">
                            <xsl:value-of
                                select="concat('vendconf:',$league-key,'-',sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='conference']/@code-key)"
                            />
                        </xsl:attribute>
                        <name xml:lang="{$lang}">
                            <xsl:value-of
                                select="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='conference']/@code-name"
                            />
                        </name>
                        <broader qcode="vendleague:{$league-key}"/>
                    </subject>
                </xsl:if>
                <xsl:if
                    test="sportsml:sports-content/sportsml:sports-event/sportsml:event-metadata or sportsml:sports-content/sportsml:tournament/sportsml:tournament-metadata">
                    <subject>
                        <xsl:attribute name="type">cpnat:event</xsl:attribute>
                        <xsl:attribute name="qcode">
                            <xsl:choose>
                                <xsl:when test="sportsml:sports-content/sportsml:tournament/sportsml:tournament-metadata">
                                    <xsl:value-of
                                        select="concat('vendevent:',sportsml:sports-content/sportsml:tournament/sportsml:tournament-metadata/@tournament-key)"
                                    />
                                </xsl:when>
                                <xsl:when test="sportsml:sports-content/sportsml:sports-event/sportsml:event-metadata/@key">
                                    <xsl:value-of
                                        select="concat('vendevent:',sportsml:sports-content/sportsml:sports-event/sportsml:event-metadata/@key)"
                                    />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="concat('vendevent:',sportsml:sports-content/sportsml:sports-event/sportsml:event-metadata/@event-key)"
                                    />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </subject>
                </xsl:if>
                <xsl:if
                    test="count(//sportsml:team)=2">
                            <xsl:for-each
                                select="//sportsml:team">
                            <subject>
                                <xsl:attribute name="type">spct:team</xsl:attribute>
                                <xsl:attribute name="qcode">
                            <xsl:choose>
                                <xsl:when test="sportsml:team-metadata/@key">
                                    <xsl:value-of
                                        select="concat('vendevent:',sportsml:team-metadata/@key)"
                                    />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="concat('vendteam:',sportsml:team-metadata/@team-key)"
                                    />
                                </xsl:otherwise>
                            </xsl:choose>
                                </xsl:attribute>
                                <name>
                                    <xsl:value-of
                                        select="sportsml:team-metadata/sportsml:name/@first"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of
                                        select="sportsml:team-metadata/sportsml:name/@last"/>
                                </name>
                            </subject>
                            </xsl:for-each>
                </xsl:if>
                <xsl:if
                    test="(($fixture-key='post-event-coverage' or $fixture-key='pre-event-coverage') and sportsml:sports-content/sportsml:sports-event/sportsml:team/sportsml:player) or string(sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='player']/@code-key)">
                    <xsl:choose>
                        <xsl:when
                            test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='player']">
                            <xsl:for-each
                                select="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='player']">
                                <subject>
                                    <xsl:attribute name="type">cpnat:person</xsl:attribute>
                                    <xsl:attribute name="qcode">
                                        <xsl:value-of select="concat('person:',@code-key)"/>
                                    </xsl:attribute>
                                    <name>
                                        <xsl:value-of select="@code-name"/>
                                    </name>
                                </subject>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:for-each
                                select="sportsml:sports-content/*/sportsml:team/sportsml:player[sportsml:player-metadata/@player-key]">
                                <subject>
                                    <xsl:attribute name="type">cpnat:person</xsl:attribute>
                                    <xsl:attribute name="qcode">
                                        <xsl:value-of
                                            select="concat('person:',sportsml:player-metadata/@player-key)"/>
                                    </xsl:attribute>
                                    <name>
                                        <xsl:choose>
                                            <xsl:when test="sportsml:player-metadata/sportsml:name/@full">
                                                <xsl:value-of select="sportsml:player-metadata/sportsml:name/@full"/>
                                            </xsl:when>
                                            <xsl:when test="sportsml:player-metadata/sportsml:name/@first">
                                                <xsl:value-of select="sportsml:player-metadata/sportsml:name/@first"/>
                                                <xsl:text> </xsl:text>
                                                <xsl:value-of select="sportsml:player-metadata/sportsml:name/@last"/>
                                            </xsl:when>
                                            <xsl:otherwise/>
                                        </xsl:choose>
                                    </name>
                                </subject>
                            </xsl:for-each>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
                <headline>
                    <xsl:value-of select="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-title"/>
                </headline>
                <xsl:if test="sportsml:sports-content/sportsml:sports-metadata/@xts:tsnslug">
                    <slugline>
                        <xsl:if test="string($slug-separator)">
                            <xsl:attribute name="separator">
                                <xsl:value-of select="$slug-separator"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="sportsml:sports-content/sportsml:sports-metadata/@xts:tsnslug"/>
                    </slugline>
                </xsl:if>
                <xsl:if test="sportsml:sports-content/article/nitf/body/body.head/abstract">
                <description role="drol:summary">
                    <xsl:value-of select="sportsml:sports-content/article/nitf/body/body.head/abstract"/>
                </description>
                </xsl:if>
                <xsl:if
                    test="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='action-listing']">
                    <xts:action-listing>
                        <xsl:value-of
                            select="sportsml:sports-content/sportsml:sports-metadata/sportsml:sports-content-codes/sportsml:sports-content-code[@code-type='action-listing']/@code-key"
                        />
                    </xts:action-listing>
                </xsl:if>
            </contentMeta>
            <contentSet>
                <xsl:apply-templates/>
            </contentSet>
        </newsItem>

    </xsl:template>

</xsl:stylesheet>
