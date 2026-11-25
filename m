Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591991;
	b=V5Ils/cptS6pq81Whapdbxk1Pp+HwNLa0Cc8tqxoiHQSxikwvOcWXvWCuizpEv1EbAH7
	 O7qe0TFWoxhi/71hxQJW5AAPrgLKDreHWTE2JgfIz00tzsyiiRNjLDSkGFdzcPC//o78C
	 4O905KgOmpBVsmeaBS1+nTgA648S34rLAODXlC7kj+kqY+3udh0cR4ftgP7038SP0pWB6
	 0w9kD2S4k9Bo1N/zvXBg5DrbvLwKlWOKkOe2ENeRIp8v8pg1Nn7ScBmH3Av8Jkh0vk7GJ
	 soKnZ2+wZRYPzbqTIYrCtP1F3aO+EHsZfWa/a42FTpzLgkSL1xFHs1d/+DSVYAbF6Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591991;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kUikyNHFdJGebftDYFBpEnxzX3+9TTzrSUWrTmmDifw=;
	b=bYBT8tYsd0P2ObAzjYkCM5gdwKF49cNkzWWTyD6L1i1D34fY8DipVguPg7VHHqlIS3HE
	 fvZcvOT41Rn9o2gzyqlsSU1AiS3pXUNJEwYRgvnDUczvZQoaE1D4UAdqfIK31aLpWP9LP
	 P2hdFOYvyrCVWy7ti86WWAeNhZbmWz65xBTM6IzWDwGL/puciTExjFP1sIP0y8Xl+nrk+
	 qCcXhgw8RkpqbpdbO+37RaaTwOV2pE3/RMk35Y2WYVLYSa9UU22Bmsna7Kr++qLCsJ6VV
	 vAavfWpaOdwF0yOByo1Zs6ZIzMVlVcbBe5fbCr+qtGIe9Yrl3/gekgqW1jQdASb9m6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHwuW4sx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84601606A336
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHwuW4sx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D931F000D3;
	Wed, 25 Nov 2026 07:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591990;
	bh=kUikyNHFdJGebftDYFBpEnxzX3+9TTzrSUWrTmmDifw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mHwuW4sx3WZCbZ097iRYSS/vxwzI1p07c5SM92KSiQS69c0BRVmonsimWBZgloHpU
	 26kaBLQl/4ebFViC3UpO4SnZspZl0Jx+9aR9dzzBepXCnW1HboEyfhQVHDw+3G8fQo
	 LAQDmO31KT6DxstvrfjIZjaNEGcsE6zr8ICeuvqlDRTDtcNl7pAH1b55Fs/HFsuJ/y
	 wxlSzKD6atrPUToXxTt2MONVKWkMEXxiLTiYd+aqoUyF3smlNSLEMzT0QscxQSj2Gh
	 Tr1ysdmE0RuI+X6KLZJSYnXX6aD1XTvn97xfeeS6tsRHWva2fzRlZARDGUTIN4w+iL
	 H/scZA/lCI/qA==
Message-ID: <sashiko-outbox-232811@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 00/12] rtc: clear the wake IRQ on unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prasanth R" <ragaprasanth@gmail.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
References: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 07:33:10 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 12-patch series:

- Patches 1-3 and 5-9: no issues found.
- Patch 4 ("rtc: mxc_v2: clear the wake IRQ on unbind"): 1 related
  pre-existing bug noted
- Patch 10 ("rtc: pcf8523: clear the wake IRQ on unbind"): 1 potential
  issue (1 Medium)
- Patch 11 ("rtc: pcf85063: clear the wake IRQ on unbind"): 1 potential
  issue (1 Low)
- Patch 12 ("rtc: rv8803: clear the wake IRQ on unbind"): 1 potential
  issue (1 Medium)

Detailed reviews have been sent as separate replies to patches 4 and
10-12.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125072026.2997=
493-1-prasanth.r@lineo.co.jp
