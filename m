Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79602230264;
	Wed, 14 Oct 2026 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967377; cv=none; b=DNBcvh/ucSAsmkeWbaK2soL4J2pNkJcjTG9025EiFq9srnwuJSf7i+wREUJ0ldfFNWXuB2JdTkF+1J1kzcnO/aF2EggTu6pWbpK4thiYw1+xm0Q1ILXjL6V/YTic9GrliWgr9hQdEkEJFC7eGalWybIBTMgnG/EPhFA+CGaFpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967377; c=relaxed/simple;
	bh=QjK3p8/xVkg2lzsf5sciO1yYMp75AVDrk/baZf48cOU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=u3l1kmxumUyhU7LG0GeTApNtRTt9RHFMm/ZqQKjpdyMb2dZ+7RJMN02GwhIsKQgfyacH8uLHZgTpIEfeBilJbZeU8Uos7pe4NzyWoE5XWaW4wqBCuo8pgwzC5S4pzBRLgd1cmCt1EfeB1PAf73LF6CA6BQvY6yYNfXrp0CfUg8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IecS5uc5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IecS5uc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055701F000FF;
	Wed, 14 Oct 2026 08:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791967376;
	bh=xVjMpXTz5r/iHtucEs7Ry+fqkHlrvnhbpEImmTYuti0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IecS5uc5f15MkPaKE0ovPNix2pIIqDcqX6Ju0dEgl+QgoOp+vzc7f7MFSSUCONivR
	 7CCObyu27RU3VJyASyoXnB12qdW01qq3lWbSsDi0V8uDU2WXbMBFabq8zCH163A4Xt
	 3bxcHy7nhRk63yvx0Klx5zzBMQFY01jzIiN+fXZDxgDoIG/4PLLHuuw/zAhjpMCvgB
	 3+Dofjy8nZicvC18o9ED0cvmKZRzyK/cKwGqCdkmclr/ifH6UHYCvocD9M3OkAvrS1
	 C9tHYy/ZRQbaep65cwpUpRaRrAufjdKhkwZ4erphpxsTyqJ973qGCVrJ+HEOGzt2r0
	 96g+waV+zaVLQ==
Message-ID: <sashiko-outbox-171032@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/3] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261014083016.332338-4-sander.speetjens@gmail.com>
References: <20261014083016.332338-1-sander.speetjens@gmail.com>
 <20261014083016.332338-4-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:42:55 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] rtc: rpi: missing alarm pending clear outside probe
- [Low] core: Unused variable `firmware` in rpi_register_rtc_driver()
--

commit fd3eb73150bb8312044bd5332b80f44be6ed81ec
Author: Sander Speetjens <sander.speetjens@gmail.com>

rtc: Add Raspberry Pi 5 RTC driver

This commit upstreams the downstream Raspberry Pi 5 RTC driver. It adds
support for the custom DA9091, which is accessed through the firmware mailb=
ox.

> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberryp=
i.c
> index 0aa322e9a2e73..b22c59a429dea 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
[ ... ]
> @@ -231,6 +232,27 @@ static void rpi_register_clk_driver(struct device *d=
ev)
>  						-1, NULL, 0);
>  }
> =20
> +static void rpi_register_rtc_driver(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *firmware;

[Severity: Low]
Is the firmware variable needed here? It appears to be declared but
never used in rpi_register_rtc_driver(), which will trigger a
-Wunused-variable compiler warning and fail builds configured with -Werror.

> +
> +	/*
> +	 * Check if our model of Raspberry Pi board is from the 5th gen
> +	 * as the RTC is only present on that model.
> +	 */
> +	if (!of_machine_is_compatible("brcm,bcm2712"))
> +		return;
[ ... ]
> diff --git a/drivers/rtc/rtc-raspberrypi.c b/drivers/rtc/rtc-raspberrypi.c
> new file mode 100644
> index 0000000000000..6d5c8111f4db6
> --- /dev/null
> +++ b/drivers/rtc/rtc-raspberrypi.c
[ ... ]
> +static int rpi_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alar=
m)
> +{
> +	struct rpi_rtc_data *rtc =3D dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data =3D {
> +		.reg =3D cpu_to_le32(RTC_ALARM),
> +		.val =3D cpu_to_le32(rtc_tm_to_time64(&alarm->time))
> +	};
> +	int err;
> +
> +	err =3D rpi_firmware_property(rtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				    &data, sizeof(data));
> +
> +	if (!err)
> +		err =3D rpi_rtc_alarm_irq_enable(dev, alarm->enabled);

[Severity: Medium]
Should we explicitly clear the alarm pending bit when setting a new alarm?

rpi_rtc_alarm_clear_pending() is called once during rpi_rtc_probe(), but
the pending state does not seem to be cleared when new alarms are set
here or during a resume path. If an alarm triggers while the system is
awake (or if the system uses S2idle/S3 suspend where probe is not re-run),
could the lingering pending bit prevent subsequent wake alarms from firing
or cause immediate spurious wakeups?

> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014083016.3323=
38-1-sander.speetjens@gmail.com?part=3D3
