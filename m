Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18433531AED;
	Wed, 23 Sep 2026 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170158; cv=none; b=KZoz6JRVYqk7oIF5gv3KEwEYCSBoW/rGTEEBK07olpuW56XAil3+VkQBXADF0imwK2e2sSYLaKo2aydOLyfXq0ZKDvvFMynlPR1lT/loCNnJGjbiv2MEAjuGz5ibjpfZEBT97mEMeVLAsMN9KwjsCADEAxY0PnbnEY2iIhlNTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170158; c=relaxed/simple;
	bh=X3iHfkBmDnJ2r73DOu/shzQ6mOn6JbNhX6svfNlv7KI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RE5bT2c89NwSDfDooCi8SRCsg3o22udBUqnE29emUlMABD8SZfbPac88C6PnfKzNyHlKwTqslCW9xdKMO/FCLoqd57zaZNi+dxjE2ib/rosCOEjUoPDoJgtvzrbxLL1SIdOt9p6cU1igXKIWchzRk8s55gH2JRcP+zFcKHPwp44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfBBgcU+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfBBgcU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D871F00893;
	Wed, 23 Sep 2026 13:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790170155;
	bh=VHd+JW/U8mZqTt5Y+1LBX5uivdCUKUUyqbTA27UOKXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PfBBgcU+thb4rpybY5HwbpTKlCjeTkrFVTXO2Doo3ifLEFTgyQSOU1SpTQmMjwMWw
	 NTffp/XMaU3uuvOlF/bKSBBRrpDQRfUz1IZNR4H4XW6du0gWfQffSMnlDMs+cBvKRv
	 IQsMTAoDTKPDEdBvcGhhQiXqQmBLZXloeYv/nxQWssAPoVfpl/6scNtcDcErHjA2pD
	 ZEOyfy3Yc6iSGOqwvwZKz1YMOcpVp5yWfL8QbqMOVXwL1jAmZgyqBHrPRWFyCrgnJi
	 fRkS6lquzQsdRL2nYcHmKBJVhlrE6eTLYrKY7yoxsUGV+izBHy9njSKjpWX39rOzmF
	 Luq8LXcHj0oog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260923131323.1099979-3-sander.speetjens@gmail.com>
References: <20260923131323.1099979-1-sander.speetjens@gmail.com>
 <20260923131323.1099979-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 13:29:15 +0000
Message-Id: <20260923132915.83D871F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] rtc: dt binding violation by reading property from parent node
- [Low] firmware: global device pointer race and leak on multiple probes
--

commit f13bdcb7308fe3b9ecc514f418f2d57fa4e0247f
Author: Sander Speetjens <sander.speetjens@gmail.com>
Subject: rtc: Add Raspberry Pi 5 RTC driver

This upstreaming patch introduces support for the downstream Raspberry Pi 5
RTC driver. The driver enables support for the custom DA9091 RTC, which is
accessed through the firmware mailbox.

> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberryp=
i.c
> index 0aa322e9a2e73..a35f00c6fb2c1 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
[ ... ]
> @@ -231,6 +232,27 @@ static void rpi_register_clk_driver(struct device *d=
ev)
[ ... ]
> +static void rpi_register_rtc_driver(struct device *dev)
> +{
[ ... ]
> +	rpi_rtc =3D platform_device_register_data(dev, "raspberrypi-rtc",
> +						-1, NULL, 0);
> +}

[Severity: Low]
Does locklessly overwriting the global rpi_rtc pointer here risk a resource
leak? If multiple probes occur (for example, via a custom Device Tree
overlay), it appears the initially registered platform device could be
permanently leaked since the pointer is overwritten without synchronization.

[ ... ]
> @@ -327,6 +350,8 @@ static void rpi_firmware_remove(struct platform_devic=
e *pdev)
[ ... ]
>  	platform_device_unregister(rpi_clk);
>  	rpi_clk =3D NULL;
> +	platform_device_unregister(rpi_rtc);
> +	rpi_rtc =3D NULL;
> =20
>  	rpi_firmware_put(fw);
>  }

[Severity: Low]
If a secondary probe occurred and overwrote the global pointer as noted abo=
ve,
could this cross-unregister the wrong device during removal in
rpi_firmware_remove(), leading to a double-unregister of NULL and a leaked
device?

> diff --git a/drivers/rtc/rtc-raspberrypi.c b/drivers/rtc/rtc-raspberrypi.c
> new file mode 100644
> index 0000000000000..494b949374064
> --- /dev/null
> +++ b/drivers/rtc/rtc-raspberrypi.c
[ ... ]
> +static int rpi_rtc_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	rpi_rtc_alarm_clear_pending(dev);
> +
> +	vrtc->bbat_vchg_millivolts =3D 0;
> +	of_property_read_u32(dev->parent->of_node, "trickle-voltage-millivolt",
> +			     &vrtc->bbat_vchg_millivolts);

[Severity: Medium]
Is it intentional to unconditionally read the trickle-voltage-millivolt
property from the parent MFD firmware node instead of the driver's own RTC
subnode?

If this property is placed correctly in the raspberrypi,firmware-rtc subnod=
e,
it seems it would be silently ignored, causing trickle charging to be disab=
led
and breaking standard Device Tree encapsulation.

> +
> +	rpi_rtc_set_limits(dev);
> +	rpi_rtc_set_charge_voltage(dev);
> +
> +	return devm_rtc_register_device(vrtc->rtc);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923131323.1099=
979-1-sander.speetjens@gmail.com?part=3D2
