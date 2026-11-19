Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072150;
	b=a0GmneSeczM4BvJ2udwQNWAan+up1HyVoTSnJHm9WTCrKb56PA/HK3uoGBQoXomKAJtV
	 7MuMa3uPiSK+JQ3m2GTMFBGJm/ZxHgX2vw6jC7fvaRTtbZgZDgvzuo2aDraxnyb1ZFeeM
	 2Oaixcs21EUAFvvib/8Y8BbTZAPKDibZ/7gzAtX54FcNtpTVJMvT2SiqRwobVRXeBHMPE
	 nslWEfCeXg9gEeZjOqSXHKFkFe7FCO9CDRKUaN2UPHh8s3SU1N6/m+Vt1/vhY76uilap/
	 mVSljhileSWvxguG87ARvKk2sbbI3jPe7KPJKSEVQEgQy/8MvfW4fpbodUIlSpfcQmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072150;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MfkzoFWgfUqsd10FETPWwPPhqjMC35AhfPWVPrdiufE=;
	b=sITSJudD7usHCuwKNBH7urLFwtKN84HNl2s1CybkopqAOHkN67N69uQyu2Nlsb/Oo5kM
	 5qoqLPZ1V2dBwF4z3CIlJMaHXJjAyuQhxxrq3RfpstNzc3XYz6EgUQTEiJ5PNt8YTx0Lw
	 RB7oW6aEJG2dnVt/blCedVFtM7zsxP3xaKTKvCjqdoMmYDRrNJtBIXEKWzuBYgcaRMyQv
	 xhtoc0ZDxRskbzJgMsL6y3v1EegBvHc9B4Zys7OldnuNjYImGCqxAFgiFOJn9d7kFSTii
	 GGynLXOJ1Qv/4IRV1+n60H6j71YbOI9i6/5pilJlO4jJjB7TmnGlxDkGEKorEieYG+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuuQeAPi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BAF606A33F
	for <linux-rtc@vger.kernel.org>; Thu, 19 Nov 2026 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuuQeAPi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6558D1F000C4;
	Thu, 19 Nov 2026 07:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795072149;
	bh=MfkzoFWgfUqsd10FETPWwPPhqjMC35AhfPWVPrdiufE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZuuQeAPiuFQ7+YtvQ9EUVhwakjwAZgzMdE9iiuzSXabG3mpLjcBxT4/lxCadqx1gf
	 +Qe0qP1sTZ0QNz770e2cvY6ir5M5+K7Hdvj0Txp3iOJ0aGLVGtjdGhqZ1dVbff1R+i
	 kMI184t9E2jJ7ofqEAjppuL4Gi/EuoMHuzvoEvMSBorQQYyqhDfObAoknlwv8L3dtU
	 4nu+BSBQtBAriqUSbWWGqZCjfaAvHuEJpfi96MgvWo5YsEaxtbPZH5w1DOmHB4+brW
	 zxc1OYPbxghQRI1QvEcZCbjZh4VmEkzuW88lpsYtEF1NJRwSX6f973Hl5O8FHvF8Kj
	 AKPo0UwW9Qw+A==
Message-ID: <sashiko-outbox-222542@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] soc: qcom: Add pmic-gio GIO framework driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261118-gio-framework-rtc-driver-2026-10-12-v3-1-52d78a8f43ee@oss.qualcomm.com>
References: <20261118-gio-framework-rtc-driver-2026-10-12-v3-0-52d78a8f43ee@oss.qualcomm.com>
 <20261118-gio-framework-rtc-driver-2026-10-12-v3-1-52d78a8f43ee@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 07:09:08 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Qualcomm SoCCP battery-management firmware on Glymur platform
> introduces a new interface which is called General I/O (GIO).
> It exposes functions through fixed-size register blocks grouped
> into virtual peripherals such as core, battery, USB-C, service,
> settings, debug, and OEM, etc. The data blocks must be accessed
> using block-aligned transactions. It also generates alert
> notifications which could be identified by a pair of peripheral
> and alert ID.
>=20
> Add a transport-agnostic PMIC GIO framework that validates register
> accesses against the common GIO register definitions, and exposes the
> firmware register space through regmap using transport-provided read
> and write operations. The framework tracks transport availability
> and notify consumers when its state changes, and route alerts through
> a virtual IRQ domain while retaining their payload data. It also
> provides a group of managed helpers for registering GIO transports,
> state notifiers, IRQ mappings, and auxiliary consumer devices required
> by the transport and the consumer drivers.
>=20
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-gio-framew=
ork-rtc-driver-2026-10-12-v3-0-52d78a8f43ee@oss.qualcomm.com?part=3D1

