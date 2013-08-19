<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<html lang="zh_cn">
			<head>							
				<link rel="stylesheet"  href="/cssjs/jquery.mobile-1.0.1.css" />
				
				<script src="/cssjs/jquery.js"></script>
				<script src="/cssjs/jquery.cookie.js"></script>
				<script src="/view/mobileBridge.js"></script>
				<script src="/cssjs/jquery.mobile-1.0.1.js"></script>
				<script src="/view/js/cherry.js"></script>
			</head>
			<body>
				<div id="notice" data-role="page">
					<div data-role="content" align="center">
						模板错误，请查看日志
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
