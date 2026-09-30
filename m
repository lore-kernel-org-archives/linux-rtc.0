Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33633B6D6;
	Wed, 30 Sep 2026 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758147; cv=none; b=iAInHurpUJhpiMh92wzX7EP+bEln1Ih5OBsVigZi3fkoc/gH/qvxf9jRSyNzhUQXCNi9bdZruBQOih8AaWD+ZUUeY+oj21BuwsWzoxrOtdqnWlt7TfvRhbsZxraKH9iUggWreQKPeGM43/JG+dGu//YXobX+1vXah877+Bc1zac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758147; c=relaxed/simple;
	bh=Bp0H97RGVcnNhgLgyQyDDm4y7cDi5b5h65DjbZkNxwc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TitI5i3e0265PDSaheTCANFnPkR2Ly5RnPkD8HOxm7WeriBSwMXTpbjOHxe286112LvtJtjbwjTYkoDB7kQLOv3nRpK/1+eCFqmufonlZM7rBEA+Ms4wJICSLp4AC62RX/HgF0enzmfZoDojzlxQrif0t1dODQp9McNlhMh+13E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM+026pr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM+026pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA641F00893;
	Wed, 30 Sep 2026 08:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790758146;
	bh=CSzUIBlRUjeyGtQIw8v8hKiOSDYuEYna/gt1FbNkadQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DM+026prM52PVZhRGuiiidwS42Kcsgc7jPirYGb2AVoXGrya9/JfuWx9caMpQQFrZ
	 p4CeG2S5r6sXmi6vCE8jHHpay4UqScPIgXmuxm8hoKFhRB1k3g38halx62avoHtcaL
	 ab5datshcTu3MK176N4mRb+4bi5ldBhOy55GO/nRcU+EsrjqcHCd8DaHgIxzpjlcYV
	 GDUdFaYlzA5ukVgCFePPT8IwlNLf5KivOWfp5Hf3/vOc3u7JuyFDZNqaIDH/ZAcxAr
	 9kTTGxiP2ICwF++elGRxiddphcSdzUBu+m6MzujBVw4MqL8rIfUrphjKkudXyt9DOn
	 sG0WAcoINOwhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260930083922.484885-3-sander.speetjens@gmail.com>
References: <20260930083922.484885-1-sander.speetjens@gmail.com>
 <20260930083922.484885-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 08:49:05 +0000
Message-Id: <20260930084905.CEA641F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt: brittle string comparison on model property instead of compa=
tible match
--

commit 785b9ba4b6f1ff162b94712e510b9c39d0c39474
Author: Sander Speetjens <sander.speetjens@gmail.com>

rtc: Add Raspberry Pi 5 RTC driver

Upstreaming the downstream Raspberry Pi 5 RTC driver. This driver supports
the custom DA9091, which is accessed through the firmware mailbox.

> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberryp=
i.c
> index 0aa322e9a2e73..a35f00c6fb2c1 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
[ ... ]
> @@ -231,6 +232,27 @@ static void rpi_register_clk_driver(struct device *d=
ev)
>  						-1, NULL, 0);
>  }
> =20
> +static void rpi_register_rtc_driver(struct device *dev)
> +{
> +	struct device_node *firmware;
> +
> +	// Check if our model is a Raspberry Pi 5, as the RTC is only present o=
n that model.
> +	const char *model =3D of_get_property(of_root, "model", NULL);
> +
> +	if (!model || strncmp(model, "Raspberry Pi 5", 14) !=3D 0)

[Severity: Medium]
Is it safe to use strncmp() on the human-readable "model" property to
identify the board here in rpi_register_rtc_driver()?

Since the check only compares the first 14 characters, could this incorrect=
ly
match unrecognized future devices like 'Raspberry Pi 500' and improperly
register the RTC?

Would it be better to use of_machine_is_compatible() with a compatible stri=
ng
match instead, which is more robust against formatting changes?

> +		return;
> +
> +	firmware =3D of_get_compatible_child(dev->of_node,
> +					   "raspberrypi,firmware-rtc");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930083922.4848=
85-1-sander.speetjens@gmail.com?part=3D2
