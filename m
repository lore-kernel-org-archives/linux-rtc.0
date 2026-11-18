Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990559;
	b=BJorwTULXJACkpqm9WvizTErMfZVhSshPH9YVQJurkSsgQ9oop2EPGFZjefFVGJAIssz
	 Ff+DaH4W0SbdY3b18Iayq1nTsLr+tjUS4KkLD4RX4y1eIu6Q0s4dYYbaxNnzgffDXjdiL
	 CfmDrBO62zhFbFTfSLJxmewqLigyI4bcmHLfGZshGuztekvlhswEZW8yIyhgkFcyDDcHt
	 7Hesk0FhNKrDSvHBqAYsGqrHTYe2AETiyf0/NCYdBOkw5DQk6+sDWAOpBpaghfO+1iF7n
	 PEvrnCjNjnSyknAj0WPX+ipJgvaJHB/yH1wpp4+2ssFK2U9hVuswoEpmJnvto8gXJZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990559;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ciJVtNtxH38Q6pvHD/O0H+Vukg8SUBGOxlIE4tg40bY=;
	b=hJyCQd2SgohaolQvBbkDGK9Ieh19jZfQw1Zna9OZGF6PwTxAO8ZPPylUNAe/DghlxY/h
	 bVqDHJ6wCtSXVM8Lw9wYy2QFFVTIzzvwmc9GA1hgwa5E032X/ElXJt+w5om5XNSX5qYVm
	 +KsHpZ3iv7T9VDUjTlP2n8NtWH3OcsUXcooNM2W0S3GJ0avdoEioLpwfpAE79zCUNzXGN
	 otR2Te/pbhvQfZ1bka+KbcR216CUkfaZ70joj5eW9CvM5THFgBay8WBESeEVV1B9S+xPf
	 U2tM8Y26RdaHgcAK8dYR9kOqVBC4WUBp5FCOePa9j24WFWYCV6wbK+IhNvwS+dEe8nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BVy3Sj/3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5AA606A31C;
	Wed, 18 Nov 2026 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVy3Sj/3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F344C1F000C4;
	Wed, 18 Nov 2026 08:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794990559;
	bh=ciJVtNtxH38Q6pvHD/O0H+Vukg8SUBGOxlIE4tg40bY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BVy3Sj/3m5ysri3bOmwYY5fZxofJylPfcQwHPSala1xmIJVAZvp27bQ3aXJ5dkbUi
	 V/79GOO+2/l9xfIDmLfCnBnV2iEPl87WQztmTwkEFF4Q/TNBuafVvsJT4bzxkcQYSb
	 fLwqtcUfJ5IbkgXcg4nr6lEBr4XeHrygkZIjx3tJ5OWLMSb3u/5b2HW/m84bDxsN9J
	 SgV13fW4pBkPLzkaEHYrY0D4+FHA4nKLRA79mvmo4mA/AEPCGYs8W9afezRtENjul0
	 Kxhc5Yi7NSX/M/inDq2isq2r2/glzcOiBu/zwUSXiR5+f8ySykQr454IKP+9mcUT2I
	 D/QwnGj/0YRrQ==
Message-ID: <sashiko-outbox-220449@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: haoyu,hym8563: document vcc-supply
Reply-To: sashiko-reviews@lists.linux.dev
To: pjh456 <147148383@qq.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <tencent_B11DE1495C3C54CE186ED508E2CE5CE41106@qq.com>
References: <tencent_B11DE1495C3C54CE186ED508E2CE5CE41106@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:29:18 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] dt-bindings: rtc: haoyu,hym8563: VDD supply documented as
  vcc-supply
--

commit b43da37686bbff8c05e2939d152dd97bed1884f1
Author: pjh456 <147148383@qq.com>

dt-bindings: rtc: haoyu,hym8563: document vcc-supply

This commit adds a vcc-supply property to the Haoyu HYM8563 RTC Device
Tree binding schema to describe its optional VDD supply.

> diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml b/D=
ocumentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> index 0b9f39ef0edc3..b27b250d3c2e3 100644
> --- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> +++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> @@ -29,6 +29,9 @@ properties:
>    wakeup-source:
>      description: Enables wake up of host system on alarm.
> =20
> +  vcc-supply:
> +    description: Main power supply (VDD).
> +

[Severity: Medium]
Should this property be named vdd-supply instead of vcc-supply?

Both the description and the HYM8563 datasheet identify the IC supply pin
as VDD, and neither hym8563_probe() in drivers/rtc/rtc-hym8563.c nor any
in-tree haoyu,hym8563 Device Tree node currently uses vcc-supply.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_B11DE1495C3=
C54CE186ED508E2CE5CE41106@qq.com?part=3D1
