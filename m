Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FD3DDAE2;
	Fri,  2 Oct 2026 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949568; cv=none; b=cmnYbxu9iRW0KWRqD5sWfhNgHy7YzGeJvPgwgXPyRsyytcxOsjnLfGpqYDqXQI2HqSzxCYQxoxAShrmDj0C9oA6xgIhUcCxO7nLLtyRGSN+2HiNyhvwCkRHXnKYxlo3w78qjlYsqWtIoioHKHoehkDMBMvV5WPbF2K0eCrqXXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949568; c=relaxed/simple;
	bh=8HSWU21jOq7n0nzOLLWuiiubceDbgfWo+4wscB72HUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMnvXFaSQCj9QHfo+CgwfGKlf6b9LN3TMUSDPZ0DJtvjgcuFxgiBRUzG2GYGP/OpXI5E22IbQBrleymisMF3YOju1OeL+Mme0ZglKo0Bf1dQZEV9MMTicnRMQvtCD2nu+WTEYXtQ/ZEEzwkHLv1ChtAkLn4wVxJu2BCjW+jUx3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=FgPAgVug; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="FgPAgVug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1790949532; x=1791554332; i=wahrenst@gmx.net;
	bh=4psCWC/r6MS0OYcxt8F/CC/cqnFKRpNjtoQgorqVsvo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FgPAgVugy42yeoosyAFRHE4JjjCCRs634817NHpRaLDayZqqSm+jFd3Wl79M+dxB
	 yfb+zGclMclBYon+9onLWwH07+o+nEYn2pyARuHoIA/ntgn32AibNt/gwPEsoOevH
	 0pu7p2CUh6aErChU9e8Iky/6KIUBOwtBEigGH2cXacveK2j1dzat57iFbNW16XvUa
	 WYj8vpToqMPRSJ8fzhPDOXXqVPSn6bT40VhXi01M5QGnMMP8VquaV7FNJgvQKx3nc
	 SLYOlvc+ylgUMsDrLbne6BjKiSUN/JPAH1r9NhtgSvlpwE9VSmgNvuRVAchRlntGS
	 68ISLkevQ0o+oW0aTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGyxN-1wyZIW3Jrf-00GKuY; Fri, 02
 Oct 2026 15:58:51 +0200
Message-ID: <e49fdbd1-dbe9-4c06-9797-492db689d894@gmx.net>
Date: Fri, 2 Oct 2026 15:58:50 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] rtc: Add Raspberry Pi 5 RTC driver
To: Sander Speetjens <sander.speetjens@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonathan Bell <jonathan@raspberrypi.com>, linux-rtc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, pbrobinson@gmail.com
References: <20261002102419.830595-1-sander.speetjens@gmail.com>
 <20261002102419.830595-4-sander.speetjens@gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20261002102419.830595-4-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n1rbB0lbuOX72Tx7lj8EzDrCVWSR+cwuAQnDnZ+nJC8kC0dp3xF
 098AUeJht16g9Atv8kA1ckVWuG1VqX4Q0FlHa3FeDCNXL1p2CrqJh4lDUXWqQt+QcvMhl5+
 2ePRalc6Qofw+0RQ6A4C30w/K+7dH+bUfygfLaQIyC1ZaHq8dOVb/909fc1H9qLRLhfnIY/
 ngiEXzNHJmVFZMinJzkvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aIV+jBgPNEM=;ixBqzd9NScSGC7UGvZQonfx8SEZ
 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
 kG2V

Hello Sander,

Am 02.10.26 um 12:24 schrieb Sander Speetjens:
> Upstreaming the downstream Raspberry Pi 5 RTC driver.
> This driver supports the custom DA9091,
> which is accessed through the firmware mailbox.
>
> Based on code originally written by Jonathan Bell <jonathan@raspberrypi.=
com>
> and Dom Cobley <popcornmix@gmail.com>
>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
in general this patch looks good except a few nits, maybe wait for=20
Alexandre's feedback.
After fixing the nits you can add my:

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> ---
> V9 -> V10:
> - Fix sign-off-by
> - Change enum to defines
> - Change comment in firmware
>
> V8 -> V9:
> - Fix whitespace in Kconfig
> - Move RTC regs to firmware header
> - Add a warn when getting the min or max charging values fails
> - Remove the unused return value of set charge voltage
>
> V7 -> V8:
> - Fix whitespacing errors
> - Use of_machine_is_compatible instead of strncmp
>
> V6 -> V7:
> - Move from u32 array to struct
> - Fix encapsulation as mentioned by sashiko-bot
>
> V5 -> V6:
> - Add MODULE_ALIAS, as mentioned by sashiko-bot
> - Encapsulate the mailbox data in le32_to_cpu or cpu_to_le32, as
>    mentioned by sashiko-bot. For good practice
>
> V4 -> V5: No changes
>
> V3 -> V4:
> - Fix Kconfig depends that disallows having Raspberrypi
> firmware built as a module while the rtc driver is built in
> - Remove sysfs
> - Add limits from firmware properties and check in rpi_rtc_set_charge_vo=
ltage
>
> V2 -> V3:
> - Move platform check to firmware and abort before registering
> a platform device if on another platform
> - Add a dependency on the Raspberry Pi firmware to Kconfig
> - Check return value of devm_device_init_wakeup
> - Fix property name
>
> V1 -> V2:
> Instead of the original driver, which was directly bound to the device t=
ree.
> This driver is bound to the Raspberry Pi firmware device by creating
> a child device in the firmware driver probe function.
> The child device is then bound to this driver,
> which uses the firmware mailbox to access the RTC.
>
> A couple of minor changes have been made to the driver since it was orig=
inally written, including:
> - Checking if the model is a Raspberry Pi 5, as the RTC is only present =
on that model.
> - Using the new devm_rpi_firmware_get() and devm_init_wakeup() helper to=
 get the firmware device and avoid leaking memory.
> - Using millivolts instead of microvolts for the trickle charge voltage,=
 to match the RTC standard.
> - Instead of setting the trickle charge voltage to 0 to disable trickle =
charging, the property is now optional. If the property is not present, tr=
ickle charging is disabled, per the RTC standard.
> - Renaming the driver dt match compatible to "raspberrypi,firmware-rtc" =
to match the other firmware bindings.
> - Renaming the driver name to "raspberrypi-rtc" to match the other firmw=
are drivers.
>
>   drivers/firmware/raspberrypi.c             |  24 ++
>   drivers/rtc/Kconfig                        |  12 +
>   drivers/rtc/Makefile                       |   1 +
>   drivers/rtc/rtc-raspberrypi.c              | 276 +++++++++++++++++++++
>   include/soc/bcm2835/raspberrypi-firmware.h |   2 +
>   5 files changed, 315 insertions(+)
>   create mode 100644 drivers/rtc/rtc-raspberrypi.c
>
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberry=
pi.c
> index 0aa322e9a2e7..f8c83c25eccc 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -24,6 +24,7 @@
>  =20
>   static struct platform_device *rpi_hwmon;
>   static struct platform_device *rpi_clk;
> +static struct platform_device *rpi_rtc;
>  =20
>   struct rpi_firmware {
>   	struct mbox_client cl;
> @@ -231,6 +232,26 @@ static void rpi_register_clk_driver(struct device *=
dev)
>   						-1, NULL, 0);
>   }
>  =20
> +static void rpi_register_rtc_driver(struct device *dev)
> +{
> +	struct device_node *firmware;
> +
> +	// Check if our model of Raspberry Pi board is from the 5th gen
> +	// as the RTC is only present on that model.
> +	if (!of_machine_is_compatible("brcm,bcm2712"))
> +		return;
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
> +}
> +
>   unsigned int rpi_firmware_clk_get_max_rate(struct rpi_firmware *fw, un=
signed int id)
>   {
>   	struct rpi_firmware_clk_rate_request msg =3D
> @@ -305,6 +326,7 @@ static int rpi_firmware_probe(struct platform_device=
 *pdev)
>   	rpi_firmware_print_firmware_revision(fw);
>   	rpi_register_hwmon_driver(dev, fw);
>   	rpi_register_clk_driver(dev);
> +	rpi_register_rtc_driver(dev);
>  =20
>   	return 0;
>   }
> @@ -327,6 +349,8 @@ static void rpi_firmware_remove(struct platform_devi=
ce *pdev)
>   	rpi_hwmon =3D NULL;
>   	platform_device_unregister(rpi_clk);
>   	rpi_clk =3D NULL;
> +	platform_device_unregister(rpi_rtc);
> +	rpi_rtc =3D NULL;
>  =20
>   	rpi_firmware_put(fw);
>   }
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 05b9233b9418..6dae4c069be2 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1999,6 +1999,18 @@ config RTC_DRV_R7301
>   	   This driver can also be built as a module. If so, the module
>   	   will be called rtc-r7301.
>  =20
> +config RTC_DRV_RPI
> +	tristate "Raspberry Pi RTC"
> +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMW=
ARE)
> +	depends on ARCH_BRCMSTB || COMPILE_TEST
> +	default ARCH_BRCMSTB
> +	help
> +		If you say yes here you get support for the RTC found on
> +		Raspberry Pi devices.
> +
> +		This driver can also be built as a module. If so, the module
> +		will be called rtc-raspberrypi.
Sorry for my misleading wording. I meant in this case 1 tab and align=20
the rest with spaces just like the other.
...
> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bc=
m2835/raspberrypi-firmware.h
> index 975bef529854..e13994d8281c 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -75,6 +75,8 @@ enum rpi_firmware_property_tag {
>   	RPI_FIRMWARE_GET_THROTTLED =3D                          0x00030046,
>   	RPI_FIRMWARE_GET_CLOCK_MEASURED =3D                     0x00030047,
>   	RPI_FIRMWARE_NOTIFY_REBOOT =3D                          0x00030048,
> +	RPI_FIRMWARE_GET_RTC_REG =3D                            0x00030087,
> +	RPI_FIRMWARE_SET_RTC_REG =3D                            0x00038087,
Please try to keep the value order. I know it's already messed up,=20
Gregor Herburger send a patch which already address the existing order=20
("firmware: raspberrypi: reorder rpi_firmware_property_tag enum").

Best regards
>   	RPI_FIRMWARE_SET_CLOCK_STATE =3D                        0x00038001,
>   	RPI_FIRMWARE_SET_CLOCK_RATE =3D                         0x00038002,
>   	RPI_FIRMWARE_SET_VOLTAGE =3D                            0x00038003,

