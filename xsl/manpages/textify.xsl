<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                exclude-result-prefixes="exsl"
                version="1.0">

  <xsl:output method="xml"
              encoding="US-ASCII"
              indent="yes"/>
  <xsl:preserve-space elements="*"/>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://docbook.sf.net/release/xsl/current/ for
     copyright and other information.

     ******************************************************************** -->

  <!-- textify.xsl - Make "textified" copies of templates from a stylesheet. -->

  <!-- This stylesheet is currently only used as part of the build for -->
  <!-- DocBook manpages releases. It creates a manpages/xref.xsl stylesheet -->
  <!-- containing transformed copies of templates for processing the "xref" -->
  <!-- and "olink" templates. -->

  <xsl:template match="/">
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> * This file was created automatically by textify.xsl </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> * as part of the DocBook manpages stylesheet build </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> * </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> * DocBook Project developers: DO NOT EDIT THIS FILE. </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> * </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> * Instead, edit a source stylesheet and then re-run </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> * textify.xsl to generate a new version of this file. </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="xsl:stylesheet" >
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="xsl:output">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="method">xml</xsl:attribute>
      <xsl:attribute name="encoding">UTF-8</xsl:attribute>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <!-- copy a template but transform it such that, when the copy is used, it -->
  <!-- takes the content which the original template would have output and -->
  <!-- instead reads into a variable which it then runs through -->
  <!-- "replace-entities" template -->

  <!-- the main purpose of this change is to make it possible to replace -->
  <!-- entities in output of xrefs and onlinks -->
  <xsl:template match="xsl:template">
    <xsl:choose>
      <xsl:when test="
                      @match = 'xref' or
                      @match = 'olink'
                      ">
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:element name="xsl:variable">
            <xsl:attribute name="name">content</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
          <xsl:element name="xsl:call-template">
            <xsl:attribute name="name">replace-entities</xsl:attribute>
            <xsl:element name="xsl:with-param">
              <xsl:attribute name="name">content</xsl:attribute>
              <xsl:attribute name="select">$content</xsl:attribute>
            </xsl:element>
          </xsl:element>
        </xsl:copy>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="processing-instruction()">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="comment()|text()"/>

</xsl:stylesheet>
