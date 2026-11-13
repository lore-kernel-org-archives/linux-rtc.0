Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609465;
	b=oI0FfxRbbE8rkH0xL4EXoxosipohEurU0i7U6XTXrw3ot1sQnIr4e5UhhwU+HiQE4vDn
	 sEjA6HuHLF/eY55qyWMA/Eny4Z0sPDzhROcehR17Dogf1FlJmpsruLASO4z/T4KAR7naG
	 mUfWehle0zjNlDXcN0N9qrbnaJmekyow2sOgo46jreqSfx/+ScRUrHZpnlSmQF3yg/18z
	 V3MxMw6yXzzR3qQxVtJ6sT2BBKWv2RHc8mXoHsAfNOXbh+yPk1D44Kxvth29cBEuTxAjq
	 N8sXINUddOaY5sXRXdxTZaaOpqb14jkhMm7LLy4SalfqmCrK9nnJL4yc3YQWLoV93gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609465;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OViGSCgRb4HYHg3cxyaikMiq0jrgczGgIhAkuuxwBuY=;
	b=37f9fsy69ViN174t9CMoeLYDbcxlSNng92E40csYh9ws+o4ta3Ne3PerSX45UlCuM3Hg
	 UWkYV0oLGC7U1z/L4vgfG+4vZctE6ngS1oR7sqBv1XaXfkqSKXBlAycIKu/SA2yjPouMA
	 7Ih+zRxJno8LoI9052M56R7ntFkrJgWoktkUF1deQ5LMjToHAXMZp0oCsSXX52LsqsCEr
	 kvo2jgnuYddAszpIxYryyRjJfozzXUaeWzI8wk5CZodCSIVg0zZDwMoGY2OBLOEqWQidr
	 bX7+IiHDILq1mnW8GrwbLIFG3CJrinvwi+FgPxQaWcCvZ4VUQRbKJT2fQdys1gZUFyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBdWaGYE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFDF606A551
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBdWaGYE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94A71F000CC;
	Fri, 13 Nov 2026 22:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609465;
	bh=OViGSCgRb4HYHg3cxyaikMiq0jrgczGgIhAkuuxwBuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lBdWaGYEfHmwHGMuU1lVdPoaxqgmZZtCdu7xc3TK4zZA1rKaMZHE1PtSSn4cOQxVz
	 SOF4tAqCo70NiI92GY5eouGCKip6iTIiOKSvPYEIqfB25nBP19yXj+RWWIFKak4oTa
	 KKUqm83I5ACAOXIaiXBMLnkxDv33DfUbxFYcc2vnhBfnXvBHRxxeXJJqvPZBVoRC/j
	 aw2rXx0e+x9LqxaiQMLMu/Va9SAcAglYjSNVF+ioa/lfBinCSklD+JAirlQwtIV7pb
	 RqhxTeY6g8OnHNx7kvatezWtbSexjys+GhjDxA1xlvejqscYcKJmTMRCQO0VgKslD3
	 D8Xe+o7SAgfYQ==
Message-ID: <sashiko-outbox-213825@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/19] clk: sunxi-ng: sun6i-rtc: add Allwinner V861
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-11-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-11-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:37:44 +0000
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
> The V861 RTC clocks are like the A523 ones, without the 32k fanout mux.
>=20
> The 24 MHz to 32k divider ratio is not documented. With the RTC running
> from it, the RTC kept time with the architectural timer, which uses the
> same oscillator, to within 5 ppm over 15 minutes. So the divider
> outputs 32768 Hz, not 24 MHz / 750.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D11

