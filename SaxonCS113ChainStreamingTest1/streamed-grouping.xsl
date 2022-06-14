<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="3.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="#all"
  expand-text="yes">

	<xsl:mode on-no-match="shallow-copy" streamable="yes"/>

	<xsl:strip-space elements="*"/>

	<xsl:output indent="yes"/>

	<xsl:template match="items">
		<xsl:copy>
			<xsl:fork>
				<xsl:for-each-group select="item" group-by="@producer">
					<producer name="{current-grouping-key()}">
						<xsl:fork>
							<xsl:for-each-group select="current-group()" group-by="@category">
								<category name="{current-grouping-key()}">
									<xsl:apply-templates select="current-group()"/>
								</category>
							</xsl:for-each-group>							
						</xsl:fork>
					</producer>
				</xsl:for-each-group>
			</xsl:fork>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="item">
		<item>{@id}</item>
	</xsl:template>

	<xsl:template match="/" name="xsl:initial-template">
		<xsl:next-match/>
		<xsl:comment>Transformed by {static-base-uri()} with {system-property('xsl:product-name')} {system-property('xsl:product-version')}</xsl:comment>
	</xsl:template>

</xsl:stylesheet>
