Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828683C1974
	for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485206; cv=none; b=VdocVA+QsvZ0olo+bM6SeluzYTfuMpTZEFZgx3qamn+CFpkuwU7J94nSPPWc4VdpWMaao9t5wPGQTrotryqjf8hRGuLVaFEUP7CeNkJvqoEIWLCqJhoMTsYk97FtPr7Zl2BRu0Cky5XVe7VliqFPUxrQBu3MBUn0k4Rg0ZORpYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485206; c=relaxed/simple;
	bh=+fqnbfbRkGEwULxfCXzJ81orCXA6GrJWlYG7VweMXvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oVZ5cf+RVKpFFNU/Huxn6TDpo0FvZhwZS/hNZgj3F8sR/7mGtK+F6jJK3uJo5hNO8fhkA6ri9hfyY7Za55vbU/MptQLpDw0wY6Ug6DPoLbU4y5pEfEiZIrn1L9WIwFKy2qY2V4LGKqAH31I8D0WkcPvbqhhYlzqmuoFrs6R2tFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf7m6HvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf7m6HvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953911F000E9;
	Fri, 31 Jul 2026 08:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785485205;
	bh=+fqnbfbRkGEwULxfCXzJ81orCXA6GrJWlYG7VweMXvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gf7m6HvH4NEHBkRUfDzLzFpHmZe5+d98lUa9ebOF+5bMnJgV5MA4i8kl2LxNvvk+v
	 rI6phw2u5r8nNe7z8zeazBcH3pLLoKGOFPm8t/AWRmPjQ/ag5Qiq/2lTN9QhxAnXI7
	 i+F6tfM4T2tFEh3LRm+fAHnVsw9P02KkNYjBM+lu617yIK3aPjiyXfiEKr7csX0CJL
	 J5eAK0PK/3dH8TMq7ns3M7Rdzf9nd7ttL91kz91vxqkAec7gIw2VL+/0AbyWni9KVF
	 Gzy/b0OkHFRKcM7dY9LZcw1fu1E1D/uwHM8ku924H6AIWPfbc7LNTw4VycIlNO/vsB
	 cMI4RkDTkjIXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: gamecube: check return value of
 devm_rtc_register_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linkai Gong" <gonglinkai@kylinos.cn>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260731080239.383831-1-gonglinkai@kylinos.cn>
References: <20260731080239.383831-1-gonglinkai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 08:06:44 +0000
Message-Id: <20260731080644.953911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> gamecube_rtc_probe() ignored the return value of
> devm_rtc_register_device() and always returned success. Propagate the
> error so probe fails when RTC registration fails.
>=20
> Fixes: 86559400b3ef ("rtc: gamecube: Add a RTC driver for the GameCube, W=
ii and Wii U")
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731080239.3838=
31-1-gonglinkai@kylinos.cn?part=3D1

