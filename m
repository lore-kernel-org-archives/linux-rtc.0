Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370859;
	b=xmXnNjhS1/9ouZ8dwsqvwxYygsCvF+21IIc/AJx98y/HQ2aqyn327IKEU6MeUIhdhS2e
	 5ibKMyMuiHVIg7cK+gaNHTa1KpUdSR1xPBy5EWDXJlbTVi7e4ZChdyiT3E/0HSDlbW+Jd
	 Jfg8IqIpD5f0lZJ/BLrtYWE9RP7IXcxLHoisNKtoqgr0NWlL9FEu912XDV12KKRZWwF37
	 t8PfgqYzv9lHC3S23J9KkMbUfgl8aOWg8+xbdBjAXnsiuE5GxIdQGYGqkMlNnJzkoU0r2
	 zZUcImPQFzbNoHXCuy17+bFVfALL9Fpru4e1jqRfEbMZnw+IoX/dqAzJhDEnAhueqxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370859;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LZ5EdNqBsxXh5fJ/fBAx7ysenYHyOTCJIM89ryCZP3k=;
	b=scroDEHQoMmDxWJ4f1bJ78ACz0XLV4ZrZ2BJ5wpBPnFbo0tEeXsXtoGPIBihjGT/U2t/
	 s5UwUDRvRd5GUW/4USjwYh5wpuvtOrAkHDgHwP6pUXfuag9jatgSfVMPE3BlQSwemIr0b
	 ptf7HmBybVYbAttT0Nxi7C+6hc8AS8HTiVEfbdjX5aRNTTr8afvDAQG2XsMnGq8sIPlBL
	 QKn9BAgaL5GVgJQEkZLQ4fDn7seymeW6R89rAjVwp6BfdlHYntEDoBLUBMZIs/D/+iwj1
	 5hbMaW4n6lRNnOjJ7SmuTdyHeTeyc0H/2rtzu1AQ+3YJtW5g0rNwbJ9yJFEmykj1gvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OM4hNswX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404E606A320
	for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 04:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OM4hNswX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F03A1F0089F;
	Wed, 11 Nov 2026 04:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370858;
	bh=LZ5EdNqBsxXh5fJ/fBAx7ysenYHyOTCJIM89ryCZP3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OM4hNswXiI5qE5eSlR0cTvkCwX08cCmHTYmVmHudTlQMotX5lxuk2DNvolT/Wghi6
	 P/I5SmPPvvN4sBIOE8mn6eVrOn9LXw2IxwFVYKvnP8/WvxKszqVFJmwuoDf2GJh0au
	 LYMujyWL836ynuNxnSGeO/UPrPdh1rMMtef01j7IXBT7aFIfkh4A5eOfsJfrBJv364
	 vFLsuMQqxR6aI+ZGpIiLVuKLMIyJsQ8I1ShOwHnP1zZfevb944ezgkqiKGzQbvYyjN
	 zjqEjvcas9dIo0Luo8xEvV0DfaFrbBdksEwWSxEqisaGgSHvhq7jApX8hbNlD2pXJT
	 BVg/zgREIGuHQ==
Message-ID: <sashiko-outbox-208272@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] rtc: Add Qualcomm GIO RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261110-gio-framework-rtc-driver-2026-10-12-v1-3-e4164178183a@oss.qualcomm.com>
References: <20261110-gio-framework-rtc-driver-2026-10-12-v1-0-e4164178183a@oss.qualcomm.com>
 <20261110-gio-framework-rtc-driver-2026-10-12-v1-3-e4164178183a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:20:58 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] soc: qcom: devm-allocated auxiliary_device in
  pmic_glink_gio_add_consumer()
--

commit d5c1d09a8c9a83fd69f16467e16b3f0ae413a0cd
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

rtc: Add Qualcomm GIO RTC driver

This commit adds an auxiliary RTC driver for the Qualcomm GIO interface
and registers the "pmic_gio.rtc" auxiliary device from the PMIC GLINK GIO
driver.

> diff --git a/drivers/soc/qcom/pmic_glink_gio.c b/drivers/soc/qcom/pmic_gl=
ink_gio.c
> index f222c0d59220f..83656a5758b81 100644
> --- a/drivers/soc/qcom/pmic_glink_gio.c
> +++ b/drivers/soc/qcom/pmic_glink_gio.c

[ ... ]

> @@ -318,6 +320,28 @@ static void pmic_glink_gio_enable_alerts(struct pmic=
_glink_gio *pgio)
>  		dev_err(pgio->dev, "GIO turn on global alert failed: %d\n", ret);
>  }
> =20
> +static int pmic_glink_gio_add_consumer(struct pmic_glink_gio *pgio,
> +				       struct auxiliary_device **aux,
> +				       const char *name)
> +{
> +	struct auxiliary_device *new_aux;
> +	int ret;
> +
> +	new_aux =3D devm_kzalloc(pgio->dev, sizeof(*new_aux), GFP_KERNEL);
> +	if (!new_aux)
> +		return -ENOMEM;
> +
> +	ret =3D devm_pmic_gio_add_consumer(pgio->gio, new_aux, name);
> +	if (ret) {
> +		devm_kfree(pgio->dev, new_aux);
> +		return ret;
> +	}

[Severity: Medium]
Can allocating new_aux with devm_kzalloc() cause a use-after-free when
pgio->dev unbinds or when devm_pmic_gio_add_consumer() fails after
auxiliary_device_init()?

devm_pmic_gio_add_consumer() initializes new_aux->dev with
auxiliary_device_init():

drivers/soc/qcom/pmic_gio.c:devm_pmic_gio_add_consumer() {
	...
	aux->dev.release =3D pmic_gio_aux_release;
	aux->dev.platform_data =3D gio;
	device_set_of_node_from_dev(&aux->dev, gio->dev);
	ret =3D auxiliary_device_init(aux);
	...
	ret =3D auxiliary_device_add(aux);
	if (ret) {
		auxiliary_device_uninit(aux);
		return ret;
	}

	return devm_add_action_or_reset(gio->dev, pmic_gio_del_aux_device, aux);
}

Once auxiliary_device_init() has been called, the lifetime of new_aux is
governed by the embedded struct device reference count and its memory may
only be freed from the dev.release callback.  Instead, devres frees
new_aux as soon as pgio->dev unbinds (or immediately via devm_kfree() if
auxiliary_device_add() fails), while references to new_aux->dev are still
held or before delayed kobject release runs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-gio-framew=
ork-rtc-driver-2026-10-12-v1-0-e4164178183a@oss.qualcomm.com?part=3D3
