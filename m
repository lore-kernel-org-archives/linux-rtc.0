Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B1287518
	for <linux-rtc@vger.kernel.org>; Mon, 24 Aug 2026 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559563; cv=none; b=nQ25GudKrTSP8b/oNZcyKbsSym4/7FXSiNeegjsPTc5i7qal1gXAgvllwBT9iXYeSc1vPY7z3aEXj4oVpzQpahelN2FEju5f9+7EeKOa0wuA8buB22pcIgNC5g7nRn7/CFTRIU14eTclWCOCTj9qx9rC0IkCHNKy0zna+JSri5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559563; c=relaxed/simple;
	bh=a6u+3A1nIwBM197JpABf0ZreM9GhMmHlf0Ed9GrcEwU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eWZp5u4mQtnDT96SaxF943gYUHGfE0y8mMeLRmDHy6+xSRue4ezQkqmOmy0EF8wNE2sl3Ca+cbKqz11sNuY3J3PBoNm4aqYbmaIYNtPXLgZ8pmeMfgsR427cRNFBHKTfq19u7FuzL9bapXZNZdAZtx6aUi0MhjfbnvT/O0tctVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHSqHu/U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHSqHu/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF2D1F000E9;
	Mon, 24 Aug 2026 08:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787559562;
	bh=bGIh+6koBjqrYVe8KN2VOFn3EVOfiifYG/OlC2bW0YI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VHSqHu/UYYbZLt7ymj8G3e74O29w8URGK15Ua7f+rz5YSK4XLCigdrD985SYlOzdN
	 w5O9X/Ylbt0uc0OgVOQ+Po20ZXdv8jfes7yNQ4C5W3M/KPtnDXg/eMjKHnvukUxUJA
	 W1caRhuAUv5QN+CLhxzbMjlzNjfa3GY9iGb706UsMfO6pOms2ubKf17LJmCHxV6u4J
	 cwhe1sVb7xPYXbz246Lkw96NaJg76CoUBy46y78HhuTz/h1jlpAuXsPVMyM7zGdZj6
	 4vSqE8LGnH2qhfa+n0+P0Fiud6NsPQNGDHALHqMxjPxBWh1IDFXFUkGWMQhN7UZgYe
	 8C2jmm+LwVytg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: pcf85063: disable the clkout output by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260824080801.709764-1-alexander.sverdlin@siemens.com>
References: <20260824080801.709764-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:19:21 +0000
Message-Id: <20260824081921.CDF2D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Unconditionally gating the CLKOUT clock during probe overrides=
 the hardware power-on state and breaks Device Tree ABI backward compatibil=
ity.
- [Low] The patch introduces a compilation failure because the variable `re=
t` is undeclared, and returning it directly causes a type mismatch.

Pre-existing issues:
- [High] The driver's clock implementation violates the Common Clock Framew=
ork (CCF) contract by implicitly enabling the clock during set_rate and dis=
carding the configured rate after unprepare.
- [High] The clock provider registered via `of_clk_add_provider` is never r=
emoved, causing a memory leak and a dangling pointer on driver unbind, desp=
ite the commit message claiming otherwise.
--

--- Patch [1]: [PATCH] rtc: pcf85063: disable the clkout output by default =
---
commit f0b8f2118b75da5ed86252e825d0385a7e1fe816
Author: Alexander Sverdlin <alexander.sverdlin@siemens.com>

rtc: pcf85063: disable the clkout output by default

This patch gates the PCF85063 CLKOUT pin by default before registering the
OF provider to save power, unless a consumer explicitly claims it.

> Therefore gate CLKOUT in the driver before registering the OF provider,
> mirroring the pcf8563 and hym8563 siblings which already force an off sta=
te
> at registration. Doing it before devm_of_clk_add_hw_provider() leaves the
> real consumers in the device tree free to re-enable the output afterwards,
> while an otherwise unused CLKOUT now stays off.

[Severity: High]
This is a pre-existing issue, but the commit message mentions using
devm_of_clk_add_hw_provider(), which contradicts the actual code. The code
still uses of_clk_add_provider() without a corresponding removal, which
leads to a dangling pointer and memory leak if the driver is unbound:

drivers/rtc/rtc-pcf85063.c:pcf85063_clkout_register_clk() {
    ...
    if (!IS_ERR(clk))
        of_clk_add_provider(node, of_clk_src_simple_get, clk);
    ...
}

Since devm_clk_register() automatically frees the clock allocation on
unbind, but of_clk_del_provider() is never called, the global
of_clk_providers list will contain a pointer to freed memory. Should the
driver be updated to actually use devm_of_clk_add_hw_provider() to ensure
proper cleanup?

> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index 8cb9ffc73f6d9..9ccfc893be8d3 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c
> @@ -523,6 +523,12 @@ static struct clk *pcf85063_clkout_register_clk(stru=
ct pcf85063 *pcf85063)
>  	/* optional override of the clockname */
>  	of_property_read_string(node, "clock-output-names", &init.name);
> =20
> +	/* power-on default is the 32768 Hz output on; gate it until claimed */
> +	ret =3D regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
> +				 PCF85063_REG_CLKO_F_MASK, PCF85063_REG_CLKO_F_OFF);

[Severity: Critical]
Does unconditionally gating the CLKOUT clock during probe break Device Tree
ABI backward compatibility? Legacy hardware platforms might rely on the
default active 32.768 kHz clock output without explicitly defining a clock
consumer in their device tree. Will those systems lose their clock signal
when booting a kernel with this patch?

> +	if (ret)
> +		return ret;

[Severity: Low]
Does this code compile with CONFIG_COMMON_CLK enabled? It looks like the
variable ret is undeclared in pcf85063_clkout_register_clk(). Also, since
the function returns a struct clk pointer, wouldn't returning an integer
error code directly cause a type mismatch?

[Severity: High]
This isn't a bug introduced by this patch, but does the current clock
implementation violate the Common Clock Framework contract?

Looking at pcf85063_clkout_set_rate(), setting a rate implicitly enables
the clock by modifying the hardware register directly:

drivers/rtc/rtc-pcf85063.c:pcf85063_clkout_set_rate() {
    ...
    return regmap_update_bits(pcf85063->regmap,
                              PCF85063_REG_CTRL2,
                              PCF85063_REG_CLKO_F_MASK, i);
}

Furthermore, if a consumer disables the clock and later re-enables it,
pcf85063_clkout_control() unconditionally resets the rate to 32768 Hz,
discarding any previously configured custom rates:

drivers/rtc/rtc-pcf85063.c:pcf85063_clkout_control() {
    ...
    if (enable) {
        if (buf =3D=3D PCF85063_REG_CLKO_F_OFF)
            buf =3D PCF85063_REG_CLKO_F_32768HZ;
    ...
}

Will this cause custom clock rates set by consumers or device tree to be
silently lost across enable/disable cycles?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824080801.7097=
64-1-alexander.sverdlin@siemens.com?part=3D1
