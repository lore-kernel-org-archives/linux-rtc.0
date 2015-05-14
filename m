Return-Path: <rtc-linux+bncBDS4VBOTRMFRBS6O2OVAKGQEMYTL4LY@googlegroups.com>
Received: from ni.com (skprod3.natinst.com. [130.164.80.24])
        by gmr-mx.google.com with ESMTPS id lr7si847477igb.2.2015.05.14.11.19.54
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 11:19:55 -0700 (PDT)
Date: Thu, 14 May 2015 13:19:53 -0500
From: Josh Cartwright <joshc@ni.com>
To: Joachim Eastwood <manabian@gmail.com>
Cc: akpm@linux-foundation.org, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rtc-linux@googlegroups.com, wellsk40@gmail.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: add rtc-lpc24xx driver
Message-ID: <20150514181953.GC23600@jcartwri.amer.corp.natinst.com>
References: <1431624875-20990-1-git-send-email-manabian@gmail.com>
 <1431624875-20990-2-git-send-email-manabian@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1431624875-20990-2-git-send-email-manabian@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hello Joachim,

Just a quick comment/question below.

On Thu, May 14, 2015 at 07:34:34PM +0200, Joachim Eastwood wrote:
> Add driver for the RTC found on NXP LPC24xx/178x/18xx/43xx devices.
> The RTC provides calendar and clock functionality together with
> periodic tick and alarm interrupt support.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
[..]
> +
> +static const struct of_device_id lpc24xx_rtc_match[] = {
> +	{ .compatible = "nxp,lpc1788-rtc", .data = (void *)HAVE_CALIBRATION},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lpc24xx_rtc_match);
> +
> +static int lpc24xx_rtc_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	struct lpc24xx_rtc *rtc;
> +	struct resource *res;
> +	u32 rtc_ccr = 0;
> +	int irq, ret;
> +
[..]
> +
> +	/* Clear the counter increment state */
> +	rtc_writel(rtc, LPC24XX_ILR, LPC24XX_RTCCIF);
> +
> +	if (rtc->features & HAVE_PRESCALER) {
> +		/* Clock source is 32k oscillator */
> +		rtc_ccr = LPC24XX_CLKSRC;
> +		rtc_writel(rtc, LPC24XX_CCR, rtc_ccr);
> +
> +		/* Set prescaler to divide by 1 */
> +		rtc_writel(rtc, LPC24XX_PREINT, 0);
> +		rtc_writel(rtc, LPC24XX_PREFRAC, 0);
> +	}
> +
> +	if (rtc->features & HAVE_SUBSECOND) {
> +		/* Disable sub-second interrupt */
> +		rtc_writel(rtc, LPC24XX_CISS, 0);
> +	}

Neither HAVE_PRESCALER, nor HAVE_SUBSECOND are used for the claimed
supported RTC, so this is effectively dead code.  Was this something you
intended to add later?  Some remnant of the rework?

  Josh

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVVOdFAAoJEKp7ZBKwQFAreFoH/jEMVQAGY8PFXDOX1/TanMBo
+mTUBJueULKs1jbFi7TBvHzJOnOOYDIWU4DyFBOXt2yAZWGkEXj/+cnpUd0Xr0P2
pVaeVkmDr6EtDFMr1CrmgKs3nqQD8xqTj6osG3Q47GTYvB0jhgYig60NiEOcAiW6
YId1wgCVoACwRC2yBjd1IKikK2Fsgy7A/PJYySkGB2AWAW8YJXlNnWFkNLuib2K9
LDprDqBpX+xt8K9tB2ZKUFN7ZqihiIclGIAUwG34Dyo6kCR/DFjkhkhzw/uWFlJo
u+3idreaWNXMCdGS02KeaqkgwEYWY2+mwBIJcQ+VI98Lov9S6slepV9arwipdvM=
=D+hp
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
