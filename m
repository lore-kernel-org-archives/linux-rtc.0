Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0156C579822;
	Wed, 23 Sep 2026 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195349; cv=none; b=Wj0/mfb69l/40Je8TmVh5gAoD6HUGzbsdK7cMNDrGheNLZadxBDTv1s4cPYqPSRsOJkjKxii7+1wbI3xNXvVGg5FRYThztMSThRhXseGfcTFBfR9uyvLf4d8IBe1hoQf52ybjMi3jWcXRTKOaHE5+DUVD3ZSv5FNvIqMZmbhgIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195349; c=relaxed/simple;
	bh=aNms1UO9qu+24WXImZlDmhMF3+xEojLyVGW8hUnBInw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gk1DQkgLM+qmmWBIbjsqSXtAB8lc+EwyzKqorjYQCItp8eGZsSeCcpBHh0hfX5NzCUoHlfAJBU+H3xOser+suZFGvPRC2IbSwla8GxVeZ6eo7Whud9fTPvokaMSnyKPzl5Aa17H84Q9YyIaInB9wf4rPj3o7zfoXMtkWBiWruq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7vWF3Uw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7vWF3Uw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF911F00893;
	Wed, 23 Sep 2026 20:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790195334;
	bh=TjMxjX8Yyu6QN0Rlp5EVyC3hwKuo5nklZTlBNRlVAu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7vWF3UwTihB6jFv4vxAGSh7AMgy/LkbTCXhcHr3f4M0/M9WzmmPMLCyI1f21mNAf
	 AD2bxxG+dgMixK6XK8UrM03+LcIaDhptXlPEhEqXAJYDiMDxJx8HilKDw+6iBu4Cpt
	 i2i6MQX+5oz1BA+W1KQZCDEyIrE5wxLCxT4oFuS1jVBWCRgI0sv4PKfc5mvU3ubwk0
	 cUaQL0y8A7YQ/7hnNs/fOpk52dftaPqxTFeRG8+RLB6QjTk91ZL0fCAuE+/xISp1U9
	 o9VjIRj4rNHQYn3eIMN0pCLgORemp+aMLRmyl0RdZPS44UauZREcEBHpr/y4+G3k5Q
	 Jewn4eRzTeFiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/11] dt-bindings: rtc: sun6i-a31: add Allwinner
 B288
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pablo Mazzini" <pmazzini@gmail.com>
Cc: linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org
In-Reply-To: <20260923201701.43391-5-pmazzini@gmail.com>
References: <20260923201701.43391-1-pmazzini@gmail.com>
 <20260923201701.43391-5-pmazzini@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:28:54 +0000
Message-Id: <20260923202854.7CF911F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: missing clock-output-names schema constraint for b288
--

commit d061a16a5e55b66a00315843c7f4655412cd0e5f
Author: Pablo Mazzini <pmazzini@gmail.com>

dt-bindings: rtc: sun6i-a31: add Allwinner B288

The B288 RTC wires one alarm interrupt, not two.

> diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rt=
c.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> index f2b91186ed377..1699e3576b915 100644
> --- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> @@ -19,6 +19,7 @@ properties:
>        - enum:
>            - allwinner,sun6i-a31-rtc
>            - allwinner,sun8i-a23-rtc
> +          - allwinner,sun8i-b288-rtc
>            - allwinner,sun8i-h3-rtc
>            - allwinner,sun8i-r40-rtc
>            - allwinner,sun8i-v3-rtc

[ ... ]

> @@ -162,6 +163,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - allwinner,sun8i-b288-rtc
>                - allwinner,sun8i-r40-rtc
>                - allwinner,sun50i-h616-rtc
>                - allwinner,sun50i-r329-rtc

[Severity: Low]
Does this new b288 compatible string also need to be added to one of the
clock-output-names conditional blocks?

It is added here for the interrupts constraint, but omitted from the if
blocks managing clock-output-names. Without an explicit block for the b288,
invalid device trees specifying the wrong number of clocks might silently
pass validation due to the generic top-level fallback limits.

For example, other variants in this file are explicitly constrained:

allOf:
  - if:
      properties:
        compatible:
          contains:
            enum:
              - allwinner,sun8i-a23-rtc
              - allwinner,sun8i-r40-rtc
              - allwinner,sun8i-v3-rtc
    then:
      properties:
        clock-output-names:
          minItems: 2
          maxItems: 2

Should a similar constraint (or false) be applied for the b288 variant?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923201701.4339=
1-1-pmazzini@gmail.com?part=3D5
