Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793598291;
	b=4gGG+bzZYZJ4R/6GQ3LC73mPLNEVyMxFUmqsyfuN/cXGpTianNaJ68q1kmSFuPBMFqo+
	 rj0ksJaywO/Kyi5fyJJyuuGwlMLTvOYczP8AJRGJ54FFfzRJnZxq5igyTRP/3rgT+acLt
	 xbuii8ldvbGdYC6CR8HhFy7ywmj0FDxptq+AF9HrPG70bUccMjfGRVu7Z1zvaWaVIdYJS
	 0nToz6PiQQ4r4PuvW06f0rHeMql4Ty4aFuMqbP83eemfEvDzQAolQOeDMvQp56cY5g/gE
	 aCW4b0Q37ix/OEgIW9Dkxt1VuRzpUVSh6XQxrT5GeLFhCm1BKCvwhozB1TidnhikOHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793598291;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mFp7tohhPZAqLgfV25DlFazRnjrErluUbALeGPYkzSI=;
	b=wCXwm8zZDtFe+QDKHc4kOIuz3svUxd0NdW1CVIaQr81BphcpD6kBwtDt1P/umZNU7acv
	 h5A5yinwluRfoa5KkAUvv2niCrnu3WsOZPRBEQR4neQQ9HHhykCnBUqj76fvhZ3NBVXDu
	 fxoCcuk6c+yZvW80RgXRkOSFrYKOcwG3XHFkILKiF6bHkWusEaiLhCX+jGkfkmpX4JDWa
	 Nwvsvl94PDLUB2/K6OKF5Bl6/n0kaofs4Or5cPlZOdfLO+Gv0o0zGyBTnG4S4hZoyTx9f
	 jncRIlTRz8FnADRzir2EjXtOsBPEJl85oy0KPx3w9o7gkQewyGyv/9fLp08CQQ1SOpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vn5hJCtf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A444606A324;
	Mon,  2 Nov 2026 05:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vn5hJCtf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845071F00A16;
	Mon,  2 Nov 2026 05:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793598291;
	bh=mFp7tohhPZAqLgfV25DlFazRnjrErluUbALeGPYkzSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vn5hJCtfSWM1keBPjzEf4kyndK73P/ON+YvSE79YvuJn++nrG6bxC8GeuW7xmpH5D
	 p3KnyKe+Vcw27aWnYEODslZrOJR3RhT9+WZmu5SPzc0nCNvL4ilyZkSKWpdw29A8I+
	 6csnVZGA+f3egLLSgz07Bho6CZx8Yaib7BZZ6KmBtKWysmiAzvLfZJfj4qaVGbMSKo
	 J/fuAYowOz4kKUn9CXwQzg5VcCzE+XxLmzmnhlIBzsfH7ZRc6Y+Qbzcny3NabxBD4J
	 hJU+k5ANt1W6O156ntyvfIUyfaZ/0UpusFvwOk6HWyhdSue0PFi5mQ8HOm8U6LZgpZ
	 qs69qe4oZFCAQ==
Message-ID: <sashiko-outbox-192928@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] rtc: mt6397: provide the 32 kHz output as a clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, lee@kernel.org
In-Reply-To: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-2-9758f38d7053@gmail.com>
References: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
 <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-2-9758f38d7053@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 05:44:50 +0000
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
- [High] rtc: mt6397: NULL dereference of rtc->data in mtk_rtc_register_clk=
out()
--

commit 7a674b1fa23c59043354cce078b81b55651fd9c2
Author: Ryan Brue <ryanbrue.dev@gmail.com>

rtc: mt6397: provide the 32 kHz output as a clock

This commit registers the MT6397 RTC's 32 kHz output gated by RTC_CON.F32KOB
as a clock provider when the RTC node specifies #clock-cells, allowing clie=
nt
devices such as Wi-Fi/Bluetooth combo chips to enable their sleep clock.

> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index d6e156516aa6c..5130fecffa7b4 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
[ ... ]
> @@ -317,6 +318,84 @@ static int mtk_rtc_nvram_write(void *priv, unsigned =
int offset, void *val,
[ ... ]
> +/* The 32 kHz output the PMIC drives to other chips, such as a combo chi=
p */
> +static int mtk_rtc_register_clkout(struct device *dev, struct mt6397_rtc=
 *rtc)
> +{
> +	struct clk_init_data init =3D {
> +		.name =3D "mt6397-rtc-32k",
> +		.ops =3D &mtk_rtc_clkout_ops,
> +	};
> +	int ret;
> +
> +	if (!rtc->data->con || !of_property_present(dev->of_node, "#clock-cells=
"))
> +		return 0;

[Severity: High]
Can this dereference a NULL rtc->data pointer during mtk_rtc_probe()?

In drivers/mfd/mt6397-core.c, mt6397_devs[] unconditionally registers the
mt6397-rtc MFD cell:

    {
        .name =3D "mt6397-rtc",
        .num_resources =3D ARRAY_SIZE(mt6397_rtc_resources),
        .resources =3D mt6397_rtc_resources,
        .of_compatible =3D "mediatek,mt6397-rtc",
    }

On MT6397 boards whose Device Tree omits the optional mediatek,mt6397-rtc
child node under the PMIC node (such as mt8173-evb.dts and mt8135-evbp1.dts=
),
mfd_add_device() registers the mt6397-rtc platform device with
pdev->dev.of_node set to NULL. Because mtk_rtc_driver has .driver.name set =
to
"mt6397-rtc" and no id_table, platform_match() binds the device via the
driver-name fallback and invokes mtk_rtc_probe():

drivers/rtc/rtc-mt6397.c:mtk_rtc_probe() {
    ...
    rtc->data =3D of_device_get_match_data(&pdev->dev);
    ...
    ret =3D mtk_rtc_register_clkout(&pdev->dev, rtc);
}

When pdev->dev.of_node is NULL, of_device_get_match_data() returns NULL.
Previously, mtk_rtc_probe() never dereferenced rtc->data during probe,
whereas mtk_rtc_register_clkout() now evaluates !rtc->data->con before
checking dev->of_node or whether rtc->data is NULL.

Should mtk_rtc_register_clkout() check !rtc->data (or check
of_property_present() first), or should mtk_rtc_probe() handle a NULL
rtc->data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101-rbrue-suez=
-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com?part=3D2
