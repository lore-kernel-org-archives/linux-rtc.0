Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987956;
	b=kv5/cD8v2lSnLj+ETQKP6oVR3/tA1HKBSmNUhKOLn09lBXKO5p+TsKyFt9GoZHVEuke7
	 O52xc/uLttGFWB56gi1bUyl5niOGdno1uT8xpci97oFfLY4NU4YWaNT5gr5jOMPSrKhNL
	 eeusf1nO0Q/etOcDuV3gNHTTsJ3QIsg9yzsKCefA9zm7gWsZJyFsgnSl8rTT4ymJ7kAtk
	 SIx5ncna7jvLVS5P3k4MEp19GkXhPmkUqDEUZHh9zsPESREOSrtPOBo/R+jksUm5mQuYo
	 HUXPtyU+g4H0cXtSyY0akXYllMpfGRKldf+EhFoxivtc61wxxeALbBC/36uqiHcEZ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987956;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cd7mjccadecZDAnzqAg24bM7kMt/9WPtDi3UwX92vd0=;
	b=jjGBhzycreOwe4kOY0LWXwniKysmGxwJcwb02ytXMxkUtbUetMrO1Tb0dfFEG79S7sG3
	 ecA2jlyvx4IAl215jAmqYdmie7Wea6D1cKROE59IL7FDDb/SIl/KXAA8Gz/dfy+uBgAl9
	 ybQjnIrkKtvkY4/Bkn9QP997mEMlB2me6MSirCQRmG8IBP38Nz5A3ygidH7ICMTStBeN4
	 /PMKz6A9bMHiUC9YtPidfsjX6SOiP0v7TGjB95RCJ7zCfyyDStkH6M0InYiVM7+Qv4cwl
	 u85z6Xl2Yvs++62yfzKuHoGCfeH0Pv0KHSIj1PQHh2dXWR0dVkIHWQMLyVNvR1WhG5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUHzS268;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77D606A329
	for <linux-rtc@vger.kernel.org>; Fri,  6 Nov 2026 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUHzS268
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C771F0089F;
	Fri,  6 Nov 2026 17:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987955;
	bh=Cd7mjccadecZDAnzqAg24bM7kMt/9WPtDi3UwX92vd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QUHzS268crxBKK3xBbGLX2GZUJovT3NP92CDfA1qakjE1W1Nc+0BI4lH9ueYIHKAP
	 vqDT4KkCRdWedV6tnFlCSh9AAzsAC/wNbh5ZDl526msR+jiED4R8IiE4G5BwU2jOUb
	 1S/yVRLXPEUEFN/lPFZaOImoDERD3Fdhnc/XFyCsbmgIrmQWD+rqRvbf1tsTVeuqOw
	 XmtbG6gNchxQLpDW6B+1nWfj6VRsFurxaU0AzxI46mwCqJXyHv9qrQE3Nlcvt/+XGC
	 GyH/a53SalI81Me/nBi7qawCrnegvt26yhk/hKiCz2+FREtkwwn9LK27Z0EqqUTxsi
	 Dpo3U0r5bIdTg==
Message-ID: <sashiko-outbox-201982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] riscv: dts: starfive: jh7110: Add the RTC node
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?T3dlbiBPJ0hlaGly?= <oo.hehir@gmail.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261106175600.3877614-4-oo.hehir@gmail.com>
References: <20261106175600.3877614-1-oo.hehir@gmail.com>
 <20261106175600.3877614-4-oo.hehir@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:59:15 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Tested on a VisionFive 2 v1.3B.
>=20
> Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106175600.3877=
614-1-oo.hehir@gmail.com?part=3D3

