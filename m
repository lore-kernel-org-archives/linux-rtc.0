Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281130;
	b=HX05+vemiCLFudw73JGmjJMEmOsSpZG4OU+50Gd+2jgJJKROm8jTB29Lw6Z+RsEuFI9M
	 cTzXfzt32LLA+Sc9QqmKedCmO00vs6D1QPwzR3w47+QuRiqkEwOE0qGdOgxBP7JKPLdNm
	 /M7qLCvKJpwk5JqySPowlIsT4wWcQR7gypOlMR6T2D0lqjVUWJ5YtUwqfaIH/S83yTzLl
	 sTTKKxAdzxqoM5s1dcrAdkv4jS6xpX4B0qOTT5lSyx+SJYYhuP2vwhm40TsHARmk0tGAV
	 Kde1HY/bZ8tWDXTxzTVDUU6B2O0fwhKUsHxF7mEdRMdARR5Sm+ilhwm9VKw+FPNSmsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281130;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VCiFWsHZJtFcSKqCWT3+InY/XQRgS6JTtOZsOe5y7Ls=;
	b=vUFMSMC6aAwW8FIcRX5Pvu8UG10OSDlJh/RzfZ8Sk8aBCYBv5GgBQ2tYnG7XXTIkxjHz
	 xZVVx6P1P/z0oBQEM2k6iQ4gMMR4//56j8NRaAlHuz6WxxMxq2qz8gyXO5wKDdiqlaU+s
	 ex15G7wYZORbndF1RWvUp1kMdi0zdGG0lL/C5GIPETbCa2+bdX4GIe0nvh384TtJoSDSo
	 TU5pDkcaqsaGh+kBRwiXS3k0slgRU87m0rvr+thv02Pu9XB82NFmCCc1m2iRnPgMWnoC7
	 bu9QeOTqQw7cgptXELcx/6qT+51I/crjZZ4Pxu4SGQ8iVv6JCdSkSu9n4++AOCrV+pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZajxxKp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7DC606B54A
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZajxxKp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04201F01243;
	Thu, 29 Oct 2026 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281129;
	bh=VCiFWsHZJtFcSKqCWT3+InY/XQRgS6JTtOZsOe5y7Ls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZajxxKp/WBnPbO03Rj6C+760kLsBQ0vVlsP9ljPaT53hlRpZIeFnt+3JPOHv18pz
	 Rq7b4hZkWa8ThSygccIcy7DSGSAXLMUPWoSPqYUR8DmotlhBpaiUCAkwWUr3Ncm8bw
	 M7EXQS/vqP59u/kjmX8LLGuv2f20lmQwdwnApf3wSiAHaARgYoVGHbsZJ3bQ+i41fz
	 jEZ6ze8h7oM9TtZf0i6w+F0G4YvMmMKyM7YeqLuB206EEJKOSWYGcINZjGZV3ETUo6
	 2ahqsERL4LFwsYOZifMCLhrseRUsQZuUZ0Q9vUoYdsQszU5PQZ/5ruuwDIyyI90MER
	 kF7ik53FyOacw==
Message-ID: <sashiko-outbox-189402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] rtc: pcf2127: use sysfs_emit() instead of
 sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261029132339.925021-2-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
 <20261029132339.925021-2-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:38:49 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use sysfs_emit() instead of sprintf() in the sysfs show callback
> (timestamp_show) to conform to the recommended sysfs attribute
> formatting guidelines in Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029132339.9250=
21-1-alexandre.belloni@bootlin.com?part=3D2

