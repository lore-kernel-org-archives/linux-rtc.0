Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF514F55B6;
	Wed, 30 Sep 2026 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787077; cv=none; b=mpLU96L/Vrfv0gedUep+ZMX1/Gp7A3AArDx9EalZovH9pDaYbKNiWEuWi6ak8BisqKvQJhsyLLRHufGU/kbKj1gfDrn8XQa7JoU+dJDl2TiiWIFUpV03rOvLt6EzeYQ5w/X6IobCdkwoeTaT6pLC2pw21lGYpM6DJ8bmmLJ7M0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787077; c=relaxed/simple;
	bh=RrF5rMEfsyW4lzsvzEjwfbLK/aGRVkaksQm2k5YvxwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4M4brtF/SaijI1G5CW/SyQtqbtsNAGbHD/b7XICmSq4pKMB3APBJIPTyqoXu9k/XzYkc3ZGiZ0TtuxNEJtbxh0k9uMXd8h0eD/XcYrmjc9v4j8BgKzfOgHxnJ9h0X6T3weynVDd1XOnlJzFMsEPgu1TKIL3SbZqq3GO+L/gZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=EfNAgxie; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="EfNAgxie"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1790787059; x=1791391859; i=wahrenst@gmx.net;
	bh=+GR+6pjagmoen4fimAop2gEIfc4C3nny5uzGymfyVQI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EfNAgxie3GW5ezh+AIdHG2exz+qdsZm5n/lm2ML19M80/2NcRVVGZmaOz7aPoM36
	 /4d7WGiZYo/eQfPKzXls19G/MhjwJwZRwnT6/e4opa5V4052E/ljsLmIuN2LuzvTE
	 Y18L5sZ1fPz5SmnGXEXAASP+yZLJq0nXfru+kD37i74YB3M2XH4rCyZADdQm27H9o
	 tnou6A377IdLxrmEFZgTEOMCoZnQu/F5jMPLKKnMSirmOgCpqc6PiEhXEVL2KUwe4
	 znI5D6c01sDfx569BjOE10sRiBjvvOEeOiQjNalRtiTJVHEpsJ2f6PJHu9PJ5Dsbs
	 +NPDvVBOa4hp50abFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1wPeC30rWS-00oqmF; Wed, 30
 Sep 2026 18:50:59 +0200
Message-ID: <7441de5b-e9a6-4080-b312-d6c7123fdcde@gmx.net>
Date: Wed, 30 Sep 2026 18:50:55 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rtc: Add Raspberry Pi 5 RTC driver
To: Sander Speetjens <sander.speetjens@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonathan Bell <jonathan@raspberrypi.com>, linux-rtc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, pbrobinson@gmail.com,
 Dom Cobley <popcornmix@gmail.com>
References: <20260930095203.492949-1-sander.speetjens@gmail.com>
 <20260930095203.492949-3-sander.speetjens@gmail.com>
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
In-Reply-To: <20260930095203.492949-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Do3UBRLlkHW7oJsaPvpkSzWTCBVBFon2SNP4GLwKKvdTD16zpo1
 A0hpqg+fQAB6SXAyPZ6GQ1xliXKxA2abaUFp/bQnZ/RY42sBUW210mTa1mp+BtM5RSLcEbN
 ZyBgxbzOUvKh6Rcojv9K3wXN3EKggEiFqw7+qQ3hOUwM8PchNWp1boOF8XhUgyfyUAa4hbE
 QyArnx8VWz9hecQjEZhzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vSH5J8YM/Is=;LudDHUomUISBCdTVoO+WHAh4PwL
 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
 iMERlaiIWG+Tk5H7yYam21yReeLA9UhZerw418=

Hi Sander,

Am 30.09.26 um 11:52 schrieb Sander Speetjens:
> Upstreaming the downstream Raspberry Pi 5 RTC driver.
> This driver supports the custom DA9091,
> which is accessed through the firmware mailbox.
>
> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
> ---
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
>
>   drivers/firmware/raspberrypi.c |  23 +++
>   drivers/rtc/Kconfig            |  12 ++
>   drivers/rtc/Makefile           |   1 +
>   drivers/rtc/rtc-raspberrypi.c  | 279 +++++++++++++++++++++++++++++++++
>   4 files changed, 315 insertions(+)
>   create mode 100644 drivers/rtc/rtc-raspberrypi.c
>
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberry=
pi.c
> index 0aa322e9a2e7..b5ee6d7a8951 100644
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
> @@ -231,6 +232,25 @@ static void rpi_register_clk_driver(struct device *=
dev)
>   						-1, NULL, 0);
>   }
>  =20
> +static void rpi_register_rtc_driver(struct device *dev)
> +{
> +	struct device_node *firmware;
> +
> +	// Check if our model is a Raspberry Pi 5, as the RTC is only present =
on that model.
> +	if (!of_machine_is_compatible("brcm,bcm2712"))
> +		return;
I don't like the comment, because it doesn't check for Raspberry Pi 5,=20
the code checks for a BCM2712 SoC which could also be on a CM5 or a=20
Raspberry Pi 500+
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
> @@ -305,6 +325,7 @@ static int rpi_firmware_probe(struct platform_device=
 *pdev)
>   	rpi_firmware_print_firmware_revision(fw);
>   	rpi_register_hwmon_driver(dev, fw);
>   	rpi_register_clk_driver(dev);
> +	rpi_register_rtc_driver(dev);
>  =20
>   	return 0;
>   }
> @@ -327,6 +348,8 @@ static void rpi_firmware_remove(struct platform_devi=
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
> index 05b9233b9418..4dbe20bcace8 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1999,6 +1999,18 @@ config RTC_DRV_R7301
>   	   This driver can also be built as a module. If so, the module
>   	   will be called rtc-r7301.
>  =20
> +config RTC_DRV_RPI
> +        tristate "Raspberry Pi RTC"
> +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMW=
ARE)
> +        depends on ARCH_BRCMSTB || COMPILE_TEST
> +        default ARCH_BRCMSTB
> +        help
> +          If you say yes here you get support for the RTC found on
> +          Raspberry Pi devices.
> +
> +          This driver can also be built as a module. If so, the module
> +          will be called rtc-raspberrypi.
> +
AFAIK we should try to use tabs here instead of pure spaces
>   config RTC_DRV_STM32
>   	tristate "STM32 RTC"
>   	select REGMAP_MMIO
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 0347645b021f..46f1a0fc2416 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -144,6 +144,7 @@ obj-$(CONFIG_RTC_DRV_PS3)	+=3D rtc-ps3.o
>   obj-$(CONFIG_RTC_DRV_PXA)	+=3D rtc-pxa.o
>   obj-$(CONFIG_RTC_DRV_R7301)	+=3D rtc-r7301.o
>   obj-$(CONFIG_RTC_DRV_R9701)	+=3D rtc-r9701.o
> +obj-$(CONFIG_RTC_DRV_RPI)	+=3D rtc-raspberrypi.o
>   obj-$(CONFIG_RTC_DRV_RC5T583)	+=3D rtc-rc5t583.o
>   obj-$(CONFIG_RTC_DRV_RC5T619)	+=3D rtc-rc5t619.o
>   obj-$(CONFIG_RTC_DRV_RK808)	+=3D rtc-rk808.o
> diff --git a/drivers/rtc/rtc-raspberrypi.c b/drivers/rtc/rtc-raspberrypi=
.c
> new file mode 100644
> index 000000000000..3b77a0cef1d3
> --- /dev/null
> +++ b/drivers/rtc/rtc-raspberrypi.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/**
> + * rtc-raspberrypi.c
> + *
> + * RTC driver using firmware mailbox
> + * Supports battery backed RTC and wake alarms
> + *
> + * Based on rtc-meson-vrtc by Neil Armstrong
> + *
> + * Copyright (c) 2023, Raspberry Pi Ltd.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +#include <linux/of.h>
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
> +#define RPI_FIRMWARE_GET_RTC_REG 0x00030087
> +#define RPI_FIRMWARE_SET_RTC_REG 0x00038087
Was there a specific reason to not include these defines to=20
include/soc/bcm2835/raspberry-pi-firmware.h as all the others firmware=20
tags?
> +
> +enum {
> +	RTC_TIME,
> +	RTC_ALARM,
> +	RTC_ALARM_PENDING,
> +	RTC_ALARM_ENABLE,
> +	RTC_BBAT_CHG_VOLTS,
> +	RTC_BBAT_CHG_VOLTS_MIN,
> +	RTC_BBAT_CHG_VOLTS_MAX,
> +	RTC_BBAT_VOLTS
> +};
Hm, an enum suggests that we simply can add / remove items, but that's=20
not the case. The Raspberry Pi firmware defines the values.
> +
> +struct rpi_rtc_data {
> +	struct rtc_device *rtc;
> +	struct rpi_firmware *fw;
> +	u32 bbat_vchg_millivolts;
> +	u32 bbat_vchg_min_millivolts;
> +	u32 bbat_vchg_max_millivolts;
> +};
> +
> +struct rpi_rtc_reg {
> +	__le32 reg;
> +	__le32 val;
> +} __packed;
> +
> +static int rpi_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data =3D {
> +		.reg =3D cpu_to_le32(RTC_TIME)
> +	};
> +	int err;
> +
> +	err =3D rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +				    &data, sizeof(data));
> +	rtc_time64_to_tm(le32_to_cpu(data.val), tm);
> +	return err;
> +}
> +
> +static int rpi_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data =3D {
> +		.reg =3D cpu_to_le32(RTC_TIME),
> +		.val =3D cpu_to_le32(rtc_tm_to_time64(tm))
> +	};
> +
> +	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				     &data, sizeof(data));
> +}
> +
> +static int rpi_rtc_alarm_irq_is_enabled(struct device *dev, unsigned ch=
ar *enabled)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data =3D {
> +		.reg =3D cpu_to_le32(RTC_ALARM_ENABLE)
> +	};
> +	s32 err =3D 0;
Please use int and no need to initialize
> +
> +	err =3D rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +				    &data, sizeof(data));
> +	*enabled =3D le32_to_cpu(data.val) & 0x1;
> +	return err;
> +}
> +
> +static int rpi_rtc_alarm_irq_enable(struct device *dev, unsigned int en=
abled)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data =3D {
> +		.reg =3D cpu_to_le32(RTC_ALARM_ENABLE),
> +		.val =3D cpu_to_le32(enabled)
> +	};
> +
> +	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				     &data, sizeof(data));
> +}
> +
> +static int rpi_rtc_alarm_clear_pending(struct device *dev)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data =3D {
> +		.reg =3D cpu_to_le32(RTC_ALARM_PENDING),
> +		.val =3D cpu_to_le32(1)
> +	};
> +
> +	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				     &data, sizeof(data));
> +}
> +
> +static int rpi_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *al=
arm)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data =3D {
> +		.reg =3D cpu_to_le32(RTC_ALARM)
> +	};
> +	s32 err =3D 0;
Please use int and no need to initialize
> +
> +	err =3D rpi_rtc_alarm_irq_is_enabled(dev, &alarm->enabled);
> +	if (!err)
> +		err =3D rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +					    &data, sizeof(data));
> +	rtc_time64_to_tm(le32_to_cpu(data.val), &alarm->time);
> +
> +	return err;
> +}
> +
> +static int rpi_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *ala=
rm)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data =3D {
> +		.reg =3D cpu_to_le32(RTC_ALARM),
> +		.val =3D cpu_to_le32(rtc_tm_to_time64(&alarm->time))
> +	};
> +	int err;
> +
> +	err =3D rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				    &data, sizeof(data));
> +
> +	if (err =3D=3D 0)
if (!err)
> +		err =3D rpi_rtc_alarm_irq_enable(dev, alarm->enabled);
> +
> +	return err;
> +}
> +
> +static const struct rtc_class_ops rpi_rtc_ops =3D {
> +	.read_time =3D rpi_rtc_read_time,
> +	.set_time =3D rpi_rtc_set_time,
> +	.read_alarm =3D rpi_rtc_read_alarm,
> +	.set_alarm =3D rpi_rtc_set_alarm,
> +	.alarm_irq_enable =3D rpi_rtc_alarm_irq_enable,
> +};
> +
> +static void rpi_rtc_set_limits(struct device *dev)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data =3D {
> +		.reg =3D cpu_to_le32(RTC_BBAT_CHG_VOLTS_MIN)
> +	};
> +
> +	int err =3D rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +					&data, sizeof(data));
> +	if (err =3D=3D 0)
if (!err)
> +		vrtc->bbat_vchg_min_millivolts =3D le32_to_cpu(data.val) / 1000U;
> +
> +	data.reg =3D cpu_to_le32(RTC_BBAT_CHG_VOLTS_MAX);
> +	data.val =3D cpu_to_le32(0);
> +	err =3D rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +				    &data, sizeof(data));
> +	if (err =3D=3D 0)
> +		vrtc->bbat_vchg_max_millivolts =3D le32_to_cpu(data.val) / 1000U;
> +}
> +
> +static int rpi_rtc_set_charge_voltage(struct device *dev)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data =3D {
> +		.reg =3D cpu_to_le32(RTC_BBAT_CHG_VOLTS),
> +		.val =3D cpu_to_le32(vrtc->bbat_vchg_millivolts * 1000U)
> +	};
> +	int err;
> +
> +	if (vrtc->bbat_vchg_millivolts !=3D 0 &&
> +	    (vrtc->bbat_vchg_millivolts < vrtc->bbat_vchg_min_millivolts ||
> +	    vrtc->bbat_vchg_millivolts > vrtc->bbat_vchg_max_millivolts)) {
> +		dev_warn(dev, "trickle charge voltage %umV is outside of the supporte=
d range (%umV - %umV)\n",
> +			 vrtc->bbat_vchg_millivolts,
> +			 vrtc->bbat_vchg_min_millivolts,
> +			 vrtc->bbat_vchg_max_millivolts);
In case rpi_rtc_set_limits() fails, both limit would be initialized with=
=20
0 and this always fail. Maybe we should dev_warn to rpi_rtc_set_limits()?
> +		return -EINVAL;
> +	}
> +
> +	err =3D rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				    &data, sizeof(data));
> +
> +	if (err)
> +		dev_err(dev, "failed to set trickle charge voltage to %umV: %d\n",
> +			vrtc->bbat_vchg_millivolts, err);
> +	else if (vrtc->bbat_vchg_millivolts)
> +		dev_info(dev, "trickle charging enabled at %umV\n",
> +			 vrtc->bbat_vchg_millivolts);
> +
> +	return err;
> +}
> +
> +static int rpi_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rpi_rtc_data *vrtc;
> +	struct device *dev =3D &pdev->dev;
> +	struct rpi_firmware *firmware;
> +	int ret;
> +
> +	// Get the firmware device from the parent device
> +	firmware =3D devm_rpi_firmware_get(dev, dev->parent->of_node);
> +
> +	if (!firmware)
> +		return -EPROBE_DEFER;
> +
> +	vrtc =3D devm_kzalloc(dev, sizeof(*vrtc), GFP_KERNEL);
> +	if (!vrtc)
> +		return -ENOMEM;
> +
> +	vrtc->fw =3D firmware;
> +
> +	ret =3D devm_device_init_wakeup(dev);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, vrtc);
> +
> +	vrtc->rtc =3D devm_rtc_allocate_device(dev);
> +	if (IS_ERR(vrtc->rtc))
> +		return PTR_ERR(vrtc->rtc);
> +
> +	vrtc->rtc->range_max =3D U32_MAX;           /* 2106-02-07 */
> +
> +	set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, vrtc->rtc->features);
> +	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, vrtc->rtc->features);
> +
> +	vrtc->rtc->ops =3D &rpi_rtc_ops;
> +
> +	rpi_rtc_alarm_clear_pending(dev);
> +
> +	/*
> +	 * The trickle-voltage property lives on the parent firmware node
> +	 * because we deliberately do not create a DT child node just to
> +	 * instantiate this driver (see DT maintainer guidance).
> +	 * The firmware driver registers us as a platform device at runtime.
> +	 */
> +	vrtc->bbat_vchg_millivolts =3D 0;
> +	of_property_read_u32(dev->parent->of_node, "trickle-voltage-millivolt"=
,
> +			     &vrtc->bbat_vchg_millivolts);
> +
> +	rpi_rtc_set_limits(dev);
> +	rpi_rtc_set_charge_voltage(dev);
Just to be sure, both calls are optional and not critical for the=20
drivers function?
Why does rpi_rtc_set_charge_voltage have a return value at all?
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
> +
> +module_platform_driver(rpi_rtc_driver);
> +
> +MODULE_AUTHOR("Jonathan Bell <jonathan@raspberrypi.com>");
> +MODULE_AUTHOR("Sander Speetjens <sander.speetjens@gmail.com>");
> +MODULE_DESCRIPTION("Raspberry Pi RTC driver");
> +MODULE_LICENSE("GPL");
According to SPDX header this is a license "Dual BSD/GPL" ?
> +MODULE_ALIAS("platform:raspberrypi-rtc");
Is this really necessary for module autoloading?

Best regards
