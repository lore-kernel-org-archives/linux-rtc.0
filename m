Return-Path: <rtc-linux+bncBDS4VBOTRMFRB2POR6WQKGQE3ML4DJY@googlegroups.com>
Received: from ni.com (skprod2.natinst.com. [130.164.80.23])
        by gmr-mx.google.com with ESMTPS id rs3si692632igb.2.2015.07.13.10.37.45
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 10:37:45 -0700 (PDT)
Date: Mon, 13 Jul 2015 12:37:39 -0500
From: Josh Cartwright <joshc@ni.com>
To: Joachim Eastwood <manabian@gmail.com>
Cc: alexandre.belloni@free-electrons.com, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v3 1/2] rtc: add rtc-lpc24xx driver
Message-ID: <20150713173739.GF25028@jcartwri.amer.corp.natinst.com>
References: <1436635730-15617-1-git-send-email-manabian@gmail.com>
 <1436635730-15617-2-git-send-email-manabian@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1436635730-15617-2-git-send-email-manabian@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sdOeJE8sLwpQaOMV"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--sdOeJE8sLwpQaOMV
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sat, Jul 11, 2015 at 07:28:49PM +0200, Joachim Eastwood wrote:
> Add driver for the RTC found on NXP LPC178x/18xx/408x/43xx devices.
> The RTC provides calendar and clock functionality together with
> alarm interrupt support.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
[..]
> +static int lpc24xx_rtc_remove(struct platform_device *pdev)
> +{
> +	struct lpc24xx_rtc *rtc = platform_get_drvdata(pdev);
> +
> +	/* Ensure all interrupt sources are masked */
> +	rtc_writel(rtc, LPC24XX_AMR, LPC24XX_ALARM_DISABLE);
> +	rtc_writel(rtc, LPC24XX_CIIR, 0);
> +
> +	rtc_writel(rtc, LPC24XX_CCR, LPC178X_CCALEN);
> +
> +	clk_disable_unprepare(rtc->clk_rtc);
> +	clk_disable_unprepare(rtc->clk_reg);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id lpc24xx_rtc_match[] = {
> +	{ .compatible = "nxp,lpc1788-rtc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lpc24xx_rtc_match);
> +
> +static struct platform_driver lpc24xx_rtc_driver = {
> +	.probe	= lpc24xx_rtc_probe,
> +	.remove	= lpc24xx_rtc_remove,
> +	.driver	= {
> +		.name = "lpc24xx-rtc",
> +		.of_match_table	= lpc24xx_rtc_match,
> +	},
> +};
> +module_platform_driver(lpc24xx_rtc_driver);
> +
> +MODULE_AUTHOR("Kevin Wells <wellsk40@gmail.com");

Missing closing '>'.

Otherwise,

Reviewed-by: Josh Cartwright <joshc@ni.com>

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

--sdOeJE8sLwpQaOMV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVo/dgAAoJEKp7ZBKwQFAr4BkH/jxWe3K1eCx9B1luX1iyiMnL
Nw6HK2BjU4bIxVwXE2fv0fp1Jvd/uzOwttpOyHyuFRsOR9X+saRuGpOImeAjHwMl
5g3I0NxC0zT7Y7f9+iNV9V7X/Vl7slFXoHQSNiPwrRevFsHAK4HXDeXYRBHQKjhT
byLCwDL6OErJcEmhzVXUBRQkKTqKOgaNKPN6HNE1ScNsNED+gj+eay/9Wkob0dj/
NHlAvDeR+cK0T4/1C/iw5ru/sV5qinFQtYVUor7q3AJCLuX0IDf9dC5FIDU1f8yY
yutmb6pVrS8UscIKMZ6rKo83oQIOT5YbPpnTJuzmHg7SWe3zByGwC6bc/AsHwyY=
=SzwP
-----END PGP SIGNATURE-----

--sdOeJE8sLwpQaOMV--
