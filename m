Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4347F2CC;
	Mon, 14 Sep 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396481; cv=none; b=Jq9H1mObIJ0nqyv+eXL9tgdej7mMrRwCA4afoSJ058DIm/PLIN9GuWWqng57Pp+FDhn+nkg5cWoexXPCyxEwYuCl5jC+PrznoSGoOL2IXQDSEmEwSB1Mz3GxhmiGnlMa/4wfCeP9OqARszcmoxv6Ra9Yh3ETomQTDR+wRtUX9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396481; c=relaxed/simple;
	bh=f5byggXjpqh+b/WuNgnpgsX06cKUQVwY955c/sKkggI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D2yNP3mE4uariPggRwdvn4Y+Eon95/jEwhVJ5ivf0m1DLIm84CBngD4mpfDgQGQqhETGXoEIdnoGnedtf7z5jW//i3+9foQoGDCOI7EcJZ3eQ/ZD9MtCR9qfJkux7XT06uHogT1Kk1z6ysLP8duQfH2YOenDEHX5Weq8Hx9RLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzBkOHyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzBkOHyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15BA1F000FF;
	Mon, 14 Sep 2026 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396480;
	bh=93VDUuptAX940frxflNLuAn9xS5nIidbQbVMzIjHoPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UzBkOHyRCd8fRU28htTfHJh59oE+BQvu7+ypdZ5GTQ10WjwZaWPU+C7vLYAXS52EW
	 47gaJ4FJ56eXS3NXFhNfgad7xmdrXwSaxfs+AAPbLGtkPaRP5tYeTJL4HEUs6UJUlM
	 +qAfYo5zZVCMx0kBx6ioKL5MHUIp39DEa8ZY6Jjj22nYW1dUIdWgOJIS56V5+11/ui
	 vrJTCE2fk/5N0WlSaaeSxYnCgioQISA7REo7PuMJdksIlcLC17ebPNLhq+KfefR79M
	 unHALzWtzPSQW4BCYzob8x+9oKJxhB8Qxvc49GY+3hBb0owQKUKXq+EkHIKJEJmsV5
	 Z3ByTfpSKOMwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/2] rtc: Add NXP PCF85053 driver support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260914141537.3881890-2-lakshay.piplani@nxp.com>
References: <20260914141537.3881890-1-lakshay.piplani@nxp.com>
 <20260914141537.3881890-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:34:39 +0000
Message-Id: <20260914143439.D15BA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Possible use-after-free of `rtc` object in `rtc->irqwork` due to u=
nbalanced devres teardown order.
- [High] Missing mutual exclusion between the threaded IRQ handler and alar=
m configuration leads to dropped alarms.
--

commit 41cf346ef49a0ce7f8953c6b31dac43a5fae5017
Author: Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: rtc: Add NXP PCF85053 driver support

This commit introduces support for the NXP PCF85053 I2C RTC. It includes
timer and calendar functionality, alarm management, and clock output contro=
l.

diff --git a/drivers/rtc/rtc-pcf85053.c b/drivers/rtc/rtc-pcf85053.c
--- a/drivers/rtc/rtc-pcf85053.c
+++ b/drivers/rtc/rtc-pcf85053.c

[ ... ]

> +static irqreturn_t pcf85053_irq(int irq, void *dev_id)
> +{
> +	struct device *dev =3D dev_id;
> +	struct pcf85053 *pcf85053 =3D dev_get_drvdata(dev);
> +	unsigned int st;
> +	int err;
> +
> +	err =3D regmap_read(pcf85053->regmap, PCF85053_REG_ST, &st);
> +	if (err || !(st & PCF85053_BIT_AF))
> +		return IRQ_NONE;
> +
> +	/*
> +	 * The alarm matches every day; disable AIE to make it one-shot. Mask
> +	 * the interrupt before clearing AF so there is no window where AF is
> +	 * cleared but AIE is still able to re-assert the line.
> +	 */
> +	err =3D pcf85053_set_aie(pcf85053->regmap, false);

[Severity: High]
Could this threaded IRQ handler race with pcf85053_rtc_set_alarm() and drop=
 a
newly programmed alarm?

If the IRQ thread reads the status register and sees the alarm flag AF is
set, but is then preempted by a userspace process programming a new alarm v=
ia
pcf85053_rtc_set_alarm():

Userspace in pcf85053_rtc_set_alarm() would:
- configure the new time
- clear AF
- enable AIE

When the IRQ thread resumes here, it calls pcf85053_set_aie(..., false).
Would this overwrite the newly enabled AIE bit and silently disable the new
alarm interrupt?

[ ... ]

> +static int pcf85053_probe(struct i2c_client *client)
> +{
> +	const struct pcf85053_config *config;
> +	struct device *dev =3D &client->dev;
> +	const char *iface =3D NULL;
> +	struct pcf85053 *pcf85053;
> +	int err;

[ ... ]

> +	pcf85053->rtc =3D devm_rtc_allocate_device(dev);
> +	if (IS_ERR(pcf85053->rtc))
> +		return PTR_ERR(pcf85053->rtc);

[ ... ]

> +	if (config->has_alarms && pcf85053->is_primary && client->irq > 0) {
> +		/*
> +		 * ALRT is shared by the alarm (AIE), oscillator-fail (OFIE) and
> +		 * RTC-clear (CIE) sources. This driver only services the alarm,
> +		 * so disable the other two; otherwise ALRT could stay asserted
> +		 * with AF=3D0 and the handler could not clear it.
> +		 */
> +		err =3D regmap_update_bits(pcf85053->regmap, PCF85053_REG_CTRL,
> +					 PCF85053_BIT_OFIE | PCF85053_BIT_CIE, 0);
> +		if (err)
> +			return err;
> +
> +		err =3D devm_request_threaded_irq(dev, client->irq,
> +						NULL, pcf85053_irq,
> +						IRQF_ONESHOT,
> +						"pcf85053", dev);

[Severity: High]
Is there a potential use-after-free during device unbind due to the devres
allocation order here?

Since devres cleans up in reverse order of creation:
1. devm_rtc_register_device() unregisters the RTC.
2. devm_request_threaded_irq() frees the IRQ.
3. devm_rtc_allocate_device() frees the RTC structure.

If a hardware alarm interrupt fires exactly in the window after the RTC is
unregistered but before the IRQ is freed, the handler pcf85053_irq() will
execute and call rtc_update_irq().

This unconditionally queues rtc->irqwork, but the rtc object will be freed
momentarily when devm_rtc_allocate_device() unrolls. Can this result in a
use-after-free when the scheduled work runs on the freed rtc object?

> +		if (err)
> +			return dev_err_probe(dev, err,
> +					     "unable to request IRQ %d\n",
> +					     client->irq);
> +
> +		set_bit(RTC_FEATURE_ALARM, pcf85053->rtc->features);
> +		err =3D devm_device_init_wakeup(dev);
> +		if (err)
> +			return dev_err_probe(dev, err,
> +					     "failed to initialize wakeup\n");
> +		err =3D devm_pm_set_wake_irq(dev, client->irq);
> +		if (err)
> +			return dev_err_probe(dev, err,
> +					     "failed to set wake IRQ\n");
> +	}
> +
> +#ifdef CONFIG_COMMON_CLK
> +	err =3D pcf85053_clkout_register_clk(pcf85053);
> +	if (err)
> +		return err;
> +#endif
> +
> +	return devm_rtc_register_device(pcf85053->rtc);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914141537.3881=
890-1-lakshay.piplani@nxp.com?part=3D2
