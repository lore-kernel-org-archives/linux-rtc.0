Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444922;
	b=mzdrw9i31myD1Fn0iXZ08UxrH6riuFtlD5vpgW/jhl933GQXHPBfnp82ff8eRiGyZxDm
	 WtNq8jPy27+JInKxW9pLXyICDoOmNih5gy7jgwAKRUg0L1Uf3SAftzPYYwpnRyLAVsxTC
	 q/i42JAo+BoifJ+5VcK8M7fnHZpnK+vhficCb/FGpJcO+gt14qnZH8GI5M3L5UmBUvXAy
	 Wq0F+lKpThnE18ALRe377AzalwCoBCeGSbLokeqV8AEav21qNksJeQ1rK+sehtUJ6Gm69
	 6DhO9ekPbrajWsS84b5aaLG2PhnbMB6kfwUlJ2itPtx0/I1whWNRQ1BwOD5BGAZeeUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444922;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3DF/sQUWimLvSeMj3S1wNMAE/A+qQb3iFlhFAoT1yfg=;
	b=qfQVN2ZA32WGQs8Fy7jifJ3M26yLcW/qdrm4YmA8jmaOV5XFRASaDBzx6tECpWiqZIvH
	 r+MLMsqsylOBGpNBhKwD/PrKSxxf0IJJRzGl+BxXZPh86OFvaFpRb8YK7tHDOYPidv0q5
	 lGrNXZxVgAPvy1epPZMJPuj04kSyqLhWt3H8EtpgbG6+To07mxa/aTHFAXdPZ4+ySP2lz
	 jDMdgdbYJmaH9TttR24upqBykG1tykWIOpAR98Pnj8nEftyZXCFZQW1OejBCIYZgEILAm
	 vdNqoVooV+fxAc1t9LwKjQr+UCwdxPnfa3E+l2NExqO2Qmz0n8c2vp/Og2HfJeC7J/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGATuVgD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D3606A319
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGATuVgD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589FF1F000C5;
	Mon, 19 Oct 2026 21:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444921;
	bh=3DF/sQUWimLvSeMj3S1wNMAE/A+qQb3iFlhFAoT1yfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BGATuVgDabayrpThHEVxnR9OQAhauwHD6gKTzZSerU/6Bk+/d8sqk4B33PFAC0J5B
	 XFCEr4vKzQ8/6hv3Y1EkNOkSzBiK/iHrrPmkU4UZ9UWcC6gjnOLv6jed9kh5X70GF5
	 Tq2zBDsK3+HwKiq6h0ZvjaS7xlO6+uzzxK7vMJ5nhDwggJ/H2PwPnDvAGElKxs9Tny
	 xcZfgGdh4bD04ODMZGwZT9xC21x/gm2C7UX3qgeyi9xMeLY+RBTpxyrP++JwxTWQK0
	 C0eT1UPveYwgFdGeaJv1QRknZy866B/oskdzriE0MGVVUqRch8dvGXFhPI8Mgv4DCs
	 CZNDK6osqg4sQ==
Message-ID: <sashiko-outbox-178234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/19] rtc: mcp795: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-12-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-12-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:00 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use guard() to simplify locking
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019211827.1262=
62-1-alexandre.belloni@bootlin.com?part=3D12

