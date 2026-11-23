Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459879;
	b=VWgHdoIC7lApzggH3seJGcHx3p/CWD4HeWbxGlXEEBYw8YFUo5LTZaeG8uzjodOHEPKK
	 mquBm0qf8eUeWO7Fisq9kzEXtqsQFDHUattVTeRy8+4C7g8rs1sTFoBbVrhlkz9u160DS
	 l+9hOsyxtukl5DhMUp78PCIyuQzbq2zbsQbS9skeGre7/eYPjrBoGikHqOaYwXDKxqcaD
	 ZZDKG6TfukGlT2JM4FpQ2el50uYcVHOzT1ys/o0uUJKJxJRJ8gbhsa6eDUgueo/YJ1u9r
	 BS9eJwsHKOKQpT2Myma+NLPdELbfoZn2sNp0fwyIxf34iaOqnw61WhkpcH8P83joQyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459879;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s2W751rqiu8JPGshI6dgb5JMLD8iCL60Ig9sdFcH+0g=;
	b=lnBHeYlpnU0PCFJWu9jqpMya07C+qIW65MtYjVTwMCTnpXaWQawNig53XgFhWZHMHxom
	 zbW+JMdH9IM1GejuJCW38OUN/IDPBQS0kjGdwsbcNA2X5nQHu98qE7Thcs9kux2D16Qxj
	 WxPz3wu5Tk+4G98gnpp7+LpgFzkrmME7YvgKRKAnOup7V4ck8Ar6sebLIysn65H493RTz
	 ddWH0jkhZX4UQmAqIRuqgk1UpgrbOXVMZTPvt+/YZH2WSyksdt0JP8OTNGv20ZyZtH+8B
	 2Wi02tSRuCP4+LPaDweQt+KdJw5zcNhk9XCfVcjpitDeFD6ZaS2W6S4kBz/vbTFsHkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZhAbg7QG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F3606A31A;
	Mon, 23 Nov 2026 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZhAbg7QG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B041F000C0;
	Mon, 23 Nov 2026 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459879;
	bh=s2W751rqiu8JPGshI6dgb5JMLD8iCL60Ig9sdFcH+0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZhAbg7QG+FIIH4JRB7FJt4NqbuHm7lq6Zc0iE6T7yENAmAzVa/hPir1RGUe2G2IPO
	 chBmmUefvWWXodTKsqHsGZi2PVjUgoiBg7CBGJi4vhevXFrMFJDqz0FtWddHmxDhSp
	 0YGYmnKeiClVMtumzsomyTmmQYDZEhEJEsOtyCpQco71LjDs86ibO5XM+Z8Zro5bJ/
	 aK11w+K9casMfoYN1bLcty3p3N0s9IVNhH6/XGo8SIL0RVXWcdFJUgkg23Pz5Zo19I
	 /8dYx9DLq59fsVSEhDPbCymGDs7IpkLQwqeQyPGYlKf8QmEEq94doViZwnulj+2P7X
	 FtLgTifJ3B9sA==
Message-ID: <sashiko-outbox-229879@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] rtc: Add Cortina Systems CS7542 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261123-b4-cs7542-rtc-v1-2-6c53761ffa03@gmail.com>
References: <20261123-b4-cs7542-rtc-v1-0-6c53761ffa03@gmail.com>
 <20261123-b4-cs7542-rtc-v1-2-6c53761ffa03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 18:51:18 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] rtc: misplaced RTC_DRV_CS75XX in Kconfig and unsorted entry in
  Makefile
--

commit 60817476625dfa4e7c3a4d8e71f7e7cf8d4f7e0d
Author: Fil Dunsky <filipp.dunsky@gmail.com>

rtc: Add Cortina Systems CS7542 RTC driver

This commit adds an RTC driver for the Cortina Systems CS7542 SoC,
supporting calendar read and set operations in the 2000-2099 range.

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 73ec9230edfd0..0878ec33c6db8 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -2212,4 +2212,14 @@ config RTC_DRV_HID_SENSOR_TIME
>  	  If this driver is compiled as a module, it will be named
>  	  rtc-hid-sensor-time.
> =20
> +
> +config RTC_DRV_CS75XX
> +	tristate "Cortina Systems CS7542 RTC"
> +	depends on OF && HAS_IOMEM
> +	help
> +	  Support the calendar clock of the Cortina Systems CS7542 SoC.
> +	  Read and set dates in the 2000-2099 range.
> +	  Alarm interrupts are not supported.
> +	  The module will be named rtc-cs75xx.
> +
>  endif # RTC_CLASS
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 46f1a0fc24165..bc73db37bdea1 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -200,3 +200,4 @@ obj-$(CONFIG_RTC_DRV_WM8350)	+=3D rtc-wm8350.o
>  obj-$(CONFIG_RTC_DRV_X1205)	+=3D rtc-x1205.o
>  obj-$(CONFIG_RTC_DRV_XGENE)	+=3D rtc-xgene.o
>  obj-$(CONFIG_RTC_DRV_ZYNQMP)	+=3D rtc-zynqmp.o
> +obj-$(CONFIG_RTC_DRV_CS75XX)		+=3D rtc-cs75xx.o

[Severity: Low]
This isn't a bug, but placing RTC_DRV_CS75XX after RTC_DRV_HID_SENSOR_TIME
puts this on-SoC RTC under the "HID Sensor RTC drivers" heading instead of
the "on-CPU RTC drivers" section (see commit a5a19e80b235 ("rtc: Kconfig:
move symbols to proper section")).  Also, drivers/rtc/Makefile asks to
keep the driver list ordered alphabetically, so CONFIG_RTC_DRV_CS75XX
belongs between CONFIG_RTC_DRV_CROS_EC and CONFIG_RTC_DRV_CV1800.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-b4-cs7542-=
rtc-v1-0-6c53761ffa03@gmail.com?part=3D2
