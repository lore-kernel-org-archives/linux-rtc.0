Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113E4E06CE;
	Wed, 16 Sep 2026 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592751; cv=none; b=f9QKeIl2zGKMqxNak5e/Kwm2XJ+SPUbLzYzFGwSLyu8FnQIUt+Gbi6pDleZzb5TjlS6RNV6bFHLXOvKyJclxj4OVtycdtaBcZooZzJhMCpDqABkxINYbYlUbntahkGYPK1eo4/Dzm4Ig4g3VC14abm6oQTy8Me+/q14QS4UBwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592751; c=relaxed/simple;
	bh=5P87G2gLsi8Vxd6ZbbHlq3E/VQBHECsXZNjR/2SV9kA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iQhsuz+8y+wQCO3jBax8HdbgimpmmA/J8bEbgZ+dntQAlPmsk+Uo26Dv2fIP5aM9pgIlO/paxiunqq4A7FPwV0vTfarp08TCl+G+RuuyLKU+h0IKZKLLIWy80CI2xf5GJ2ZpudH0R8AHo6A/f1MlPbHw33kABVuipgIl4hG6Sy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh//k7Qu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh//k7Qu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF14B1F0089A;
	Wed, 16 Sep 2026 21:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592728;
	bh=RmsKzTqxMBi7ujc/r+ETx04E9MLFmWy+BfbQ2xZETts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jh//k7Qu90mWYGanccQm9kGsBU7M+rhGGlCnRXnnZoU3rI0kRazjbGr6rJOspZBd2
	 VAE9MIJf9cZ4DC1GjLmbyRyVcXHrDVe2omcKxN+8/Lr2d1JkqfMaDyO15D1Qvx4sXt
	 /+qdqlFwqDzu7BclodmLHhTSyaZ6QfdkVVn1PPnK7hgsUdI7O6k5bdyuYghXSLi2yg
	 6SoEKo5WsdpKXR45B52pf84Gr0DFhlSg2nPdH4N830JdbB92ot3cFHKwFhIVOXsYou
	 Vv+sFctRDbYAicfhELZ7ViCfL+DpWVpmNq8oRZUSc61HgSkwbcRrDWP2b+i2bIonOv
	 RS8LfPgqXj/gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/9] rtc: abx80x: properly handle shared IRQs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260916205138.16771-5-apokusinski01@gmail.com>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
 <20260916205138.16771-5-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:05:27 +0000
Message-Id: <20260916210527.CF14B1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: abx80x: race condition loses interrupts due to flawed W0C sta=
tus register clearing
--

commit 27cfcb7135851594344aa538f01f8ef1328d2392
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: properly handle shared IRQs

This commit updates the abx80x RTC interrupt handler to only return
IRQ_HANDLED and clear the status register when the alarm or watchdog flags
are set. It aims to properly support IRQF_SHARED by returning IRQ_NONE
for unrelated interrupts.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c

[ ... ]

> @@ -284,9 +291,15 @@ static irqreturn_t abx80x_handle_irq(int irq, void *=
dev_id)
>  	if (status & ABX8XX_STATUS_WDT)
>  		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
> =20
> -	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
> +	status_flags_clear =3D status & (ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT);
> =20
> -	return IRQ_HANDLED;
> +	if (status_flags_clear) {
> +		i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
> +					  status & ~status_flags_clear);

[Severity: High]
Does this logic introduce a race condition that loses late-arriving interru=
pts
in abx80x_handle_irq()?

Because the ABX8XX_REG_STATUS register is W0C (write-0-to-clear), any bit
written as 0 will be cleared in hardware.=20

The expression status & ~status_flags_clear forces a 0 for all bits that
were 0 during the initial read. If a new hardware interrupt asserts between
the read and this write, its status bit will be newly set to 1 in hardware.
However, writing back the old status value forces a 0 for that new bit,
silently clearing it and losing the event.

To preserve unhandled or newly asserted bits, the correct write value for a
W0C register is ~status_flags_clear instead.

> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916205138.1677=
1-1-apokusinski01@gmail.com?part=3D4
