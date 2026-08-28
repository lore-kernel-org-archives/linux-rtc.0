Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122E3859EC
	for <linux-rtc@vger.kernel.org>; Fri, 28 Aug 2026 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936444; cv=none; b=oFBX0ZJyCZxvqLzgGMvSb8t0CysR8DNuRBpghopW1ebn0Y4PINe+XWuYzHj62DZkHhMTlE26MbzW39QDVNSsCDcB2/TWakYkPHvt8f8/dr1M8kcc9KcBoFnSjQ9ffIQgnMqVvBqsySktQsUSRuxVCmMcrL0727cwU9J1V5R+NmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936444; c=relaxed/simple;
	bh=di/hyWZL/S6OUuhaormIRmS8BWMYbbFd8WF1XWPXCTk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hZVunvxoYZzxAFSZOZmBwIUxrYLTlYP2IXx/wTbw/fQGEkfX0od9q/4D8PgSb/gUg8gW6D4SkZz69unwkTJ9F7uBvAZaAj/9+tiIU2E/lch1pTu0nvEjS2bkBrZdrJaOP0eEMnzDLLkBpPb8aviLb52PLhKySiTuJXTKUlDlMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdmiKkHq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdmiKkHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B111F000E9;
	Fri, 28 Aug 2026 17:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787936441;
	bh=PK6lFgUkoxQmC5wbFd3fEHdTFDakMS+hCYdhgdlFx9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KdmiKkHqFyPR2qBuOSUj5NGDHjq5pwArQo36FwNwYA1RjfYlS8vcc48t22nt2Eu83
	 NCopiX1YIcRKLfraLy9IXBwyvlrePovxT29N754LIaD55vMToZS66rrZGGlot/FyLT
	 LP5yB3O+MapLr06eC39ovB/QYpPcLHTkfW33tnqNBLBfoQqlQKZaI1vrMUf3sbHI2I
	 5RZ+S/Zqz5WPk21n1cRJWzXBmz31paRGyOBsgS/8SjouZdRNlnQzuH0cw7f2E7QxTH
	 DdZY+hKEc7w6Oc7QETc/X07L2LmB665Z+Ac72O1mZxDw24GKPvqh8ztS4LtgIh1mpB
	 ptrla2kOPn0AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] rtc: pcf85063: add 1 Hz update interrupt (UIE)
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260828164445.3907839-5-alexander.sverdlin@siemens.com>
References: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
 <20260828164445.3907839-5-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 17:00:40 +0000
Message-Id: <20260828170040.E2B111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The driver completely ignores the requested alarm enable parameter=
s, breaking generic `alarmtimers` (POSIX timers) and system wakeups.

Pre-existing issues:
- [High] In `pcf85063_rtc_alarm_irq_enable()`, the `PCF85063_CTRL2_AF` (Ala=
rm Flag) bit is omitted from the `regmap_update_bits` mask and value, which=
 can inadvertently clear a pending alarm interrupt.
--

commit 72f77be444d700f19ce672423be21e8db8ec0a3d
Author: Alexander Sverdlin <alexander.sverdlin@siemens.com>

rtc: pcf85063: add 1 Hz update interrupt (UIE) support

The PCF85063A/RV8263 have no dedicated 1 Hz update interrupt, but their
countdown timer can be sourced from a 1 Hz clock (TCF =3D 1 Hz, T =3D 1) to
generate a periodic interrupt on the INT pin. Use it to offload UIE to
the hardware, following the pattern of other RTC drivers.

> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index a3af86456ccfc..32952e73f2f1c 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c

[ ... ]

> @@ -211,23 +275,33 @@ static int pcf85063_rtc_set_alarm(struct device *de=
v, struct rtc_wkalrm *alrm)
>  		return ret;
> =20
>  	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
> -				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF,
> -				  alrm->enabled ? PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF : PCF85063_=
CTRL2_AF);
> +				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF | PCF85063_CTRL2_TF,
> +				  pcf85063->rtc->aie_timer.enabled ?
> +				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF | PCF85063_CTRL2_TF :
> +				  PCF85063_CTRL2_AF | PCF85063_CTRL2_TF);
>  }

[Severity: High]
Does this code ignore the requested alrm->enabled parameter in favor of
pcf85063->rtc->aie_timer.enabled?

The RTC core multiplexes various timers onto the hardware alarm and passes =
the
desired hardware state via alrm->enabled here and via the enabled parameter=
 in
pcf85063_rtc_alarm_irq_enable().

By checking aie_timer.enabled instead, it appears the driver will only enab=
le
the hardware alarm for the legacy ioctl alarm. If a generic alarmtimer (such
as a system wakealarm or a POSIX timer) reaches the front of the queue, won=
't
aie_timer.enabled be false, silencing the requested alarm?

>  static int pcf85063_rtc_alarm_irq_enable(struct device *dev,
>  					 unsigned int enabled)
>  {
>  	struct pcf85063 *pcf85063 =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D pcf85063_set_timer_1hz(pcf85063, pcf85063->rtc->uie_rtctimer.en=
abled);
> +	if (ret)
> +		return ret;
> =20
>  	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
> -				  PCF85063_CTRL2_AIE,
> -				  enabled ? PCF85063_CTRL2_AIE : 0);
> +				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_TF,
> +				  pcf85063->rtc->aie_timer.enabled ?
> +				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_TF : PCF85063_CTRL2_TF);
>  }

[Severity: High]
This is a pre-existing issue, but does this read-modify-write omit
PCF85063_CTRL2_AF from the mask, potentially clearing a pending alarm?

Since the AF bit in PCF85063_REG_CTRL2 is write-0-to-clear, if the hardware
asserts the AF interrupt between the internal register read and write of th=
is
operation, the read value will have AF=3D0. Because AF is not masked,
regmap_update_bits() will write back AF=3D0, which unintentionally clears t=
he
newly asserted alarm flag.

Also, similar to pcf85063_rtc_set_alarm() above, does this code
inappropriately ignore the enabled parameter passed by the core?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828164445.3907=
839-1-alexander.sverdlin@siemens.com?part=3D4
