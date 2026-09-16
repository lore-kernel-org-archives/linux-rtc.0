Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70714C651F;
	Wed, 16 Sep 2026 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575191; cv=none; b=Fe796Gr5/QvhAcFDeBdwCBxGTYIt/oStUeEzBjiqhc45NFu8cTipAGCNHp7LjgtRwcdMjGPJxSy5oS5UqJQUzdRzHUB9IvwNRplapB/Je3osP8sopubl2iIa6bTLopp5hT0qF6+vi8WQEkMedK8SCs0z/MqdP/CSkx+Za41Dgww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575191; c=relaxed/simple;
	bh=P9poBzXZp6k6mgEmJyozofTgAiKQ0w9pHYRy5uQeXe4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WsvdMAiwR6W3+Lb8965bzj9LmW32msnsra+KhDdn3j3Rya9eGLm2L7mKjoHFgQPmEJgLhbst8O8HznGM0Z7skq9N2cE9zo2aLr/ThgkBm+Z5GvknsJum6pI/a429VWuSetxIyrPzFQu8x6UdpG11v6hgy2tiFB2i1h3XJIa5RL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsKn0hWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsKn0hWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1051F00893;
	Wed, 16 Sep 2026 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789575189;
	bh=jh/cDQCoDzbpTlJ51Vo/1euSnX1DBTZ9IQj1GutpsTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WsKn0hWIRz0g94upZ994iO7n9h795bFqLthSP3UWrl6aEtTAx3RKFNhvlfbmciWd+
	 yFLRvFMpMeD5QSjSX8PYhgGcVlIosIL4gKT5fBsdkcNToVzzOmucHLC/M08cxi1qqv
	 oH2gdnnfil1YOyAPcpJl/j1yXhhc46H1W43ihVxnw0aS6q4gjMblK0IFALLgqHx7un
	 7hNE7xBg/IxjGwjHiicV7ullMZ4ad+/nFAKrc5HhivPzNiYjkDxs9A31SQcwqRFUHM
	 AJFkwYh7TwtV5SmERoWx9vW9V+sz1+CX7EKguxAcP6aXNnZVABL2DR559Eo5RIRhvN
	 0nIlxHBA2PaEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/6] rtc: s35390a: Fix alarm not disabling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260916-rtc_s35390a_int1-v9-3-b2567a3e4959@posteo.de>
References: <20260916-rtc_s35390a_int1-v9-0-b2567a3e4959@posteo.de>
 <20260916-rtc_s35390a_int1-v9-3-b2567a3e4959@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:13:08 +0000
Message-Id: <20260916161308.EE1051F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: s35390a: unhandled interrupt storm in alarm_irq_enable()
--

commit f08c593edb80ced466b342983365673dd8bdb4ee
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: Fix alarm not disabling

Implement alarm_irq_enable callback.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 4cfe7034c5165..575bb256eb258 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
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
Does this code risk causing an unhandled interrupt storm if a previous alarm
was pending?

The S-35390A hardware holds the alarm interrupt flag in STATUS1 until it is
explicitly read. If a previous alarm fired and STATUS1 was not read, the fl=
ag
remains set.

When userspace calls ioctl(RTC_AIE_ON), the RTC core directly invokes
s35390a_rtc_alarm_irq_enable(1) without calling .set_alarm(). Writing to
STATUS2 enables the INT2 alarm output, but without first reading STATUS1 to
clear any pending interrupt, the hardware will immediately assert the INT2 =
pin
if the flag is still set.

Because the driver has no runtime ISR to acknowledge the interrupt, could t=
he
pin remain asserted indefinitely and prevent the system from sleeping or
disable shared IRQ lines?

> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-rtc_s35390=
a_int1-v9-0-b2567a3e4959@posteo.de?part=3D3
