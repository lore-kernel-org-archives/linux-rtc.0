Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610874;
	b=WylOvtx1nWvJiDdwrn6o3azidAJtm/jt6iZmA5ce7WI+siKh3tXhAi6+uUVPmNLbyGSu
	 lbDSmGwdLLPfDLmrxFFB83amHcY9LbHVnEkQiUkZBZeUuGwQdAlY1HjamJl/kfRY1HkYn
	 8j8HtnOto2kEOM8lTdi+1RQ26mIG4t/PU5vJPSJtj48Hv1d/m97cajDlNpABD+x/uBGQs
	 /9YOHmv7ldzhnF/6y3VAakt53hqG7UMQJGYCxg9jjbcTeByBNw4fGOfuMvwC6dXeKXjar
	 zyrDJbMEB9dr1Bb1ObKqd5jPZElBkRj876hwZhy5vEcL1PXzWe+usQNtpKJSA3eVfaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610874;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ly9DFeqLRw1CAOhdHA+AtJuS5VBp/Crp1mMgruGlaI8=;
	b=YY3u57Kte26FanmFNzH9BNwos7xRJkfPC9WB4+/nP1dHS8IkfN+E/E0FWs7Sa682Pmbd
	 +iSflU2R6euDlj2Mg1XGdvsA/CavFMDgFmYo7QtjK7pb+OBCAavH4z3WR4egKBVbc6LSr
	 GAJolA9W9LlrHK/Az2o0UiqEtxWtG2pPylznZSlspdYceitng+rWdmFAg4g/K8gWUJ9RM
	 zEb+T1lPTz4/x0S509arzHuyH2sG/3qtgRNd900iWL1kjdujq8yIOqWZZVyugTnCoyYXz
	 XGGIGgdKYSr+AzNaE91hCKs64p177WP4naO85CkqGoRdJf3O09D/PUNpq0P7lhwQKEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBtScbpT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18289606A326
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBtScbpT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B579B1F000C4;
	Wed, 25 Nov 2026 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795610873;
	bh=ly9DFeqLRw1CAOhdHA+AtJuS5VBp/Crp1mMgruGlaI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jBtScbpTU0vdfNdmxCabPIwWIHahhXxG6HoQV03XpfQP+d9OtHq5uEqKANURdT1FW
	 pOsdLlFSJ/LQRJpSiK5po1aRVrzumgxURxGLljwbzrZEA+Mp4LWCksEeA//MwJuDmK
	 Et/S/acxx2GXL4/a0limybfEeasDtldXaq5HV2voqARMAB7X+gph7Uvnqb2WfoPKNS
	 mSdnA07MmCDGwdnn0wfTnEv9he97G8+4iOFo6+1r/O0W09+r18D8iOiMaQVGEw/JCj
	 c6cadqb3slp90WYY19LOgFk+W97EmlUWJtiX28wkk7O03kctpQbb41uG+90Fy4s4is
	 6he5wdrL5gmCQ==
Message-ID: <sashiko-outbox-233394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: pcf2127: use const per-variant regmap_config
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akshat Rawat" <akshatrawat095@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261125124416.468-1-akshatrawat095@gmail.com>
References: <20261125124416.468-1-akshatrawat095@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 12:47:53 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Both pcf2127_i2c_probe() and pcf2127_spi_probe() declare config as a
> static struct regmap_config and update it in place based on the chip
> variant.
>=20
> In pcf2127_spi_probe(), if a PCF2131 probes first, read_flag_mask and
> write_flag_mask are overwritten to 0 and never restored. Any PCF2127 or
> PCF2129 probed later reuses those zeroed masks instead of 0xa0/0x20,
> breaking SPI register access. Modifying static max_register and flag
> masks also races if multiple instances probe concurrently.
>=20
> Replace the shared mutable config structs in both probe paths with
> per-variant static const struct regmap_config tables, and drop the
> now-unused max_register field from struct pcf21xx_config.
>=20
> Fixes: fd28ceb4603f ("rtc: pcf2127: add variant-specific configuration st=
ructure")
> Fixes: fa78e9b606a4 ("rtc: pcf2127: fix SPI command byte for PCF2131")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125124416.468-=
1-akshatrawat095@gmail.com?part=3D1
