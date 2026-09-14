Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040B838B7A6;
	Mon, 14 Sep 2026 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421378; cv=none; b=MXM2Twx09ov1Ui/hNUtKT7rw8viwBMRjUsRscflN8AYAQDG9s8bJpRJXDiVbC+cn/p9adETwmzuTlft9zBuJEokClryUKt9ZyJXQ0YnkpHqL7gWZEzEIU39iPBttSctN1xb7ZkjLn65H60wV5w4f2pv6tHHlS5PrgSFzVR+U8fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421378; c=relaxed/simple;
	bh=FTOlaPKBzrfLHwVJg60o08uCOppfYItlAcBpECkbVe4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rUH4yw0PRJXWy2nLH5VU35V6LixRUGEpfXrgPUEIMdCGxlZLePDJFcDG+gQcOQQpTkD6QKB9eIfNkvWZwsJTM3CC7BvAij001MCA5tb/6eJQIsGGSFoCQ5QR2IRkDVYauf5tdVqaiz6DTtgpVjVyIjecOQmMWI5oivuNsi0zcLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH88T+9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH88T+9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C56B1F000FF;
	Mon, 14 Sep 2026 21:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789421376;
	bh=/U4fM2akW0kipN4DMQEfvBEPra533m9MNRA2EHmFwRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YH88T+9dsWgMOSgli+DEPAyABWjMzzAthSKSbw1eo2JCLmI1eTHNedPaTICGu+gYz
	 qd81SHJ3bbzpg2t1mqlYfpCQXglJF0zTScZkpodMsrOc1FOYIh4Pl7tKgOU7H6iYHf
	 JjW6wJk5e96lvH9UNnsz4F4qzsqeO0sZQOpqKeJr3qe7SYi74pRoQPDKBbSSLdRv3U
	 Xe/XAgEn3U5OhIrP9UPmVB+kV9cEuju8bwl1kOiV2uzBMuioxLBjj1eX3QC6BdqO78
	 RW8Psvc+d+thqhENIPDYEcqnqxE7InCdByoLJemC4rJzpN380fNwUwtaFnz4dAzVaB
	 HpbnVQrGjst0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: rtc: rzn1: interrupts are not required
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260914211826.73727-11-wsa+renesas@sang-engineering.com>
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
 <20260914211826.73727-11-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 21:29:36 +0000
Message-Id: <20260914212936.6C56B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Globally removing `interrupts` and `interrupt-names` from `requi=
red` weakens schema validation for existing SoCs.
- [Medium] Making `interrupts` and `interrupt-names` optional without addin=
g a schema dependency allows incomplete interrupt specifications.
--

commit 963405de649fb7157801d57b7a47cf959108ca2c
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>

dt-bindings: rtc: rzn1: interrupts are not required

This commit drops the interrupts and interrupt-names properties from the
required list in the rzn1-rtc binding. This change is made to support an
upcoming SoC where interrupts are not wired to the RTC.

> diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml =
b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> index 7ea77cd0bee15..b426a34958d6d 100644
> --- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> @@ -52,8 +52,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
> -  - interrupt-names

[Severity: Medium]
Does globally removing these properties weaken schema validation for existi=
ng
SoCs? Device trees for existing SoCs where interrupts are physically wired
could now incorrectly omit the interrupts and silently pass the schema
checker, resulting in incomplete hardware descriptions.

To accommodate the new SoC without affecting existing ones, should we
conditionally require these properties for the older compatible strings
using an allOf -> if -> then block?

[Severity: Medium]
By making these properties optional independently, could this allow
incomplete interrupt specifications? If a device tree specifies interrupts
but omits interrupt-names, schema validation will pass. However, the driver
uses platform_get_irq_byname_optional(), which will fail with -EINVAL at
runtime if names are missing, silently disabling alarm functionality.

Would it be better to include a dependencies block (e.g.,
interrupts: [ interrupt-names ]) to ensure complete descriptions when
interrupts are provided?

>    - clocks
>    - clock-names
>    - power-domains

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914211826.7372=
7-8-wsa+renesas@sang-engineering.com?part=3D3
