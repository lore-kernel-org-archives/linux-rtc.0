Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264099;
	b=SHMwwXPBiNGjXq9rJsvOvGGngcxe4SU21YDgA/O2DV06Os+l3XP9sj74Uyzccne4bg74
	 tiyG6R1LHhNjRRGtMW9fczGt+jE0Yy7YhIlRnGcn4w0b7mXZxyMXAU2hrie2wLqL4R7zp
	 t4bC81+Q0CrmbMw6wD2Yr86AR1bI47NqJvzFLz2KSFqf/JJTinmgHsfUU0rdLPfFUGz0W
	 UTJrYVfUeTkb/TU8DNt/pklf3tWJpg2jxPkQIALDwcjNyYsgJ2GMgmfTAJmy624yOZ5v5
	 V+yVAti9X+w8RbExs1gFW5mKNdJtONu6duE24wQnYn4OpPiju+52nmc0eJlyW22ulWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264099;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4/girJ/rxXhiLU89k9FEeD069URA2Oer9wLa9brczdA=;
	b=gghW7V/8lBL3+rEGYLV6Iy0Km7ZUxaN5Q13J9Ukd+DIZSbFpr7MRUyRDi1BmFMehAwJv
	 BW74AbTTPeUD9VszqQezIgFZ7lwSwR819f0RVQ1XOmc3QR+GvaQY8WDHjQsH4mcXcxhkE
	 lxHlkwiT1vrZdfOMQ0n7rlaRBzlfG0N/TN4hFi4antHEEIBU6OAaUopZgf/4F2jhvQIhh
	 8j2P+AdkpQUdAohTe8hAoDtOsLDJZv0qx6McrQqk7jzLaMcBKNvww+Cvxk3iTmk6nOAmP
	 5/IrWutOhlZU2oBQrxIcImKQIwKzpZOVVwiyur9SsIxpwJQXYUVLThLnHF8k7X25VLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XHEjyKMG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D7B606A339
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XHEjyKMG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3915F1F008BC;
	Mon,  9 Nov 2026 22:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264099;
	bh=4/girJ/rxXhiLU89k9FEeD069URA2Oer9wLa9brczdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XHEjyKMGKEfDUF2G8swpwi6+TSgzm818vtQNeRAOP5iH365OG4iAYAL/D+iA7GiXT
	 O0JdOimZep+1eVULppBtOVYCRWB1PJHhv0b/HneHWypm4owa4gi1p3v7QlV669yk7D
	 MrITC2iS16qyjVZu8B954Do+X3/foFg75rrc2btWpnHMWoZD67Syw8+dHGyiX99BVk
	 QOVdf3Omw6opcwKhuDqEIbCUF+UC0r8zjmymgpih0s0W6LSuoq7scH/+ftLMcFdr70
	 EmJYrloy6E2vSs8LQuuIiHmzbMBQQ/zPKNPwBw4zsw8kYF20L9cCBGlApQLOK0Qa05
	 xOq0ZUyoC0MRA==
Message-ID: <sashiko-outbox-205764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] rtc: gamecube: Use unsigned int for control0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261109223902.84918-9-blum@kernel.org>
References: <20261109223902.84918-6-blum@kernel.org>
 <20261109223902.84918-9-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:41:38 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> regmap_read() expects an unsigned int pointer for its output value.
> Declare control0 as unsigned int to match the expected type.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109223902.8491=
8-6-blum@kernel.org?part=3D4

