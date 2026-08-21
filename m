Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24446D577;
	Fri, 21 Aug 2026 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309660; cv=none; b=bh53MZoJ0WCiYhlPr5O7+zLEpMUZhmCI6o7r6ER1OdpANKmpydOqpXRcXDGn+IxW0oGwnxsnsNJQ6ksb/4uRVKwubIFuGmV8mb/5P/AsY6kG67CzPOcy2yEa9tB+elDsN+J/gbVIb84sZEqRn5Tbf7QjXAaWZgf7jtPhYmJZGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309660; c=relaxed/simple;
	bh=SxbmPocrmuNfaEZIu/GB/DNMQTt6YCgBiYe/Sz5lSCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XXN2hdEy1tXGWgaoFWZjKChGf1Vk0m7SNtHyzvcG50XvBcy74axfKYAxiyyOGBEclnzB8BdbIpzibRicDe2CbJnYPxcor73rFRKR4eMA04Nr0xLLzfEef8sNFJWbzyrotwwvQOYrYK0jzNg2baidOcHT28PjrNR7xMCJFRb00/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anBC+iP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anBC+iP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8B01F000E9;
	Fri, 21 Aug 2026 10:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787309656;
	bh=pKzVHJ7Q5+3Va28/1NZ/54XhpPv+DZa5p2KbW6/9twM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=anBC+iP3RR40uqjVijDFV6/jq5QUzFzXJRhl51mmd8Rc/w0k7RAzOPWTCKr04Y48b
	 jaS1IG3uhceEzRFzM8PXknXRgSSxVk2ObGPZHzDc8fdrrcgvf3LDzYrRFuZDhGxjkO
	 HqAd3F8sVpNENYR8CXaOAu1jdOus73W0n5xjFi7JF7MwwgH2DD8iiprTiYeDSFXd/V
	 1Y+/j+b3GuUUuhVHZ4knh8x+7MEh/MjnVYV2tO4Uga+fnimtHY83bdcwOkQR1oPkX6
	 230jr1dlfn/HP8zrU6g+ZxnmaSXXc62NAtcqcKce4FdBljDNJ3SMYWHVtLpDhRR0o1
	 gAYyrq3QG0wxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] rtc: microcrystal: Make sure clk_init_data is fully
 initialized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <6e7b5258ff73e93fe23dd83cf56f806ee60fa7a9.1787241693.git.geert+renesas@glider.be>
References: <cover.1787241693.git.geert+renesas@glider.be>
 <6e7b5258ff73e93fe23dd83cf56f806ee60fa7a9.1787241693.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:54:15 +0000
Message-Id: <20260821105416.4F8B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unmanaged `of_clk_add_provider` combined with managed `devm_clk_re=
gister` creates a Use-After-Free and memory leak upon driver unbind.
- [High] Missing timeout in `rv3032_hwmon_read_temp` hardware polling loop =
can cause an infinite loop.
--

--- Patch [5]: [PATCH 5/5] rtc: microcrystal: Make sure clk_init_data is fu=
lly initialized ---
commit c0e71ecfe90533b7e0c9d613fb7e76ed54fcf87d
Author: Geert Uytterhoeven <geert+renesas@glider.be>

rtc: microcrystal: Make sure clk_init_data is fully initialized

This commit fully initializes the clk_init_data structure to avoid subtle
issues when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled. This prevents breakage when drivers are converted to different
methods for specifying parents.

> diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
> index d96f6bb68850d..d25e33d0835ee 100644
> --- a/drivers/rtc/rtc-rv3028.c
> +++ b/drivers/rtc/rtc-rv3028.c
> @@ -816,7 +816,7 @@ static int rv3028_clkout_register_clk(struct rv3028_d=
ata *rv3028,
>  {
>  	int ret;
>  	struct clk *clk;
> -	struct clk_init_data init;
> +	struct clk_init_data init =3D {};
>  	struct device_node *node =3D client->dev.of_node;
> =20
>  	ret =3D regmap_update_bits(rv3028->regmap, RV3028_STATUS,

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this functio=
n,
I noticed a potential issue with how the clock provider is registered later=
 in
rv3028_clkout_register_clk():

	clk =3D devm_clk_register(&client->dev, &rv3028->clkout_hw);
	if (!IS_ERR(clk))
		of_clk_add_provider(node, of_clk_src_simple_get, clk);

Because of_clk_add_provider() is unmanaged, does this cause a use-after-free
and memory leak when the driver is unbound?

The driver registers a clock provider using the unmanaged
of_clk_add_provider() but uses devm_clk_register() for the clock itself.

When the driver is unbound, devres automatically unwinds devm_clk_register()
and frees the clock structure.

Since there is no remove callback or devres action to call
of_clk_del_provider(), it seems the provider remains in the global
of_clk_providers list with a dangling pointer to the freed clock.

Since driver unbind can be triggered by a privileged user via sysfs or by
hardware hot-unplug, can this lead to a kernel panic if another driver looks
up the clock after the device is unbound?

> diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
> index 6bafdec637aea..687faaef42b25 100644
> --- a/drivers/rtc/rtc-rv3032.c
> +++ b/drivers/rtc/rtc-rv3032.c
> @@ -752,7 +752,7 @@ static int rv3032_clkout_register_clk(struct rv3032_d=
ata *rv3032,
>  {
>  	int ret;
>  	struct clk *clk;
> -	struct clk_init_data init;
> +	struct clk_init_data init =3D {};
>  	struct device_node *node =3D client->dev.of_node;
> =20
>  	ret =3D regmap_update_bits(rv3032->regmap, RV3032_TLSB, RV3032_TLSB_CLK=
F, 0);

[Severity: High]
This is also a pre-existing issue, but rv3032_clkout_register_clk() appears
to have the same unmanaged provider registration:

	clk =3D devm_clk_register(&client->dev, &rv3032->clkout_hw);
	if (!IS_ERR(clk))
		of_clk_add_provider(node, of_clk_src_simple_get, clk);

Does this also leave a dangling pointer in the global of_clk_providers list
when devres frees the clock upon unbind?

While looking at drivers/rtc/rtc-rv3032.c, I also noticed another
pre-existing issue in the hwmon code:

drivers/rtc/rtc-rv3032.c:rv3032_hwmon_read_temp() {
    ...
	do {
		prev =3D temp;

		ret =3D regmap_bulk_read(rv3032->regmap, RV3032_TLSB, buf, sizeof(buf));
		if (ret)
			return ret;

		temp =3D sign_extend32(buf[1], 7) << 4;
		temp |=3D FIELD_GET(RV3032_TLSB_TEMP, buf[0]);
	} while (temp !=3D prev);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this loop lack a timeout or maximum
retry count?

If the I2C hardware enters an unstable state and is faulty or noisy, it cou=
ld
consistently return varying values, preventing the loop from terminating.

Since this code path is exposed to unprivileged userspace via the hwmon sys=
fs
attributes, can this be used by unprivileged users to trigger an indefinite
hang on a task?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787241693.gi=
t.geert+renesas@glider.be?part=3D5
