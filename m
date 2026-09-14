Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389E233936;
	Mon, 14 Sep 2026 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367649; cv=none; b=qCuJhXUg6m5MLYFh8nyuTp8+Dv8ojuz/cQYsxASSI0qHt4WYwVpXrelFYCSLkAgFMXvGh5lCQdPZMx7MkFF1piaWrEfig1s+W4HSnMS5guDVSfVAZTrm7eBeN4KASm4moXIAbgz1UBCdD8bQIs5dcsOvwYG/SyJFGGUw8qZm8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367649; c=relaxed/simple;
	bh=57NCocXFLUL3aUV3LBVm3NQHMo8OnYkge14JuiM5zM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HPj13o37uAcUDG3AtNyW8AkC9IUXKCEv3qJWy36E++49GjtB5Vf6lotvI+nESIkHJaimK2zKE0fpzs6GyAARwlqaYc58r+BL1cg4dubd4HY01j/cWZALomrl7jrrJWT6xFgMtBZ9zoCjJeWdMdvQvm7T5AEwOf9A8rBD3box9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSIa/NsZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSIa/NsZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170931F000FF;
	Mon, 14 Sep 2026 06:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367647;
	bh=AF1jmbnhhJHLc89Yno9skiykaf+JVrSOtw9oJg3LKdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QSIa/NsZoJtG8BMsreJu436V1asEUUALc07i41QUnFuMq1R6EdcuLltdHEn9zgfGa
	 lqMQKziB15XgMROm1SddE6O4FaUFXzLdFmEeUaa2Wh+7dvfVPsfZsZsI1F/4wiHh+F
	 JIMib8CuJLmkkrDD3wK6OJnwqFMTvM0MQLd0clQboZvKg3EUoelVZeNjjCcF6u3mMR
	 uQZ1Wj7UObqkEbg886K+iLuEENcEzPNRvAX+KXF7zQmVCska2BJDlC1T+lTRqfpL4V
	 egIrB1sWt/hwPS28ZsPBHGDg321qAngLfoJrupx2+KQJ5A+zUI0QV9ZEGCineRVjlE
	 9MVQfQd8szNVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: rtc: Add pcf85053 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260914062048.3704059-1-lakshay.piplani@nxp.com>
References: <20260914062048.3704059-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:34:06 +0000
Message-Id: <20260914063407.170931F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The schema definition for `interrupts` lacks a description indicati=
ng that the alarm interrupt is active-low level triggered, contradicting th=
e commit message.
- [Low] MAINTAINERS file changes are included in the dt-bindings patch desp=
ite the commit message claiming they were moved to the driver patch.
--

commit fbacfc3b449475be8cfd2e294eee7d9182570611
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

dt-bindings: rtc: Add pcf85053 support

This commit adds device tree bindings for the NXP PCF85053 RTC chip.

> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml b/Do=
cumentation/devicetree/bindings/rtc/nxp,pcf85053.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml
[ ... ]
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +

[Severity: Low]
Does this property definition need an explicit description? The V8 -> V9
changelog states "Describe the alarm interrupt as active-low level
triggered," but this definition only contains maxItems: 1.

While the example at the bottom of the schema correctly uses
IRQ_TYPE_LEVEL_LOW, the property itself lacks the promised description text.

[ ... ]

> diff --git a/MAINTAINERS b/MAINTAINERS
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19571,6 +19571,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
>  F:	drivers/extcon/extcon-ptn5150.c
> =20
> +NXP RTC PCF85053 DRIVER
> +M:	Pankit Garg <pankit.garg@nxp.com>
> +M:	Lakshay Piplani <lakshay.piplani@nxp.com>
> +L:	linux-rtc@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml
> +

[Severity: Low]
Should these MAINTAINERS file changes be included in this dt-bindings patch?

The V2 -> V3 changelog claims "Moved MAINTAINERS file changes to the driver
patch", but this patch still introduces the new section.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062048.3704=
059-1-lakshay.piplani@nxp.com?part=3D1
