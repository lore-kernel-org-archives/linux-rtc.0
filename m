Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368832;
	b=Kr5Zc5S7h9vdAxo6NhZXFAHmg9Nwl/QVV94a60nWdZ8EFOhSnRLU/RyZVHu0w9regr9/
	 RoOu4G5Z+8SXFHO5GnAgKXuAlZux24OURh2hWmxuIomO/RPPyC3UVDzZTudrrX5apkF7X
	 JlV9NpQCrmz+V+WXm2izMvkUxREy4c9/e4OPUpzdNHoAF8xi/ordIwkhmMk5bJ0dAhqnq
	 mKpX1j7shjehDaKaJREHCZEmsAwlnLvvPgFQdPIMEqPD5otO0ShfJmPjSJDh/0AbiUB1B
	 mbab9O1X7VdA83sh+n7WW4Dv391zvYq67sTCvxx99YKvZrvSIhhbaPctKo3MSeIszSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BKYEfMA+qkNmwM5QrG6RXKh2BIzfUJTRqYphD0Kqqm8=;
	b=uuSbea/xrgUbj7B5jXURZ+W7eZXdvyJ6tss/y75pIwb7KYnMfmNUzyZEOZS15frVGdAF
	 /ISWboSh8zjEmMwFX5vhsNu4HaBdmzQxJ2VqJ1suD4ZAbNHv+vPCWeVhzSz0wKs2/jA9X
	 ZlZVJIGtvk+ISCQZhpNvr/ruokR2kTSob0juylrwAiHCegcO77MKtI7S76la0Q6eD6rmb
	 ri2HU/XRwF8udrAp/yMARl4AyOqjqaV/Nms8lWgHkGBCteqULZ9E+7l4SsorbC+W3nDPk
	 kts+tmBvQz6L9GD/Tva/QW4ofMdaAZlNIF4r3PR3MA7rCzICrsr18OBKBu127PqWfDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Omyz16xf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB2606A31C
	for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Omyz16xf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C741F0089F;
	Wed, 11 Nov 2026 03:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368831;
	bh=BKYEfMA+qkNmwM5QrG6RXKh2BIzfUJTRqYphD0Kqqm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Omyz16xfzuzADds17jfeggTrZIvw/fE8XW4jsVPULIFcpfseV5jCLjc+4sT07yRcz
	 qOrADKbYZU9wrqgjMxpqqvu1qQPA5b/RwK+x5mXMwsS/tubQFEJ0o8Fmxdg0fzVN4Q
	 dJYNVJ5qKOjv/LWEEyFpNRlN9KWu6eHGkRNhQV8xFYO0FQqUX7fi56V0q0fjyJ8L0L
	 BkyBVhM5EOrHYjGIgqG1kkL0x6b4cNjYw2vMk0SUIu+FYO0PCWiUdpEEjMObgHvFA4
	 ZXraeTV1Bo6fe+33n7Fo82A2GLgQUat1v23b43BN2A6SM9wcMRtp32gzyJsNO5s1ig
	 t95VfzguVxZ1A==
Message-ID: <sashiko-outbox-208223@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] soc: qcom: Add pmic-gio GIO framework driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261110-gio-framework-rtc-driver-2026-10-12-v1-1-e4164178183a@oss.qualcomm.com>
References: <20261110-gio-framework-rtc-driver-2026-10-12-v1-0-e4164178183a@oss.qualcomm.com>
 <20261110-gio-framework-rtc-driver-2026-10-12-v1-1-e4164178183a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:47:10 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] soc: qcom: pmic_gio: UCSI MESSAGE_OUT blocks marked read-only
  in pmic_gio_reg_blocks
- [Medium] soc: qcom: pmic_gio: broken auxiliary_device release lifetime
  in devm_pmic_gio_add_consumer()
--

commit 0534b1e914edfb726f83b9ccdae4428780afd1fd
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

soc: qcom: Add pmic-gio GIO framework driver

This commit adds a transport-agnostic PMIC GIO framework driver that exposes
the SoCCP battery-management firmware register space via regmap, routes
alerts through a virtual IRQ domain, and provides helpers for registering
transports, state notifiers, and auxiliary consumer devices.

> diff --git a/drivers/soc/qcom/pmic_gio.c b/drivers/soc/qcom/pmic_gio.c
> new file mode 100644
> index 0000000000000..7237bf1c549cf
> --- /dev/null
> +++ b/drivers/soc/qcom/pmic_gio.c
[ ... ]
> +static const struct pmic_gio_reg_block pmic_gio_reg_blocks[] =3D {
[ ... ]
> +	/* USBC */
> +	{ GIO_USBC_IF_VERSION_ADDR, GIO_USBC_IF_VERSION_SIZE, false },
> +	{ GIO_USBC_ALERT_STATUS_ADDR, GIO_USBC_ALERT_STATUS_SIZE, false },
> +	{ GIO_USBC_LAST_ALERT_ADDR, GIO_USBC_LAST_ALERT_SIZE, false },
> +	{ GIO_USBC_UCSI_VERSION_REG, GIO_USBC_UCSI_VERSION_SIZE, false },
> +	{ GIO_USBC_UCSI_CCI_REG, GIO_USBC_UCSI_CCI_SIZE, false },
> +	{ GIO_USBC_UCSI_CONTROL_REG, GIO_USBC_UCSI_CONTROL_SIZE, true },
> +	{ GIO_USBC_UCSI_MESSAGE_IN_REG, GIO_USBC_UCSI_MESSAGE_IN_SIZE, false },
> +	{ GIO_USBC_UCSI_MSGINX_REG, GIO_USBC_UCSI_MSGINX_SIZE, false },
> +	{ GIO_USBC_UCSI_MESSAGE_OUT_REG, GIO_USBC_UCSI_MESSAGE_OUT_SIZE, false =
},
> +	{ GIO_USBC_UCSI_MSGOUTX_ADDR, GIO_USBC_UCSI_MSGOUTX_SIZE, false },

[Severity: Medium]
Should GIO_USBC_UCSI_MESSAGE_OUT_REG and GIO_USBC_UCSI_MSGOUTX_ADDR have
writeable set to true?  In UCSI, the OS writes outbound command payloads to
MESSAGE_OUT and MSGOUTX before writing CONTROL, but
pmic_gio_regmap_bus_gather_write() and pmic_gio_writeable_reg() reject
writes when writeable is false.

[ ... ]

> +static void pmic_gio_aux_release(struct device *dev)
> +{
> +	of_node_put(dev->of_node);
> +	dev->of_node =3D NULL;
> +}
> +
> +static void pmic_gio_del_aux_device(void *data)
> +{
> +	struct auxiliary_device *aux =3D data;
> +
> +	auxiliary_device_delete(aux);
> +	auxiliary_device_uninit(aux);
> +}

[ ... ]

> +int devm_pmic_gio_add_consumer(struct pmic_gio_device *gio, struct auxil=
iary_device *aux,
> +			       const char *name)
> +{
> +	int ret;
> +
> +	aux->name =3D name;
> +	aux->dev.parent =3D gio->dev;
> +	aux->dev.release =3D pmic_gio_aux_release;
> +	aux->dev.platform_data =3D gio;
> +	device_set_of_node_from_dev(&aux->dev, gio->dev);
> +	ret =3D auxiliary_device_init(aux);
> +	if (ret) {
> +		of_node_put(aux->dev.of_node);
> +		aux->dev.of_node =3D NULL;
> +		return ret;
> +	}
> +
> +	ret =3D auxiliary_device_add(aux);
> +	if (ret) {
> +		auxiliary_device_uninit(aux);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(gio->dev, pmic_gio_del_aux_device, aux);
> +}
> +EXPORT_SYMBOL_GPL(devm_pmic_gio_add_consumer);

[Severity: Medium]
Does pmic_gio_aux_release() violate the struct device lifetime rules by not
freeing aux?  A reference-counted struct auxiliary_device must be freed in
its dev.release callback when the last reference drops; if the caller
allocates aux with devm_kzalloc(), unbinding the parent frees aux while a
reference to aux->dev may still be held, causing a use-after-free.

Could devm_pmic_gio_add_consumer() wrap devm_auxiliary_device_create(gio->d=
ev,
name, gio) instead of taking a caller-allocated struct auxiliary_device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-gio-framew=
ork-rtc-driver-2026-10-12-v1-0-e4164178183a@oss.qualcomm.com?part=3D1
