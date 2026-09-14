Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B2411A04
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421383; cv=none; b=eRl5Vz6XIuzyR5Ys2WK5pRU6i1w8DEQVnBA8M8c2nNzYlNrfuLiWeGUEtH8db1bz86elgbJqsAplrmmN7nVbP6eguOdd7wS+q73jf1qnvaLuXzcdAYNVSAyBzCuZv2lJQ1t8XeGCtHvHCcv6OEDBHY8UJyWS+Ow20np6IO6T6b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421383; c=relaxed/simple;
	bh=lXTbm1pogHlnjy6t74uw84WZ6j5Yt1jVrTdv/Mck6RI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MzTw7EFViX8JDTDxlN2lGAHZkft9WdYpdwUlmBZOHnwW1U3R0Yx5UBdVWxrHBveWwuSQzVL3KC160uCXfUVU5zddnaW0guMVB1giC5duk97VnwBpVSxk4mudLoPRc/CPGa0uQXI1s9IdMemwpgrCs/Dxf4GvVxaRo+U2/YXiEq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHpNySBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHpNySBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF551F000FF;
	Mon, 14 Sep 2026 21:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789421382;
	bh=lXTbm1pogHlnjy6t74uw84WZ6j5Yt1jVrTdv/Mck6RI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kHpNySBcVXShuKP4y3013YxdueHoY+SRmjaNAYkQbZ93WwSSVMJtAgC1QJ6gX1ZO3
	 j9Q8uC9kECCR5ARGs2C+vEjTk9gxhtFRbLpU1RFVfS1AXZQ3pjvYGRc19nMpbU32S2
	 cxd7hieBD/PxM9PVRz5wZlo4+wu+Tcl0D8Nc+RoR6+xVel7uKllZqEistbZKuJpjLA
	 dhv/1Dq5U5RsMZQ0vWhZjSYTTnudaLlHpjpMOTrGB0c4USZKoBVAj4Qw9a1WNUnvtO
	 XDfvezbZAhibko1baHp//F55guqN1kcLDEyb+myvfp3IFN/U4ldffAi9mSLjDTjKsn
	 pjTGfVDf7aWew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: class: Make the time32 hctosys limit configurable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260914212537.1452-1-kmehltretter@gmail.com>
References: <20260914212537.1452-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 21:29:41 +0000
Message-Id: <20260914212942.5CF551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> On 32-bit systems with RTC_HCTOSYS enabled, rtc_hctosys() rejects
> RTC dates whose seconds value exceeds INT_MAX, even when userspace
> uses a 64-bit time_t. This leaves system time uninitialized by the RTC.
>=20
> Commit b3a5ac42ab18 ("rtc: hctosys: Ensure system time doesn't overflow
> time_t") introduced this limit to protect time32 userspace from future
> RTC dates that can break boot. The same limit prevents systems with
> time64 userspace from initializing the clock from valid post-2038 dates.
>=20
> Add RTC_HCTOSYS_TIME32_LIMIT for 32-bit kernels, defaulting to y to
> preserve the existing safeguard. Allow integrators to disable it once
> their entire userspace, including init, supports post-2038 dates.
> Warn on rejection with the RTC date and option name so users can
> identify the cause and find the setting.
>=20
> Keep the option independent of COMPAT_32BIT_TIME. Userspace with a
> 64-bit time_t may still need legacy syscalls for operations that do
> not represent post-2038 dates.
>=20
> Fixes: b3a5ac42ab18 ("rtc: hctosys: Ensure system time doesn't overflow t=
ime_t")
> Link: https://lore.kernel.org/all/20220908115337.1604277-1-arnd@kernel.or=
g/
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914212537.1452=
-1-kmehltretter@gmail.com?part=3D1

