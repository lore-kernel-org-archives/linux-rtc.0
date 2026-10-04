Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FFC3F54D1
	for <linux-rtc@vger.kernel.org>; Sun,  4 Oct 2026 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791153707; cv=none; b=nGk5hwZdJ9JfsjXtH9lpzHH8lCWNK7VVExb8jwS9gRknc8D/M6VniUCeA0HhvoVpgqgL1797oGJkfVj6iPcDIHHt5/irLHoQLzDtt6r7z9z5oVQch0SFFUXmkshiQqx0ubuILt/GjHIXF0bHK2q/nUWaq3kqm0f60ZbW9LXTkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791153707; c=relaxed/simple;
	bh=Xv/VSJS8S1lyOyWsj9loZkbmHgMxByF7N0dO0TbVtGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HNPioSVKG/TDcxQ6XOYcqy4Ase/5BYhJbbSfb9wN04LjboPfkUXfa9fa0ew4kuOV5uksQOidcJU89OjpnuBOmxD6LVlCnZQmRt7dDl0D+quG1MdcYuCJdu1GCmu/JA/uxT9kC68Fls55BRO8foT8/lI5BJLMkQI65u0I1nEYZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUJApt30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUJApt30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABE31F000FF;
	Sun,  4 Oct 2026 22:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791153706;
	bh=Xv/VSJS8S1lyOyWsj9loZkbmHgMxByF7N0dO0TbVtGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mUJApt30BqwjVpftyS57KpHadwhzMfq+VKc10dbu4Cfk5mDjSPdooxZPgJ1FvV8/1
	 nFdIkC7DP3pgwJBb30Sx265Q0rrFPGRhGVg478j7muUx6RcwqPvBrRsSrcmsbC1vLW
	 gHIkBtzdo29hea07RwjSnScECwo6HVuXfTju5tsxnKY30ajfbF2+wCcSMxfmXTf+dF
	 P1mT3zrRICv+chdRu+fNK0XzienbAbI8i+b9HLzkyOdUWiAi4Po73sSxrnXL/tUFV+
	 LV4sL6EmNVhOOy/bUe+x0exaijsEtjeJRA1oSk6b82ZE4HezOddO7l0NMUaN+zYD8M
	 334pLVK2WEvbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: mpc5121: replace in_8/out_8 with generic accessors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261004223540.455708-1-rosenp@gmail.com>
References: <20261004223540.455708-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 22:41:45 +0000
Message-Id: <20261004224145.BABE31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Convert the PowerPC-specific in_8/out_8, in_be16/out_be16 and
> in_be32/out_be32 accessors to the portable ioread8/iowrite8,
> ioread16be/iowrite16be and ioread32be/iowrite32be. On PowerPC these
> use the same ordered MMIO accessors, so behaviour is unchanged.
>=20
> With no PowerPC-only accessors left, allow COMPILE_TEST, and add the
> HAS_IOMEM dependency the generic accessors need.
>=20
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004223540.4557=
08-1-rosenp@gmail.com?part=3D1

