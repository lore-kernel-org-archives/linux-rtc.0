Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609560;
	b=Q+civ33y0eBUk+4tiu1Rw4+EZNaie8MpyYECifll3VkaJCBKotqF8v57wSlAp2nUGT3U
	 bRFM2Rzr+/z+xvyc5y10N6WYvfApw/4bt0xUfAOrFeV0kvFmbGRHUQabt5+jAi3LKk0H7
	 UVU7RmhcFYXWXL+RHyxUuw6QZew2tRGmkh8XqQwRQKB8U16fp8Dg7goic9XX4c86eO8/P
	 gDSbQ9tIuULlT0pS2cNC18zZ2uM27CCVN2/5X28s7n/HS07IC9jHr5X4cjYJ16Wn4T0kb
	 v+YfQYC7pzIMy9mIwMDJsBnFGN67qtlJlDCXx7Ss6nt/15nQR8B3bJaTzva4Fx9bNkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609560;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HNWtY00h1BvD0PdGGV4YeVQiWtcEoAT5xmkYAicygbg=;
	b=S3wjNzyYmIGd0Qevs1wy4fCrc7uOYNEPU6XCNBBIdRctpw4tRYgdtD5W3a4nQWezlDu3
	 jg1E99p02E3YInSFbgr1+Ca/5o7/4kXiCuEBuDPwP88EEKKi/TyCUTWfMfJxY7B0xKsze
	 NA30nsIGohH0B9L0KTATVdQ+Gt+OwZ1A2a4ylhrXtdDwpTvhKK4JI32aTsXmC1uKEB+jn
	 TwkesYp+qGlgM1JB+yj+W5L16Zwczwixv66a/MiL4027fgXVq+Ts10f+Z7+BprBjUEp7o
	 RpevzwMOkvQOK1QbB724IonnwBLXYcw4ewAqlk3V9ZmEaNeIw1pQa5qu5L6GFiZIvkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R82YwbyC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CB8606A33E
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R82YwbyC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AC91F000C4;
	Fri, 13 Nov 2026 22:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609560;
	bh=HNWtY00h1BvD0PdGGV4YeVQiWtcEoAT5xmkYAicygbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R82YwbyCeQMRmY2BUP/x3EiN5y/NF4Xtp3Bhm4YAfUb2OPFe00RAttGa0zdUFADgS
	 g/4ECcUY2Y6dLG0ePaZOJvnRUy28BHEo+NxTWOPf8K+cz2yKpNHhgtAmC505ID6Mfo
	 JPSGwwzf/JgezGySwbscKxHKRz9sZzhHkfC98HY8N/Y/7nf043V1rRe3boYwyIaGDP
	 URTCumi0rV6+Km+oE4aUxxYS5jp+3rwe5CfmOk5VWhY7LZXkUfTySwa41uHAwG8Gyc
	 Ps2YlJrMXkE2xWD/pSyvB2yUuBIjEdcHT5eU/T6PpKi4YrtDMe81FdSETnQwTjypmJ
	 GpvGLrAkzzBCQ==
Message-ID: <sashiko-outbox-213831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/19] dt-bindings: riscv: cpus: add the XuanTie C907
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-2-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-2-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:39:20 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Add the XuanTie C907, used in the Allwinner V861.
>=20
> XuanTie is a brand of C-SKY Microsystems [1], whose JEP106 ID 0x5b7 [2]
> is what the C907 reports in mvendorid, so use the csky prefix rather
> than thead.
>=20
> [1] https://www.xrvm.com/declaration
> [2] https://www.jedec.org/standards-documents/docs/jep-106ab
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D2

