Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012C385516;
	Mon, 31 Aug 2026 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207274; cv=none; b=rJcBa+k0WszGLiRD7hWWlsXcT12rO5hz6G36D6x2w3D/xlSAUrQ3BLyVUN0qW/JbTv3zzgHnTgcu2AgvcYSrWfJLCo1rnK5LqHAXFRZh/jYCQNqCmCfGi7WeBjkRxh/Kfx0Er7Ootxbc81cUddbDMGGnJt3HVyjKSwbeT3RdrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207274; c=relaxed/simple;
	bh=zRmv+7HSX3ga3wbRBKVoyt9AVaxJIg8v1/83A2oIemo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D9wqdGG5yJq1X4iVWOlFNezJCZI4Ks2d9NxnnZ+rp1rL4Urah+ZNkercx/7ZfQ8OTQfSJvEAAk2P2kqf8hSiBlJQ42+44v5tVK2S9eSajLoVQeQIsYAzndRS9khW7qh3euUZ2GdzkhopKeuEPhUG0mhISFbWJetVwmkAB8ti6+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHhlyU19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHhlyU19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6506C1F00A3D;
	Mon, 31 Aug 2026 20:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207272;
	bh=GvQN5WCZbaTcgyuFd/keEw61jzZzHWNfz+5kRZV65io=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PHhlyU19Bwqgqd6NOmKns1EUnrDu0Wejbf/nkm+Hu83GXvlrIQXWU9yNsjR1qPAI0
	 93FGcPL9xFFwyBCRN0ni3zXRBHEoQM7AI8sv50itTZmR7BIXOsnxRr8MGzJVF1g6EI
	 wgdZYoW45d89NDHKFCKhZgUX5a3AjcMDZZa1oHCpkElx3p5VQstQ4lC+yyMvFVlmkA
	 MBhrjlYdiyxtR6c/qMk8LTfJtj8+Z/8lT6GqWkpi5uvLqzfXnac71LQuVPjvgaKnnw
	 zZsaBzkqY0o3KUGhcX1YvqAcBCDxyy31yvNys7ZOjjT58t5CjCkh6j1+fzhHzScL/x
	 PK8g7b0TpkZSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/6] rtc: s35390a: Fix alarm not disabling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260831-rtc_s35390a_int1-v8-3-dac1dc86ce1f@posteo.de>
References: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de>
 <20260831-rtc_s35390a_int1-v8-3-dac1dc86ce1f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:14:32 +0000
Message-Id: <20260831201432.6506C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Adding `alarm_irq_enable` exposes a preexisting flaw where `set_al=
arm(enabled=3D0)` drops the alarm time, causing subsequent `RTC_AIE_ON` ioc=
tls to enable the alarm with an incorrect/stale time.
--

commit 9902d89ba2e478f9c2ca532d42600946943b66e7
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: Fix alarm not disabling

This commit implements the alarm_irq_enable callback to fix an issue where
the alarm was not disabling.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 4cfe7034c5165..575bb256eb258 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
[ ... ]
> @@ -270,6 +270,24 @@ static int s35390a_rtc_read_time(struct device *dev,=
 struct rtc_time *tm)
>  	return 0;
>  }
> =20
> +static int s35390a_rtc_alarm_irq_enable(struct device *dev, unsigned int=
 enabled)
> +{
> +	struct s35390a *s35390a =3D dev_get_drvdata(dev);
> +	u8 sts;
> +	int err;
> +
> +	if (enabled)
> +		sts =3D S35390A_INT2_MODE_ALARM;
> +	else
> +		sts =3D S35390A_INT2_MODE_NOINTR;
> +
> +	err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts)=
);

[Severity: High]
This is a pre-existing issue, but does enabling the alarm here (e.g., via
the RTC_AIE_ON ioctl) expose a flaw where s35390a_rtc_set_alarm() drops the
alarm time?

When a user issues the RTC_ALM_SET ioctl, it inherently calls
s35390a_rtc_set_alarm() with enabled =3D 0. The driver sets STATUS2 to NOIN=
TR
mode:

drivers/rtc/rtc-s35390a.c:s35390a_rtc_set_alarm() {
    ...
    if (alm->enabled)
        sts =3D S35390A_INT2_MODE_ALARM;
    else
        sts =3D S35390A_INT2_MODE_NOINTR;

    /* set interrupt mode*/
    err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts)=
);
    ...
}

The driver then attempts to write the time to INT2_REG1:

drivers/rtc/rtc-s35390a.c:s35390a_rtc_set_alarm() {
    ...
    err =3D s35390a_set_reg(s35390a, S35390A_CMD_INT2_REG1, buf,
                          sizeof(buf));
    ...
}

However, as documented by the driver's own comment in s35390a_rtc_read_alar=
m(),
the alarm time register is completely inaccessible when the alarm is not
enabled. Thus, the time update is silently dropped by the hardware.

When the user subsequently calls RTC_AIE_ON, this newly added
alarm_irq_enable callback enables the alarm interrupt using the incorrect or
stale time previously residing in the registers.

Note: This issue is not resolved by follow-up patches in this series. In the
final patch (commit "rtc: s35390a: Add synology quirk"),
s35390a_rtc_set_alarm() still leaves the interrupt mode disabled when
alm->enabled =3D=3D 0 before performing the time register writes, preservin=
g the
issue.

> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-rtc_s35390=
a_int1-v8-0-dac1dc86ce1f@posteo.de?part=3D3
