Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C186DCE1;
	Wed,  9 Sep 2026 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965078; cv=none; b=LK54Pg0qcS0f2VT3pDcD0jkBrIz2Tw+/3sR26ciR4kPVqoJc0oANiWlFgUoJm2O3yepl3xciGjRSFkJPFzmCpjCzBFZtpvg1Lr2bYpm4Viyz2YMuA1Ee5Nxg2Z9mJm8j549Nin1TBmdH1oWq6w+d65A73vlevexYdhdawpPrfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965078; c=relaxed/simple;
	bh=OIDfxYfqmu2Ih8oS8M2qJF3yY6RhAeQ+tTrgGOgS6lk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MuHic/YGpmjgsmnTqePdxwsc/eTUTuNcd+/U7qPe2Q7xzCLmXtOIluMBAzKp26mMSciHC99m112u0H7y7GQJph8Um0rmw5gvNqqibeWY1CEcnAcFb5t9i8JLnvVtVY8zO9Z+En2TZqGzbB8Ybb0IohreldQEg+uqKRpRYw7Dgj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8tXjrgK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8tXjrgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585DC1F00A3A;
	Wed,  9 Sep 2026 14:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965076;
	bh=xGQa4umocNQPl2GBMWaPQRtAI4fAX3MesHNulA0VUaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P8tXjrgKs3SxMzTz/VbwlC4Irbe3G0TRzskSF27d03bU61ncn/YvpKqD5rUT5wMnK
	 Z8sksvzLTcq1dI6/N9rkNeYh/lxsU7fwbomcnlHizjD2rk2I4jA3m4vY9CTgU+2LPG
	 yPjedm/rotgNAFX3wUkNn8fHGFHHDBzKuV80EpDRl6lxBRl6Gsvd7kSAs9oFjTDNZh
	 Cm4T5MReeCNFaF5JDjyPsVmahRaMQroFX/BfY1rpVFWTAPn14kesOkJaH8UAMc41tG
	 jlVikEHXM01lt68qbYVx0ivg+KUe2IZt21KUEnqA1PM6BkFK/kYPYqnn2v2PCyI7Dn
	 nuiQM7+Sr8hDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: broadcom: Add RTC to Raspberry Pi 5 B
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260909141300.1368790-4-sander.speetjens@gmail.com>
References: <20260909141300.1368790-1-sander.speetjens@gmail.com>
 <20260909141300.1368790-4-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:44:35 +0000
Message-Id: <20260909144436.585DC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The RTC node uses a non-generic node name.
- [Low] Commit message contains multiple obvious spelling mistakes.
--

commit badbff5dbc66bc9afed161f21071dd3b6408304c
Author: Sander Speetjens <sander.speetjens@gmail.com>

arm64: dts: broadcom: Add RTC to Raspberry Pi 5 B

This commit adds a devicetree node for the battery-backed RTC found on the
Raspberry Pi 5's custom DA9091 PMIC, accessed via the firmware mailbox.

> The Raspberry Pi 5 contains a RTC on a custom DA9091 PMIC that is accesed=
 trought the firware mailbox.
> This so we have a battery backed RTC, so the OS does not need network to =
get the time.

[Severity: Low]
There are a few typos here: "accesed trought the firware" should be "access=
ed
through the firmware", and "This so we have" should be "This is so we have".

> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi b/arc=
h/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
> index b7a6bc34ae1ab..5a82dd585f32b 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
> @@ -102,6 +102,13 @@ wl_on_reg: wl-on-reg {
>  		startup-delay-us =3D <150000>;
>  		enable-active-high;
>  	};
> +
> +	rpi_rtc: rpi-rtc {

[Severity: Low]
Should this node use a generic name like "rtc" instead of "rpi-rtc"? The
Devicetree specification recommends generic names reflecting the class of t=
he
device rather than the specific model.

> +		compatible =3D "raspberrypi,rpi-rtc";
> +		firmware =3D <&firmware>;
> +		status =3D "okay";
> +		trickle-charge-microvolt =3D <0>;
> +	};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909141300.1368=
790-1-sander.speetjens@gmail.com?part=3D3
