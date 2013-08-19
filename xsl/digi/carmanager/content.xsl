<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<html lang="zh_cn">
			<head>							
				<link rel="stylesheet"  href="/cssjs/jquery.mobile-1.2.0.css" />
				
				<script src="/cssjs/jquery.js"></script>
				<script src="/cssjs/jquery.cookie.js"></script>
				
				<script src="/view/mobileBridge.js"></script>
				<script src="/cssjs/jquery.mobile-1.2.0.js"></script><script src="/view/js/cherry.js"></script>
			</head>
			<body>
				<div id="notice" data-role="page">
					<div data-role="content" align="center">
						<div data-role="collapsible-set" data-theme="c" data-content-theme="d">
							<div data-role="collapsible" data-collapsed="false">
								<h1>车辆预订申请单</h1>
								<p>
									<ul data-role="listview" data-inset="true" data-theme="d"> 
										<li><xsl:apply-templates select="//div[@id='divtA']/table" mode="c1"/></li>
									</ul>
								</p>
							</div>
							<div data-role="collapsible">
								<h1>查询可用车辆</h1>
								<p>
									<ul data-role="listview" data-inset="true" data-theme="d"> 
										<li><xsl:apply-templates select="//div[@id='tbl2']/table" mode="c1"/></li>
									</ul>
								</p>
							</div>
							<div data-role="collapsible">
								<h1>费用核算</h1>
								<p>
									<ul data-role="listview" data-inset="true" data-theme="d"> 
										<li><xsl:apply-templates select="//div[@id='tbl3']/table" mode="c1"/></li>
									</ul>
								</p>
							</div>
							<div data-role="collapsible">
								<h1>服务质量反馈</h1>
								<p>
									<ul data-role="listview" data-inset="true" data-theme="d"> 
										<li><xsl:apply-templates select="//div[@id='tbl4']/table" mode="c1"/></li>
									</ul>
								</p>
							</div>
						</div>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>

	
	<!-- 表单批量格式化模版 -->
	<!-- variable of $mini and $aliasname at mdp.xsl -->
	<xsl:template match="table" mode="c1">
		<xsl:apply-templates mode="c2"/>
	</xsl:template>

	<xsl:template match="tbody" mode="c2">
		<xsl:apply-templates mode="c2"/>
	</xsl:template>

	<xsl:template match="tr" mode="c2">
		<xsl:if test="position()=1 or position()=2">
			<!--<div style="width:100%" align="center">
				<xsl:value-of select=".//q/." />
			</div>-->
		</xsl:if>
		<xsl:if test="not(position()=1 or position()=2)">
			<div style="width:100%" align="left">
				<xsl:attribute name="align">
					<xsl:if test="not(position()=2 or position()=4)">left</xsl:if>
				</xsl:attribute>
				<xsl:apply-templates mode="c3"/>
			</div>
		</xsl:if>
		<hr/>
	</xsl:template>

	<xsl:template match="td" mode="c3">
		<xsl:if test="not(@style) or not(contains(@style, 'display:none'))">
			<!-- 发文红色字体特殊处理 -->
			<xsl:choose>
				<xsl:when test="@class='DF_GTable_LTD_Style'">
					<span style="width:38%;display:inline-block;text-align:right"><font color="red"><xsl:value-of select="."/></font></span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="c4"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="@class='DF_GTable_RTD_Style'">
				<br/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="text()" mode="c4">
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="q" mode="c4">
		<xsl:apply-templates mode="c4"/>
	</xsl:template>
	<xsl:template match="b" mode="c4">
		<xsl:if test="normalize-space(.)!=''">
			<strong><xsl:apply-templates mode="c4"/></strong>
		</xsl:if>
	</xsl:template>
	<xsl:template match="center" mode="c4">
		<span width="100%" align="center" mode="c4">
			<xsl:apply-templates mode="c4"/>
		</span>
	</xsl:template>
	<xsl:template match="font" mode="c4">
		<font>
			<xsl:apply-templates mode="c4"/>
		</font>
	</xsl:template>
	<xsl:template match="input" mode="c4">
		<xsl:value-of select="@value"/>
	</xsl:template>
	<xsl:template match="select" mode="c4">
		<xsl:if test="starts-with(@name, 'fld')">
			<xsl:value-of select="option[@selected='selected']/text()"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="textarea" mode="c4">
		<xsl:value-of select="text()"/>
	</xsl:template>
	<xsl:template match="hr" mode="c4">
		<hr size="{@size}">
			<xsl:attribute name="color">
				<xsl:call-template name="color">
					<xsl:with-param name="name"><xsl:value-of select="@color" /></xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
		</hr>
	</xsl:template>
	<xsl:template match="div" mode="c4">
		<xsl:apply-templates mode="c4" />
	</xsl:template>
	<xsl:template match="img" mode="c4">
	</xsl:template>
	<xsl:template name="color">
		<xsl:param name="name" />
		<xsl:choose>
			<xsl:when test="@color='red'">
				<xsl:text>#FF0000</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>#FF0000</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
