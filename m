Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADBD52379B;
	Tue, 13 Oct 2026 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897572; cv=none; b=tTyFGwfB6ugWqO70CIQ3znJ+6l35ueR+piL1TYn+RoAOiCsH93h8W8u6xhLO2IP2M8bErjoPI6T+WhMpRdbFXM3rxqY/ATgTtHNT3mxizq8tHG1RwwzzJ3KqAHKMewa59LvbWqx0BraTUHwaGMMPzI3mqtpK/XjcpW8nPnJwIk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897572; c=relaxed/simple;
	bh=QipJ6wPBHpMP+BTSosweW60JH6rIH+4Fj/QcnsO3b3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0DqBWM/bF+WNlP7Vgki11LHx+N6++s9Ix9FrYyXHsjSPPL0xLxaOwW20XjLKQVgMWOC+q0J7cB3LSCQi+vQ5PZvlLJyJdFLYYPEnMe1RFJHHWHd1XRiA+JEAHp/BGAqL+qo6KWWzMJr+9x6tY1qTYS3W7H9uxnIuyQO37Sp/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpMs+n4V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpMs+n4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8D01F00898;
	Tue, 13 Oct 2026 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897571;
	bh=QECiByFAFAN0zfVwy7WM+UVWM1oEiELug/4rtzxS9n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dpMs+n4VcEWc31lqlbRsIjlkGNEhUKknBAGy5RFpyHKnQ8kksacxE084ObRuht6He
	 +RvyE7HkfVot325Q8eKMvjsYPbyLdWigdfXjgGT6jT6/hS8p3KLqmzismo8ZnU59rC
	 op71dq9P12aeLxdCAJMujgL7OzU4JCu1YnhtCYpxEkqkTXODzUgAOkpyvWWqb2ZSaN
	 9jP6uP+SsEuSIp0Wyvc1oXrXbjIxUWE3Ze4zEsuluv+6Gh8GbfpGA+05tmybXcNifz
	 xiPGssQoyoE2PU2mua5FP27yYgKqjpXwjq84bfk2GLqLZZ+4fib3WLmUGcNqOGFy0S
	 TV9Hex8WE8Y6A==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Subject: [PATCH v2 30/53] rtc: m48t35: support the SGI IP35 timekeeper's 1968 year base
Date: Tue, 13 Oct 2026 15:16:50 +0200
Message-ID: <271bf55b479fbfd9b934e93a13eb8e96eb64e9fb.1791890466.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791890466.git.kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
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
 drivers/rtc/rtc-m48t35.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-m48t35.c b/drivers/rtc/rtc-m48t35.c
index 92f19bf997b2..fa228a2bb527 100644
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
-		return -EINVAL;
-
-	if (yrs > 169)
+	if (yrs < priv->epoch || yrs >= priv->epoch + 100)
 		return -EINVAL;
 
-	if (yrs >= 100)
-		yrs -= 100;
+	yrs -= priv->epoch;
 
 	sec = bin2bcd(sec);
 	min = bin2bcd(min);
@@ -149,9 +139,13 @@ static const struct rtc_class_ops m48t35_ops = {
 
 static int m48t35_probe(struct platform_device *pdev)
 {
+	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct resource *res;
 	struct m48t35_priv *priv;
 
+	if (!id)
+		return -ENODEV;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
@@ -164,6 +158,7 @@ static int m48t35_probe(struct platform_device *pdev)
 				     pdev->name))
 		return -EBUSY;
 
+	priv->epoch = id->driver_data;
 	priv->baseaddr = res->start;
 	priv->reg = devm_ioremap(&pdev->dev, priv->baseaddr, priv->size);
 	if (!priv->reg)
@@ -178,11 +173,20 @@ static int m48t35_probe(struct platform_device *pdev)
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
@@ -191,3 +195,4 @@ MODULE_AUTHOR("Thomas Bogendoerfer <tsbogend@alpha.franken.de>");
 MODULE_DESCRIPTION("M48T35 RTC driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:rtc-m48t35");
+MODULE_ALIAS("platform:rtc-m48t35-ip35");
-- 
2.47.3

