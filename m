Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A44AF665;
	Wed, 16 Sep 2026 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554709; cv=none; b=EKzw0OUELjaudzPKBthZY4/SULS6h7/8Fjs7jW79kR8xhhevn7Y8153Lxc0ucoQl+puQ/KpoQtHrJGWy5ngtdSmp4HKT9snF31zT9Udbw/wklnb7A/8cL+VXtdhF9s94r4v1CeDkZIfPyfeDieuTMJoQmxNMlo/6EpxFLGEIhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554709; c=relaxed/simple;
	bh=7KkWN9W/l4UwJbzoM/UjyhZjI1eFnBiDYRiNLiphr0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XSYZSgiGMNsHPP7fkHKppoHbZG6Y4wFLFaxnfWAbez0zkxPwTV7yUwXfOSnvFBOfZCp+nVk7QuhpvbAm8nMZmov6RXLKmMzLrAcP7rL6oA3TH4vUhHmSSlBIt/3bXGclWT20CfxYqMfTj4EEVJhfUYhygTlNim+X51/fdHeWzGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db2BPi5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db2BPi5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1331F00893;
	Wed, 16 Sep 2026 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789554689;
	bh=7KkWN9W/l4UwJbzoM/UjyhZjI1eFnBiDYRiNLiphr0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=db2BPi5tJ+vfYJrsJ9ooSBRd6Q2SV/s2S1O8JOC3OsOomMjAVwJLOCRfVsH4zB/TL
	 BALQ6BtarPWcO+T1Urn9VAgPyhRdYlXPAo9vo8XfzSpakLDv5qFIWMIp2ezeuCyZ9O
	 GwL+xScVvHJgzL4H2p2aGaEsMP2s5z14WbiMmzbeLoQ7B8e4A+u2pCvIiC4bkO2WBv
	 GFXaFYv3VJ5GoWEv0mhNwfR/poOO9XBKiuS+pQ/iTBPKlOJNUyslk7a1aNE9Esv2GB
	 lZahehuVd3SVYF3VRQgI3DNL+DvNcU1bF5Ptc/YsKORBetZZPlTdk5E0T44KscqFdd
	 KNAJFxCR0cvGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: rtc: rzn1: add R-Car Gen5 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260916102520.24288-4-wsa+renesas@sang-engineering.com>
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com>
 <20260916102520.24288-4-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 10:31:28 +0000
Message-Id: <20260916103129.3A1331F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> In general, the RTC on R-Car Gen5 is identical to RZ/T2H. X5H is an
> exception, though, because interrupts are not wired. X5H2 will have them
> wired again.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916102520.2428=
8-1-wsa+renesas@sang-engineering.com?part=3D3

