<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<html lang="zh_cn">
			<head>							
				<link rel="stylesheet"  href="/cssjs/jquery.mobile-1.2.0.css" />
				
				<style>
					pre {
						white-space: pre-wrap;
						white-space: -moz-pre-wrap;
						white-space: -pre-wrap;
						white-space: -o-pre-wrap;
						word-wrap: break-word;
						width:100%;
					}
				</style>
				<script src="/cssjs/jquery.js"></script>
				<script src="/cssjs/jquery.cookie.js"></script>
				
				<script src="/view/mobileBridge.js"></script>
				<script src="/cssjs/jquery.mobile-1.2.0.js"></script><script src="/view/js/cherry.js"></script>
				<script>
					var title = "<xsl:value-of select='//title/text()'/>";
					if(title==""){
						title = '内容';
					}
					var _title=new cherry.bridge.NativeOperation("case","setProperty",["title",title]);
					_title.dispatch();
					cherry.bridge.flushOperations();
				</script>
			</head>
			<body>
				<div id="notice" data-role="page">
					<div data-role="content" align="center">
						<script type="text/javascript">
							function viewfile(url){
								$.hori.loadPage(url);
							}
						</script>
						<div align="center" style="width:100%"><strong><xsl:value-of select="//div[@id='docContent']/div[1]/."/></strong></div>
						<div data-role="collapsible-set" data-theme="c" data-content-theme="d">
							<ul data-role="listview" data-inset="true">
								<li data-role="list-divider">工作日程</li>
								<li>
									<xsl:apply-templates select="//table[@class='DF_GTable_Style']/tbody[1]/tr[position()&gt;1]" mode="c2"/>
									<xsl:apply-templates select="//table[@class='DF_GTable_Style']/tbody[2]/tr" mode="c2"/>
								</li>
							</ul>
						</div>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="tr" mode="time">
		<xsl:apply-templates mode="time"/>
		<hr/>
	</xsl:template>

	<xsl:template match="td" mode="time">
		<xsl:variable name="pos" select="position()"/>
		<xsl:if test="position()!=1">
			<xsl:value-of select="../../tr[1]/td[$pos]/."/>
			<xsl:text>:</xsl:text>
		</xsl:if>
		<xsl:value-of select="."/>
		<br/>
	</xsl:template>

	<xsl:template match="a" mode="file">
		<xsl:if test="@href='#'">
			<a href="javascript:void(0)" onclick="viewfile('/view/digi/file/{substring(substring-before(substring-after(@onclick,'('),')'), 2)});"  data-role="button"><xsl:value-of select="."/></a>
		</xsl:if>
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
		<div style="width:100%" align="left">
			<xsl:attribute name="align">
				<xsl:if test="not(position()=2 or position()=4)">left</xsl:if>
			</xsl:attribute>
			<xsl:apply-templates mode="c3"/>
		</div>
	</xsl:template>

	<xsl:template match="th" mode="c3">
	</xsl:template>
	<xsl:template match="td" mode="c3">
		<xsl:if test="not(contains(@style, 'display:none'))">
			<!-- 发文红色字体特殊处理 -->
			<xsl:choose>
				<xsl:when test="@class='DF_GTable_LTD_Style'">
					<span style=""><xsl:value-of select="."/></span>
				</xsl:when>
				<xsl:when test="@class='DF_GTable_TH_Style'">
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="c4"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="@class='DF_GTable_RTD_Style'">
				<hr/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="text()" mode="c4">
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="span" mode="c4">
		<xsl:if test="not(@style) or @style!='display:none'">
			<xsl:value-of select="."/>
		</xsl:if>
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
