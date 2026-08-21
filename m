Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127984BC02B;
	Fri, 21 Aug 2026 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321371; cv=none; b=IHHRxfep2x6E6QrnteCH8jxl9pWqsLTd4tNTuN7GGMD4znMUeC2qpZntM0lxdqr5qSDrGQlnOUc21/dZ1ZpnWuizW69bZDCK4VacJqGnChXlGSj3s0zptNvCE1vUZhN8vOMf1DWE8WHs/t/IcmwzaOeBVRBUln0hkPvwlx4eW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321371; c=relaxed/simple;
	bh=fFD8uBQW6EJctRsPoct7wsER2SlV8jwVW2efJJLFyvg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQWJkw1jxa79kumcLJA5uHi2JZYYe8mKNm9g7qxec/caEgS6oD0obUOpcGA15HU0bvLc2Wxo5p1TgPGP/cDmVdTJa1GLTGptqpkVGvSNbTbwPEj++zHa6qNiItQcUelbASpmAN5DT9K6pCJY/zwVQlOZMTyXKKiGJE+qss4ejhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9kD6iF4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9kD6iF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951E81F000E9;
	Fri, 21 Aug 2026 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321370;
	bh=fFD8uBQW6EJctRsPoct7wsER2SlV8jwVW2efJJLFyvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I9kD6iF4aEFUmHb17Wxelx4sKVZ17/WFvnv05m6BIruRUFC//suzTx1Zl75MhRp7W
	 HAAfs3tBlNo1SdpcpqtOwyA0FFSPAkpYmoz6OkyTggI48vseiGucs+dYgEO59fMsCF
	 GOXv9IsU214xHSiH1tWGYfwsLsZvy52IRwVRkFAeMjcqMMG0Jpa6kMk5UNd/gwInlV
	 2qAwAWbzkX/Xr6JoEVTqKo4fQR1biLtpySRi2vI+LL/84MaL6zAa8Ih8q9vzCGiWSx
	 4J6wLYELQZ6FoymQFPVaioSYj3EggOz/HEMTpXNvnp5CS5sjLjUaaEo6s0vAhz4A2Z
	 e05veLToeJJMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/17] rtc: rzn1: Add support for Renesas RZ/T2H and
 RZ/N2H SoCs
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, wsa+renesas@sang-engineering.com, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260821135608.275233-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:09:29 +0000
Message-Id: <20260821140929.951E81F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D17

