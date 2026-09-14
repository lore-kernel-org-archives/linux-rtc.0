Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61AD39E18E;
	Mon, 14 Sep 2026 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421402; cv=none; b=GGhNy98y8585zyE3bJD7PBC8+HgHD9dMeMAX+63u7xEyFabOtRbra0l0VlUer+W8TZTq1zYMS07kNGS1AELmt0nz9n/8WtH4vvNFKf1fpfvrmprH/alVtYXxQUJI/vKAp/4OqSGnplY8TpEuy3jTw3PY9/TE8Zir1TgXfzytjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421402; c=relaxed/simple;
	bh=sffVtv5DgPeAsJoPREIVlxQbySHZZICD8U4V8HuXI/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s+Hag9+4zEjDGe5beZmW1TCO3yvUrw85AkjOgUMZgu5sJoygAwV2skJ6g6kN2vUvNcNw/4VwO8mVxPRNhlvqhZVsmlxm5Y1ismPBGAqm/3uXC45qGPwvCChzED7/DTrppQ42RbFxboWPFzt/QaPtI8oXXyRdKZvBhb9RIbo3YUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te7edimY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te7edimY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E10C1F000FF;
	Mon, 14 Sep 2026 21:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789421399;
	bh=Yy0ZQ8tQWhX4ISt0LGUcQ0fRpgj97EM9WaJBBFr2Eng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Te7edimY7jeUNx2GDDicXQzdnllg8arCM4zojaYdUJrOkZcnLwBxdUWIO8/xuEtto
	 yNKwT8eZNL2Mgyc9TsHaq0HIVrhiWCnqG6ZWBSz7FW3cbm2Ebi+9bpgZtfArPOYifD
	 /pbkdkq1z/Jz1Luc7is+QGlTba6GUVOmt0A6/ctGqxaxqlcV6V/iIRbOJ36e4f7dz0
	 Z4ThEhy1kehxQ01/mT4MZTMEpMFk9vZnMtLchJ6jC5r7PUM2W0I/8fFW5ghIJWOFIP
	 I67zsTt2pgZDViVMYTPhL0puN34rFcCRFW/sgm+H5jLAbM5qcS+GE0VSam3ssmH5Rg
	 xFbYfMqwaXj1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: rtc: rzn1: add R-Car X5H support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260914211826.73727-13-wsa+renesas@sang-engineering.com>
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
 <20260914211826.73727-13-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 21:29:59 +0000
Message-Id: <20260914212959.7E10C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The R-Car X5H compatible string is missing an `if-then` conditio=
nal block to explicitly disallow interrupts.

Pre-existing issues:
- [High] The driver dynamically modifies a global static `rtc_class_ops` st=
ructure during probe, causing operations to be incorrectly shared and corru=
pted across all device instances.
--

commit a9257218efe4782b04de9171568942363749f822
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>

    dt-bindings: rtc: rzn1: add R-Car X5H support

This patch adds support for the R-Car X5H hardware variant to the RZ/N1 RTC
device tree binding schema. The commit message explicitly notes that this
hardware is identical to RZ/T2H except that interrupts are not wired.

> diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml =
b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> --- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
[ ... ]
> @@ -66,6 +71,7 @@ allOf:
>              enum:
>                - renesas,r9a09g077-rtc
>                - renesas,r9a09g087-rtc
> +              - renesas,rcar-gen5-rtc
>      then:
>        properties:
>          clocks:

[Severity: Medium]
Since the commit message states that interrupts are not wired for R-Car X5H,
should there be another if-then block added to the allOf section to
explicitly restrict the interrupts property for renesas,rcar-gen5-rtc?

Without this conditional check, a device tree incorrectly defining an
interrupts property for this compatible string would silently pass schema
validation despite the hardware limitation.

While reviewing the associated driver code, I noticed a separate issue:

drivers/rtc/rtc-rzn1.c:rzn1_rtc_probe() {
[ ... ]
	if (scmp_val) {
		writel(rate - 1, rtc->base + RZN1_RTC_SCMP);
	} else {
		rzn1_rtc_ops.read_offset =3D rzn1_rtc_read_offset;
		rzn1_rtc_ops.set_offset =3D rzn1_rtc_set_offset;
	}
[ ... ]
		rzn1_rtc_ops.read_alarm =3D rzn1_rtc_read_alarm;
		rzn1_rtc_ops.set_alarm =3D rzn1_rtc_set_alarm;
		rzn1_rtc_ops.alarm_irq_enable =3D rzn1_rtc_alarm_irq_enable;
	}

	return devm_rtc_register_device(rtc->rtcdev);
}

[Severity: High]
This is a pre-existing issue, but does mutating the global static rzn1_rtc_=
ops
structure during probe cause state corruption across device instances?

If multiple RTC instances exist, devices probed subsequently that lack
certain capabilities (like no SUBU register or no alarm interrupt) will
incorrectly inherit the callbacks set by previously probed devices. Could
this lead to unhandled behavior if unsupported operations are invoked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914211826.7372=
7-8-wsa+renesas@sang-engineering.com?part=3D5
