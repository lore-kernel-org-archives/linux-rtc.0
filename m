Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D02F359A68
	for <linux-rtc@vger.kernel.org>; Fri, 28 Aug 2026 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936336; cv=none; b=rugVhQZ4hAq0YhvkXa3QlVdF2TWJ2WAwlzSGHDDbGe6/GA9AYEnLjBa0j/vpJk3wPrgH/4/3RwVg+j5RhdvfGEuij5Cp8iTno0T4NRWF65JtbjA47lX6j+TW+hKSK0Q/NeqighgjFG5L+Nl1WpkAt9SLDOqt6jai5fe+12Fi5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936336; c=relaxed/simple;
	bh=CE/gstRtSXBdPLB9N69fYRy1tslZiBgNIiU0G6aHRow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RSUN0e0HToWSfZKopVTIT6f+pYehjVIRBKdbqhGHMBLn2kVPo1qNFOH+nvnPQz7vMvZAcK1m38TerRu3jvkf6FPtC9p+uZ9/cv5YMxVaxNzvmE6vFqF3aCh5VTyOcHtpcAuSVYpLurMbMLdPk8OnYPrcKz3ZV/yqMs+e1uznI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/38VAp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/38VAp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF87C1F000E9;
	Fri, 28 Aug 2026 16:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787936335;
	bh=88lE5iI6oj+CQV0me7ihW9VMWg1rv5PeM5DD96HMllQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m/38VAp9nMNhwlbc6nyU1m8iQ6Oj6MCZnmfoqrxabjyi1iCdQsCaDw4Ja16d9Lewo
	 7RGbWUJz8woY97uGKq28MGj2jCrleD3rqftaAz61QnuueqZH3XxI3ryej95SFFLyRk
	 rn7OJi2RY7b63HbygAxtvy7FmiQP9fdBopoJP7D4CRrGU1ExrL9OI9jaK8CGLOw5/I
	 6lJEyI8SpdXKKswRReUzK9+wlikLxmpf0iG+PYGPdjN8fFrrd0UXM96dehTy7Rztou
	 532/Dowe74k1Akdf4GSxGZUm//a+ReSgSE37IR/mqtLKd8fJKxPyBNy2mHaG8Zt5FU
	 u99CObu1zYjtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] rtc: pcf85063: preserve the alarm flag in clkout
 register updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260828164445.3907839-4-alexander.sverdlin@siemens.com>
References: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
 <20260828164445.3907839-4-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 16:58:54 +0000
Message-Id: <20260828165854.DF87C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch correctly fixes the read-modify-write race condition for=
 the alarm flag (AF) in the clkout helpers, but it completely misses the ex=
act same bug in `pcf85063_rtc_alarm_irq_enable()`.
--

commit 10941c8a0cce0c4a8065c1c9da8c092b66df0282
Author: Alexander Sverdlin <alexander.sverdlin@siemens.com>

rtc: pcf85063: preserve the alarm flag in clkout register updates

This commit fixes a read-modify-write race condition for the alarm flag (AF)
in the clkout helpers by ensuring AF is preserved during regmap updates.

> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index af900fe8ae15e..a3af86456ccfc 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c
> @@ -431,7 +431,8 @@ static int pcf85063_clkout_set_rate(struct clk_hw *hw=
, unsigned long rate,
>  		if (clkout_rates[i] =3D=3D rate)
>  			return regmap_update_bits(pcf85063->regmap,
>  				PCF85063_REG_CTRL2,
> -				PCF85063_REG_CLKO_F_MASK, i);
> +				PCF85063_REG_CLKO_F_MASK | PCF85063_CTRL2_AF,
> +				i | PCF85063_CTRL2_AF);
> =20
>  	return -EINVAL;
>  }
> @@ -460,7 +461,8 @@ static int pcf85063_clkout_control(struct clk_hw *hw,=
 bool enable)
>  	}
> =20
>  	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
> -					PCF85063_REG_CLKO_F_MASK, buf);
> +				  PCF85063_REG_CLKO_F_MASK | PCF85063_CTRL2_AF,
> +				  buf | PCF85063_CTRL2_AF);
>  }

[Severity: High]
This is a pre-existing issue, but does pcf85063_rtc_alarm_irq_enable() also
suffer from the exact same race condition that this patch addresses?

Looking at drivers/rtc/rtc-pcf85063.c:pcf85063_rtc_alarm_irq_enable():

	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
				  PCF85063_CTRL2_AIE,
				  enabled ? PCF85063_CTRL2_AIE : 0);

If the alarm fires exactly during this read-modify-write operation, wouldn't
the hardware alarm flag (AF) be inadvertently cleared since it is omitted f=
rom
the mask? This could lead to a lost RTC alarm interrupt and cause the system
to miss critical wakeups.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828164445.3907=
839-1-alexander.sverdlin@siemens.com?part=3D3
