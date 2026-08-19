Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB244C656;
	Wed, 19 Aug 2026 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136514; cv=none; b=MC31fEZDTlaserrkfZxf6yb3khaDYqx+ZxSLpiK5ExgA6P6py5YamCu6HDGJYO8iHKDHCnaDJSmsONnWGCpwx4xx7Q3NwejDvhxNbMMDJlihjvUvLpAIDKGKrxw/UJJBv86b2Qbtc5Uy4K6BoQz3Uw0kk9Lt5Wpg63Hk45hGbhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136514; c=relaxed/simple;
	bh=ueQsDwNiemK4vVMPL6kKLLYnfglVKUX0kLMmX+6FPVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ItPiDuhGBQB1IjRLvlKKndhcPBfmeSi1nE3kfswCorgDmGwZLUZ2UcO4bsfnjUZptV1yqPa1W2wLguh5rjGb2qrJ8u6SqCIAhMSusEkC2aX/sDb1O1IJai0oPfZfHV9Pp41T2i8qmWVaUWGekbY3k+8JG1riYOKuK0Mj1WIQAnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0U9ZCGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0U9ZCGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8351F000E9;
	Wed, 19 Aug 2026 10:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136511;
	bh=ueQsDwNiemK4vVMPL6kKLLYnfglVKUX0kLMmX+6FPVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n0U9ZCGJbCRHVblpLvrUbJirxevqmm92WHEQvjmbM4fXB3XTSF3VaPjKLS9cHDs3d
	 OaCogHD70YBzn2QjLszbdwsRKppuC7ypHcwaLt2c3Dg6uf3tpnHynnsyBpHB0IkU2N
	 H6jjdfjd5R6Dis7he4Edjl8xDHluTYTeKIPMz8SnDb3sLidorlh9HT/8gUaDy05uWl
	 F8i7u8MQNjgq8D5WmR1Y0DKRNex3EF9oXLFdFQiH64j0WBWEDvHOin+bSUx5B7WLAy
	 6Sd5GLmEpuR1VVCXhOGCBpvkSNv6zazPxIjXNpDPT3kDtkn1hkhRPBXrFo6pA085ij
	 fk2k3k9x2Yeyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/15] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H
 and RZ/N2H support
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260819103926.2136712-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:48:30 +0000
Message-Id: <20260819104830.CE8351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add compatible strings for the RTC block found on the Renesas RZ/T2H
> (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>=20
> These SoCs integrate a closely related variant of the RZ/N1 RTC IP.
> Unlike RZ/N1, they do not implement the RTCA0SUBU register. This is
> not a limitation for Linux support, as these registers are not used
> when the RTC operates in "scmp" clock mode, which is required on
> RZ/T2H and RZ/N2H due to their 195.3 kHz input clock.
>=20
> The RZ/T2H RTC variant also supports a 1Hz output signal on the
> RTCAT1HZ pin, controlled by the RTCA0CTL1[RTCA01HZE] bit. This bit is
> marked as reserved in the RZ/N1 hardware manual.
>=20
> Update the binding schema to require the additional clock inputs used by
> these SoCs.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1

