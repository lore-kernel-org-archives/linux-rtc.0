Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288768;
	b=EjgE/hbcN4Tf9/dnk+DgjuQYVKLrBSSD1UfgzetykUhNKWmEW7WkLvXMWdYSdTm5Wx3d
	 khTXWAslxkujnN4wTYPZWc1PUcAXFEBzIqUrORmP7IzHDjFvINnMNOgw0fVw/BRqhyEeG
	 RJJyvcoOmfR9y+unTE7pMOTXc4y0DuT7OMM3zC/OLajsaQjQep09vh8ezjI21/AIp5Wr6
	 Pamq31xfb8dIObhVYcvL42LVtSuPhQae9v+6cu6wM2AqwaBg5IeTHuiFu6Vrc4f9CJKCP
	 Z95HRWgzFkAWA/6Atii/1Ebo9p6k+udoTJD3cEIHChA/DlK+ubPxdf9xPwNwOIPMPlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288768;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OM9glKyWIjFS+yiKiTsbEOeLqxemfF/Vg7vbgAVgu4A=;
	b=4MgRAMi8qV1KrkG2UsrW88d/TzE53Ca6y0jWNprMAtIPHds0sZtqrO0Cp6UOh0mQFrhm
	 Em4nb8PKYPDvirgPFGqAkguOAWmxIFTYjKjiiKVS4T2agb/psPrzy3UZkeaOldfdMeELZ
	 +/m/TxwG1GpzbUJuTHAgUzA55ZRW141nWpVSnjprzJHLXaqFNuemU5DWsrjYVr6AEHSFw
	 bR9IsbM/rWejVe4+9dKdiB5xsNdHgAUT9/TvgRZ5RujfK4Cb53msElvgMe0BNucQ1uFIL
	 ukdJ5aegEvF/1H2rYljw73NCTXzZ0GqZHBbR/SD0eaqOW3CHA/EMEk5e31AvcZVhp8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyitIzFG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F3606A31C
	for <linux-rtc@vger.kernel.org>; Tue, 10 Nov 2026 05:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyitIzFG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCFD1F0089F;
	Tue, 10 Nov 2026 05:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794288768;
	bh=OM9glKyWIjFS+yiKiTsbEOeLqxemfF/Vg7vbgAVgu4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iyitIzFGEuNfevcYdIkYeKNMvblOvFcQyDvJOD2hdqwYvuQpHoS9AYH1hQBorMqP7
	 pnOe63lJrdl3bts1rHC42t66LXi9KcKqq9xQR8GlIOGOufqLKlq3wPRzLwNq8zrO7s
	 lBcw/f2bVley3WGN1MBOzlQBqVytjPRxIKwfMpk6nocxNwVOleXKTyBMSGz0OxLggP
	 +SNhDiF+Gy5UH85uGT4OZhQKUVE6vdY2paHweI5z6O7JgDS+bCFSjuUNqkfL9PyLIX
	 RjUA0ZceO0bONRpNFtsTW70I/I9giOQp9nsmun/8BZPKyt7rqcMVy5wwQcJ3fONN4x
	 Apaw9BTQ2dJgw==
Message-ID: <sashiko-outbox-206302@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: Update Akhilesh Patil Email address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akhilesh Patil" <akhilesh.patil@linux.dev>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261110052942.GA2505113@u5ce4748bae3b54.ant.amazon.com>
References: <20261110052942.GA2505113@u5ce4748bae3b54.ant.amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:32:47 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Move to my new linux.dev email address akhilesh.patil@linux.dev
> I plan to use this email for kernel development going forward.
> Also update email address in few yaml and driver source files.
>=20
> Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110052942.GA25=
05113@u5ce4748bae3b54.ant.amazon.com?part=3D1

