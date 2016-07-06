Return-Path: <rtc-linux+bncBDSJBYGBRIMBB4OP6W5QKGQENWI7V2I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f10si179857wmg.2.2016.07.06.13.20.01
        for <rtc-linux@googlegroups.com>;
        Wed, 06 Jul 2016 13:20:01 -0700 (PDT)
Date: Wed, 6 Jul 2016 22:20:00 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Stephan Roslen <stephan@roslen.de>
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	wens@csie.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: sunxi: use external oscillator
Message-ID: <20160706202000.GC4247@lukather>
References: <577CC494.8020103@roslen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
In-Reply-To: <577CC494.8020103@roslen.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Jul 06, 2016 at 10:43:00AM +0200, Stephan Roslen wrote:
> We noticed some serious drift problems in Allwinner A20 RTCs. I
> found out, that the oscillator source needs to be set to an external
> 32.768 KHz oscillator instead of the internal 32.000 KHz oscillator.

You should wrap the commit description.

> 
> Signed-off-by: Stephan Roslen <stephan@roslen.de>
> ---
>  drivers/rtc/rtc-sunxi.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
> index abada60..001256e 100644
> --- a/drivers/rtc/rtc-sunxi.c
> +++ b/drivers/rtc/rtc-sunxi.c
> @@ -34,9 +34,19 @@
>  #include <linux/types.h>
>  
>  #define SUNXI_LOSC_CTRL				0x0000
> +
> +/* magic number required to set bit 0 */
> +#define SUNXI_LOSC_CTRL_KEY			0x16AA0000
> +
> +#define SUNXI_LOSC_CTRL_AUTO_SWT_EN		BIT(14)
> +
>  #define SUNXI_LOSC_CTRL_RTC_HMS_ACC		BIT(8)
>  #define SUNXI_LOSC_CTRL_RTC_YMD_ACC		BIT(7)
>  
> +#define SUNXI_LOSC_CTRL_EXT_GSM1		BIT(3)
> +#define SUNXI_LOSC_CTRL_EXT_GSM0		BIT(2)
> +#define SUNXI_LOSC_CTRL_SRC_SEL			BIT(0)
> +
>  #define SUNXI_RTC_YMD				0x0004
>  
>  #define SUNXI_RTC_HMS				0x0008
> @@ -438,6 +448,8 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	int ret;
>  
> +	uint32_t loscctrl;
> +
>  	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>  	if (!chip)
>  		return -ENOMEM;
> @@ -468,6 +480,19 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	loscctrl = readl(chip->base + SUNXI_LOSC_CTRL);
> +	loscctrl &= ~(SUNXI_LOSC_CTRL_AUTO_SWT_EN);
> +	loscctrl |= (SUNXI_LOSC_CTRL_SRC_SEL | SUNXI_LOSC_CTRL_KEY);
> +	loscctrl |= SUNXI_LOSC_CTRL_EXT_GSM1;
> +	writel(loscctrl, chip->base + SUNXI_LOSC_CTRL);
> +	udelay(100);

Why is that udelay needed?

> +
> +	loscctrl = readl(chip->base + SUNXI_LOSC_CTRL);
> +	if (!(loscctrl & SUNXI_LOSC_CTRL_SRC_SEL)) {
> +		dev_err(&pdev->dev, "Error: Set LOSC to external failed.\n");
> +		dev_err(&pdev->dev, "Warning: RTC time will be wrong!\n");
> +	}
> +

This isn't needed

The issue is actually worse than that.

That register controls the losc source for the whole clock tree, so it
will affect every clock in the system.

In order to have that correctly propagated, you should register a new
mux here in the clock framework, and have all the other clocks using
that mux as a parent.

That's going to be tricky, because the clocks usually probe way
earlier than the RTC driver. So I'm guessing you could do a clock
driver that maps the registers, register its clock, and then when the
RTC probes just takes over what has been setup already by the clock
driver. This also means removing the ability for the RTC to be
compiled as a module.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfWfwAAoJEBx+YmzsjxAg1+kP/ifCIpM8kP6BlHzSVAnO6Fv9
iGBNj9UqScYxRZDYmXHg3dt/+hzG/rlg8zkkf+G1PHjRcp+8v21ND+LBGt78RELU
9yaZXXcDQkhJRQgH/REBDXHak1CGwsC2Dwvv5OyJZm48kMjtoLBevyTiE1wij6N4
QVMXuA3cZhLXdV2IIy5+nno3MBRv7HG2lllCuG/L5l6ETsBMRpiexzx6ImF2KSHU
FH13lEpQ1TIuD88iIi8P46lgBhvK0QGNDe5nGMppgal/kCoYDxB2H6pfTdsX4xow
RjEv1gqmicsNhKTPSCjoYNM7ajq5TpPV1V4KrtShEjKnXVX5s1QAyyRyELEbkxDS
zeMPacSRYmNnsxi9da1jLYBE6SAHOdrhh7VTNFGiblAjOr+2k3KNNmtfVa4QWW8f
dedr4/RQmdNFptZaOUvJnJDv/cfgPPLR9DofMUkSzWZCsXp5O7cMhnMkJuCCR/fN
McLLVY/IvVG1AFiBbaJ3NmMHLKRQfJSHDX1rzBHPLUVy2v3ZM/werVWLKwVyruHz
DsttVn+zk78APKH1dU3UhNz1/w/GsHeqY+bXQIipgmVQAliH9UL/M9ljzGYAXLHF
nQDAjZgzzhhiZ7Mza1hjhocQm6vwq/Bt49XZ8GvvDNTizuJmf9wwI0Qr+RIwOdss
bDcwmpHMZnIKFEDaFDbG
=KWoq
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
