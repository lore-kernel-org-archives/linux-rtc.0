Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD442E41E;
	Fri, 21 Aug 2026 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330467; cv=none; b=u6UrUsZvRwXQOg587FclTishnYLDWCcbp7rN+uU/W9SuMvHa9GVvsKP9WwWga8iLHXq6QRrvpIoap8WLLoEZTVjHDGL53umXq2H4Too4m8EvKhBxpv9z32VcpoGZ1bK21KSbuhtMKSosJYcGUokImx/5JKWeMBkHoLPaWrO96fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330467; c=relaxed/simple;
	bh=PMvp+6K0nqJTmS+H8aATdAgw+H6mFSdRw9vbvGRG73g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRZZHx/Z2O2O1Whj6laQujEx6B8yg0M7V3HGur7xXtW4n+l0spvodNBMCzUGL0zc5oeXPnGdjTrxkdhXrKXAanqXN0tWNh7GgtDVCosW1v5zTEFEkQOZH5CMwo9b9qJ0CyfX7emUhkEfDNe5bKVegULPPc7hYIVOgTCUwqK6c1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dZhGatd/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dZhGatd/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 81B484E4131D;
	Fri, 21 Aug 2026 16:40:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 36F95604AA;
	Fri, 21 Aug 2026 16:40:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB16411C77441;
	Fri, 21 Aug 2026 18:40:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787330453; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9w4aNObF1g63xs4aGcSnHDEyiVTWLLQJXVHzuhgeMq0=;
	b=dZhGatd/Tk6ZLtQOj485wAETdgB49rOofHsXiHbPqV25qn6XdEvByWqa1Zrf2TcQaUiNFD
	A555CPuBPmCycs+uZh4RWSCUKacB3GibaAhcxJANVCtG4MAf+vvqox933+6tD9EW6uZCPE
	5dhc+Vx5CA9t31r99AjmWh/V1t6sQWMgDUXMKEzcFoYRQ3JuF/BL7Cq1hrcm2w+p5KVGf8
	RIKsL+qbxvGyuVzDl3fT8c7/GpXKf3JPYS4JQUxOPDDTADUt/VwOb9xiuToDJc7Sw1MD4r
	vyEhCMtN88RRrWt/b8Fr2Mh9zIu/+YL3Xm68+npN3g/oNbBgJ/g8GSrSWbMfag==
Date: Fri, 21 Aug 2026 18:40:50 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 15/17] rtc: rzn1: Add OF match data to gate SUBU
 register access
Message-ID: <20260821164050abd3ceed@mail.local>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821135608.275233-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 21/08/2026 14:56:06+0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The RZ/N1 RTC driver selects SCMP mode only when an optional xtal clock
> is provided at a valid rate other than 32768 Hz. Without an xtal clock,
> or when it runs at 32768 Hz, the driver uses SUBU mode.
> 
> However, the RTCA0SUBU register used by SUBU mode is not present on all
> SoCs that integrate a similar variant of the RTC block. Allowing SUBU
> mode on those variants would expose RTC offset operations that access a
> non-existent register.
> 
> Add OF match data to describe whether the RTC supports the SUBU register.
> Reject probe with -EOPNOTSUPP when SUBU mode would be selected on a
> variant without SUBU support.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> v4->v5:
> - Renamed rzn1_data to rzn1_rtc_rzn1_data
> - Added a print message to indicate that SUBU mode is not supported
>   on the variant.
> - Added a comment to indicate that the xtal clock is NULL when SUBU
>   mode is not supported.
> - Added Suggested-by tag from Wolfram.
> 
> v3->v4:
> - New patch
> ---
>  drivers/rtc/rtc-rzn1.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 

This doesn't apply cleanly, can you rebase on rtc-next? If you do so
today, I'll include the series this merge window.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 8b68a5ad19c0..35770bff129f 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/rtc.h>
> @@ -65,6 +66,10 @@
>  #define RZN1_RTC_TIMEC 0x68
>  #define RZN1_RTC_CALC 0x6c
>  
> +struct rzn1_rtc_data {
> +	bool has_subu;
> +};
> +
>  struct rzn1_rtc {
>  	struct rtc_device *rtcdev;
>  	void __iomem *base;
> @@ -404,6 +409,7 @@ static void rzn1_rtc_disable_hardware(void *data)
>  
>  static int rzn1_rtc_probe(struct platform_device *pdev)
>  {
> +	const struct rzn1_rtc_data *data;
>  	struct device *dev = &pdev->dev;
>  	unsigned long rate = 32768;
>  	struct rzn1_rtc *rtc;
> @@ -411,6 +417,10 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
>  	struct clk *xtal;
>  	int irq, ret;
>  
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
>  	rtc = devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
>  	if (!rtc)
>  		return -ENOMEM;
> @@ -454,8 +464,12 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
>  		if (rate < 32000 || rate > BIT(22))
>  			return -EOPNOTSUPP;
>  
> -		if (rate != 32768)
> +		if (rate != 32768 || !data->has_subu)
>  			scmp_val = RZN1_RTC_CTL0_SLSB_SCMP;
> +	} else if (!data->has_subu) {
> +		/* xtal is NULL here */
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "No valid XTAL provided and SUBU mode not supported\n");
>  	}
>  
>  	/* Calculate the duration of two RTC_PCLK clock cycles */
> @@ -508,8 +522,12 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
>  	return devm_rtc_register_device(rtc->rtcdev);
>  }
>  
> +static const struct rzn1_rtc_data rzn1_rtc_rzn1_data = {
> +	.has_subu = true,
> +};
> +
>  static const struct of_device_id rzn1_rtc_of_match[] = {
> -	{ .compatible	= "renesas,rzn1-rtc" },
> +	{ .compatible	= "renesas,rzn1-rtc", .data = &rzn1_rtc_rzn1_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rzn1_rtc_of_match);
> -- 
> 2.43.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
