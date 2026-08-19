Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12AA13DBBD;
	Wed, 19 Aug 2026 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136751; cv=none; b=V5m+B1E0r422HLUAUEmqagbcgu3MTmAsny2MMd4hVjL72DnaWh5zOUGkxhtMyDvSe9G4SxkeMc1QzrnlxUD6YZMgfiprxizoS6fjWhl2v/FVqMfrHE+rTEu4D4lv5Ocwbe78A6KElHuLuo3OWLjgY/UnCJXWyuoVdObQJzaA0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136751; c=relaxed/simple;
	bh=Yr8yU1RlXwj6E/qNzmWa2J3fx10+3HavDtmjm+6UNXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PzV3UwgfJKJ5Qa27IebatWljwjVwfJ3Gm+4cqpsgBiJMzTiKGAR0Jtr4nPeCsh4K05VlSfPcd2Qc+K6XJ/uZmzU6Wx8LQ4TjyZRA5Z1GYIzZd7+zI14TTpxJLN5GzjjVow5y1+czUj7M8hsE6fBZKBECihO9PmFPVJJ4lXrJqYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddy10HDl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddy10HDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F1A1F000E9;
	Wed, 19 Aug 2026 10:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136750;
	bh=Yr8yU1RlXwj6E/qNzmWa2J3fx10+3HavDtmjm+6UNXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ddy10HDlcRQrSXqSZ4JiupZQpq2Lofj1+yrLPAUHqLXNi57gQOzjLYffoKVSZM9IM
	 x5bqAlKKuoKwMH2jKMj03AehmNAllOG5vPlpffwWNXb2bzygcqnFRfG2Yh8FBcc7LG
	 oTAoGoZR9g6MUjbMV1B67heHY4/pYM1Jdyd9CpZ4/7aQR4dawQLPDHJuWjd4IXRy5m
	 rIhrcy+gzgXhnp/A4l2Ir8dIyBsaRH+Ary6Ch/i6wprfOpDjWRJH1IhSIakhqMpGqI
	 W7HJMvclceHR469g0yEtp1+kN2FYQSKX8j2D8npen9zLiSgQwqmNfA6KsKKFZf73/9
	 7j+c30qkMw+jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/15] rtc: rzn1: Add support for Renesas RZ/T2H and
 RZ/N2H SoCs
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260819103926.2136712-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:52:30 +0000
Message-Id: <20260819105230.59F1A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add support for the RTC block found on the Renesas RZ/T2H (R9A09G077)
> and RZ/N2H (R9A09G087) SoCs.
>=20
> These SoCs integrate a closely related variant of the RZ/N1 RTC IP, but
> do not implement the RTCA0SUBU register. Use variant-specific match data
> to disable SUBU support for these SoCs.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D15

