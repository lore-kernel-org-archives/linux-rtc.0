Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987983;
	b=xzptdTRKFacj7eq9c8wI6UG6ueLF2SSAM2oMbJN4U7GM0qSyBnFihWdcWpMg0+IqBasJ
	 S37DT/agx9nOX015tEGmT0YeugB1M900C9mjVm257GH+fa1MdU0E1Lf8nekeucnLMK/Ok
	 UwTQcIiK40pWatbJxkg60hi879gnMYb6JS56pR2Crn9oA4ctg3aabGQTt3aGtjFm4a4zb
	 ilaOoqzC3hHVql7U5lVRxzujwQrLz5kikcDUhyZ7FG50pG2cSDMKM4wNEcv7nBiq6jMnP
	 3Flfc1kxW9k38+wdOKZjOOAX1eKREUZPeJIogbtAVujY1F/eUYHm1s6MeEkwb27JDnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987983;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s7j9BA73rZju55UqgM8dYAemLuLS0EgnQBs/l/xGbhE=;
	b=m/G8oAdbAMAKKV3OGHxc5NVB6QI1FnDtAh1Wde/Pgi+3t/I8nmQYfgZRHjO/p+HKk7YN
	 6KVN+TS33hSA+wUhJXt5b6GouICNKz/vaACs6io2xKJWkeaXm/GhERpBGOI2X58ebt0/5
	 kv46needtTa+3wIJ5pOuAbGX50oKwiCmKU12vIi6MR4Sm0bIZTUggHW1YGl3Wq1gTkfZT
	 h//Q6l99DeP5xd2V0mnRcUPNugS2aiazewBefIaRXN3y9mWjIhM41oywQdAVzJpv65fcR
	 B/eDB8I9XVK1V0d9VUbfEifYs1DEjZrvRpfPhrJ1B28SQsRVYUMcxUcZ3D0EW0c8kxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NG8i/i0p";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B1B606A326
	for <linux-rtc@vger.kernel.org>; Fri,  6 Nov 2026 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NG8i/i0p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D243D1F0089F;
	Fri,  6 Nov 2026 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987983;
	bh=s7j9BA73rZju55UqgM8dYAemLuLS0EgnQBs/l/xGbhE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NG8i/i0pnhEU54luyqR7kRtTpWaywGhgePl8GVL7PnvyP9p5eXI/hRVNGerocQ5qG
	 izeveQdDRgm2498NZntvP9OyA2NokLkn0dx6RgrxUCSdxJwE/QZkIj4luEh8VwR7HI
	 OEzy3IHfst5Z4VxFxO1n0B0NWtqko7JQhOxjIFR4aVNAFG7/p46vUh+VRV6rPyVVXZ
	 SvJvm/CGlBizLaUgcsYZJj9cjQPhhL2TMwCavh60ueX4fFXmojrlKTy3WyqmYOG9bR
	 UNWoKFK4Oi3+W+zOB2cmCDua848WKfqukI1UNKkkWlZU4wIz0tLetwUCaLlUPlCwAG
	 D6Ida2AHbxzSg==
Message-ID: <sashiko-outbox-201983@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: rtc: Add StarFive JH7110 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?T3dlbiBPJ0hlaGly?= <oo.hehir@gmail.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261106175600.3877614-2-oo.hehir@gmail.com>
References: <20261106175600.3877614-1-oo.hehir@gmail.com>
 <20261106175600.3877614-2-oo.hehir@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:59:42 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Describe the RTC in the always-on domain of the StarFive JH7110 SoC.
>=20
> Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106175600.3877=
614-1-oo.hehir@gmail.com?part=3D1

