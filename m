Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501923;
	b=XHyurVN+v+PdpzmBiNC5zrv222slhbgSwGMoEmnkcrlmKJYExiVlfdfZdnES8atKFRLe
	 nQmr14o2e57JmjDQCl3FysclvpyQugRTpFvoJWYDyYqR+q8LL9dtiYw5PDTN9w475PE50
	 qEzBf8RcAKpW7GQoebr3orTcknpazvpW6D36A19DYAIQ6IrsOXC+0qjaGHXrdsve84lxb
	 EcpQYR9rnShbRRxjPGTWkuRqEDNgYjHATWCebjpSYJ3ovSLMqigu7f4vtceisNwKE+/gI
	 4qOu2ENoEUS5O8t+1Y+PrmGpb7jTT51dIDyMtYe6DZ/zmiJfIijO9KGLs1iEU03yQNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501923;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0/8Hk7GoysrKMa2DfPPd3jtfYGnEQXHj4uVE2dx3+qo=;
	b=C3yr4tytS9/FSeCL2uTX3wauze2rOGZnBJGHKEh+FyuVoTsp1L96ab98CzDkuyrnCZEd
	 jTyNOk/R+jMn0rhbD6kAH5RQCo3zMBmIPZ5DsRdfvElM4+omzE89Xhhi15j4d4jMNiDcS
	 8eYYm7XgtBhKfJWuoXBjM0PwC4rtKbNFtQJM3YQFOaxeomuUhQWYB0MgShFkb8lpGZ+ei
	 TmRhm/fevUiO+3GrYql5gYFKdm90bhsj7v68wNP67eL92KjOidWRIaltVoIkhZUVyUnmL
	 kFiCtN4dODaiPhjeczPx3Abnh1W6bdhHztKMS9Ko85lAuw67hmq4bH3AGF1pqTarsEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKbUdfTS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9860A2622
	for <linux-rtc@vger.kernel.org>; Tue, 20 Oct 2026 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKbUdfTS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5F81F000C4;
	Tue, 20 Oct 2026 13:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501922;
	bh=0/8Hk7GoysrKMa2DfPPd3jtfYGnEQXHj4uVE2dx3+qo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CKbUdfTSQyXBx1t9ohIc1xFJNpCBXLFwd5Qf3YHHOVWaMUrYzmFLQcECtwYq3AFH0
	 Z0Zq/5bQ/H2ZardCUcCbj8VIGGyhOQnZtK66GcM6bYsxoCkZ1jd4yvHk72K0s/V/NJ
	 TALYOqogBdILcyUk7dTZ+yR5EhggOMQQMJEBBtStQAszzNW60Rt90fVSYs5S5QJW9H
	 MC6oXL6Z4HvdKgiSqLoFUCQzQyk+qcXBU9jgvJBVXsVxGt7yav794AMbAqn3UNumZx
	 +cUof2MfCSSUPEdlUjzPM5127JSBh+fePO93P5OwyPGvTHViB6armSSLvMJQao+T7y
	 KMdjoTaKMsoqg==
Message-ID: <sashiko-outbox-179002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: pcf2127: arm the alarm IRQ as a wake IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aristo Chen" <aristo.chen@canonical.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261020125124.1097546-1-aristo.chen@canonical.com>
References: <20261020125124.1097546-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 13:12:02 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rtc: pcf2127: duplicate wake IRQ registration in pcf2127_probe()=
 on I2C
--

commit bb7257d310771e0aa92e0b399681a4feb16cf42a
Author: Aristo Chen <aristo.chen@canonical.com>

rtc: pcf2127: arm the alarm IRQ as a wake IRQ

This commit registers the RTC alarm IRQ with devm_pm_set_wake_irq() in
pcf2127_probe() so the PM core arms the interrupt as a wakeup source
during system suspend.

> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index ff2023908f5a3..51d8aebf34069 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
[ ... ]
> @@ -1251,6 +1252,12 @@ static int pcf2127_probe(struct device *dev, struc=
t regmap *regmap,
>  	if (alarm_irq > 0 || device_property_read_bool(dev, "wakeup-source")) {
>  		device_init_wakeup(dev, true);
>  		set_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
> +
> +		if (alarm_irq > 0) {
> +			ret =3D devm_pm_set_wake_irq(dev, alarm_irq);
> +			if (ret)
> +				dev_warn(dev, "failed to set wake IRQ: %d\n", ret);
> +		}
>  	}
> =20
>  	if (pcf2127->cfg->has_int_a_b) {

[Severity: Medium]
Can calling devm_pm_set_wake_irq() unconditionally here trigger a kernel
warning when an I2C-attached PCF2127/2129/2131 has both interrupts and
wakeup-source specified in its device tree node (or has I2C_CLIENT_WAKE set
via ACPI)?

For I2C devices, of_i2c_get_board_info() in drivers/i2c/i2c-core-of.c sets
I2C_CLIENT_WAKE when wakeup-source is present:

    if (of_property_read_bool(node, "wakeup-source"))
            info->flags |=3D I2C_CLIENT_WAKE;

Before invoking the driver probe callback (pcf2127_i2c_probe() ->
pcf2127_probe()), i2c_device_probe() in drivers/i2c/i2c-core-base.c already
initializes the wake IRQ when I2C_CLIENT_WAKE is set:

    if (client->flags & I2C_CLIENT_WAKE) {
            int wakeirq;

            wakeirq =3D fwnode_irq_get_byname(fwnode, "wakeup");
            if (wakeirq =3D=3D -EPROBE_DEFER) {
                    status =3D dev_err_probe(dev, wakeirq, "can't get wakei=
rq\n");
                    goto put_sync_adapter;
            }

            device_init_wakeup(&client->dev, true);

            if (wakeirq > 0 && wakeirq !=3D client->irq)
                    status =3D dev_pm_set_dedicated_wake_irq(dev, wakeirq);
            else if (client->irq > 0)
                    status =3D dev_pm_set_wake_irq(dev, client->irq);

When pcf2127_probe() then calls devm_pm_set_wake_irq(dev, alarm_irq),
dev_pm_attach_wake_irq() in drivers/base/power/wakeirq.c sees
dev->power.wakeirq is already initialized and fires dev_WARN_ONCE():

    spin_lock_irqsave(&dev->power.lock, flags);
    if (dev_WARN_ONCE(dev, dev->power.wakeirq,
                      "wake irq already initialized\n")) {
            spin_unlock_irqrestore(&dev->power.lock, flags);
            return -EEXIST;
    }

returning -EEXIST and printing the warning in pcf2127_probe().

Would it make sense to skip calling devm_pm_set_wake_irq() when the bus core
has already configured the wakeup source (or when dev->power.wakeirq is
already set)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020125124.1097=
546-1-aristo.chen@canonical.com?part=3D1
