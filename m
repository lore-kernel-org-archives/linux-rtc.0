Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EB7347BA9;
	Fri, 21 Aug 2026 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347202; cv=none; b=qU/h63frMUexv5uSzlinf0Ay4h4tVA4AcVzS54AKqKaxJcjrw0ffNhayBuyewG/W4McptSGgQgNeAz5ICMOGhMhXzrFVumUxdiywZYAZxjsb1HnXSTnGRcWp6xGr1pfY9Ag9SWzNT3tLzlzaOHHZ+Kgkd2jyYy7uQ/2/NCJy0as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347202; c=relaxed/simple;
	bh=TUAQshgRImRKDalFCXBksF+ty6Mg6P+jw4GDEObMN9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jNCC6xMwVe5+RZ7yCvJMYJIOhLGfPOp0xx6vlD6/pDjafAfyMZS62z639fRyeTxGoQrRBhi4w0lcZFKpLcf9ci50hbC6fKvgdLAPj4tRrShS0t9pvSvuAWV2vyW07CEP7dg1UacTltZM/EbO77sI0EZ9Z5nMePBpa5kqy4JjJS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+D/fcoM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+D/fcoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0702C1F000E9;
	Fri, 21 Aug 2026 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347201;
	bh=TUAQshgRImRKDalFCXBksF+ty6Mg6P+jw4GDEObMN9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E+D/fcoMFAKbB4b9lobjt60UtibGNyO2SSLdLzZlr0psPq7yv7RwUZSts/+Sq2st+
	 Z9q9CEbtHpsiPZmZKTq3mejb7hxCpLLdA6dUwWMIOTPPXPn58DbW3V2Pf2WDZpluz2
	 IQ5s5NnmPVRi8sv8GnWScgrTcS5sEAQpXZzG+cZM6oVDWadtq7p29PS/DieNEBihCs
	 BgqtbYyqtGeMRSCJFgLJ4ISPrE3hW2+if6CDZnVF8Y30WbBIq2nQWoQuY2YIbKxa1Z
	 pvlA7UGU6DKj8Foxb+8WEspB8jmAnd/PJn1lmW48ctIqmtP4vmw05zmYSu9cbpf17E
	 f06cylSOm9Xgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/17] rtc: rzn1: use FIELD_PREP/FIELD_GET and
 GENMASK for register access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, wsa+renesas@sang-engineering.com, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260821211032.13554-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:20:00 +0000
Message-Id: <20260821212001.0702C1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D14

