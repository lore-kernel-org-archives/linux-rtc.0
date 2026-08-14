Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133F3A8743;
	Fri, 14 Aug 2026 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748787; cv=none; b=hL5+B03ajAJtflN3fIrSwO+ircR2jmxfoTKkgG4kUCZjaD2in0v0vDhmT4R5wyavm3853HZa0klc4UT+W2Xc7WKAyYC/KTtUF8X0B7FBI0dr2ccW5AKznclqVP4RGj5Sm8+wHWFX6TdKNxMiSnloOeTNjf2kdk3Jw9wTDANDtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748787; c=relaxed/simple;
	bh=mOsIspQQObj0iuAecZ8mi0OgW81xBjawscGHKUSv4X4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uEF6t4HCySNNBOBf1TX18rdENp3aOb9gWF/0mFaYUi+b3HTEkQ3/JiE5M3aXaYi7nXKfpect5PQ2RZOm8Ha1PaqdfZNN/iY28R6Yv/7dGGqSxYpuZ1OxQzm4jj3j6PfaTJBueu4vIWd7PbiqvmlROAjzs/k7Dqn0UT5VtERG1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJWzrGwc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJWzrGwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDA71F000E9;
	Fri, 14 Aug 2026 23:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786748785;
	bh=gb2Xu/zqRK1AU6t1YPqkdr2zFSNlGrktFdNKwcVA34Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJWzrGwc+2aYhDr7Wlfc8pjlrsgnvMhDuKE3xy9U/ohABnpvccEdmUDDTotsZBSue
	 GU7kOXCEfEoOY/3lKW1Fz5rB6UcyfZqVU5GKXEC4gAnRFyKQK8jfwh+/UpK6gpQbct
	 QaVFZThJTUhkI8iAU65wcATizFK7KhRCW6jku/sFGroHS+7aTRj2HAYSxHWZw57oUi
	 x0GFgyqHE/uZDsQ4HWUv3AGImKjNasgEvAkt+2wqZMpkbhJU/qMzbsgD+19srCT9sl
	 od6u+IKmPbQwL2Z30/mr5rbzMWMjHJg+O2vJSS4WvhvtrK2UcxEjTcrN9l5MXGeoo3
	 9NZxfwbfaHm1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] rtc: s35390a: Add missing newline to dev_err
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260815-rtc_s35390a_int1-v4-2-3133309c365f@posteo.de>
References: <20260815-rtc_s35390a_int1-v4-0-3133309c365f@posteo.de>
 <20260815-rtc_s35390a_int1-v4-2-3133309c365f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:06:24 +0000
Message-Id: <20260814230625.1FDA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The probe function silently consumes and clears the hardware's pow=
er-loss status flags (POC and BLD) without acting upon them or preserving t=
heir state, causing the driver to later return invalid time to userspace.
- [High] Incorrect AM/PM bit logic in 24-hour mode causes alarms for PM hou=
rs to silently fail to match.
- [High] The `s35390a_init` function places the hardware into 24-hour mode =
but fails to update the driver's cached `twentyfourhour` state.
- [High] Missing `alarm_irq_enable` callback breaks RTC alarm interrupt tog=
gle ioctls and core disable logic.
--

--- Patch [2]: [PATCH v4 2/6] rtc: s35390a: Add missing newline to dev_err =
---
commit ea0b1d2724771f9f9acaf29d23d929d878073a1e
Author: Markus Probst <markus.probst@posteo.de>
rtc: s35390a: Add missing newline to dev_err

This commit adds a missing newline character to the dev_err message
when an error occurs disabling the alarm.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index b72eef4fb0997..4cfe7034c5165 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
> @@ -494,7 +494,7 @@ static int s35390a_probe(struct i2c_client *client)
>  		buf =3D 0;
>  		err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
>  		if (err < 0) {
> -			dev_err(dev, "error disabling alarm");
> +			dev_err(dev, "error disabling alarm\n");
>  			return err;
>  		}
>  	} else {

[Severity: High]
This is a pre-existing issue, but while looking at s35390a_probe(),
it seems err_read is not checked for a value of 1 when reading status:

drivers/rtc/rtc-s35390a.c:s35390a_probe() {
	err_read =3D s35390a_read_status(s35390a, &status1);
	if (err_read < 0) {
		dev_err(dev, "error resetting chip\n");
		return err_read;
	}

	if (status1 & S35390A_FLAG_24H)
		s35390a->twentyfourhour =3D 1;
	...

Does this mean the hardware power-loss flags are consumed and cleared witho=
ut
preserving their state? Since s35390a_read_status() returns 1 if POC or BLD
flags are set, ignoring this means the driver may later return invalid time
to userspace without noticing the battery failed.

[Severity: High]
This isn't a bug introduced by this patch, but does s35390a_rtc_set_alarm()
incorrectly set the AM/PM bit when in 24-hour mode?

drivers/rtc/rtc-s35390a.c:s35390a_rtc_set_alarm() {
	...
	buf[S35390A_ALRM_BYTE_HOURS] =3D s35390a_hr2reg(s35390a,
			alm->time.tm_hour) | 0x80;
	buf[S35390A_ALRM_BYTE_MINS] =3D bin2bcd(alm->time.tm_min) | 0x80;

	if (alm->time.tm_hour >=3D 12)
		buf[S35390A_ALRM_BYTE_HOURS] |=3D 0x40;
	...
}

If the RTC is in 24-hour mode, it uses 0-23 BCD format for the time register
and does not set the 0x40 bit for PM hours. Wouldn't setting the 0x40 bit
here unconditionally cause alarms for PM hours to silently fail to match?

[Severity: High]
This is a pre-existing issue, but does s35390a_init() fail to update the
internal state after changing the hardware to 24-hour mode?

drivers/rtc/rtc-s35390a.c:s35390a_init() {
	...
initialize:
	buf =3D S35390A_FLAG_RESET | S35390A_FLAG_24H;
	ret =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, &buf, 1);
	...
}

If the hardware is forcibly put into 24-hour mode here, but
s35390a->twentyfourhour is not updated to 1, will subsequent time setting
operations mistakenly write 12-hour formatted time to the hardware?

[Severity: High]
This isn't a bug introduced by this patch, but is the alarm_irq_enable
callback missing from s35390a_rtc_ops?

drivers/rtc/rtc-s35390a.c:
static const struct rtc_class_ops s35390a_rtc_ops =3D {
	.read_time	=3D s35390a_rtc_read_time,
	.set_time	=3D s35390a_rtc_set_time,
	.set_alarm	=3D s35390a_rtc_set_alarm,
	.read_alarm	=3D s35390a_rtc_read_alarm,
	.ioctl          =3D s35390a_rtc_ioctl,
};

Without an alarm_irq_enable function pointer, won't rtc_alarm_disable()
become a no-op, preventing the kernel from disabling the hardware alarm
interrupt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-rtc_s35390=
a_int1-v4-0-3133309c365f@posteo.de?part=3D2
