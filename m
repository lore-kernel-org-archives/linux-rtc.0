Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078AE35C190
	for <linux-rtc@vger.kernel.org>; Fri, 28 Aug 2026 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936725; cv=none; b=ZucigI9EhWV8EHaTeAOg4ucU29l7yKfz9j58+KLifPlNcW4a4othY7fni3oammDcsvjCybwB7CzVxgeFNaj7g1mCaJ6dXejzSJmcCQb+50/N8ebQu0xtBWfBMox8X03wwiLKm9qfgJwHNqoU1uxSCur3D0JgkpLfJ44nEfwLvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936725; c=relaxed/simple;
	bh=PjPY4K62PnHqaFBWrGiMwqfhTBTb5cg7Ix3CzbYbgwU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qoNHSyM6gaAut97Bp41wVN9AbhXvRnMO6B/CIit51q4/RsWd6hp7vJxuLLry4U4xZaAM7gx64/sq5Q5sm9Ke4JoS2k8UURRx5QD+o3PRw5Uh5qG4Tz/Hnwm2Xt7F+LG/O4lNJT0VaTqQnlB5+HS7wCJE1e7pe1mvTzJ4PuhizwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Crzfsng5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Crzfsng5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF0D1F000E9;
	Fri, 28 Aug 2026 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787936723;
	bh=X8qiL2anTj1XF+AjQbg7/kUd8/bQfDD4ix3zh3OpwmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Crzfsng5p8nero40crW4qFKYv5PC6B1oyfn1ELdV7gFwICjvlF+H2aAe3kDXMC5DQ
	 C+8xIaSY/Ui9wL97PWInhbca4pR9u72Fbd64PDcPoLjkImzzwA/2k/uZCFU6N9gjW1
	 W2jE4nrmzQjA7Cuv+S53ndXwNtemL1JdfrF5m+Arj3XzNgEtibDzgIJ0cIeLBNdqms
	 yG9aRxOv1UJTzUqxEv5yOzkX2vRMYzpx5qi2110RJPoN1/Wv2Sq4H+baAVdnqpvGF5
	 i3RSGd62onOcdJesa2YrC9x8Bdv2D6lEkQHbL+6cOJJzjvA7yRPBM/22ex9tvR46ad
	 p/+k1pffWqCeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] rtc: pcf85063: do not clear AIE in the interrupt
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260828164445.3907839-3-alexander.sverdlin@siemens.com>
References: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
 <20260828164445.3907839-3-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 17:05:22 +0000
Message-Id: <20260828170523.6FF0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of wake IRQ and wakeup source for the SPI device l=
eads to memory leaks and a use-after-free of the IRQ number upon unbind.
--

commit a20e38cbd0dbed144e6a870cac13aec94ffaa637
Author: Alexander Sverdlin <alexander.sverdlin@siemens.com>

rtc: pcf85063: do not clear AIE in the interrupt handler

The interrupt handler cleared the AIE bit while acknowledging the AF flag, =
which
could race with process-context updates. The RTC core already manages disab=
ling
the alarm interrupt, so this patch limits the handler to only acknowledging=
 AF.

> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index ac9ab1c376c0b..af900fe8ae15e 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c
> @@ -238,8 +238,7 @@ static irqreturn_t pcf85063_rtc_handle_irq(int irq, v=
oid *dev_id)
>  	if (val & PCF85063_CTRL2_AF) {
>  		rtc_update_irq(pcf85063->rtc, 1, RTC_IRQF | RTC_AF);
>  		regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
> -				   PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF,
> -				   0);
> +				   PCF85063_CTRL2_AF, 0);
>  		return IRQ_HANDLED;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but I noticed a potential leak during driver
unbind for the SPI variant in this file.

In pcf85063_probe(), the wake IRQ and wakeup source are allocated without
using devres:

drivers/rtc/rtc-pcf85063.c:pcf85063_probe() {
    ...
		} else {
			set_bit(RTC_FEATURE_ALARM, pcf85063->rtc->features);
			device_init_wakeup(dev, true);
			err =3D dev_pm_set_wake_irq(dev, irq);
    ...
}

The SPI subsystem, unlike I2C, does not automatically clear the wake IRQ or
wakeup source on driver removal. Since the rv8063_driver SPI driver lacks a
.remove callback, could this leak the wake IRQ and wakeup source when the
driver is unbound?

drivers/rtc/rtc-pcf85063.c:
static struct spi_driver rv8063_driver =3D {
	.driver         =3D {
		.name   =3D "rv8063",
		.of_match_table =3D rv8063_of_match,
	},
	.probe          =3D rv8063_probe,
	.id_table	=3D rv8063_id,
};

When the driver is unbound, devm_request_threaded_irq() frees the IRQ via
devres, but dev->power.wakeirq still holds the freed IRQ number and the
wakeup_source remains registered.=20

If the system subsequently suspends, dev_pm_arm_wake_irq() iterates over
registered wakeup sources and calls enable_irq_wake() with the freed IRQ
number. Could this access a stale IRQ descriptor and interfere with hardware
state, potentially leading to an unhandled IRQ storm on resume?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828164445.3907=
839-1-alexander.sverdlin@siemens.com?part=3D2
