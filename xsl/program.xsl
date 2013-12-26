<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:output method="text" indent="no"/>

    <xsl:param name="xml-dir"/>
    <xsl:param name="json-dir"/>

    <xsl:variable name="public-sessions">|230|323|523|607|346|547|707|155A|269A|422|476|635|661|43|69|84|92|131|149|163|241|258|295|299|309|312|347|372|421|474|504|518|583|593|598|599|627|630|660|682|691|710|777|</xsl:variable>

    <xsl:variable name="morning">|4|5|6|7|8|9|10|11|</xsl:variable>
    <xsl:variable name="afternoon">|12|13|14|15|16|17|</xsl:variable>
    <xsl:variable name="evening">|18|19|</xsl:variable>
    <xsl:variable name="late-night">|20|21|22|23|</xsl:variable>

    <!-- Do "queries" in P_DTL_LINE always have a P_PRINT_ORD value of '95'? -->

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

    <xsl:template match="CONV_QUARK_XML">

        <!-- First pass (XML) -->
        <xsl:variable name="program">

            <xsl:apply-templates select="LIST_G_P_SEQ"/>

            <!-- Missing sessions -->
            <session id="M024H">
                <sequence>155A</sequence>
                <title>A Screening of <em>Eight Men Out</em>, a Film by John Sayles</title>
                <date>9 January</date>
                <day num="1" abbrev="th" ambig="Thurs.">Thursday</day>
                <start-time abbrev="18" minutes="30" ambig="eve" header="6:30 p.m.">6:30 p.m.</start-time>
                <end-time abbrev="20" minutes="45" ambig="eve">8:45 p.m.</end-time>
                <venue>Chicago Marriott</venue>
                <room>Grand I</room>
                <type abbrev="pub">Open to the Public</type>
                <details>
                    <line role="calendar">Thursday, 9 January, 6:30–8:45 p.m., Grand I, Chicago Marriott</line>
                    <line>Program arranged by the Office of the Executive Director</line>
                </details>
            </session>

        </xsl:variable>

        <!-- Sort on session start time -->
        <xsl:variable name="sorted-program">
            <sessions>
                <xsl:for-each select="$program/session">
                    <xsl:sort select="concat(day/@num, substring('0', string-length(start-time/@abbrev)), start-time/@abbrev, start-time/@minutes)" order="ascending" data-type="number"/>
                    <xsl:copy-of select="."/>
                </xsl:for-each>
            </sessions>
        </xsl:variable>

        <!-- Write as XML -->
        <xsl:result-document href="{$xml-dir}/program.xml" method="xml" indent="yes">
            <xsl:copy-of select="$sorted-program"/>
        </xsl:result-document>

        <!-- Second pass (JSON) -->
        <xsl:apply-templates select="$sorted-program"/>

    </xsl:template>


    <!-- First pass -->

    <xsl:template match="LIST_G_P_SEQ">
        <xsl:apply-templates select="G_P_SEQ"/>
    </xsl:template>

    <xsl:template match="G_P_SEQ">

        <session id="{P_PROG_ID}">

            <sequence>
                <xsl:choose>
                    <xsl:when test="P_SEQ and P_SEQ != ''"><xsl:value-of select="P_SEQ"/><xsl:value-of select="P_SEQ_SFX"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="P_PROG_ID"/></xsl:otherwise>
                </xsl:choose>
            </sequence>

            <title>
                <xsl:analyze-string select="translate(P_PROG_TLT, '+', '–')" regex="_([^_]+)_">
                    <xsl:matching-substring><em><xsl:value-of select="regex-group(1)"/></em></xsl:matching-substring>
                    <xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring>
                </xsl:analyze-string>
            </title>

            <!-- UPDATE: Days of the week -->
            <xsl:choose>
                <xsl:when test="P_DAY = '09-JAN-14'">
                    <date>9 January</date>
                    <day num="1" abbrev="th" ambig="Thurs.">Thursday</day>
                </xsl:when>
                <xsl:when test="P_DAY = '10-JAN-14'">
                    <date>10 January</date>
                    <day num="2" abbrev="fr" ambig="Fri.">Friday</day>
                </xsl:when>
                <xsl:when test="P_DAY = '11-JAN-14'">
                    <date>11 January</date>
                    <day num="3" abbrev="sa" ambig="Sat.">Saturday</day>
                </xsl:when>
                <xsl:when test="P_DAY = '12-JAN-14'">
                    <date>12 January</date>
                    <day num="4" abbrev="su" ambig="Sun.">Sunday</day>
                </xsl:when>
                <xsl:otherwise>
                    <date>[Unknown]</date>
                    <day num="0" abbrev="[Unknown]" ambig="[Unknown]">[Unknown]</day>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:analyze-string select="P_TIME" regex="([0-9]{{1,2}}):([0-9]{{2}}) ?(noon|a\.m\.|p\.m\.)?(\+([0-9]{{1,2}}):([0-9]{{2}}) (noon|a\.m\.|p\.m\.))?">

                <xsl:matching-substring>

                    <xsl:variable name="start-meridien">
                        <xsl:choose>
                            <xsl:when test="regex-group(3)"><xsl:value-of select="regex-group(3)"/></xsl:when>
                            <xsl:when test="regex-group(7)"><xsl:value-of select="regex-group(7)"/></xsl:when>
                            <xsl:otherwise>[Unknown]</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:variable name="end-meridien">
                        <xsl:choose>
                            <xsl:when test="regex-group(7)"><xsl:value-of select="regex-group(7)"/></xsl:when>
                            <xsl:otherwise>[Unknown]</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:variable name="start-time-abbrev">
                        <xsl:choose>
                            <xsl:when test="$start-meridien = 'p.m.'"><xsl:value-of select="number(regex-group(1)) + 12"/></xsl:when>
                            <xsl:when test="$start-meridien = '[Unknown]'">[Unknown]</xsl:when>
                            <xsl:otherwise><xsl:value-of select="regex-group(1)"/></xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:variable name="end-time-abbrev">
                        <xsl:choose>
                            <xsl:when test="$end-meridien = 'p.m.'"><xsl:value-of select="number(regex-group(5)) + 12"/></xsl:when>
                            <xsl:when test="$end-meridien = '[Unknown]'">[Unknown]</xsl:when>
                            <xsl:otherwise><xsl:value-of select="regex-group(5)"/></xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:variable name="start-time-ambiguation">
                        <xsl:choose>
                            <xsl:when test="contains($morning, concat('|', $start-time-abbrev, '|'))">mor</xsl:when>
                            <xsl:when test="contains($afternoon, concat('|', $start-time-abbrev, '|'))">aft</xsl:when>
                            <xsl:when test="contains($evening, concat('|', $start-time-abbrev, '|'))">eve</xsl:when>
                            <xsl:when test="contains($late-night, concat('|', $start-time-abbrev, '|'))">ln</xsl:when>
                            <xsl:otherwise>[Unknown]</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:variable name="end-time-ambiguation">
                        <xsl:choose>
                            <xsl:when test="contains($morning, concat('|', $end-time-abbrev, '|'))">mor</xsl:when>
                            <xsl:when test="contains($afternoon, concat('|', $end-time-abbrev, '|'))">aft</xsl:when>
                            <xsl:when test="contains($evening, concat('|', $end-time-abbrev, '|'))">eve</xsl:when>
                            <xsl:when test="contains($late-night, concat('|', $start-time-abbrev, '|'))">ln</xsl:when>
                            <xsl:otherwise>[Unknown]</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <start-time abbrev="{$start-time-abbrev}" minutes="{regex-group(2)}" ambig="{$start-time-ambiguation}" header="{regex-group(1)}:{regex-group(2)} {$start-meridien}">
                        <xsl:value-of select="regex-group(1)"/>:<xsl:value-of select="regex-group(2)"/><xsl:text> </xsl:text><xsl:value-of select="$start-meridien"/>
                    </start-time>

                    <xsl:if test="regex-group(4)">
                        <end-time abbrev="{$end-time-abbrev}" minutes="{regex-group(6)}" ambig="{$end-time-ambiguation}">
                            <xsl:value-of select="regex-group(5)"/>:<xsl:value-of select="regex-group(6)"/><xsl:text> </xsl:text><xsl:value-of select="$end-meridien"/>
                        </end-time>
                    </xsl:if>

                </xsl:matching-substring>

                <xsl:non-matching-substring>
                    <extra-time-info>[Unknown] <xsl:value-of select="."/></extra-time-info>
                </xsl:non-matching-substring>

            </xsl:analyze-string>

            <xsl:if test="(P_HOTEL and P_HOTEL != '') or (P_OFFSITE and P_OFFSITE = 'Y')">

                <venue>

                    <!-- UPDATE: Venues -->
                    <xsl:attribute name="abbrev">
                        <xsl:choose>
                            <xsl:when test="P_HOTEL = 'Sheraton Chicago'">sh</xsl:when>
                            <xsl:when test="P_HOTEL = 'Chicago Marriott'">ma</xsl:when>
                            <xsl:when test="P_HOTEL = 'Fairmont Chicago'">fa</xsl:when>
                            <xsl:when test="P_OFFSITE and P_OFFSITE = 'Y'">off</xsl:when>
                            <xsl:otherwise>[Unknown]</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>

                    <xsl:value-of select="P_HOTEL"/>

                </venue>

            </xsl:if>

            <xsl:if test="P_ROOM and P_ROOM != ''">
                <room><xsl:value-of select="P_ROOM"/></room>
            </xsl:if>

            <xsl:if test="P_SOCIAL and P_SOCIAL = 'Y'">
                <type abbrev="soc">Social</type>
            </xsl:if>

            <xsl:if test="P_PRESIDENTIAL and P_PRESIDENTIAL = 'Y'">
                <type abbrev="pre">Presidential Theme</type>
            </xsl:if>

            <xsl:if test="contains($public-sessions, concat('|', P_SEQ, P_SEQ_SFX, '|'))">
                <type abbrev="pub">Open to the Public</type>
            </xsl:if>

            <details>

                <line role="calendar"><xsl:value-of select="translate(P_TM_SLOT, '+', '–')"/></line>

                <xsl:if test="LIST_G_P_DTL_LINE">

                    <xsl:for-each select="LIST_G_P_DTL_LINE/G_P_DTL_LINE">

                        <xsl:sort select="P_PRINT_ORD" data-type="number" order="ascending"/>

                        <xsl:if test="P_DTL_LINE and P_DTL_LINE != '' and P_PRINT_ORD != '95'">

                            <!-- These series of RegExes impart italics and insert links around e-mail addresses and URLs. -->
                            <!-- They are "barely good enough" e-mail address / URL detectors, and they are TERRIBLE e-mail address / URL validators! -->
                            <!-- XSLT RegEx is sloooooooooooow. -->
                            <!-- UPDATE 2012-11-27: Added more Os to slow. -->

                            <xsl:variable name="sequence" select="../../P_SEQ"/>

                            <xsl:choose>

                                <xsl:when test="P_PRINT_ORD &lt;= 10 or ($sequence != '421' and $sequence != '660')">

                                    <line>

                                        <xsl:analyze-string select="translate(P_DTL_LINE, '+', '–')" regex="(https?://[^ ]+[^\. ])">
                                            <xsl:matching-substring><a href="{regex-group(1)}"><xsl:value-of select="regex-group(1)"/></a></xsl:matching-substring>
                                            <xsl:non-matching-substring>

                                                <xsl:analyze-string select="." regex="(www\.[^ ]+[^\. ])">
                                                    <xsl:matching-substring><a href="http://{regex-group(1)}"><xsl:value-of select="regex-group(1)"/></a></xsl:matching-substring>
                                                    <xsl:non-matching-substring>

                                                        <xsl:analyze-string select="." regex="visit ([^ ]{{10,}}[^\. ])">
                                                            <xsl:matching-substring>visit <a href="http://{regex-group(1)}"><xsl:value-of select="regex-group(1)"/></a></xsl:matching-substring>
                                                            <xsl:non-matching-substring>

                                                                <xsl:analyze-string select="." regex="([0-9A-Za-z][^&lt;&gt; ]*@[0-9A-Za-z][^&lt;&gt; ]*\.[A-Za-z]{{2,9}})">
                                                                    <xsl:matching-substring><a><xsl:attribute name="href">mailto:<xsl:value-of select="regex-group(1)"/></xsl:attribute><xsl:value-of select="regex-group(1)"/></a></xsl:matching-substring>
                                                                    <xsl:non-matching-substring>

                                                                        <xsl:analyze-string select="." regex="see (meetings|sessions) ([0-9]+) and ([0-9]+) and ([0-9]+)">
                                                                            <xsl:matching-substring>see <xsl:value-of select="regex-group(1)"/><xsl:text> </xsl:text><a href="#{regex-group(2)}"><xsl:value-of select="regex-group(2)"/></a>, <a href="#{regex-group(3)}"><xsl:value-of select="regex-group(3)"/></a>, and <a href="#{regex-group(4)}"><xsl:value-of select="regex-group(4)"/></a></xsl:matching-substring>
                                                                            <xsl:non-matching-substring>

                                                                            <xsl:analyze-string select="." regex="see (meetings|sessions) ([0-9]+) and ([0-9]+)">
                                                                                <xsl:matching-substring>see <xsl:value-of select="regex-group(1)"/><xsl:text> </xsl:text><a href="#{regex-group(2)}"><xsl:value-of select="regex-group(2)"/></a> and <a href="#{regex-group(3)}"><xsl:value-of select="regex-group(3)"/></a></xsl:matching-substring>
                                                                                <xsl:non-matching-substring>

                                                                                    <xsl:analyze-string select="." regex="For linked sessions, see meetings *(and *)?\.">
                                                                                        <xsl:matching-substring></xsl:matching-substring>
                                                                                        <xsl:non-matching-substring>

                                                                                            <xsl:analyze-string select="." regex="Reframing Postcolonial and Global Studies in the Longer ([^ ]+) \(346\)">
                                                                                                <xsl:matching-substring><a href="#346">Reframing Postcolonial and Global Studies in the Longer <em>Durée</em></a></xsl:matching-substring>
                                                                                                <xsl:non-matching-substring>

                                                                                                    <xsl:analyze-string select="." regex="the forum The Presidential Forum: Vulnerable Times \(230\)">
                                                                                                        <xsl:matching-substring><a href="#230">The Presidential Forum: Vulnerable Times</a></xsl:matching-substring>
                                                                                                        <xsl:non-matching-substring>

                                                                                                            <xsl:analyze-string select="." regex="_([^_]+)_">
                                                                                                                <xsl:matching-substring><em><xsl:value-of select="regex-group(1)"/></em></xsl:matching-substring>
                                                                                                                <xsl:non-matching-substring>

                                                                                                                    <xsl:analyze-string select="." regex="@IT@([^@]+)@RO@">
                                                                                                                        <xsl:matching-substring><em><xsl:value-of select="regex-group(1)"/></em></xsl:matching-substring>
                                                                                                                        <xsl:non-matching-substring>

                                                                                                                            <xsl:analyze-string select="." regex="^  . ">
                                                                                                                                <xsl:matching-substring></xsl:matching-substring>
                                                                                                                                <xsl:non-matching-substring>
                                                                                                                                    <xsl:value-of select="replace(., '--', '—')"/>
                                                                                                                                </xsl:non-matching-substring>
                                                                                                                            </xsl:analyze-string>
                                                                                                                        </xsl:non-matching-substring>
                                                                                                                    </xsl:analyze-string>

                                                                                                                </xsl:non-matching-substring>
                                                                                                            </xsl:analyze-string>

                                                                                                        </xsl:non-matching-substring>
                                                                                                    </xsl:analyze-string>

                                                                                                </xsl:non-matching-substring>
                                                                                            </xsl:analyze-string>

                                                                                        </xsl:non-matching-substring>
                                                                                    </xsl:analyze-string>

                                                                                </xsl:non-matching-substring>
                                                                            </xsl:analyze-string>

                                                                        </xsl:non-matching-substring>
                                                                    </xsl:analyze-string>

                                                                    </xsl:non-matching-substring>
                                                                </xsl:analyze-string>

                                                            </xsl:non-matching-substring>
                                                        </xsl:analyze-string>

                                                    </xsl:non-matching-substring>
                                                </xsl:analyze-string>

                                            </xsl:non-matching-substring>
                                        </xsl:analyze-string>

                                    </line>

                                </xsl:when>

                                <!-- UPDATE: Specially formatted sessions -->
                                <xsl:when test="$sequence = '421' and position() = last()">
                                    <line>1. Report of the Executive Director, Rosemary G. Feal</line>
                                    <line>2. The Presidential Address, “Connective Histories in Vulnerable Times,” Marianne Hirsch, Columbia Univ., MLA President. Hirsch will discuss her personal and scholarly interests in how traumatic stories are transmitted—in images and narratives made in the aftermath of violence—in the light of her current work on vulnerability. These connections provide a fulcrum for her reflections on the MLA and on the challenges facing the humanities. Hirsch will suggest that an acknowledgment of vulnerability, whether shared or differentially imposed, can create new space for connective engagements in vulnerable times.</line>
                                    <line>Reception immediately following.</line>
                                </xsl:when>

                                <xsl:when test="$sequence = '660' and position() = last()">
                                    <line>1. Margaret W. Ferguson, Univ. of California, Davis, MLA First Vice President, will present the William Riley Parker Prize, James Russell Lowell Prize, MLA Prize for a First Book, Kenneth W. Mildenberger Prize, Katherine Singer Kovacs Prize, Morton N. Cohen Award, MLA Prize for a Scholarly Edition, Aldo and Jeanne Scaglione Prize for Comparative Literary Studies, Aldo and Jeanne Scaglione Prize for French and Francophone Studies, Aldo and Jeanne Scaglione Prize for Studies in Slavic Languages and Literatures, Aldo and Jeanne Scaglione Prize for a Translation of a Scholarly Study of Literature, Aldo and Jeanne Scaglione Prize for Italian Studies, Aldo and Jeanne Scaglione Publication Award for a Manuscript in Italian Literary Studies, Lois Roth Award, William Sanders Scarborough Prize, and MLA Prize in United States Latina and Latino and Chicana and Chicano Literary and Cultural Studies.</line>
                                    <line>2. Rosemary G. Feal, MLA, will present the <em>MLA International Bibliography Fellowship</em> Awards.</line>
                                    <line>3. Rosemary G. Feal will announce the recipients of the seal of approval from the Committee on Scholarly Editions.</line>
                                    <line>4. Timothy Scheie, Univ. of Rochester, Eastman School of Music, ADFL President, will present the ADFL Award for Distinguished Service to the Profession to Elizabeth Bernhardt, Stanford Univ.</line>
                                    <line>5. Remarks by Elizabeth Bernhardt</line>
                                    <line>6. Susan Miller, Santa Fe Coll., ADE President, will present the ADE Francis Andrew March Award to Carol T. Christ, Smith Coll.</line>
                                    <line>7. Remarks by Carol T. Christ</line>
                                    <line>8. Marianne Hirsch will present the Phyllis Franklin Award for Public Advocacy of the Humanities to John Sayles.</line>
                                    <line>9. Remarks by John Sayles</line>
                                    <line>Reception immediately following.</line>
                                </xsl:when>

                            </xsl:choose>


                        </xsl:if>

                    </xsl:for-each>

                </xsl:if>

            </details>

            <!-- Currently unused -->

            <xsl:if test="S_TYPE and S_TYPE != ''">

                <xsl:choose>
                    <xsl:when test="S_TYPE = 'Special Session'">
                        <type abbrev="sps"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Special Event'">
                        <type abbrev="spe"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'MLA Organization'">
                        <type abbrev="mla"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Allied Organization'">
                        <type abbrev="all"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Affliate Organization'">
                        <type abbrev="aff"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Affiliate Organization'">
                        <type abbrev="aff"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'American Literature Section'">
                        <type abbrev="als"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Division'">
                        <type abbrev="div"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Discussion Group'">
                        <type abbrev="dis"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Forum'">
                        <type abbrev="for"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Forum Linked Session'">
                        <type abbrev="fls"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:otherwise>
                        <type abbrev="[Unknown]"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:otherwise>
                </xsl:choose>

            </xsl:if>

            <xsl:if test="LIST_G_1">

                <xsl:for-each select="LIST_G_1/G_1">

                    <xsl:sort data-type="number" order="ascending">
                        <xsl:attribute name="select">
                            <xsl:choose>
                                <xsl:when test="P_ROLE = 'Session Leader or Presider'">1</xsl:when>
                                <xsl:when test="P_ROLE = 'Speaker'">2</xsl:when>
                                <xsl:when test="P_ROLE = 'Respondent or Panelist'">3</xsl:when>
                                <xsl:otherwise>4</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:sort>

                    <speaker>

                        <xsl:attribute name="role">
                            <xsl:choose>
                                <xsl:when test="P_ROLE = 'Session Leader or Presider'">leader</xsl:when>
                                <xsl:when test="P_ROLE = 'Speaker'">speaker</xsl:when>
                                <xsl:when test="P_ROLE = 'Respondent or Panelist'">respondent</xsl:when>
                                <xsl:otherwise>[Unknown]</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>

                        <xsl:value-of select="P_FNAME"/><xsl:text> </xsl:text><xsl:value-of select="P_LNAME"/>

                    </speaker>

                </xsl:for-each>

            </xsl:if>

        </session>

    </xsl:template>

    <xsl:template name="parse-calendar">

        <xsl:param name="str"/>

        <!-- Strip out meridiens and "noon" -->
        <xsl:variable name="str2" select="replace($str, ' noon', '')"/>
        <xsl:variable name="str3" select="replace($str2, ' a.m.', '')"/>
        <xsl:variable name="str4" select="replace($str3, ' p.m.', '')"/>

        <!-- UPDATE: Venue names -->
        <!-- Shorten venue names -->
        <xsl:variable name="str5" select="replace($str4, 'Sheraton Chicago', 'Sheraton')"/>
        <xsl:variable name="str6" select="replace($str5, 'Chicago Marriott', 'Marriott')"/>
        <xsl:variable name="str7" select="replace($str6, 'Fairmont Chicago', 'Fairmont')"/>

        <xsl:value-of select="$str7"/>

    </xsl:template>


    <!-- Second pass (JSON output) -->

    <xsl:template match="sessions">

        <xsl:result-document href="{$json-dir}/program.json">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates select="session" mode="program">
                <xsl:sort select="concat(day/@num, substring('0', string-length(start-time/@abbrev)), start-time/@abbrev, start-time/@minutes)" order="ascending" data-type="number"/>
            </xsl:apply-templates>
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

    <xsl:template match="session" mode="program">

        <xsl:if test="position() = 1 or start-time/@header != preceding-sibling::session[1]/start-time/@header">

            <!-- Subheads for approximate session times -->
            <xsl:variable name="tod" select="concat(day, start-time/@abbrev)"/>
            <xsl:variable name="concurrent" select="self::session|following-sibling::session[concat(day, start-time/@abbrev) = $tod]"/>
            <xsl:variable name="subhead-categories">
                <xsl:text>[</xsl:text>
                <xsl:text>"</xsl:text><xsl:value-of select="day/@abbrev"/><xsl:text>",</xsl:text>
                <xsl:text>"</xsl:text><xsl:value-of select="start-time/@ambig"/><xsl:text>"</xsl:text>
                <!-- UPDATE: All filterable session classes -->
                <xsl:if test="count($concurrent[venue/@abbrev = 'sh']) &gt; 0">
                    <xsl:text>,"sh"</xsl:text>
                </xsl:if>
                <xsl:if test="count($concurrent[venue/@abbrev = 'ma']) &gt; 0">
                    <xsl:text>,"ma"</xsl:text>
                </xsl:if>
                <xsl:if test="count($concurrent[venue/@abbrev = 'fa']) &gt; 0">
                    <xsl:text>,"fa"</xsl:text>
                </xsl:if>
                <xsl:if test="count($concurrent[venue/@abbrev = 'eh']) &gt; 0">
                    <xsl:text>,"eh"</xsl:text>
                </xsl:if>
                <xsl:if test="count($concurrent[venue/@abbrev = 'off']) &gt; 0">
                    <xsl:text>,"off"</xsl:text>
                </xsl:if>
                <xsl:if test="count($concurrent[type/@abbrev = 'pub']) &gt; 0">
                    <xsl:text>,"pub"</xsl:text>
                </xsl:if>
                <xsl:if test="count($concurrent[type/@abbrev = 'soc']) &gt; 0">
                    <xsl:text>,"soc"</xsl:text>
                </xsl:if>
                <xsl:if test="count($concurrent[type/@abbrev = 'pre']) &gt; 0">
                    <xsl:text>,"pre"</xsl:text>
                </xsl:if>
                <xsl:text>]</xsl:text>
            </xsl:variable>

            <!-- JSON output -->
            <xsl:text>{</xsl:text>
            <xsl:text>"type":"subhead",</xsl:text>
            <xsl:text>"cat":</xsl:text><xsl:value-of select="$subhead-categories"/><xsl:text>,</xsl:text>
            <xsl:text>"title":"</xsl:text><xsl:value-of select="day"/>, <xsl:value-of select="start-time/@header"/><xsl:text>"</xsl:text>
            <xsl:text>},</xsl:text>

        </xsl:if>

        <xsl:variable name="session-categories">
            <xsl:text>[</xsl:text>
            <xsl:text>"</xsl:text><xsl:value-of select="day/@abbrev"/><xsl:text>",</xsl:text>
            <xsl:text>"</xsl:text><xsl:value-of select="start-time/@ambig"/><xsl:text>",</xsl:text>
            <xsl:text>"</xsl:text><xsl:value-of select="venue/@abbrev"/><xsl:text>"</xsl:text>
            <xsl:for-each select="type">
                <xsl:text>,"</xsl:text>
                <xsl:value-of select="@abbrev"/>
                <xsl:text>"</xsl:text>
            </xsl:for-each>
            <xsl:if test="room = 'Exhibit Hall Theater'">
                <xsl:text>,"eh"</xsl:text>
            </xsl:if>
            <xsl:text>]</xsl:text>
        </xsl:variable>

        <!-- JSON output -->
        <xsl:text>{</xsl:text>
        <xsl:text>"id":"</xsl:text><xsl:value-of select="sequence"/><xsl:text>",</xsl:text>
        <xsl:text>"oid":"</xsl:text><xsl:value-of select="@id"/><xsl:text>",</xsl:text>
        <xsl:text>"cat":</xsl:text><xsl:value-of select="$session-categories"/><xsl:text>,</xsl:text>
        <xsl:text>"title":"</xsl:text><xsl:apply-templates select="title/node()"/><xsl:text>",</xsl:text>
        <xsl:text>"loc":"</xsl:text><xsl:call-template name="parse-calendar"><xsl:with-param name="str" select="details/line[@role = 'calendar'][1]/node()"/></xsl:call-template><xsl:text>",</xsl:text>
        <xsl:text>"cal":"</xsl:text><xsl:value-of select="day"/>, <xsl:apply-templates select="details/line[@role = 'calendar'][1]/node()"/><xsl:text>",</xsl:text>
        <xsl:text>"text":[</xsl:text>
        <xsl:for-each select="details/line">
            <xsl:if test="not(@role) or @role != 'calendar'">
                <xsl:text>"</xsl:text><xsl:apply-templates select="node()"/><xsl:text>"</xsl:text>
                <xsl:if test="position() != last()">,</xsl:if>
            </xsl:if>
        </xsl:for-each>
        <xsl:text>]}</xsl:text>
        <xsl:if test="position() != last()">,</xsl:if>

    </xsl:template>

    <xsl:template match="*">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:for-each select="@*">
            <xsl:text> </xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text>=\&quot;</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>\&quot;</xsl:text>
        </xsl:for-each>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates select="* | text()"/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>

    <xsl:template match="text()">

        <xsl:analyze-string select="." regex="\s+">
            <xsl:matching-substring><xsl:text> </xsl:text></xsl:matching-substring>
            <xsl:non-matching-substring><xsl:value-of select="replace(., '&quot;', '\\&quot;')"/></xsl:non-matching-substring>
        </xsl:analyze-string>

    </xsl:template>

</xsl:stylesheet>
