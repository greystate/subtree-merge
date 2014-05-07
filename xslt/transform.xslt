<?xml version="1.0" encoding="utf-8" ?>
<!--
	## transform.xslt
	
	Simple starter template for a macro.
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY % entities SYSTEM "mocks/entities.ent">
	%entities;
]>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:umb="urn:umbraco.library"
	exclude-result-prefixes="umb"
>
	&compatibility;
	
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

	<xsl:param name="currentPageId" />
	<xsl:param name="currentPage" select="//*[@id = $currentPageId]" />
	<xsl:variable name="siteRoot" select="$currentPage/ancestor-or-self::Website" />
	
	<xsl:template match="/">
		<xsl:apply-templates select="$currentPage" />
	</xsl:template>
	
</xsl:stylesheet>