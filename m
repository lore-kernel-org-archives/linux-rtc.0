Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C83A4F32
	for <linux-rtc@vger.kernel.org>; Mon, 24 Aug 2026 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559910; cv=none; b=VQvrTRM2NVL0kEZpsbxC7s5hGYQSEJoIk1MLrR7MkCKz9lhUV82n/YOvXL4KYeKiz0F+VzjJBa+KSFoUjyKLrgt5xbnm4NkBGHGhe5iGsOoPz+d455S4W/+rOUhUZdLlDm2cuY4xroUTSTCX/9i6RP7opOv7MYk3lIwaWY24A2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559910; c=relaxed/simple;
	bh=sd0wTjRu+py5otY3RhVaPMv/COVScihoq+Ovo6RJlRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCliaVSsdYPilE4Me2/P1iupn30UEnES7+8ncjzSjyvT52osf2XAkSg9/vLOfTHkdeB55ww8RVi7Icrbg5fjZCkkIjuRPFs3BqNfsGKierEEJD7Gn53hErFSTX4HQM/lQauggPre8KiEvqI65y4lymR/uUEs2M2emPvJwYmGo4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LcXLufr5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LcXLufr5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7D12B1A17F9;
	Mon, 24 Aug 2026 08:25:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 51B755FFC1;
	Mon, 24 Aug 2026 08:25:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 552E211C78AD5;
	Mon, 24 Aug 2026 10:24:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787559897; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aMNiko4mX2CaYFJxQbJV4ZErlnwcfTH8qxZ0LtjS6ko=;
	b=LcXLufr5TlzT9eUmRMga8DYTIyEfOKE/PX+ZOuW3ltTzmdtQP07Pg8EhFuPHG1SaMFCq5N
	UAw9DSdvZqpFnLmorVrVWFPPM3oGRZzINhugnni2Lo15aprr21BrDHT4k+VlwYTOcrbbyP
	EnodBiBOz8ndlKoIeTM17T7jCRgIaDUjXG2wq3+5TYlJjTp4jf9MZ+IinxKRdY8eRHYCa6
	cFKwJjv84scBxyNbv0xgX8XA6hUfBCZjDx3762/4HUS04v99zzYdt5VjwMmQageDVoNNWi
	p6ewVKH3ygMDPhG/bdTN1BDxz42SbW/q+NOJEOHK4Gm9TcTz9eNzOXTdir/XYg==
Date: Mon, 24 Aug 2026 10:24:56 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf85063: disable the clkout output by default
Message-ID: <20260824082456e0edd7c6@mail.local>
References: <20260824080801.709764-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824080801.709764-1-alexander.sverdlin@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3

On 24/08/2026 10:07:59+0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> The PCF85063 powers up with its CLKOUT pin driving the 32.768 kHz. While
> it's possible to request a specific default frequency in the DT via
> assigned-clocks/assigned-clock-rates on the RTC node itself, even without
> a real consumer referencing the clock, there is no such possibility to
> disable the clock output by default.

Are you sure about this? The CCF should disable the clock if it is not
used.

> 
> Therefore gate CLKOUT in the driver before registering the OF provider,
> mirroring the pcf8563 and hym8563 siblings which already force an off state
> at registration. Doing it before devm_of_clk_add_hw_provider() leaves the
> real consumers in the device tree free to re-enable the output afterwards,
> while an otherwise unused CLKOUT now stays off.
> 
> In practice it means that with CLKOUT disabled the RTC consumes around
> 250nA at 25°C and 6-10uA with CLKOUT enabled (5v Vdd). Which means days vs
> hours on a supercapacitor.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/rtc/rtc-pcf85063.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index 01e209d88f5f3..0b6d8083b6456 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c
> @@ -523,6 +523,12 @@ static struct clk *pcf85063_clkout_register_clk(struct pcf85063 *pcf85063)
>  	/* optional override of the clockname */
>  	of_property_read_string(node, "clock-output-names", &init.name);
>  
> +	/* power-on default is the 32768 Hz output on; gate it until claimed */
> +	ret = regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
> +				 PCF85063_REG_CLKO_F_MASK, PCF85063_REG_CLKO_F_OFF);
> +	if (ret)
> +		return ret;
> +
>  	/* register the clock */
>  	clk = devm_clk_register(&pcf85063->rtc->dev, &pcf85063->clkout_hw);
>  
> -- 
> 2.55.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
