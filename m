Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BCD57EDAE;
	Thu, 17 Sep 2026 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654277; cv=none; b=aEM53Vz0mkZ4kbdJHWXAKwUUTx0nmX1f0abZNcU+tli/luKC/HS8ojhUg1nPjD2b8jFbeZ9kBjhJji3rw5+ntXYSKgZJLD3lhyW1oot8bjDrTrpFGcJeiPkWmqNQ/j1ZTKpGeTm6JpWwgQYgpOwJXc7fAljIUrSc+2qEfIx14Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654277; c=relaxed/simple;
	bh=t9na2Pz0dAVUnrX/AQQRGJZ+47XTDd9EiWqk3djAscI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qutgR28G2m/YuaT8V51ABT/vVY/04oRgbf3zspa2Dfd5hPuztB1hD79HEZ1Gd3qy4Sk2twdc21d4DJiu0zcMkFADdbNOxisyiMwuNsAp3rnlMJQ/luvSAvdA2igosXnlKfT8/KFpcv0642ofq4+qldF8AJug3jldw8LgGTZ26aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O27fYDs4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O27fYDs4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262FC1F000FF;
	Thu, 17 Sep 2026 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654270;
	bh=RDBEbZ343eiQ6b96Jzh6LBFtBCiB2Xlm3Jy7KCyBi9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O27fYDs4pOu+DVMEC/cCEdwxR7l2kwOTv+9uaW2TIz00m+co8ucHMoP+ipqQv3esS
	 8dh8/2FZCJMtjvoUMRv1QtohSWRv4rraUFIwM/WSxE03GeO/eIiW/PPaYwbIZsQmiG
	 EL5BsdJA4HN4GcG2eMxAELYbI77Jg/no/5+SnI0iF31sUGRGKMtR4/Z5eb85lG/tFQ
	 AY/fqdRTfPwtoMf6wY90hEEoXTkcC9+gLn6M5k0CEIfJz362C/aShRP8bOeVsfjJr0
	 OOEzoLlf9ugrXTT6Y0U6CI5AcSFw7Hxnr3znu2gql4jGsCyjgb3DEdqvfsFqKXPMzH
	 RCpmmW3j/85rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260917135841.841680-3-sander.speetjens@gmail.com>
References: <20260917135841.841680-1-sander.speetjens@gmail.com>
 <20260917135841.841680-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:11:09 +0000
Message-Id: <20260917141110.262FC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Endianness mismatch in Raspberry Pi firmware mailbox payloads
- [Low] Kconfig dependency allows built-in RTC driver with modular firmware
--

commit b1ad8443ceac920191fe490d4fe9a93bc6d9205a
Author: Sander Speetjens <sander.speetjens@gmail.com>

rtc: Add Raspberry Pi 5 RTC driver

This commit upstreams the downstream Raspberry Pi 5 RTC driver for the cust=
om
DA9091. The driver binds as a child device in the firmware driver probe
function and uses the firmware mailbox to access the RTC.

[ ... ]
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 05b9233b94189..1a24655fc2d39 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1999,6 +1999,17 @@ config RTC_DRV_R7301
>  	   This driver can also be built as a module. If so, the module
>  	   will be called rtc-r7301.
> =20
> +config RTC_DRV_RPI
> +        tristate "Raspberry Pi RTC"
> +        depends on ARCH_BRCMSTB || RASPBERRYPI_FIRMWARE || COMPILE_TEST

[Severity: Low]
Does this dependency allow the RTC driver to be compiled as built-in (=3Dy)
while RASPBERRYPI_FIRMWARE is compiled as a loadable module (=3Dm)?

If this driver is built-in and the firmware is modular, it looks like the
unconditional calls to devm_rpi_firmware_get() and rpi_firmware_property()
in rpi_rtc_probe() will result in a linker error.

> +        default ARCH_BRCMSTB
> +        help
> +          If you say yes here you get support for the RTC found on
> +          Raspberry Pi devices.
[ ... ]
> diff --git a/drivers/rtc/rtc-raspberrypi.c b/drivers/rtc/rtc-raspberrypi.c
> new file mode 100644
> index 0000000000000..0f5c3f8e9731e
> --- /dev/null
> +++ b/drivers/rtc/rtc-raspberrypi.c
[ ... ]
> +static int rpi_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	u32 data[2] =3D {RTC_TIME, rtc_tm_to_time64(tm)};

[Severity: High]
Can this payload format cause communication issues on big-endian architectu=
res?

The Raspberry Pi firmware mailbox expects little-endian data. By passing
a host-endian u32 array directly to rpi_firmware_property(), both the
register ID (RTC_TIME) and the timestamp payload will be byte-swapped on
big-endian machines.

> +
> +	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				     &data, sizeof(data));
> +}
[ ... ]
> +static int rpi_rtc_set_charge_voltage(struct device *dev)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	u32 data[2] =3D {RTC_BBAT_CHG_VOLTS, vrtc->bbat_vchg_millivolts * 1000U=
};

[Severity: High]
Will this conversion to a host-endian integer cause out-of-spec PMIC
voltages to be sent on big-endian machines?

Similar to rpi_rtc_set_time(), passing host-endian values to the mailbox
here will byte-swap the charge voltage target on big-endian systems,
potentially resulting in hardware misconfiguration.

> +	int err;
> +
> +	err =3D rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				    &data, sizeof(data));
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917135841.8416=
80-1-sander.speetjens@gmail.com?part=3D2
