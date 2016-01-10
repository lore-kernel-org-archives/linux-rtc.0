Return-Path: <rtc-linux+bncBDQ2L75W5QGBBT5CZG2AKGQE3JQWDPA@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id a76si1278563pfj.2.2016.01.10.04.40.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 10 Jan 2016 04:40:47 -0800 (PST)
Date: Sun, 10 Jan 2016 12:40:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Message-ID: <20160110124014.GZ6588@sirena.org.uk>
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com>
 <1452177524-23192-7-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cv++WRjpEUwHXUCE"
In-Reply-To: <1452177524-23192-7-git-send-email-ldewangan@nvidia.com>
Subject: [rtc-linux] Re: [PATCH 6/6] regulator: max77620: add regulator driver
 for max77620/max20024
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Cv++WRjpEUwHXUCE
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Jan 07, 2016 at 08:08:44PM +0530, Laxman Dewangan wrote:

This looks mostly good, a few fairly small things:

> +	if (rinfo->type == MAX77620_REGULATOR_TYPE_SD)
> +		addr = rinfo->cfg_addr;

Please write things like this as switch statement so if we end up adding
more variants the code looks more natural.

> +	case REGULATOR_MODE_IDLE:
> +	case REGULATOR_MODE_STANDBY:
> +		if (rpdata->glpm_enable)
> +			power_mode = MAX77620_POWER_MODE_GLPM;
> +		else
> +			power_mode = MAX77620_POWER_MODE_LPM;
> +		break;

If there's no difference between two modes just don't implement one of
the modes and let the framework worry about what to do for the other
one.

> +static int max77620_get_regulator_dt_data(struct platform_device *pdev,
> +		struct max77620_regulator *max77620_regs)
> +{
> +	struct device_node *np;
> +	u32 prop;
> +	int id;
> +	int ret;
> +
> +	np = of_get_child_by_name(pdev->dev.parent->of_node, "regulators");
> +	if (!np) {
> +		dev_err(&pdev->dev, "Device is not having regulators node\n");
> +		return -ENODEV;
> +	}
> +	pdev->dev.of_node = np;
> +
> +	ret = of_regulator_match(&pdev->dev, np, max77620_regulator_matches,
> +			ARRAY_SIZE(max77620_regulator_matches));
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Parsing of regulator node failed: %d\n",
> +			ret);
> +		return ret;
> +	}

Don't open code this, use the core support via regulators and of_match.

> +		if (reg_pdata->disable_remote_sense_on_suspend &&
> +				(rinfo->remote_sense_addr != 0xFF)) {

Weird indentation here, the second line doesn't seem to be aligned with
anything.

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

--Cv++WRjpEUwHXUCE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWklEtAAoJECTWi3JdVIfQ+1oH/3eSQoArzQBo7MC8zeoazryT
u8lvmt1K2pm7XDgla6UIbg5e5h6BQXONam1Dx6kf1faRqe37xFGYCuH+gyDgqJyZ
SldfbFegoXhDK8t8EC4cl6cSAEVHCj1VBedTdPm29B8ZiliuTKlr4GFXTY8vcivV
u77tctfgMFHcc9mFmlPH5itpfFaM5+XfFkbhANNL7E+VOqvIy3ElbG9llIALXAMY
HnSvhEK4vkASeHAGSYtuPSAgoOEJKY/+Rl2rF18yzbRNZNIV3pFQlVNty+U/ubgp
l348I2VJew/OG0j7QpmdZLEV2WqDnQWnLAkW6/DVB4cUjRYSuJlvkv92fZPC3pk=
=xgMx
-----END PGP SIGNATURE-----

--Cv++WRjpEUwHXUCE--
