Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792557455;
	b=gv/D628NqyYSC0h5iulaBDwIksmUxoiKti6NH+T9hfsGdH18iauJ7fMl6C5VMvzwbcFG
	 C/llLJWQh1IuvFxjCiZOtLQUCP4XVoj4QudLrBaR++urlNi2e1myi4f1fzkDzcejd8LfS
	 xVr9P+UbWlMdhx6ifvvMQ9r8wk3oqroR+ljq56V8Q26veMcbX6nX7xem+Wok7iSsgisAZ
	 XpOA4qFXlirMp7ZJKlxAVDNbvGxDkNRTxFBftbPBbo6w6VSVNbQWUsrHT6BfFNDjXW+BG
	 j7t13f25Y2t90R7BNM8FGUH4WFeTqpw7RCPNitudX276SWnazK+qnLOZ9CWDCCRgx2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792557455;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v79zoyNXG2u70Fi5Zn8yvWsG1BH/gL2IsxxEwC1v/4Y=;
	b=b332/wdqf8ProqUl1AKQcmhuelZRif5KeT4cQ+31cWBheVUmWZ9jga+EqK/WCoNEPY0R
	 RsZqMP+xAm26INskCbR41Gsg+WGIVu9vwKCJYdRnTIB7p3eAUe52LpGLt7JWXQjSjkOIB
	 /17DxunG1lIRBiQp3ZHefsa+o6iqBB6PDQg83b9NOgR6P2003Ovjzg2Q3dAWEfGo2bJQ4
	 JDVVJX404qSe5/LbAZXbj9MVcYAdTvNwWfkubA3t6RCqFht41xPbjiLT8rqkfMIBvoMbq
	 F2EaxYcUywQYe9RypmHx/IHrXIdRUZ4CIan1dWJ40f9Xk81Ndsk3ZgudDM526PTcp5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRFyIdcO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE2606A319
	for <linux-rtc@vger.kernel.org>; Wed, 21 Oct 2026 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRFyIdcO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226731F000C9;
	Wed, 21 Oct 2026 04:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792557455;
	bh=v79zoyNXG2u70Fi5Zn8yvWsG1BH/gL2IsxxEwC1v/4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SRFyIdcOPEp6xy5sS1ytI/GlhPYMRrASyRYpRwq4My61bwsEUJI7fs8xsqHJK1pp3
	 m6BF3tcF6POa+GiXees53s4hD/BXBSsYvdFr6G/uHQF56NjQIA7+ej0ySG5uiYPNAK
	 Rov8schj5kYQKLQ2ximgi1bB+xR4ro+QHk0zVSUvwm1SWvHo66AthrgmGayzMuGC+n
	 aHnOTo4UZAEil6kyBSzCN6UQbT1AGGTgC6qlCjiXKzXXrMwKnuBWfeCv+utX/Lv3ja
	 bUV8oO48ofGMIl31P6qdYUzEMLC1srcJuyjVn6NG2EW7twMofMqPIZcIeYaAvd3aLn
	 rEZ4jNLEnwbNw==
Message-ID: <sashiko-outbox-179789@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] rtc: ti-k3: Mark RTC time as invalid without
 battery backup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akashdeep Kaur" <a-kaur@ti.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261021042435.3895543-3-a-kaur@ti.com>
References: <20261021042435.3895543-1-a-kaur@ti.com>
 <20261021042435.3895543-3-a-kaur@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:37:34 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> TI K3 RTC typically has no battery backup. Prevent HCTOSYS from
> overwriting valid system time (established by bootloader or early
> NTP sync) with invalid RTC value.
>=20
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042435.3895=
543-1-a-kaur@ti.com?part=3D2

