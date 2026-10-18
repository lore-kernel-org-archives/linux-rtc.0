Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA2344D99;
	Sun, 18 Oct 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792334743; cv=none; b=A0t3LH01YSG9AWfI1cw0L/fNF003sozZOlYOqqcdOsAz+hwjiiPb/dmlNU3mEIqT1p6T9aP0v9m6cM0cS4Zai8SnIvlDQtFb/tX/2/NWD3umlmqXdEfugoy3jum6R1jnx1aRcIxjLgEiHFfiWfSgZ+qbvjJTKJ2/UxfqGRSfT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792334743; c=relaxed/simple;
	bh=Exicjpw72yxGFZNIeYecKmnubpF+3pQ6BY+gA5Hudo4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oBNoNWxDDaE7usZvh1XPWbMRdeK/rTbN1MB4CGjzTfevQbM7S5gXTSCiqTAWxEZ4B89N3ZDCDE4s7+JQ7YerHuIhEeldjiK0y84rp97hiQ+gapZGGlbaN0WxfPYGfAj5H0CQ7s/UcN9U+GumLkOrYsNL2+LnmeSGa+zcunkViZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo0vqN79; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo0vqN79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B08C1F000C4;
	Sun, 18 Oct 2026 14:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792334742;
	bh=jOTtvNqaWW5s4lEfMudGisGHsjmlgCLKUf9TgaqBecE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jo0vqN79YeEwEYa7C6cdlOULKpEnDFCHVsNPN/aNytwr+xHJ0fKLW58wUjSEU/z/U
	 3y4vNDwNXv+uxtJluwSGNXl+WAvHWUcAwpQLUnV+SqWiV1Gu6/JXOv6ANdTUGHgUf4
	 hyZhuys+M87NvcXXX3WPX08tdCx+uPqYMcZ35dQrjCH9WH/0DMm4rk0F1kOEsnw2EW
	 eufykWQzKdsHwRdbq3MG4Zf7WWzQQRki1fwMneZ5Y7QmpUXiU3Efc8rrI9J165O5rk
	 /sLEn6ITuHeaa8WfT2ynO2VKf0wJFlwwAqLf08aR/5szd1i2xmbmu9TFxOaIIOtWV9
	 jR5hOPz9u0aTA==
Message-ID: <sashiko-outbox-176212@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 3/3] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261018143712.1040152-4-sander.speetjens@gmail.com>
References: <20261018143712.1040152-1-sander.speetjens@gmail.com>
 <20261018143712.1040152-4-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 14:45:41 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rtc: Kconfig RTC_DRV_RPI depends on ARCH_BRCMSTB instead of ARCH=
_BCM2835
--

commit 764db262bbaebd42035bc0933220419e0e4cbc7d
Author: Sander Speetjens <sander.speetjens@gmail.com>

rtc: Add Raspberry Pi 5 RTC driver

This commit adds the Raspberry Pi 5 RTC driver, which accesses the custom
DA9091 RTC through the Raspberry Pi firmware mailbox, and registers the
raspberrypi-rtc platform device from drivers/firmware/raspberrypi.c on
brcm,bcm2712 machines.

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 05b9233b94189..6adaf425a76bc 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1999,6 +1999,18 @@ config RTC_DRV_R7301
>  	   This driver can also be built as a module. If so, the module
>  	   will be called rtc-r7301.
> =20
> +config RTC_DRV_RPI
> +	tristate "Raspberry Pi RTC"
> +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWA=
RE)
> +	depends on ARCH_BRCMSTB || COMPILE_TEST
> +	default ARCH_BRCMSTB

[Severity: Medium]
Should RTC_DRV_RPI depend on and default to ARCH_BCM2835 instead of
ARCH_BRCMSTB (or rely on the RASPBERRYPI_FIRMWARE dependency)?

In drivers/firmware/Kconfig, RASPBERRYPI_FIRMWARE is gated on ARCH_BCM2835:

config RASPBERRYPI_FIRMWARE
	tristate "Raspberry Pi Firmware Driver"
	depends on ARCH_BCM2835 || COMPILE_TEST
	depends on ARM || ARM64
	depends on MAILBOX
	default ARCH_BCM2835

When COMPILE_TEST=3Dn, a configuration with ARCH_BCM2835=3Dy,
RASPBERRYPI_FIRMWARE=3Dy, and ARCH_BRCMSTB=3Dn will register the
raspberrypi-rtc platform device in rpi_register_rtc_driver(), but
RTC_DRV_RPI cannot be enabled. Conversely, with ARCH_BRCMSTB=3Dy and
ARCH_BCM2835=3Dn, RASPBERRYPI_FIRMWARE cannot be enabled, so RTC_DRV_RPI's
first dependency is not satisfied.

> +	help
> +	  If you say yes here you get support for the RTC found on
> +	  Raspberry Pi 5th gen devices.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-raspberrypi.
> +
>  config RTC_DRV_STM32
>  	tristate "STM32 RTC"
>  	select REGMAP_MMIO

[ ... ]

>=20
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018143712.1040=
152-1-sander.speetjens@gmail.com?part=3D3
