Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3945349C9;
	Thu,  1 Oct 2026 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871250; cv=none; b=toNhxjvu7BZQErecuOrWgcdiwEFZfhvwh1lp9IAneqZRWPbajGwZBcMdIxHlrDwZD5ri0AWdOnUeTtx81KcZBwPG8uqWvsDaMgS+0G3gvSh3l6ipcMjmTQDi0hsHJOp+sdPcd9OPXcIDTJ58MpUNSeCw/cAKkhmEw9Zt8dL64Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871250; c=relaxed/simple;
	bh=VQXS4+i4Mg4D0PiLXH9P56zA5pOuOFVJpHUxM1UEFcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clHFFvI9KPPHObXxepWOSHLBBz6qajqiTmrAK4FHAScx8Z5iQrE5kOKz0dEHIXUBAVlj54K56y/7frhEHrxQqc0mIFemZbHhHU8bKe2z6NiLGfVCt7g7kV8pGO+3LyzSaCEXnjQqW75xIl1qEOfQmljxZmeljWna6Od6VhYJ9Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glXv0z/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glXv0z/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7471F000FF;
	Thu,  1 Oct 2026 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871248;
	bh=ODXZA7pGtjbEYN4/fUySv4jAM+kY1k5++4+TMAJn2yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=glXv0z/MyYZ8ZR+tBQo9FTbRFIq9f8pT+n/3EZ2KueZCRWlZdGDQEkDTsF31hOtLt
	 RCXH96zuVe0kc5s/mhLWqkIUfp5IHUMH6Yt4q5Ed1kMNTBx+Tru3g/vF9pbVRUnq9m
	 HNmD35vsyzQX6adhvul9g23KXgqS06PKla8wMG0vd8FIKfeyzNn82eo8YXQUOFHVqx
	 3t2O13gtK+vNWhl2bOMklJ+N6/p/9m0TWZgTWYmRDZt4rDSjSwqscI90EU3emkCB7V
	 M4AE5PG8I1Rtmo9XBCaXtBDgZJ4cT4X8XcunVi8MJewHdBuLOtltPoMhanTTOgSUOH
	 xjXIGmpzJKpRQ==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Subject: [PATCH 25/38] rtc: m48t35: support the SGI IP35 timekeeper's 1968 year base
Date: Thu,  1 Oct 2026 18:12:00 +0200
Message-ID: <7c2b71a1627e49209a8c3311f4283eb92325852c.1790857966.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790857966.git.kaloz@kernel.org>
References: <cover.1790857966.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The M48T35 of SGI IP35-family machines counts its year from 1968. Take
the epoch from a platform id table, "rtc-m48t35" for IP27 and
"rtc-m48t35-ip35" for IP35, and bound the year to the part's century: on
IP27 a year past 2069 now fails to set.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/rtc/rtc-m48t35.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-m48t35.c b/drivers/rtc/rtc-m48t35.c
index 92f19bf997b2..69c313b4b6e8 100644
--- a/drivers/rtc/rtc-m48t35.c
+++ b/drivers/rtc/rtc-m48t35.c
@@ -49,6 +49,7 @@ struct m48t35_priv {
 	struct m48t35_rtc __iomem *reg;
 	size_t size;
 	unsigned long baseaddr;
+	unsigned int epoch;
 	spinlock_t lock;
 };
 
@@ -86,10 +87,7 @@ static int m48t35_read_time(struct device *dev, struct rtc_time *tm)
 	 * Account for differences between how the RTC uses the values
 	 * and how they are defined in a struct rtc_time;
 	 */
-	tm->tm_year += 70;
-	if (tm->tm_year <= 69)
-		tm->tm_year += 100;
-
+	tm->tm_year += priv->epoch - 1900;
 	tm->tm_mon--;
 	return 0;
 }
@@ -108,18 +106,10 @@ static int m48t35_set_time(struct device *dev, struct rtc_time *tm)
 	min = tm->tm_min;
 	sec = tm->tm_sec;
 
-	if (yrs < 1970)
-		return -EINVAL;
-
-	yrs -= 1970;
-	if (yrs > 255)    /* They are unsigned */
+	if (yrs < priv->epoch || yrs >= priv->epoch + 100)
 		return -EINVAL;
 
-	if (yrs > 169)
-		return -EINVAL;
-
-	if (yrs >= 100)
-		yrs -= 100;
+	yrs -= priv->epoch;
 
 	sec = bin2bcd(sec);
 	min = bin2bcd(min);
@@ -164,6 +154,7 @@ static int m48t35_probe(struct platform_device *pdev)
 				     pdev->name))
 		return -EBUSY;
 
+	priv->epoch = platform_get_device_id(pdev)->driver_data;
 	priv->baseaddr = res->start;
 	priv->reg = devm_ioremap(&pdev->dev, priv->baseaddr, priv->size);
 	if (!priv->reg)
@@ -178,11 +169,20 @@ static int m48t35_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(priv->rtc);
 }
 
+/* The year register on SGI IP35-family machines counts from 1968. */
+static const struct platform_device_id m48t35_id_table[] = {
+	{ "rtc-m48t35", 1970 },
+	{ "rtc-m48t35-ip35", 1968 },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, m48t35_id_table);
+
 static struct platform_driver m48t35_platform_driver = {
 	.driver		= {
 		.name	= "rtc-m48t35",
 	},
 	.probe		= m48t35_probe,
+	.id_table	= m48t35_id_table,
 };
 
 module_platform_driver(m48t35_platform_driver);
@@ -191,3 +191,4 @@ MODULE_AUTHOR("Thomas Bogendoerfer <tsbogend@alpha.franken.de>");
 MODULE_DESCRIPTION("M48T35 RTC driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:rtc-m48t35");
+MODULE_ALIAS("platform:rtc-m48t35-ip35");
-- 
2.47.3

