Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FCC4FC8C0;
	Sat,  5 Sep 2026 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634179; cv=none; b=WmoNtVklaUH7mKN/SdaX2ZsSEi6cLYKKRJURkXmsT+d13shIN4/gZ/0Z2TG4jUZdfC2VjJA7UI8H+ygGiCGrBLk0oFZy8b3HOKHkdg5by/KMgqUnGpE6u2m4Kd3uxRb1e+AAhoVkkveUGEertVKHQ8dSSaAJwTzpKQ3//30ehTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634179; c=relaxed/simple;
	bh=W8kozpw2My+lbWJxtWsmiyCLdbeT0rGZ0cKQfXX/fPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ffw+Ci9CFtrczGqShjrl1es1LZF4FKm0sva/i41zll3VFvNq6olOM/RkcE+CQ70BtXfQoGFg7t90xwVlI0Xx73P/9b9KivouNQ3WG7QMDKlGQIg7GV+9dDdevtFIogMrejoyAwYsk9uekRO+QsA7wfeIBfCte+60ADNP94/+yxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0yN+qjD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0yN+qjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155E11F00A3A;
	Sat,  5 Sep 2026 18:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788634176;
	bh=U3zdm9pcObqEYJ7/OUEISRLE8QOLYmo2E9+enwEY2DE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A0yN+qjDxA2SdE8lHBSsee5UWxLkPgPi6x5rRzaLLLqbWvwjJJnBopUkMRGjqRwv4
	 9BSp9tkp9qtWb9O5mFRX25eqEAl7kDG5A5ErRlcy06dDe2nnUjw9w/gvSh6LsSNIE1
	 v7ACTBpBatSz29Bn358ybV1D+1pmG6tDI7csbZa/l9S6Yc8hJ3pnXsBA0tEximJqx3
	 zevKFUOqgQ3p8ySMBLspgKm1aSiwv+By0/Y1tKIj23mjrBMEMBIxgjYuutUG4uuOGk
	 VhXKT7QABsIGh038VGTPgvjhC430fW6iBcM4ueMFWlumQYpYfKefraP+xHHEjj3Bzy
	 r7j38ufMAYdJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ac100: Assign .num before accessing .hws
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aamir Ahmed" <elb12345@hotmail.co.uk>
Cc: linux-sunxi@lists.linux.dev, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <AS8P251MB00013E724A77A355668B6CCEC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB00013E724A77A355668B6CCEC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:49:35 +0000
Message-Id: <20260905184936.155E11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of OF clock provider and fixed-rate clock on probe=
 failure causes a Use-After-Free and resource leak.
--

commit a37d5a060e39167e75415bce4b97e44f0383fe08
Author: Aamir Ahmed <elb12345@hotmail.co.uk>

rtc: ac100: Assign .num before accessing .hws

This commit assigns .num in struct clk_hw_onecell_data before accessing
its .hws[] elements in ac100_rtc_register_clks(). This fixes a bounds
sanitizer warning triggered by the __counted_by annotation introduced
in a previous commit.

> diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
> index bba7115ff3ad0..a2f465438fd05 100644
> --- a/drivers/rtc/rtc-ac100.c
> +++ b/drivers/rtc/rtc-ac100.c
[ ... ]
> @@ -360,7 +362,6 @@ static int ac100_rtc_register_clks(struct ac100_rtc_d=
ev *chip)
>  		chip->clk_data->hws[i] =3D &clk->hw;
>  	}
> =20
> -	chip->clk_data->num =3D i;
>  	ret =3D of_clk_add_hw_provider(np, of_clk_hw_onecell_get, chip->clk_dat=
a);
>  	if (ret)
>  		goto err_unregister_rtc_32k;

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of cleanup
in ac100_rtc_probe() lead to a use-after-free and resource leak?

In ac100_rtc_probe(), ac100_rtc_register_clks() manually registers a
clock provider and a fixed-rate clock which are not devm-managed:

drivers/rtc/rtc-ac100.c:ac100_rtc_probe() {
    ...
	ret =3D ac100_rtc_register_clks(chip);
	if (ret)
		return ret;

	return devm_rtc_register_device(chip->rtc);
}

If devm_rtc_register_device() fails, the probe function exits and devm
cleans up chip->clk_data. However, since the clock provider is not
unregistered on this error path, it remains active in the Common Clock
Framework with a dangling pointer to the freed chip->clk_data.

Can any subsequent attempt to query a clock via device tree traverse the
provider list, dereference the freed pointer, and trigger a crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/AS8P251MB00013E724A=
77A355668B6CCEC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM?part=3D1
