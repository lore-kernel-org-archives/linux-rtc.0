Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64D45D926;
	Fri, 18 Sep 2026 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747395; cv=none; b=qwUnyuYPxVXHNsMTD2sLti1FCB7rkbZdrnwWKv7Iqr12ftMCfKJMRHuvjns/vVN36zKqkstRb0M7Kj4VX8YL9brz+Aja+wV4gH+vWB2BPLgUZNEicoU7t8w3reu5ACJ01gJhXgWXxHUdDVWRoIw9JZMtSe+TtLIE9QD22eB4pKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747395; c=relaxed/simple;
	bh=LkPSW2XBOvbn/bd7wq2zzgpXfaW6nMCIZX9haDRmsqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B8W+gXa9NmUxU9b/9T03Nmro5QqM0m1fsxaVbMT5YvqnqFoNlHD5AWhEok396PttDUqgh/uCaDO7HAGpg7HWaDGs/bfQFhgNzpuPuCGChrBvbBuHEZEMBfujxHGAlzTUhSUBPkWUsZjXI/Va8CdFBmljTUcndzb+grrCBDLB7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey3qhnvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey3qhnvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB6C1F000FF;
	Fri, 18 Sep 2026 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789747394;
	bh=LkPSW2XBOvbn/bd7wq2zzgpXfaW6nMCIZX9haDRmsqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ey3qhnvck0bameT+T9W1RjWdMu0xvdhA8oNM/UIhMyoFIM1SgUer5LbsJaZRwoFVX
	 std97977pqTiysSU992S9AttooEj9+FsTXPtRZlgpyYRI5LIL2DRYi3SDTM06JHdYx
	 ICnsPyqGkl7zkTcfWlNI3HnAr86N195s53sWh0iER6Z4Vmn0LeTYyO8gprG1RIwHFF
	 v27EPYA0Opg82z+WNfFrGS8CGQQF/DU5TdWajcnpTG5cQLhkltUsKEXHjlMlODbJxt
	 VVBxlwfMGT+1H/xLBo0X1+4ON+wmeji3K/HDvg8HYr2NzGIvVeaVgCxehRtp3k3HW3
	 8TiBtkqQVp26g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: mxc_v2: fix clock-unprepare race with the
 still-live alarm IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Nguyen" <congnt264@gmail.com>
Cc: linux-rtc@vger.kernel.org, Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, imx@lists.linux.dev
In-Reply-To: <20260918155642.2557978-1-congnt264@gmail.com>
References: <20260918155642.2557978-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 16:03:13 +0000
Message-Id: <20260918160313.AAB6C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> remove() unprepares the clock, but the alarm IRQ is devm-managed and
> only actually freed after remove() returns -- so it's still live while
> the clock is unprepared. If it fires in that window,
> mxc_rtc_interrupt() calls clk_enable() on an unprepared clock.
>=20
> Free the IRQ explicitly in remove(), before touching the clock, so it
> can't fire during or after the unprepare.
>=20
> Fixes: 55d5a86618d3 ("rtc: mxc_v2: Add missing clk_disable_unprepare()")
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260914134826.EC26D1F000FF@smtp.kernel.o=
rg
> Assisted-by: LLM
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918155642.2557=
978-1-congnt264@gmail.com?part=3D1

