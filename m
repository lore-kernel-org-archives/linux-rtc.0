Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485803;
	b=h7YvU9J+jzOwm33eBpvL/OA9hyu9dBNnXlgUs9B9/uS4XpPvmuUcOR4UCu4/6hS7mzhD
	 Ay4yPZodhZfTnqOwmfazBR4C1a9hkCYgldc3M3XGI9ZxSDbu2Xkx+R8DMXLluHexXFzBw
	 3dJm+qZDtphm9a3JfKccdbWep7KXR1TBKWV0U+wLhxTkOgG/bVNYo+5SqM1TShgPC+m3B
	 L/2tDuUW2vfwQtEDh73Wky+0WdUwePnu0CV45lq3SoJw26K3rHeRDzHhVq5GDKsYhVwDV
	 suzVfLnYHBTa1atvxmh2p3h+eDzNoS2XXx+fZjqGp14YmLj/UDf7I0M/eNw2abE9cYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485803;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=47wXI6X/DFX8mIjju6bsEKi53u6LPQxpY0EUKLjF04s=;
	b=QK1xq0v2wok6Rs4I+qSs6j4BuPHmyKk/rp7YG2cJBz4iv9p3bLIdDxT6X7jmwQ5HrPgA
	 lpPT9BHEmvJOZUyWs3VSjQEXmWyS6F5J3gRysyBHD8rhW9JKPYbWE7UQMso7sW1hFzHB/
	 KL2Tze34YnHCLsKd61IinmEF7c3H8FqreKAMv6PsU3G/3a3L7HNBq1ebMLgjk31XimfPL
	 GDG5DIe7MExumZXbn0dg6/kdOnrMr3RMUJVSjqT3y+k91RoN9Pkh3g5Hx790TG540/GN/
	 fBR32mO7UObU8chc6Sb9huYwT3VfUfedqq4ElO3U0BsA/En09HV+lmzapZINcfcP0Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCOQ6RqM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD2606A322
	for <linux-rtc@vger.kernel.org>; Tue, 20 Oct 2026 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCOQ6RqM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A4F1F000C5;
	Tue, 20 Oct 2026 08:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485802;
	bh=47wXI6X/DFX8mIjju6bsEKi53u6LPQxpY0EUKLjF04s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XCOQ6RqMDl560rAddw0C5yYqh/8xSwxCdY7s5OUEFP3s++zp1TcU5RX9rFSStRo9H
	 13vaKHOahmOzobyNpV8X00wqGaFM95TcpRCGNGOT0B79LIufEiqlS4d/eNoiML/C5w
	 drU2vqeOVIOwGgY2s+9oi2Hjkx9Zuk6kL72DiIUcpOi1GQQGZtKeSXgvB90wvpzvxj
	 l3xPtxDoWfF1EhnKKV6I+oO3UYEO3+TDENxDXFofzAo6shvOiHqQOPdSmHlM0Jh0qc
	 XsMb/SzQAt3EQx6k7rrl80Q2O6LAGlWeb4s6ejaPJ9fGlDJWFFcVYLkypGFOIUlt/l
	 Ac6m/P+GwHTgQ==
Message-ID: <sashiko-outbox-178602@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: class: Make the time32 hctosys limit configurable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261020080026.2461578-1-arnd@kernel.org>
References: <20261020080026.2461578-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:43:21 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Karl Mehltretter <kmehltretter@gmail.com>
>=20
> The RTC_HCTOSYS feature faces an impossible dilemma on 32-bit systems:
>=20
>  a) systemd requires RTC_HCTOSYS=3Dy with the correct timestamp
>     for its intended operation
>=20
>  b) broken RTC hardware can produce random future timestamps
>     beyond 2038 at boot time
>=20
>  c) time32 userspace immediately hangs if the time is set to a
>     date beyond 2038 and requires timestamps to be clamped
>=20
>  d) time64 userspace is intended to survive the actual 2038
>     date and requires timestamps to not be clamped
> [ ... ]
> Fixes: b3a5ac42ab18 ("rtc: hctosys: Ensure system time doesn't overflow t=
ime_t")
> Link: https://lore.kernel.org/all/20220908115337.1604277-1-arnd@kernel.or=
g/
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020080026.2461=
578-1-arnd@kernel.org?part=3D1

