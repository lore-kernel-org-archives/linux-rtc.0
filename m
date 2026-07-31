Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C9D3B6BFA;
	Fri, 31 Jul 2026 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524726; cv=none; b=WCpB53b2g+F1UyjcBycx4D6gvFEVByK6zj/Bfiz8uiGRIftWkgb23aRuJloWLmGy+9y2UWbhalt4yED+G9dh2HG0ipGZ85/l/LQimAosCn2SLOIBg7r4bbiJCLufMGE5UCJhyFup12dEMThORoae7Jc0juxP1PCRHef8V67z7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524726; c=relaxed/simple;
	bh=7QLZD+IdOf4EsThBoKlstQ5PIzb/vbMh1TwvBDHJHWw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pqi5BEJ2JtbRgKOszXgT8E2zjPR3dAxbMfIiex8ne8z0qHSy/UTQ5GF7M3jTDa78IBA8JBiia1oLix6fiLLoN0TlsFpwp+0AbnG+mshHu+uE6t/LA0jBl95MM/FCE3QffLSHsxfqXhibT975jNB9mmoCCjgjcJE+9RVX7f5G+8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTdH6UPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTdH6UPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11D41F00AC4;
	Fri, 31 Jul 2026 19:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785524723;
	bh=P16MSU8ZWjA7Kewd/eqWI0WCasgTfFwVlSxR22NxTkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XTdH6UPam7o0BhZuIz2ItiHRXqA+suGUJ14zNb63ZgzVXpMmOPd7yaL+0NA1D07da
	 WBokyrTjqycbPC6RmbLiFw/JOnx8tyIr/jSO3gOBL+Wl5dU5Bt9WfEDifsXsBjMx7D
	 4sNaCuIUJk+B3OSrgqJIh8Q3uiRT7lTacnVUjVQxNpO3sAx/Hi7+B7orpqltNcOE/v
	 NBhNpjM9hM2WD2xthagMochWIZA3WyI6lHvhARScO+U7iKwVdOPZU85ML6FzPprLy3
	 A4tXBOqsWbiEiKdhLITcENLhCkKuCmzuZaBKALhEn8VwSwoIPILCY/fX2lh5WKaD/N
	 X4LmU1iYDURzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] rtc: abx80x: properly handle shared IRQs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260731184831.44037-4-apokusinski01@gmail.com>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
 <20260731184831.44037-4-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 19:05:22 +0000
Message-Id: <20260731190522.C11D41F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning IRQ_NONE without masking or clearing unhandled RTC inter=
rupts can cause an interrupt storm on the shared IRQ line.
--

--- Patch [3]: [PATCH v3 3/8] rtc: abx80x: properly handle shared IRQs ---
commit e06155ed4aeb662277df57a2324e881c6d065e84
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: properly handle shared IRQs

This commit modifies the abx80x interrupt handler to only claim the IRQ and
clear the status register if the alarm or watchdog flags are explicitly set.
It aims to prevent claiming interrupts from other devices sharing the same
IRQ line.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c

[ ... ]

> @@ -266,27 +266,34 @@ static irqreturn_t abx80x_handle_irq(int irq, void =
*dev_id)

[ ... ]

> -	if (status & ABX8XX_STATUS_WDT)
> +	if (status & ABX8XX_STATUS_WDT) {
>  		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
> +		handled =3D IRQ_HANDLED;
> +	}
> =20
> -	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
> +	if (handled =3D=3D IRQ_HANDLED)
> +		i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
> +					  status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT));
> =20
> -	return IRQ_HANDLED;
> +	return handled;

[Severity: High]
If the RTC hardware asserts an interrupt for a reason other than AF or WDT
(for example, a timer or century interrupt left enabled by a bootloader),
will this cause an interrupt storm?

Because handled remains IRQ_NONE, the handler skips the i2c_smbus_write_byt=
e_data()
call and returns IRQ_NONE without clearing the unhandled RTC status bits.

Since the unhandled RTC interrupt is never cleared, the IRQ line will remain
asserted. This causes the kernel to immediately re-enter the handler until
the spurious IRQ detector steps in and completely disables the shared IRQ l=
ine.

Could we check if the status register indicates the interrupt originated
from this RTC, clear those bits, and return IRQ_HANDLED?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731184831.4403=
7-1-apokusinski01@gmail.com?part=3D3
