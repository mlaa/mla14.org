<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:output method="text"/>

    <xsl:param name="xml-dir"/>
    <xsl:param name="json-dir"/>

    <xsl:variable name="ext-chars"><xsl:text>ÀÁÂÃÄÅÆÈÉÊËßÇÐÌÍÎÏÑÒÓÔÕÖŒØÙÚÛÜÝŸáäãåçéèëíïñóôöøšúùü – ‘'</xsl:text></xsl:variable>
    <xsl:variable name="ext-chars-sort"><xsl:text>AAAAAAAEEEEBCDIIIINOOOOOOOUUUUYYabcdefghijklmnopqrstuvwxyzaaaaceeeiinoooosuuu</xsl:text></xsl:variable>

    <xsl:variable name="problem-chars"><xsl:text>– '</xsl:text></xsl:variable>
    <xsl:variable name="problem-chars-replacement"><xsl:text>- ’</xsl:text></xsl:variable>

    <xsl:variable name="date" select="current-date()"/>
    <xsl:variable name="time" select="current-time()"/>

    <xsl:variable name="year" select="substring(string($date), 1, 4)"/>
    <xsl:variable name="month-num" select="number(substring(string($date), 6, 2))"/>
    <xsl:variable name="day" select="number(substring(string($date), 9, 2))"/>

    <xsl:variable name="hour-num" select="number(substring(string($time), 1, 2))"/>
    <xsl:variable name="minutes" select="substring(string($time), 4, 2)"/>

    <xsl:variable name="month">
        <xsl:choose>
            <xsl:when test="$month-num = 12">Dec.</xsl:when>
            <xsl:when test="$month-num = 1">Jan.</xsl:when>
            <xsl:when test="$month-num = 2">Feb.</xsl:when>
            <xsl:when test="$month-num = 3">Mar.</xsl:when>
            <xsl:when test="$month-num = 4">Apr.</xsl:when>
            <xsl:when test="$month-num = 5">May</xsl:when>
            <xsl:when test="$month-num = 6">Jun.</xsl:when>
            <xsl:when test="$month-num = 7">Jul.</xsl:when>
            <xsl:when test="$month-num = 8">Aug.</xsl:when>
            <xsl:when test="$month-num = 9">Sep.</xsl:when>
            <xsl:when test="$month-num = 10">Oct.</xsl:when>
            <xsl:when test="$month-num = 11">Nov.</xsl:when>
            <xsl:otherwise>Jan.</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="hour">
        <xsl:choose>
            <xsl:when test="$hour-num = 0">12</xsl:when>
            <xsl:when test="$hour-num > 12"><xsl:value-of select="$hour-num - 12"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="$hour-num"/></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="meridien">
        <xsl:choose>
            <xsl:when test="$hour-num > 11">p.m.</xsl:when>
            <xsl:otherwise>a.m.</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>


    <!-- Master template -->

    <xsl:template match="CONV_PART_PROG_XML">

        <!-- First pass (XML) -->
        <xsl:variable name="people">
            <xsl:apply-templates select="LIST_G_P_FNAME"/>
        </xsl:variable>

        <!-- Write as XML -->
        <xsl:result-document href="{$xml-dir}/people.xml" method="xml" indent="yes">
            <xsl:copy-of select="$people"/>
        </xsl:result-document>

        <!-- Second pass (JSON) -->
        <xsl:apply-templates select="$people"/>

    </xsl:template>


    <!-- First pass -->

    <xsl:template match="LIST_G_P_FNAME">
        <people>
            <xsl:apply-templates select="G_P_FNAME">
                <xsl:sort select="translate(upper-case(P_LNAME), $ext-chars, $ext-chars-sort)" data-type="text" order="ascending"/>
                <xsl:sort select="translate(upper-case(P_FNAME), $ext-chars, $ext-chars-sort)" data-type="text" order="ascending"/>
            </xsl:apply-templates>
        </people>
    </xsl:template>

    <xsl:template match="G_P_FNAME">

        <person id="{P_ID}" sort="{translate(upper-case(substring(P_LNAME, 1, 1)), $ext-chars, $ext-chars-sort)}">

            <first><xsl:value-of select="translate(P_FNAME, $problem-chars, $problem-chars-replacement)"/></first>
            <last><xsl:value-of select="translate(P_LNAME, $problem-chars, $problem-chars-replacement)"/></last>


            <sessions>

                <count><xsl:value-of select="count(LIST_G_S_SEQ/G_S_SEQ)"/></count>

                <xsl:for-each select="LIST_G_S_SEQ/G_S_SEQ">

                    <xsl:sort select="S_SEQ" data-type="number" order="ascending"/>
                    <xsl:sort select="S_SEQ_SFX" data-type="text" order="ascending"/>

                    <session><xsl:value-of select="S_SEQ"/><xsl:value-of select="S_SEQ_SFX"/></session>

                </xsl:for-each>

            </sessions>

        </person>

    </xsl:template>


    <!-- Second pass (JSON output) -->

    <xsl:template match="people">

        <xsl:result-document href="{$json-dir}/people.json">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates select="person"/>
            <xsl:text>]</xsl:text>
        </xsl:result-document>

        <xsl:result-document href="{$json-dir}/updated.json">
            <xsl:text>{</xsl:text>
            <xsl:text>"date":"</xsl:text><xsl:value-of select="$day"/><xsl:text> </xsl:text><xsl:value-of select="$month"/><xsl:text> </xsl:text><xsl:value-of select="$year"/><xsl:text>",</xsl:text>
            <xsl:text>"time":"</xsl:text><xsl:value-of select="$hour"/>:<xsl:value-of select="$minutes"/><xsl:text> </xsl:text><xsl:value-of select="$meridien"/><xsl:text>",</xsl:text>
            <xsl:text>"timezone":"EST"</xsl:text>
            <xsl:text>}</xsl:text>
        </xsl:result-document>

    </xsl:template>

    <xsl:template match="person">

        <xsl:text>{</xsl:text>
        <xsl:text>"id":"</xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"cat":["</xsl:text>
        <xsl:value-of select="@sort"/>
        <xsl:text>"],</xsl:text>
        <xsl:text>"sessions":[</xsl:text>
        <xsl:for-each select="sessions/session">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>"</xsl:text>
            <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        <xsl:text>],</xsl:text>
        <xsl:text>"name":"</xsl:text><xsl:value-of select="first"/><xsl:text> </xsl:text><xsl:value-of select="last"/><xsl:text>"</xsl:text>
        <xsl:text>}</xsl:text>
        <xsl:if test="position() != last()">,</xsl:if>

    </xsl:template>

</xsl:stylesheet>
