<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://iptc.org/std/nar/2006-10-01/" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:sm="http://iptc.org/std/nar/2006-10-01/" exclude-result-prefixes="xs sm" version="2.0">

    <!-- Lookup file to get information on element structure -->
    <xsl:param name="attributelist" select="document('generic-to-specific-lookup.xml')"/>
    <!-- It has groups with either/and rows to check or subgroups to check -->

    <xsl:output method="xml" exclude-result-prefixes="#all" indent="yes"/>

    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- passes an xml thru xsl with no significant changes -->
    
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
    
    <!-- pass all values through -->
    <xsl:template match="text()">
        <xsl:if test="normalize-space()">
            <xsl:value-of select="."/>
        </xsl:if>
    </xsl:template>
    
    <!-- team-stats have generic stats so we need to convert any of those to specific stats -->
    <xsl:template match="sm:team-stats">

        <xsl:variable name="oneteam" select="."/>
        <!-- Make a copy of this team-stats -->

        <xsl:element name="team-stats">
            <!-- Start the element for team-stats -->

            <!-- If we have attributes directly in this team stats element they need to be copied -->
            <xsl:for-each select="./@*">
                <!-- Copy all attributes in the root stats element to the newly created team-stats element -->
                <xsl:variable name="attname" select="name()"/>
                <xsl:attribute name="{$attname}">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:for-each>

            <!-- Now is the time for the general team-stats -->
            <xsl:for-each select="$attributelist/tests/team-stats/row">
                <!-- Check all the rows for team-stats in the listfile -->
                <xsl:variable name="name" select="./name"/>
                <!-- Get the name -->
                <xsl:variable name="stat-type" select="./stat-type"/>
                <!-- Get the stat-type -->
                <xsl:variable name="prefix" select="./prefix"/>
                <!-- Get the prefix -->
                <xsl:if test="$oneteam//sm:stat[@stat-type = $stat-type]/@value">
                    <!-- If the original has this in the generic stats -->
                    <xsl:attribute name="{$name}">
                        <xsl:value-of
                            select="concat($prefix, $oneteam//sm:stat[@stat-type = $stat-type]/@value)"
                        />
                    </xsl:attribute>
                    <!-- Create an attribute with it -->
                </xsl:if>
            </xsl:for-each>


            <xsl:apply-templates/>
            <!-- Copy elements from team-stats, except those named specially -->


            <!-- Check all named substat nodes of team-stats -->
            <xsl:for-each select="$attributelist/tests/team-stats/substat">
                <!-- for each substat under team-stats in attributelist.xml -->
                <xsl:variable name="statgroup" select="./statgroup"/>
                <!-- Pick the groupname -->
                <xsl:variable name="elementname" select="./elementname"/>
                <!-- Get the name the element should get in the output -->

                <xsl:variable name="oneSubGroup">
                    <!-- Create a variable, because we do not know if we're getting any content from this check -->
                    <xsl:call-template name="CheckSubStatGroup">
                        <!-- Call the generic sub group check for this specific subgroup -->
                        <xsl:with-param name="statgroup" select="$statgroup"/>
                        <xsl:with-param name="elementname" select="$elementname"/>
                        <xsl:with-param name="oneteam" select="$oneteam"/>
                        <xsl:with-param name="situation" select="''"/>
                    </xsl:call-template>
                </xsl:variable>

                <!-- Now is the time to check if the above created variable got any content -->
                <xsl:if test="$oneSubGroup/node()[1][count(@*) &gt; 0]">
                    <!-- If we got any content copy the node -->
                    <xsl:copy-of select="$oneSubGroup"/>
                </xsl:if>
            </xsl:for-each>

        </xsl:element>
        <!-- Done with the new team-stats -->


    </xsl:template>
    <!-- End of template for team stats -->


    <!-- player-stats also have generic stats so they need to be handled in the same manner as team-stats-->
    <xsl:template match="sm:player-stats">

        <xsl:for-each select="sm:stats">
            <!-- There can be more than one stats element in player-stats -->
            <xsl:variable name="oneplayer" select="."/>
            <!-- Make a copy of these stats for this player-stats -->

            <xsl:element name="player-stats">
                <!-- Start an element for player-stats, one for each stats group that exist -->

                <xsl:for-each select="./@*">
                    <!-- Copy all attributes in the stats element to the newly created player-stats element -->
                    <xsl:variable name="attname" select="name()"/>
                    <xsl:attribute name="{$attname}">
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                </xsl:for-each>

                <!-- Now it is time for the general-player stats in this stats collection -->
                <xsl:for-each select="$attributelist/tests/player-stats/row">
                    <!-- Check all the rows for player-stats in the listfile -->
                    <xsl:variable name="name" select="./name"/>
                    <!-- Get the name -->
                    <xsl:variable name="stat-type" select="./stat-type"/>
                    <!-- Get the stat-type -->
                    <xsl:variable name="prefix" select="./prefix"/>
                    <!-- Get the prefix -->
                    <xsl:if test="$oneplayer//sm:stat[@stat-type = $stat-type]/@value">
                        <!-- If the original has this in the generic stats -->
                        <xsl:attribute name="{$name}">
                            <xsl:value-of
                                select="concat($prefix, $oneplayer//sm:stat[@stat-type = $stat-type]/@value)"
                            />
                        </xsl:attribute>
                        <!-- Create an attribute with it -->
                    </xsl:if>
                </xsl:for-each>


                <xsl:apply-templates/>
                <!-- Copy elements and templates from player-stats, except those named specially -->


                <!-- Check all named substat nodes of player-stats -->
                <xsl:for-each select="$attributelist/tests/player-stats/substat">
                    <xsl:variable name="statgroup" select="./statgroup"/>
                    <xsl:variable name="elementname" select="./elementname"/>

                    <xsl:variable name="oneSubGroup">
                        <!-- Create a variable because we are not sure there will be any result -->
                        <xsl:call-template name="CheckSubStatGroup">
                            <!-- For each call the generic sub group check -->
                            <xsl:with-param name="statgroup" select="$statgroup"/>
                            <xsl:with-param name="elementname" select="$elementname"/>
                            <xsl:with-param name="oneteam" select="$oneplayer"/>
                            <xsl:with-param name="situation" select="''"/>
                        </xsl:call-template>
                    </xsl:variable>

                    <!-- Now it is time to check if the above resulted in any content -->
                    <xsl:if
                        test="$oneSubGroup/node()[1][count(@*) &gt; 0] or $oneSubGroup/node()[1][count(node()) &gt; 0]">
                        <!-- If we got any content copy the node -->
                        <xsl:copy-of select="$oneSubGroup"/>
                    </xsl:if>
                </xsl:for-each>

            </xsl:element>
            <!-- One player-stats for each stat group in the generic version -->

        </xsl:for-each>
        <!-- stat-group in player-stats -->

    </xsl:template>
    <!-- End template for player-stats -->



    <!-- Generic elements that we handle in other means. -->
    <xsl:template match="sm:stats"/>
    <!-- Will catch both stats in player and team -->
    <xsl:template match="sm:stat"/>
    <!-- Will catch stat in both player and team -->





    <!-- General template to check one group from the datafile -->
    <xsl:template name="CheckSubStatGroup">
        <xsl:param name="statgroup"/>
        <!-- The group to get from attributelist.xml -->
        <xsl:param name="elementname"/>
        <!-- The name to use in the output -->
        <xsl:param name="oneteam"/>
        <!-- Data att kolla i  -->
        <xsl:param name="situation"/>

        <xsl:element name="{$elementname}">
            <!-- Skapa ett element -->

            <xsl:if test="$situation != ''">
                <xsl:attribute name="situation" select="$situation"/>
            </xsl:if>

            <xsl:for-each select="$attributelist/tests/*[local-name() = $statgroup]/row">
                <!-- Check all the rows for team-stats in the listfile -->
                <xsl:variable name="name" select="./name"/>
                <!-- Get the name -->
                <xsl:variable name="stat-type" select="./stat-type"/>
                <!-- Get the stat-type -->
                <xsl:variable name="prefix" select="./prefix"/>
                <!-- Get the prefix -->
                <xsl:variable name="class" select="./class"/>
                <!-- Get the prefix -->

                <xsl:choose>
                    <xsl:when test="$situation != ''">

                        <xsl:choose>
                            <xsl:when test="$class != ''">
                                <xsl:if
                                    test="$oneteam//sm:stat[@class = $class and @stat-type = $stat-type and @situation = $situation]/@value">
                                    <!-- If the original has this in the generic stats -->
                                    <xsl:attribute name="{$name}">
                                        <xsl:value-of
                                            select="concat($prefix, $oneteam//sm:stat[@class = $class and @stat-type = $stat-type and @situation = $situation]/@value)"
                                        />
                                    </xsl:attribute>
                                    <!-- Create an attribute with it -->
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if
                                    test="$oneteam//sm:stat[@stat-type = $stat-type and @situation = $situation]/@value">
                                    <!-- If the original has this in the generic stats -->
                                    <xsl:attribute name="{$name}">
                                        <xsl:value-of
                                            select="concat($prefix, $oneteam//sm:stat[@stat-type = $stat-type and @situation = $situation]/@value)"
                                        />
                                    </xsl:attribute>
                                    <!-- Create an attribute with it -->
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="$class != ''">
                                <xsl:if
                                    test="$oneteam//sm:stat[@class = $class and @stat-type = $stat-type and not(@situation)]/@value">
                                    <!-- If the original has this in the generic stats -->
                                    <xsl:attribute name="{$name}">
                                        <xsl:value-of
                                            select="concat($prefix, $oneteam//sm:stat[@class = $class and @stat-type = $stat-type and not(@situation)]/@value)"
                                        />
                                    </xsl:attribute>
                                    <!-- Create an attribute with it -->


                                    <!--                                    <xsl:for-each select="$oneteam//sm:stat[@class = $class and @stat-type = $stat-type]">
                                        <xsl:variable name="attname" select="concat($name,'_',position())"/>
                                       <xsl:attribute name="{$attname}"><xsl:value-of select="concat($prefix,./@value)"/></xsl:attribute> <!-\- Create an attribute with it -\->
                                    </xsl:for-each>
-->
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if
                                    test="$oneteam//sm:stat[@stat-type = $stat-type and not(@situation)]/@value">
                                    <!-- If the original has this in the generic stats -->
                                    <xsl:attribute name="{$name}">
                                        <xsl:value-of
                                            select="concat($prefix, $oneteam//sm:stat[@stat-type = $stat-type and not(@situation)]/@value)"
                                        />
                                    </xsl:attribute>
                                    <!-- Create an attribute with it -->
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>


            </xsl:for-each>
            <!-- Alla rader -->

            <!-- Nu ska vi kolla om denna grupp hade någon undergrupp -->
            <xsl:for-each select="$attributelist/tests/*[local-name() = $statgroup]/substat">
                <xsl:variable name="statgroup" select="./statgroup"/>
                <xsl:variable name="elementname" select="./elementname"/>
                <xsl:variable name="situation" select="./situation"/>

                <xsl:variable name="oneSubGroup">
                    <xsl:call-template name="CheckSubStatGroup">
                        <xsl:with-param name="statgroup" select="$statgroup"/>
                        <xsl:with-param name="elementname" select="$elementname"/>
                        <xsl:with-param name="oneteam" select="$oneteam"/>
                        <xsl:with-param name="situation" select="$situation"/>
                    </xsl:call-template>
                </xsl:variable>

                <xsl:if
                    test="$oneSubGroup/node()[1][count(@*) &gt; 0] or $oneSubGroup/node()[1][count(node()) &gt; 0]">
                    <xsl:copy-of select="$oneSubGroup"/>
                </xsl:if>

            </xsl:for-each>

        </xsl:element>
        <!-- slut på ett element -->


    </xsl:template>
    <!-- Slut generellt template för en grupp -->




</xsl:stylesheet>
