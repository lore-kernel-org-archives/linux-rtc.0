Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846574BF95E;
	Thu, 17 Sep 2026 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648854; cv=none; b=DrViTmN4q4EvZwoMP/uR59kkrxrqIHQCvm3IvyZKrmvTJTs/QTNw12sbjNZpbtDw1vRgxafz2opp8m0A1v81juKYrPsbG3ocyMxgUhNMGissTORZkEn4vukoHbZvwo795k379D3qhKFBjY/5lP6Yi17GUnQoja30eKaj/OlQ6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648854; c=relaxed/simple;
	bh=eoSBK9p5L59KTc+noX7tdIp3PDNkXYiGoui47nmamdI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FB7+G/oXzwneW3s6zt4QR2z+gPZXcNp3nyMuJRBFZSkVHw2sdEO1GEV5i5OTJMTjahfECSb22jdtx24W0XUXPzETk4tA9mN9hI93cYv5sMKhCDRu3rpvez96dB5KZ6+DaXIrtW8+gOClx/WusLkkfbKPA6mzJHAxpQ7OawXf9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyPt+hop; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyPt+hop"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22471F00893;
	Thu, 17 Sep 2026 12:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789648840;
	bh=qZMsgM5pquArY8+ZYtouKuGMvKctqpnDxS8qIYTPpZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AyPt+hopSojdJOXCqG2fv8rlUvExggXE6zxmJeKDxHnvRdeU6uKXKJDgXe76BAi+K
	 dCby35l9tVco4WE90ffgHu49VPjHvvIkWzmKmP/OAatFLTDk6QX9QGit6RfqkrY297
	 NTvCscqqsU19n/yBC3GSS8Try8MdQvHIzgXOuY9GTumn/X/gGTim3C6cJqUKX9DZzy
	 g2mr9VkGNUyYORgGiiwZNoL6EjOyuz/+eh+G25Q/nz/H+xoYd6h0IFT0dFQD1yBR5v
	 JemhWN7yi7KyNBGdVGl7yGRWvdjLum5Q5QsgZ/SVY0bL/0yzfjzVHewaRJymPSteex
	 KgThLTmzf7FaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260917122144.703221-3-sander.speetjens@gmail.com>
References: <20260917122144.703221-1-sander.speetjens@gmail.com>
 <20260917122144.703221-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 12:40:39 +0000
Message-Id: <20260917124039.F22471F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] rtc: unconditional dev_err on unsupported platforms
- [Medium] rtc: dt property name mismatch with schema and standard
- [Medium] rtc: ignored devm_device_init_wakeup return value
- [Low] kconfig: missing dependency on RASPBERRYPI_FIRMWARE
--

commit 63b49baa5affb33b58f7190d1f915c0156fa6365
Author: Sander Speetjens <sander.speetjens@gmail.com>

rtc: Add Raspberry Pi 5 RTC driver

This commit upstream supports the Raspberry Pi 5 RTC by interacting with
the custom DA9091 over the firmware mailbox. It binds as a child of the
firmware device and configures trickle charging based on device tree
settings.

> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberryp=
i.c
> index 0aa322e9a2e73..b284c689f7828 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
[ ... ]
> @@ -231,6 +232,21 @@ static void rpi_register_clk_driver(struct device *d=
ev)
>  						-1, NULL, 0);
>  }
> =20
> +static void rpi_register_rtc_driver(struct device *dev)
> +{
> +	struct device_node *firmware;
> +
> +	firmware =3D of_get_compatible_child(dev->of_node,
> +					   "raspberrypi,firmware-rtc");
> +	if (firmware) {
> +		of_node_put(firmware);
> +		return;
> +	}
> +
> +	rpi_rtc =3D platform_device_register_data(dev, "raspberrypi-rtc",
> +						-1, NULL, 0);

[Severity: Medium]
Will this unconditionally register the rtc platform device on legacy
Raspberry Pi models?

If rpi_rtc is registered on all models, the probe function will run
universally. When rpi_rtc_probe() executes on a model other than the
Raspberry Pi 5, it prints an error message via dev_err() and aborts:

    if (!model || strncmp(model, "Raspberry Pi 5", 14) !=3D 0) {
            dev_err(dev, "RTC is only available on Raspberry Pi 5\n");
            return -ENODEV;
    }

This seems like it would produce a spurious error message in the kernel log
on every boot for all older models where the hardware doesn't exist.

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 05b9233b94189..382973d46e06d 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
[ ... ]
> @@ -1999,6 +1999,17 @@ config RTC_DRV_R7301
>  	   This driver can also be built as a module. If so, the module
>  	   will be called rtc-r7301.
> =20
> +config RTC_DRV_RPI
> +        tristate "Raspberry Pi RTC"
> +        depends on ARCH_BRCMSTB || COMPILE_TEST
> +        default ARCH_BRCMSTB

[Severity: Low]
Does this configuration allow RTC_DRV_RPI to be built-in when
RASPBERRYPI_FIRMWARE is built as a module?

The driver calls devm_rpi_firmware_get() and rpi_firmware_property(),
which are exported by the raspberrypi-firmware module. If the RTC driver
is built-in and the firmware driver is a module, this will result in an
undefined reference linker error. Should there be a dependency on
RASPBERRYPI_FIRMWARE?

> diff --git a/drivers/rtc/rtc-raspberrypi.c b/drivers/rtc/rtc-raspberrypi.c
> new file mode 100644
> index 0000000000000..af775ae55a871
> --- /dev/null
> +++ b/drivers/rtc/rtc-raspberrypi.c
[ ... ]
> +static int rpi_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rpi_rtc_data *vrtc;
> +	struct device *dev =3D &pdev->dev;
> +	struct rpi_firmware *firmware;
> +	int ret;
[ ... ]
> +	vrtc =3D devm_kzalloc(dev, sizeof(*vrtc), GFP_KERNEL);
> +	if (!vrtc)
> +		return -ENOMEM;
> +
> +	vrtc->fw =3D firmware;
> +
> +	devm_device_init_wakeup(dev);

[Severity: Medium]
Should the return value of devm_device_init_wakeup() be checked here?

This function registers a devres action and can fail, for instance, due to
an out of memory condition. By ignoring the integer error code, the driver
might continue with an uninitialized or broken wakeup state on failure.

> +
> +	platform_set_drvdata(pdev, vrtc);
[ ... ]
> +	rpi_rtc_alarm_clear_pending(dev);
> +
> +	vrtc->bbat_vchg_millivolts =3D 0;
> +	of_property_read_u32(dev->parent->of_node, "trickle-charge-millivolt",
> +			&vrtc->bbat_vchg_millivolts);

[Severity: Medium]
Does this device tree property name match the binding schemas?

The standard RTC bindings typically use trickle-voltage-millivolt, and the
driver's own schema might define charging-voltage-millivolt, but this
attempts to read trickle-charge-millivolt. If a device tree follows the
standard schema, this property lookup will fail and leave trickle charging
silently disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917122144.7032=
21-1-sander.speetjens@gmail.com?part=3D2
