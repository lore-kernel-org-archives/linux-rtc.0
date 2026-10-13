Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC45013DF
	for <linux-rtc@vger.kernel.org>; Tue, 13 Oct 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901747; cv=none; b=erv3dSQ68RCM+s8wAO0yx+RkcxvN5NMxW6pdJCKqAoJrUjQjmzXQX4bT+Ku2HBEpZw2FAd3WKjzAUJYr7YfvCG6mgcxJON++RRBy9a+TniUO4m3lOBpHS8ILGSBCdRbZZmZtvoYwGGJhSi8tSSDKa0JvK2e+iNME22iPifOTjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901747; c=relaxed/simple;
	bh=7pQLICiwDQGi4veiyWftXynaBIvBK9m2LLGNbUmS5sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncVMSjrHybWDN8VreVnZJfEsUEjUuW2T9YGYEpbHrDJJl8qX35DinfqZC+oTtWe0c4goRas2CGif6/8DCEBUQa5jZERyGQNUANB5f6tD+gzCTr+clDP0O6ckegSFuz9vx/pYp7pj7o8UjVGergLHbmEd3D0QxIbef0UTMWPEMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KFMNICHw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KFMNICHw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D90AFC653ED
	for <linux-rtc@vger.kernel.org>; Tue, 13 Oct 2026 14:29:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22FBB60362;
	Tue, 13 Oct 2026 14:29:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F14E211D716F6;
	Tue, 13 Oct 2026 16:28:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791901738; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/wrEKHXblZ2nx08vVSNmqtW+MawEMZrP73gz4o7xkP8=;
	b=KFMNICHwjUCttLMRcQ8f8UpYbbNITs9ZkOtn8QztB0HEujRuu4s9DCD8JfJMnbrWabnIiR
	FBu1xIPD0ScmbWmJoOHORUt5xAFb6MkQLhsji4TL6hT0R7mJ2InhQQAwqqmBCp5YolvENd
	1Z/OBfIi1oIhzXO6tQjO3pfBPjaWJBG1GCY4O41/79CweGEg9vSeqbTR0KlMtwHsP9bzRQ
	B8lV+toVrGlLQqtW/863whyGiMmw1rsT1mNxTBtCxSGXzmZpBIYT5xzMxShAtjsu+oP9QY
	9QKeO5/m5l3DMFVCtF63RmoP9LgQRhONoOEi9/4di32CBDyPTHqLB9QVN1KXVA==
Date: Tue, 13 Oct 2026 16:28:55 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 30/53] rtc: m48t35: support the SGI IP35 timekeeper's
 1968 year base
Message-ID: <2026101314285588f70d85@mail.local>
References: <cover.1791890466.git.kaloz@kernel.org>
 <271bf55b479fbfd9b934e93a13eb8e96eb64e9fb.1791890466.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="QIi22XUrPanoMPkY"
Content-Disposition: inline
In-Reply-To: <271bf55b479fbfd9b934e93a13eb8e96eb64e9fb.1791890466.git.kaloz@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

--QIi22XUrPanoMPkY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 13/10/2026 15:16:50+0200, Imre Kaloz wrote:
> The M48T35 of SGI IP35-family machines counts its year from 1968. Take
> the epoch from a platform id table, "rtc-m48t35" for IP27 and
> "rtc-m48t35-ip35" for IP35, and bound the year to the part's century: on
> IP27 a year past 2069 now fails to set.
> 
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  drivers/rtc/rtc-m48t35.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-m48t35.c b/drivers/rtc/rtc-m48t35.c
> index 92f19bf997b2..fa228a2bb527 100644
> --- a/drivers/rtc/rtc-m48t35.c
> +++ b/drivers/rtc/rtc-m48t35.c
> @@ -49,6 +49,7 @@ struct m48t35_priv {
>  	struct m48t35_rtc __iomem *reg;
>  	size_t size;
>  	unsigned long baseaddr;
> +	unsigned int epoch;
>  	spinlock_t lock;
>  };
>  
> @@ -86,10 +87,7 @@ static int m48t35_read_time(struct device *dev, struct rtc_time *tm)
>  	 * Account for differences between how the RTC uses the values
>  	 * and how they are defined in a struct rtc_time;
>  	 */
> -	tm->tm_year += 70;
> -	if (tm->tm_year <= 69)
> -		tm->tm_year += 100;
> -
> +	tm->tm_year += priv->epoch - 1900;
>  	tm->tm_mon--;
>  	return 0;
>  }
> @@ -108,18 +106,10 @@ static int m48t35_set_time(struct device *dev, struct rtc_time *tm)
>  	min = tm->tm_min;
>  	sec = tm->tm_sec;
>  
> -	if (yrs < 1970)
> -		return -EINVAL;
> -
> -	yrs -= 1970;
> -	if (yrs > 255)    /* They are unsigned */
> -		return -EINVAL;
> -
> -	if (yrs > 169)
> +	if (yrs < priv->epoch || yrs >= priv->epoch + 100)
>  		return -EINVAL;
>  
> -	if (yrs >= 100)
> -		yrs -= 100;
> +	yrs -= priv->epoch;
>  


Instead of open coding, you should use start_secs after setting the rtc
range in probe(). attached i a patch I refreshed for the
devm_rtc_allocate_device/devm_rtc_register_device conversion that you
can include in this series. drivers/rtc/rtc-mt6397.c is an example that
should be working for you.

I never sent the patch because it is not clear from the datasheet how
well leap year calculation works. My guess is that it worked in 2000 but
fails in 2100.

>  	sec = bin2bcd(sec);
>  	min = bin2bcd(min);
> @@ -149,9 +139,13 @@ static const struct rtc_class_ops m48t35_ops = {
>  
>  static int m48t35_probe(struct platform_device *pdev)
>  {
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
>  	struct resource *res;
>  	struct m48t35_priv *priv;
>  
> +	if (!id)
> +		return -ENODEV;
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res)
>  		return -ENODEV;
> @@ -164,6 +158,7 @@ static int m48t35_probe(struct platform_device *pdev)
>  				     pdev->name))
>  		return -EBUSY;
>  
> +	priv->epoch = id->driver_data;
>  	priv->baseaddr = res->start;
>  	priv->reg = devm_ioremap(&pdev->dev, priv->baseaddr, priv->size);
>  	if (!priv->reg)
> @@ -178,11 +173,20 @@ static int m48t35_probe(struct platform_device *pdev)
>  	return PTR_ERR_OR_ZERO(priv->rtc);
>  }
>  
> +/* The year register on SGI IP35-family machines counts from 1968. */
> +static const struct platform_device_id m48t35_id_table[] = {
> +	{ "rtc-m48t35", 1970 },
> +	{ "rtc-m48t35-ip35", 1968 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, m48t35_id_table);
> +
>  static struct platform_driver m48t35_platform_driver = {
>  	.driver		= {
>  		.name	= "rtc-m48t35",
>  	},
>  	.probe		= m48t35_probe,
> +	.id_table	= m48t35_id_table,
>  };
>  
>  module_platform_driver(m48t35_platform_driver);
> @@ -191,3 +195,4 @@ MODULE_AUTHOR("Thomas Bogendoerfer <tsbogend@alpha.franken.de>");
>  MODULE_DESCRIPTION("M48T35 RTC driver");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:rtc-m48t35");
> +MODULE_ALIAS("platform:rtc-m48t35-ip35");
> -- 
> 2.47.3
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--QIi22XUrPanoMPkY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-rtc-m48t35-switch-to-devm_rtc_allocate_device.patch

From 7aed40aa17edfdd132ad10f6fb1ca9f1f1ddac07 Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 13 Oct 2026 16:21:06 +0200
Subject: [PATCH] rtc: m48t35: switch to devm_rtc_allocate_device

Switch to devm_rtc_allocate_device/devm_rtc_register_device, this allows
for further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-m48t35.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-m48t35.c b/drivers/rtc/rtc-m48t35.c
index 92f19bf997b2..0f4a3cb1e1f0 100644
--- a/drivers/rtc/rtc-m48t35.c
+++ b/drivers/rtc/rtc-m48t35.c
@@ -173,9 +173,13 @@ static int m48t35_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	priv->rtc = devm_rtc_device_register(&pdev->dev, "m48t35",
-				  &m48t35_ops, THIS_MODULE);
-	return PTR_ERR_OR_ZERO(priv->rtc);
+	priv->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(priv->rtc))
+		return PTR_ERR(priv->rtc);
+
+	priv->rtc->ops = &m48t35_ops;
+
+	return devm_rtc_register_device(priv->rtc);
 }
 
 static struct platform_driver m48t35_platform_driver = {
-- 
2.56.0


--QIi22XUrPanoMPkY--
