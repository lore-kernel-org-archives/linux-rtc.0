Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A7348F003;
	Thu, 24 Sep 2026 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256881; cv=none; b=qOw8PBZsTZqtGYDmNbAIqEdDU8WW/Q5I6MCqaWoBbsyUwmD5RWq7jxizbyQ9FFimkG3UAGbmOpQcTpLps3WmrW/wAEjHjiqFfUcHUmwGTfHSfmAnNEZpZZsKwLoVSVtojYm+w2g1raUlWnh/iMHSPLW/bMUJMK8zvWhrOXZyQms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256881; c=relaxed/simple;
	bh=5F2In7tBxEIgs7mABXiHhSYfk63RbWqXxU1rPwimG/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zj5vmZnoQbIxFVg6CfFtxuUxxyL3r1VBm17H5L1sNYFx5QM0ITR7BEAyu9tBLyLhzWL00kxmI/ppZ1AqkJIwmmlq8augA75pfvAUI56NQgMG2gBcQ3SAUK4bJuTLqlz1HCK07yNlrenOBbF6bmBJ9tIU7FVFFcTppPrYqyelyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFYTsuJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFYTsuJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DFF1F000FF;
	Thu, 24 Sep 2026 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256867;
	bh=vCVxOTCNFcQYUW13c+WPf80SiNmKoxL2dUmJNQmZznA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CFYTsuJITFYQypIBZp/VfpCAtOJn5O9gmpxox7R0Z+I5Z90/aCzXA1jXYVVoz+veU
	 Qro0Mpfr+Z8lTRj+RLjlND3lEWckcvhYaoJlrecwWiyrJ308Asp+N95drS6/2BjP5V
	 ClXWJeByY/8LnzS2j3A/3C+r2c7VjweADhdyVuUQz7o7CzgMs+P7JArmpQGBnSFjvc
	 F7dMTVH6IsBlDBNOPIjw9WaA7Ey7ddWMZNfmLCtJoGCEc6zNsrpHyz95ZIYDY+I3kH
	 z5O6i+inGHzwo28AkzaNpf3G7RBH/YqL9/RmgrzeJ0ZVtTnqbT6rUXspaUo9mbtEEG
	 RInmXAcvGLM5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260924132217.1281752-3-sander.speetjens@gmail.com>
References: <20260924132217.1281752-1-sander.speetjens@gmail.com>
 <20260924132217.1281752-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 13:34:27 +0000
Message-Id: <20260924133427.99DFF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] rtc: raspberrypi: Missing endianness conversion in firmware commun=
ication
- [Medium] rtc: raspberrypi: Incorrect DT node for trickle voltage property
- [Medium] rtc: raspberrypi: Missing MODULE_ALIAS prevents autoloading
--

commit 2afa604e9b62ac37552a0a69c5399fed7850a086
Author: Sander Speetjens <sander.speetjens@gmail.com>

rtc: Add Raspberry Pi 5 RTC driver

Upstreaming the downstream Raspberry Pi 5 RTC driver. This driver supports
the custom DA9091, which is accessed through the firmware mailbox.

> diff --git a/drivers/rtc/rtc-raspberrypi.c b/drivers/rtc/rtc-raspberrypi.c
> new file mode 100644
> index 0000000000000..494b949374064
> --- /dev/null
> +++ b/drivers/rtc/rtc-raspberrypi.c
[ ... ]
> +static int rpi_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	u32 data[2] =3D { RTC_TIME };
> +	int err;
> +
> +	err =3D rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +				    &data, sizeof(data));
> +	rtc_time64_to_tm(data[1], tm);

[Severity: High]
Will this driver run correctly on big-endian kernels?

The raw payload returned by the firmware is treated as host-endian here. If
the firmware expects and returns little-endian payloads (as is common for
mailbox interfaces), should this code use le32_to_cpu() to prevent byte
transposition issues?

> +	return err;
> +}
> +
> +static int rpi_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	u32 data[2] =3D { RTC_TIME, rtc_tm_to_time64(tm) };

[Severity: High]
Similar to rpi_rtc_read_time(), the timestamp and sub-command are placed
into a host-endian u32 array without conversion.

Should this value be converted to little-endian using cpu_to_le32() before
sending it to the firmware?

> +
> +	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				     &data, sizeof(data));
> +}
[ ... ]
> +static int rpi_rtc_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	vrtc->rtc->ops =3D &rpi_rtc_ops;
> +
> +	rpi_rtc_alarm_clear_pending(dev);
> +
> +	vrtc->bbat_vchg_millivolts =3D 0;
> +	of_property_read_u32(dev->parent->of_node, "trickle-voltage-millivolt",
> +			     &vrtc->bbat_vchg_millivolts);

[Severity: Medium]
Does this read the property from the correct device tree node?

It appears this reads trickle-voltage-millivolt from the parent firmware
node (dev->parent->of_node) instead of the child RTC node. If a correct
device tree specifies this property on the RTC node to follow DT encapsulat=
ion
rules, will that configuration be ignored here?

> +
> +	rpi_rtc_set_limits(dev);
> +	rpi_rtc_set_charge_voltage(dev);
> +
> +	return devm_rtc_register_device(vrtc->rtc);
> +}
> +
> +static const struct of_device_id rpi_rtc_dt_match[] =3D {
> +	{ .compatible =3D "raspberrypi,firmware-rtc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rpi_rtc_dt_match);
> +
> +static struct platform_driver rpi_rtc_driver =3D {
> +	.driver =3D {
> +		.name =3D "raspberrypi-rtc",
> +		.of_match_table =3D of_match_ptr(rpi_rtc_dt_match),
> +	},
> +	.probe =3D rpi_rtc_probe
> +};

[Severity: Medium]
Will this module autoload correctly on systems using manual registration?

The firmware driver registers a platform device named raspberrypi-rtc, which
generates a platform:raspberrypi-rtc uevent. Without a matching MODULE_ALIAS
declaration here, it seems udev might not be able to match the fallback
device to the driver module.

> +
> +module_platform_driver(rpi_rtc_driver);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924132217.1281=
752-1-sander.speetjens@gmail.com?part=3D2
