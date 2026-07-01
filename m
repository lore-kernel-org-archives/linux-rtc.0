Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3825356754;
	Wed,  1 Jul 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917285; cv=none; b=MgxNUQfN8lPeEi0Nv/aaG6GnXOcrSWytcOGIwBvyW2PWfvL+EHrKbJj9gq5oS97Ufoo29jItOty8sGJUZUibXL+9u1z7Q+jZC52c2LU2ODnc9EXyubCpkgVl/ebNOGrHAqpKj6XD1XIqPCOl+y6vyeW4ib/ZBQLkut56cFZZ+wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917285; c=relaxed/simple;
	bh=4WwYd2z4bEQE70WOkbrz9dgu7c254X/3TvRPEHXPzGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hLg0cWH3lTXWYsLRRp9vtzA/QjRbhc1MoUqNj7hzfjtpKArz4sn6WFxX17mfNgbjDPYacaEnkmcAIcGV8IzbptYjYl0Vuf6HAuG/ZTBZkBsuMule7dpY572+3viSRh+FdrdJ7KjWk5T5nE54sInb6WEsP18fpSgnjKZkifGzIl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csA3G9JD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csA3G9JD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC421F000E9;
	Wed,  1 Jul 2026 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917284;
	bh=4WwYd2z4bEQE70WOkbrz9dgu7c254X/3TvRPEHXPzGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=csA3G9JDJHoRpGD9txTSXSu9Z0i4BjIVnERxrKB/Vrtf0W3PuZ1ey42zlkP377D7c
	 d79hrSn/sggQidEcc+MlPY77o/VDkfnzIzvPBE08irHdTEpbyPjyRFnIDZIJmxHtBl
	 mkCubmVHetA1Ajh2IYuxFecpiSdNxu5gsOmcDGmNEJfPAZdyY6JX2oUyZb37RTbUxT
	 aHjwzCEEG3Vkm5tPk0G3vfAXKtcx7uA/iBP961fIKRpvJYgtZ8t9iTyp60YjYIPe57
	 6ptIrouXxdrGVC7CGmxg3thMjKzC1Qh/nnqQot287uOEfCBi4KyONJrPIk+EDcRtVQ
	 AwRpEtUWAyz3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] rtc: rzn1: use FIELD_PREP/FIELD_GET and
 GENMASK for register access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260701142953.2014895-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260701142953.2014895-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260701142953.2014895-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:48:02 +0000
Message-Id: <20260701144803.DFC421F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701142953.2014=
895-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D9

