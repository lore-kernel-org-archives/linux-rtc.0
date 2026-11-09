Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196127;
	b=yu3LgzxGCmxijmkkzsTWfmOwRdlRqQvDDhCtc3KZx+iP6BAMiP+X+0r2bkeS57WqNkO9
	 h1j/bzU4Jkr+HfJRMp9oyuKV8wHT0EoXuj5XZkIMXXUuUj/ygeHnaAETyww9VY5rKHj4t
	 DC1c8X9dTmNpOs3pElbkxTQGLjESlfhJ4SzQr6ng8eV+vjSpMFvKprKRng2D/lGPJiVE+
	 D4xJfXruFTje36IWyaHd4c/KUEYdJIHm17gKPYSBWhWSRt7exKaVO821UQxzfTYeFPS0+
	 50fU/QNcsoJ2lG9WE517jvj4DLrZVA7Qxza329M2Hbvn2XByXA4cUqo0AVbifm7WKQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196127;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dPUI79ZTuYvyeGLw2oxosUBgSkuYkeg+QlasMFm1hio=;
	b=XF/TLnxJWAMsWK2BMFSCYKKQqag27vpmSu2Wwt29nDfbi5FtuKe+pBDUgYZPzPWQVqti
	 w26FQ0E0iUlvWTk8eBlcuHOFBSWJkar3hHtR+H3jUghDvC1uKW+YeBlEDH4AuRwKVUGLp
	 zuk3+7/L8uoqGP+wJl6Q7vxEsWxNaSu+p6GLde+Jugj8woQ+5hJlRNBXAvlcZumCueFYE
	 WEFWJ9VpqVp1JjVdBaobUOAIaOhzWM0DcOjjvPLJDpzbdJEpMnGyilT6XVaJl15D5cSVr
	 s9dF/8ZspyCcOmgjFX6ALYcHjxihaXEriqMSmKFCXeQU6j3qCMr2hCM4hG6ZGFUJfRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdBzpZG1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99833606A31C
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdBzpZG1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2291F1F0089F;
	Mon,  9 Nov 2026 03:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794196127;
	bh=dPUI79ZTuYvyeGLw2oxosUBgSkuYkeg+QlasMFm1hio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UdBzpZG1u7CpPnhjDjl6AYvud49cUa8v6phVHgI7HFa1iAoscMY3llkbdqNtjcRTy
	 jebCM4fuOOErObr32VgZEHs1AC3vcEbDhqcX0qTFRElGDNLHosxtwmwQmso9ebh03Q
	 NSVyipYAiIYh7k0DU7oiRjOmwi24MGIPcs55LdgDKmTuHRD7kD2BPClPn23S/hezax
	 qvY2+BlADkDDuI2LRtCs1D/Uv4mTDJkj13RK0JCY98Pkl1GJZul5WRhg15qCz2c9Tf
	 FoW8Thj4b3Svf4Xz8yZ5QT+J+53yezRE4vIvWQjDnGXtB2vuslJ3e7BArgdo+DOOl9
	 0jk/5Tcyo0xZQ==
Message-ID: <sashiko-outbox-204383@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: ab-eoz9: fix negative temperature readings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuehong Wu" <wuyuehong@cmss.chinamobile.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261109-rtc-ab-eoz9-neg-temp-v2-1-yuehongwu@cmss.chinamobile.com>
References: <20261109-rtc-ab-eoz9-neg-temp-1-yuehongwu@cmss.chinamobile.com>
 <20261109-rtc-ab-eoz9-neg-temp-v2-1-yuehongwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 03:48:46 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The temperature register is coded with an offset of ABEOZ953_TEMP_MIN
> (-60 degrees C), so the driver computes "raw + ABEOZ953_TEMP_MIN".
> regmap_read() hands the raw value back in an unsigned int, which makes
> that addition - and the multiplication by 1000 that follows - unsigned as
> well: -60 becomes 0xffffffc4 and 1000 * (raw - 60) wraps around for every
> raw value below 60.
>=20
> On 64-bit systems the wrapped unsigned int is then zero-extended into the
> long hwmon attribute, so every temperature below 0 degrees C is reported
> as a huge positive value: raw 0 (the -60 degrees C code) becomes
> 4294907296 instead of -60000, raw 30 (-30 degrees C) becomes 4294937296
> instead of -30000.  This also contradicts temp1_min, which the same
> driver reports as -60000, and consumers that only look for negative
> values (thermal governors, monitoring daemons) do not discard the bogus
> value.
>=20
> Perform the arithmetic on a signed value.
>=20
> Fixes: 67075b63cce2 ("rtc: add AB-RTCMC-32.768kHz-EOZ9 RTC support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-rtc-ab-eoz=
9-neg-temp-v2-1-yuehongwu@cmss.chinamobile.com?part=3D1

