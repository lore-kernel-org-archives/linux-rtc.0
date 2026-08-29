Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716DFC0A;
	Sat, 29 Aug 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788014251; cv=none; b=FNOFPw6O1xag/FALRB3GVJKQxdQzgJB9lrVYEqvxISR3LpbHZn6qlee/zX9hqBo38+9pipX2B6g8bTaIAbg3AR7Zg/XMIy6wsAQUpQ3AOG29q/Vl52A1hD6o3doyFupqdXtisEX+NlCyOJWhAfIaYx9SPs1y20odvDyABgFHBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788014251; c=relaxed/simple;
	bh=vh9OzXTbJJYKa+bq7WWsybygViW9sQf0O8uVGKlkQ3Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZL2ekxYVrjhTSweIZXwegekoGo56P4JV74wAHPPYE7ekx6znsfseGM+JLtmZM8b5lmjNYUqFDxeVhuJNvb67qVjjyxhPPjJZYElfeJrWNetSMQUU/DHxffRKU/+rSj6bxhKXNqhuJfPtHzvE0pJnVeVhkIzQ++f1Xpjnc5IHP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXVzdQ82; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXVzdQ82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0B91F00A3D;
	Sat, 29 Aug 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788014249;
	bh=vWjcqflWl/2ofYF49Z/2GQZmUgyWWM0dvt2wJUvj/1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mXVzdQ82AICfl70wBivNyQRZJ+hKAOJ5XnsaVvPL+2TIRXMvWS1VoEPlM7trD+je4
	 Ka5h3QGjdsINv4i85ANahUI8ZURAzhELRZq86pKhL/JAj7ZP+vzE02E2FOLh/y88VM
	 Tww0BYfF64brutRuFhGmXDjr1CTTnvFCNhjCiHHm1TFjxKmV+UITXQjK9GLWR7L+jl
	 B7Gn4DMfncr+wPjmv7/nujYXlYhXHKzctyAaMMo/R7Sj9Jb0E+ithvZkai9vvSM81Y
	 HNWvR960eTM8TG6XGk8YwwzEvfIyvzt1jAf/kwJB62cPaHItgtXmzD3bZX8rPHsW3d
	 LNvE2ijmg4cTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] rtc: s35390a: Read 24-hour mode on access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260829-rtc_s35390a_int1-v7-4-debcd31143ae@posteo.de>
References: <20260829-rtc_s35390a_int1-v7-0-debcd31143ae@posteo.de>
 <20260829-rtc_s35390a_int1-v7-4-debcd31143ae@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 14:37:28 +0000
Message-Id: <20260829143729.4B0B91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Reading STATUS1 in s35390a_rtc_read_alarm() unintentionally clears=
 pending interrupts.

Pre-existing issues:
- [High] Alarm configuration corrupts PM hours in 24-hour mode.
--

commit e047fd38f53476482d3e7de4c5b2930bff24fc30
Author: Markus Probst <markus.probst@posteo.de>
Date:   Sat Aug 29 14:22:58 2026 +0000

    rtc: s35390a: Read 24-hour mode on access

This patch modifies the s35390a RTC driver to read the 24-hour mode flag
dynamically upon access rather than caching it once at probe time. This ens=
ures
the mode cannot get out of sync and resolves time corruption issues that oc=
cur
when resetting the chip while in 12-hour mode.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 575bb256eb258..12ed504db94d8 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
[ ... ]
> @@ -325,8 +330,8 @@ static int s35390a_rtc_set_alarm(struct device *dev, =
struct rtc_wkalrm *alm)
>  	else
>  		buf[S35390A_ALRM_BYTE_WDAY] =3D 0;
> =20
> -	buf[S35390A_ALRM_BYTE_HOURS] =3D s35390a_hr2reg(s35390a,
> -			alm->time.tm_hour) | 0x80;
> +	buf[S35390A_ALRM_BYTE_HOURS] =3D s35390a_hr2reg(alm->time.tm_hour,
> +						      status1 & S35390A_FLAG_24H) | 0x80;
>  	buf[S35390A_ALRM_BYTE_MINS] =3D bin2bcd(alm->time.tm_min) | 0x80;
> =20
>  	if (alm->time.tm_hour >=3D 12)
>  		buf[S35390A_ALRM_BYTE_HOURS] |=3D 0x40;

[Severity: High]
This isn't a bug introduced by this patch, but does this bitwise operation
corrupt the 24-hour mode alarm hour format by wrongly applying the 12-hour =
PM
bit?

When configuring an alarm via s35390a_rtc_set_alarm(), the hour is encoded =
via
s35390a_hr2reg(). In 24-hour mode, this correctly returns the BCD value of =
the
hour without bit 6 (0x40) set.

However, unconditionally applying the 0x40 bit if tm_hour >=3D 12 forces bi=
t 6
high. Since the actual time register in 24-hour mode does not use bit 6 (max
hour is 23, BCD 0x23), will this prevent the RTC hardware's alarm match log=
ic
from matching the corrupted alarm register with the current time?

[ ... ]
> @@ -345,14 +350,20 @@ static int s35390a_rtc_read_alarm(struct device *de=
v, struct rtc_wkalrm *alm)
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct s35390a *s35390a =3D i2c_get_clientdata(client);
> -	u8 buf[3], sts;
> +	u8 buf[3], status1, status2;
>  	int i, err;
> =20
> -	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts)=
);
> +	err =3D s35390a_read_status(s35390a, &status1);
> +	if (err =3D=3D 1)
> +		return -EINVAL;

[Severity: High]
Does reading STATUS1 here in s35390a_rtc_read_alarm() unintentionally clear
pending interrupts?

As documented by the clear pending interrupt comment in
s35390a_rtc_set_alarm(), reading the STATUS1 register clears the hardware's
pending interrupt flag.

If a user or subsystem merely queries the alarm configuration by calling
s35390a_rtc_read_alarm(), could this I2C read cause pending wake events or
interrupts to be silently cleared and dropped in the RTC hardware without b=
eing
processed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829-rtc_s35390=
a_int1-v7-0-debcd31143ae@posteo.de?part=3D4
