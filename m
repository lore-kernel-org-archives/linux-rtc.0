Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913D2F7EF6;
	Tue, 25 Aug 2026 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642668; cv=none; b=O0bOGryC4fTVKSDlBhQPIQeuEEu5y+yVPoZEjpG2smUFRhdZO3wCue8x2ViHv2QehGBwEMdXwsxSTxH5bA4YudC1Mnmf+yxEvO63s3mkoI98broCiBm2koiLYpi1iLYWXiF+J9fh2jczwM72qKzTvsGrYnE0VqcnwaAC+vM+8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642668; c=relaxed/simple;
	bh=C5LYAn31a+0QFsASq8xoICp2dp1xj+BKtJHHlthw070=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tz5AGItoCyHj0s71xMy1Gv/W3nXsW+nd6vwESlpZJRdvUd50kz3+IpOiVH9L0HimhRqSL5o4/lgaLdhemALnv0yHZSVUi/JyIvZgcmv5Lf4H0/77E2WkqYS6llveT0F+gmK84EkI5TyTJkPBP/4E2F5Ld/KsH+nqoh5mXZ7+gBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RamAZi6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RamAZi6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77DE1F000E9;
	Tue, 25 Aug 2026 07:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787642667;
	bh=TZzu6SOl6cUAtBmGXNzZPRHGs44nXco7LVPWeWcO+rQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RamAZi6fi9P6DlL8MqCKnmHjap1QjePgOSMFxIv7JfaiBsvKE6wfR1F7NxebJp4mk
	 zHgPTeNZXfly+1U0ZG2udmrNzmXb5jetXlqsUa19oWPDU8Z2HvTMurLo9t8pHvCqqN
	 i7YqzAlBnjE5pkljpCjmtqFi17zBfH996jkDUmlx6hozmJ/tShzHovOVdCvmc7GeYo
	 QLrdn6wIYYqq5STK2+QR3aEPvwAq4nZq2c0YVKqoWPKJqxkk1lVFbtP4Xdym0sNzP0
	 +oo5S/ge7BDEGVEPWl/Bhg9xy6EReTLUFvjwfj4LW0RzJlkxWjMG5QLbb2Rw3SFP7C
	 mAkxJvzRCvuBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: add ricoh,r2223x binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Schocher" <hs@nabladev.com>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260825071927.4090460-2-hs@nabladev.com>
References: <20260825071927.4090460-1-hs@nabladev.com>
 <20260825071927.4090460-2-hs@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 07:24:26 +0000
Message-Id: <20260825072426.A77DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `#clock-cells` property is omitted from the `required` list =
despite the device functioning as a clock provider.
--

--- Patch [1]: [PATCH v2 1/3] dt-bindings: rtc: add ricoh,r2223x binding ---
commit c9a8726516af9b3ebff5835956246051050d1e80
Author: Heiko Schocher <hs@nabladev.com>

dt-bindings: rtc: add ricoh,r2223x binding

This commit adds a new device tree binding for the Ricoh R2223x I2C RTC.
The device drives a clock output and features an eco mode to lower current
consumption from the backup supply.

> diff --git a/Documentation/devicetree/bindings/rtc/ricoh,r2223x.yaml b/Do=
cumentation/devicetree/bindings/rtc/ricoh,r2223x.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/ricoh,r2223x.yaml
[ ... ]
> +  start-year: true
> +
> +required:
> +  - compatible
> +  - reg

[Severity: Medium]
Since this device functions as a clock provider and defines #clock-cells,
should #clock-cells be included in the required list?

Omitting it allows incomplete device tree nodes to pass schema validation
but fail at runtime when dependent subsystems attempt to use the clock
functionality.

> +
> +additionalProperties: false
> +
> +examples:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825071927.4090=
460-1-hs@nabladev.com?part=3D1
