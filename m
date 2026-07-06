Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE6127A107;
	Mon,  6 Jul 2026 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360638; cv=none; b=YuZSCjfHG5IYqo0WU0Tja1NYqMSMAmEXYcT1wzQFO7dkaAEsKtEhP+zaRiGoETwYrO4JHJa3w5j3H2vRz4HENfQDX5WeypbMQiLsFVrpHHJowNGJ/3H256QYfe78hmRes6f4G0rqXyegtaXxNj2BovVZ64bTuNhbSRcnyayNKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360638; c=relaxed/simple;
	bh=W2ym/VLbMXCq5mZbCOlWoQcJCaWATYEHt6aCGQhVVA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eJJoX8kNP7w3IERXY6RKX3xY74RRvpgMGFxiYnIfT/jv0VyCfgJJHXiZgOTxkSRE81iDMdWyR43EfkFG6DuPN+IXMmEAbVYkeK2dnv+oTQfxDFK8FEso/7Kstvr5Wl52U0DDQYbL5oU4zSBv2VlGODHWQLVt+1s1dP5AgoSCwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K74j5/T7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K74j5/T7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ADA1F000E9;
	Mon,  6 Jul 2026 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360637;
	bh=W2ym/VLbMXCq5mZbCOlWoQcJCaWATYEHt6aCGQhVVA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K74j5/T7HZ9gNNBc7S4onuVbqVpPjG7m46aG9Uv0Hzr47SzFAi8rpWgtI6KzuubmV
	 ZNtRsD4oSQC+sudB9iZcQMwCjd2D6RIwDp0OYFKVr1VdULkbaLAtmBMFBL8wPTlGRV
	 UFaQOcNDkmWBrKkPtHF66/gOy0kRVAVZJ1WOvQUdAawtWu+uENzuwk7lljEPRXNW5J
	 QZS+mxPHh0xOO6dQ9f+eGH70Kju2w857L9k2cUVO2U1gRRKGomqBRUakmUV/MZpz0D
	 wiS7OPr54SyjXC+KNzEyUgLFIeo4Ss7Gl+qqfleVIx63D2qtjaHkCa7kVYibsJxe7V
	 kzqHHBIUOQJpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/12] rtc: rzn1: use FIELD_PREP/FIELD_GET and
 GENMASK for register access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260706175138.12587-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 17:57:17 +0000
Message-Id: <20260706175717.69ADA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Replace open-coded shift and mask operations with the bitfield API.
>=20
> Note that the weekday field is changed from an explicit 0x0f mask to
> an 8-bit field definition, matching the hardware manual. This does not
> change behaviour, as valid weekday values cannot exceed 7.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706175138.1258=
7-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D11

