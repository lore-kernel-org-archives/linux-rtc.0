Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0837E5DE;
	Tue, 11 Aug 2026 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478637; cv=none; b=gX3FWStL6XzOIlyB2iEkgrgnFYF2An4n4TgC3C2W97VtGtdYPrNv5PodUL86/q6L9BT+BjozeKdPwHTHkmkbeLHI9an0vKrBnFfQpottSWHWV0Kf2yktvPJO76Jb0gTBaiDbha7tec1PSvAwZyBhWtqlPeqPVCkf4Ec5JhkYNdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478637; c=relaxed/simple;
	bh=dCzIU7ojE8D3UmzNibeyd975Rw86O5ZtsP9WH4rx9+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cdp0Wu4/Qyf9LB4aHpr4sxG7SnPnQQoCPHKxF1cPz9SvR2LgevD2w43geycGX2Dh6nc66bpe8i+bguV9CePV5P6Q4Fwtgm+KtFusSvuB7UPtok9UOKasSjfM8K5oEVB+nZld+17VYSXqzVMDbD+kvt6P5xG5+R5d88vz9FlY6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibaORHt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibaORHt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B981F000E9;
	Tue, 11 Aug 2026 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786478635;
	bh=6GNUxbGg84bFvNfezGSzVaWY/WwMbCtxfyu0mf+DJfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ibaORHt2RqE13gkr6prwxcXP2CPvw+SarpAqNC5mvtCW0GW/Ap8yoWQ9IAH8eDAU1
	 yh0QAOPuH/qbO4t8XokLxNz2sMQ6qyCbVIysrngqnKeAeaQoVbjQJjF4qdAwPQre0s
	 jjtMOu+KHyagZ+6xpejm5q7fSJpyV8yYHsTC4v1wWm9H1MIR8W87k8W0n/mBPk3/Fd
	 rC7uAgzo4A9yy1frJM7dC1aXrD7WXw1w+nxqlelIyBYggpfwWwyz2rzviG60oABC8B
	 7FGPDhW8ggLxsEV6HTFgzwthwquaMbzBs8CbP8fFR3yezsvrZt+h51tfZxndlKEkjW
	 BxjGNAqn7/cVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] rtc: abx80x: add support for ABX81X
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260811194034.28937-10-apokusinski01@gmail.com>
References: <20260811194034.28937-1-apokusinski01@gmail.com>
 <20260811194034.28937-10-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 20:03:54 +0000
Message-Id: <20260811200355.40B981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Read-modify-write (RMW) operations on the W0C (write-zero-to-clear=
) status register cause lost interrupts.
--

--- Patch [9]: [PATCH v5 9/9] rtc: abx80x: add support for ABX81X ---
commit de21e840f75a86e42ad746c99077b6acf5f3e1fb
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: add support for ABX81X
   =20
Abracon ABX81X is a family of RTCs with SPI interface featuring
the same functionalities as the ABX80X I2C clocks.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 08b22c0676995..7145de876b50b 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * A driver for the I2C members of the Abracon AB x8xx RTC family,
> - * and compatible: AB 1805 and AB 0805
> + * A driver for the I2C and SPI members of the Abracon AB x8xx RTC famil=
y,
> + * and compatible: AB 1805, AB 0805, AB 1815 and AB 0815

[ ... ]

While reviewing this patch, I noticed a pre-existing issue in the driver
that might cause lost interrupts.

drivers/rtc/rtc-abx80x.c:abx80x_handle_irq() {
[ ... ]
	if (handled =3D=3D IRQ_HANDLED)
		regmap_write(priv->regmap, ABX8XX_REG_STATUS,
			     status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT));
[ ... ]
}

[Severity: High]
This isn't a bug introduced by this patch, but does this write inadvertently
clear newly-asserted interrupts?

The ABX8XX_REG_STATUS register uses a 'Write 0 to Clear' (W0C) mechanism,
where writing 0 clears a bit and writing 1 preserves it. Because the code
bitwise-ANDs the previously read status, it writes 0 to any bit that was
0 during the read.

If a hardware event asserts a flag between the read and this write, the
write of 0 will clear the new event before it is handled.

[ ... ]

drivers/rtc/rtc-abx80x.c:abx80x_ioctl() {
[ ... ]
	case RTC_VL_CLR:
		scoped_guard(mutex, &priv->lock) {
			err =3D regmap_update_bits(priv->regmap, ABX8XX_REG_STATUS,
						 ABX8XX_STATUS_BLF, 0);
		}
[ ... ]
}

[Severity: High]
This is also a pre-existing issue, but does this read-modify-write operation
expose all other W0C flags to the exact same race condition?

Using regmap_update_bits to clear the BLF bit performs a read-modify-write
and writes 0 to all other unasserted bits, which could cause them to be lost
if they were asserted right after the read phase.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194034.2893=
7-1-apokusinski01@gmail.com?part=3D9
