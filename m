Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3441D647
	for <linux-rtc@vger.kernel.org>; Sun,  4 Oct 2026 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151745; cv=none; b=tKXDNlEF3BnqaT+434iYnsKSyHd7Ahj8Voq/ymwwfgj1HRC0gc30iLmzbfF+P03YWb7Cgimnp52hr2Mnd9PmNs8/D683JwNR3pgoU6m6yXjIBUx7Vc5brsn4h1Z2etHNl1gxN9W3IyU+fEhtXrNnPIsfMCi+OT9I3Rfh5mtqJZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151745; c=relaxed/simple;
	bh=1d9SWsrE7s3f6/HtwX2kra8cGkw9YbMrqGCFWY9Y2M8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HiM2DAcYctVc2u9yR4eQZVlzjqQ47BmKYI2FeBcz6CVWsAArCahUszpTdnGef4XW55XNDgVISV6TEeSJ5R1nNRQdxa7D3uc+2/oqLFS8JWH/u3j/9Mmw2AlPyb6kupE6I+gS7cESKSUQrljUKdRAKsh+bMQErl6dwzwOZ8VUaL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRW6huND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRW6huND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B951F000FF;
	Sun,  4 Oct 2026 22:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791151739;
	bh=1d9SWsrE7s3f6/HtwX2kra8cGkw9YbMrqGCFWY9Y2M8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fRW6huNDcBCygpE2Wm+GA/HXJWdCJWwBcWX+Athvx31G9WAXwfbAAEzPsJHKIX032
	 jhjqQHl5kjY0I+U7cUiDyLX/twINmNAtIg21ugN5zYzvTr1fNeuAIvUCSWPh/RJJzh
	 BpWGLI2Ud8SeWereRrw30V5Dslf6lg+nRjbb7R1w2yt8okPvyHI6jZCEnvSNg19LlV
	 E8yMqvVYDH3Y8XaX6KdCB33QAf4tH0hlj8PnUHDCw0ftaDvAIEf+sUNlAMYAwLo7Qv
	 iyN8s61XpSsA27QhHgf76wJItqfahYKNl/eXZ3gxgsGGcI8tglis9vkDLnTW1AZ8CW
	 BvIb9LbOvZEcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ftrtc010: use devm_platform_ioremap_resource()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20261004220258.401706-1-rosenp@gmail.com>
References: <20261004220258.401706-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 22:08:58 +0000
Message-Id: <20261004220859.43B951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Replace the open-coded platform_get_resource() plus devm_ioremap()
> sequence with devm_platform_ioremap_resource(), and propagate its
> ERR_PTR() directly.
>=20
> This also reserves the MMIO region. The only user, gemini.dtsi,
> describes a single 0x100 window at 0x45000000 that no other node
> overlaps, so this introduces no conflict.
>=20
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004220258.4017=
06-1-rosenp@gmail.com?part=3D1

