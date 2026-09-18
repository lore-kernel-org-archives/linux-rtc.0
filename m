Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1F2798F8;
	Fri, 18 Sep 2026 05:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707856; cv=none; b=q5ztQiY9NOZJG+zwGF6I9dDWqE+x/XbXRLUckuLrRQkWSP1GzTdBlmVJdo0wsyo+aZkYuMcHsz93QxwpOCNCBiYyg2vUXEM+O2fx+Jh5LpJyFvwfZCgCCQqHrdxP5bJGz2fHnGdNbn+974AJiT+P4Yultkk5tLuPWnRYq3XMHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707856; c=relaxed/simple;
	bh=oOAYo6SvphT4J+IGsfaCbdBlYL86pmz4cHD6ag1txrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SqYsgqUlpQDZ3VnSwY5gDaWuGD0OYX+ZduMe/tIegvxN8rXe9Q/WCoTcCR5K1t3codWNRHHh2M1O4LYwpZjlVtnWDb1cVClgzXRhBd8/ZjbRzfnlEhnQW0DME2LLKTysIy3lCw4SSUvsiKxlS0Zr5NNveWxDzCqyEE2oxhSOmPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+kf9Ul3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+kf9Ul3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E183F1F000FF;
	Fri, 18 Sep 2026 05:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789707855;
	bh=oOAYo6SvphT4J+IGsfaCbdBlYL86pmz4cHD6ag1txrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g+kf9Ul3bsX5yIE1EZpJeXu7UF4hUwhBn5lBMqNwA7FPIgvXWTcHsGDOdauIJ/6Sy
	 f8nrrxNtwvSUZorKfTD6I/vPIXaAiAB8DcVEDyzf4+e8lvtcPxYzM81QAcjmq7L+c0
	 YcWGQOOQJb5s8hiloG+Cmvyt5x1mRRSujGQJMCgJCI9ZNSJS25mgcT5UyAEa93A+T4
	 ANj/47TXXqsDoIIb7sKE1D41D0N2we9Tg0UVzwpJwSfmDlEwDtClu+0fevo8+10HkT
	 LoQ3Zmg2o4QF1UTYFw6ULT+pAvuF7wUoGx5WwA4BvqJXnr9nNKkNnGyvUGLEGi8Ywz
	 NRWLc3topFeiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] rtc: mt6397: expose the spare bytes of the alarm
 registers as nvmem
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: linux-rtc@vger.kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org, lee@kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org
In-Reply-To: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-2-558b8f95cfbc@gmail.com>
References: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-0-558b8f95cfbc@gmail.com>
 <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-2-558b8f95cfbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 05:04:14 +0000
Message-Id: <20260918050414.E183F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Each alarm field lives in the low bits of its register and the driver
> masks its writes accordingly, so the high byte of four of them is storage
> the RTC never touches. MediaTek names these RTC_NEW_SPARE0 to
> RTC_NEW_SPARE3 and gives the first to a fuel gauge, which is how its PMIC
> battery drivers carry a state of charge over a reboot.
>=20
> Offer all four as a battery-backed nvmem provider, so that a consumer does
> not have to reach into this block behind the driver's back. Doing it here
> is what makes it safe: a write lands under the same lock the alarm paths
> take, so it can neither be lost inside mtk_rtc_set_alarm()'s
> read-modify-write nor fire the write trigger in the middle of one.
>=20
> The nvmem core does not range check a cell against the provider size, so
> the callbacks check the offset themselves.
>=20
> Tested on an MT6397; MediaTek's spare map for mt6323 matches, and the
> alarm field masks are common to every compatible this driver binds.
>=20
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-rbrue-suez=
-upstreaming-mt6397-rtc-nvmem-v1-0-558b8f95cfbc@gmail.com?part=3D2

