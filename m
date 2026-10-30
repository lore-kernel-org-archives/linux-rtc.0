Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358285;
	b=ir3bqC2HmlxPjGVHpQBShKpCzAFPZXQP/XYkmPAWkNVK6IYgkxmV13bBRhG5F1OH5Jq6
	 7HjUeZhkQ0hjmyEPT4UBPE1coUvv2232h+59EwMwC67KV2YjK5uNfQWBW4YYgHTFifsBZ
	 mSpaAmzyNJpi1TP3PC6ReYA7QpMU8XSxEeOM73KD93yBXjosIdu8HYHV4TuOojwsgbWB5
	 wnPohQqjLyUrodZ3EROF3LyoSCqV4dmh6ml08syuUokUihoSXbQjLiCFkOZNWv/9PyKI1
	 Omm0wl2y+X2wpKL0WSbYIxJWKscrlutIOPzmY0LVIDWKmGnsMnDlqczv0W7Hp+4bCEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358285;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xjSM/Q7AU/9T76q4kLo/OfOvCDeXF10H2dfyxwXH/kg=;
	b=V67J75WxsKHcizFZseViLZlRwHh1CqhYJ3797G47zXEBNKixKQtSdRV9gIDQDNjyjjYY
	 XjzWtdRO0NsQlmaZ7ZAWHMbw0QqCyNxkJHfNjRgUjJXSqPwvmYAuF6HVV+c8kMNmd4i1n
	 bnBG8D+GwnCNeNG30gRYqjnfDk8ydW1IZ4fX2qSlN3K2g4nk0WNx6rRTxrHlbtio9zUqt
	 T6Ag6gZ6cK+cAkmFtcsnydsXh9K1daHuc2UFNdiABVhzQs7HB3AD/Mwez0Xxj30qtcBk3
	 Pp1hcZVFnVHxuxLe3Tlm/8ztxwGoRd4IkgwfgcbFFwMQVd/6ed/1Detqpl8lPALGanA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V/kARnTY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376A5606A31A;
	Fri, 30 Oct 2026 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V/kARnTY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E20A1F000C1;
	Fri, 30 Oct 2026 11:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793358284;
	bh=xjSM/Q7AU/9T76q4kLo/OfOvCDeXF10H2dfyxwXH/kg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V/kARnTYAXeFdw3YVHgGBY1OM4gG4R4I0PCy32uycbngbJEppxvawiOj5IOfRjazE
	 F9x36Q0JRRVMboz+N+QPrdhdyQnwoFnBusM/9v+jKnkkiX1IRgoKl0Jse6uNAdX/F/
	 Sa35ZNXU2Kl0Cc5jEl6K6/jGrG8ixbA7JekvTscyFeFuvBXljyxT+bahiKmfPGR6Bp
	 HP7Mf/V+xsqeuTinTNwRP5mPKg9cduGeq0b08RgL8j49c5xtv9z5ALT/VoRXkW+ld8
	 CnE/UieWoSofab2xk14EAQZqKSbUIFPGxwl1uQe0PQQbt8zAwjp0LyavyuNEf4YR3s
	 7owC+dcU/4oRg==
Message-ID: <sashiko-outbox-190915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: rtc: Add NXP PCF8525 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>, linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261030110139.1929109-2-shivprakash.gupta@nxp.com>
References: <20261030110139.1929109-1-shivprakash.gupta@nxp.com>
 <20261030110139.1929109-2-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 11:04:44 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Add a Devicetree binding for the NXP PCF8525 I2C RTC. Describe the
> optional INTA interrupt used for RTC alarm and timestamp events, and
> the INTB interrupt used by the watchdog.
>=20
> Add properties to select the external crystal load capacitance and
> temperature-compensation crystal model. Also allow the common
> start-year, wakeup-source and reset-source properties, with
> reset-source enabling watchdog registration
>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030110139.1929=
109-1-shivprakash.gupta@nxp.com?part=3D1

