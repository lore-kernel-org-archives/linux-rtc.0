Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9347ACDC;
	Fri, 21 Aug 2026 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309132; cv=none; b=cEjbTANO+LWfWAN3fmS7/fOW1DcU5JazZ+SSLq11xLIvHmy0qWpi/SRCElsY3nBYU8BDKoS+T1hVL2PQLCi7FIvtALm524tQ5UYvcy7istUwMcP4ZiCkOTxt4Zlq0vHLwWxcZNSmH+1ET01qTVWv8t5EnFXlN3tM5mw54XwlWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309132; c=relaxed/simple;
	bh=V5F2CV1ZPJMlnM+dPEm0axmPnSnvFvsfYbGV5SjCBpc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XVkAETRd9E5aG6lOr2FD9tDItsybX/B9r7mH4bLX6RNjrYlq9JBbprO3+GmFiFMk53rB7R8o4amRnb++KKfe9oNrBg9pTR73eR839LT8JsYw0IeD5rjqnZ6k24IMY0NdfjObdKBuW3IZ5FgyYwgs7ZZygpkAaPXNKufGNczxlso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np+AYQ7D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np+AYQ7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411041F000E9;
	Fri, 21 Aug 2026 10:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787309131;
	bh=wSwf1wCZeet//DvHY/nYXHQfQsUu8Kz5WUOO0NnYjWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Np+AYQ7DTufj03R73NTJ7j+N0vE5egvWn+ijarAbG/3rWjnd+z2A3ZmdyqHnS+S/7
	 1TtNqTd/RsLOTcDvMCK6BsWDWzWOSZcaDU2sZljAe4bo/+yByw4E55dlZUtR1ucrsj
	 aCkhimOOHmfnac4ZqnGZ4BICLqXJwX2SzVws2xv0mrr9acc7+mOENheWcvMn7FBgV1
	 ApTVxG0ojGvqoPEmvdKb1AUj/AzIv5mSoia2voRpHd8fkuOaDLZEFK3bv6N7iFWmEL
	 17AicMqz2Rtv8A+DRsk4g0ZX/0ZA1v+rqyz+GXF6KpvFLrDi7MXTyxaaF8ytArOhTU
	 t1yFAQxkNY7Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] rtc: philips: Make sure clk_init_data is fully
 initialized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <8281eaf605069aac2211d83233e11285b8e8ca84.1787241693.git.geert+renesas@glider.be>
References: <cover.1787241693.git.geert+renesas@glider.be>
 <8281eaf605069aac2211d83233e11285b8e8ca84.1787241693.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:45:30 +0000
Message-Id: <20260821104531.411041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unmanaged `of_clk_add_provider()` causes memory leak and Use-After=
-Free (UAF) on probe failure or driver unbind.
--

--- Patch [4]: [PATCH 4/5] rtc: philips: Make sure clk_init_data is fully i=
nitialized ---
commit 33e5514e66c5385440eb77c7db4a09f5f2b1c50d
Author: Geert Uytterhoeven <geert+renesas@glider.be>

rtc: philips: Make sure clk_init_data is fully initialized

This commit zero-initializes clk_init_data upon declaration to prevent subt=
le
bugs from uninitialized mutually-exclusive members. This helps avoid issues
exposed when certain stack initialization configurations are enabled.

> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index 01e209d88f5f3..8cb9ffc73f6d9 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c
> @@ -498,7 +498,7 @@ static const struct clk_ops pcf85063_clkout_ops =3D {
>  static struct clk *pcf85063_clkout_register_clk(struct pcf85063 *pcf8506=
3)
>  {
>  	struct clk *clk;
> -	struct clk_init_data init;
> +	struct clk_init_data init =3D {};

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free and
resource leak regarding the clock provider registered later in this functio=
n.

In pcf85063_clkout_register_clk(), the clock provider is added using the
unmanaged API without any cleanup mechanism:

	clk =3D devm_clk_register(&pcf85063->rtc->dev, &pcf85063->clkout_hw);
	if (!IS_ERR(clk))
		of_clk_add_provider(node, of_clk_src_simple_get, clk);

If the probe later fails when calling devm_rtc_register_device() in
pcf85063_probe():

	return devm_rtc_register_device(pcf85063->rtc);

Or if the driver is unbound via sysfs, devres will automatically free the
clock structure and driver data.

Since of_clk_add_provider() is unmanaged, does this leave the clock provider
in the global of_clk_providers list pointing to a freed clock?

It seems a subsequent device tree lookup could invoke of_clk_src_simple_get=
()
and cause a use-after-free by returning the dangling pointer.

Would it be better to use a managed API or devm_add_action_or_reset()
to ensure the provider is safely removed on teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787241693.gi=
t.geert+renesas@glider.be?part=3D4
