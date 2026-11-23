Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467955;
	b=l1Wpto1RVFLw45IMaiL29FP07pAYbSX+b3D9TbdUsKgNJ1TSsWIYnY10i2VsVL3jcdIQ
	 tV0hVxscR8KJ/rlAwjEHgq3+QF4npbIrKjbYc22sDPwzZKdiUV1FT194/h1KOFxhwRm+p
	 Aj47Vq8a9KgLXIHZ7CPK44zrjcwnqoExhQrUfMBowhIDo27/r/3WjRnhDnFk+w+tv6lNB
	 ji3UlDDYnUaR6q8irYLsZP4xt3uxiOakHLfVmw/4NUEyPS/b54oCEK/xT9WxgTwJMjEo7
	 Zo3p0US6p9zFfObKMh+uVw4XGST2Kbs279XgL5u32aDzi46D/iQskvPLGaubCBuEajg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467955;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vOD2vJ7TbA88wMLPsSBcEwTq4jpiqLQwBHGIeWEx7YQ=;
	b=0bb8UkJhWyPuFVaxEM7tHOsyAWE6dPpCJsy73knQ3LSaeYs0V07cwQGGLquwsU2UgsNp
	 EAGLHBPPr2TRTDZWkgN+d5rZrX17BUIBOsLdmDShiIoNSo4LK3puxUmYJQVuYgHGNDJHM
	 MxpxBHX8IwDe9LI0q3wWs8ZeHq8JTlocRX5VghU34SoCABUiiAa4gBHexMZRaPl4x7q8F
	 HBQIalU/7CG+ay+nHFPrClAqU/z61W23SkNkvn1k7F7QglkYHAX2Gz+lBeNe7oYft8X2c
	 mqcAxWWupxdiKa0fk1jB9VVLF2p+W4LcEF2vwSRgvG/KVSIvOXvYkeWKj/+RtUqxjtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxuON12f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD57606A321
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxuON12f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0181F000C0;
	Mon, 23 Nov 2026 21:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795467955;
	bh=vOD2vJ7TbA88wMLPsSBcEwTq4jpiqLQwBHGIeWEx7YQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxuON12fd2rioegG9XrYgqUjFitPcskTCcK0fIXtz2biM7DUMUVWoLp+W54k91IA5
	 QCf9ilsdT6DD7Yos0Cg1IOn1DJqTbbHkzh/fk+0DTuumNrGAjIseMrUdK6mSSiTiKP
	 PdQKf6gAfvlQZ6KChAJgFaAheLvKC6cWEyfRQqa0NuPYde+XNgb2OYBcy1aie33GIF
	 w4bm0wRPtlgcLH7yru3JtKNFvsOUt5WX/q3YIc4WFwtQ1HbBWPugZ/M0y4hlsjAxYH
	 aE29anG0MYj8aYTEe1oi51ww7bWvYZ0Rd+YrlY89/clepRTysh3Eg/u98+fcztyuyp
	 AE/hR+WUGMVlw==
Message-ID: <sashiko-outbox-230059@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: asm9260: Use devm_clk_get_enabled() in
 asm9260_rtc_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Elfring" <Markus.Elfring@web.de>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <ef3d0b97-e1ad-4924-b380-16a46fd17b94@web.de>
References: <ef3d0b97-e1ad-4924-b380-16a46fd17b94@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 21:05:54 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 23 Nov 2026 21:50:07 +0100
>=20
> * Reuse existing functionality from devm_clk_get_enabled() instead of
>   keeping duplicate source code.
>=20
> * Delete a clk_disable_unprepare() call on an error handling path
>   and in the implementation of the function =E2=80=9Casm9260_rtc_remove=
=E2=80=9D.
>=20
> * Omit the label =E2=80=9Cerr_return=E2=80=9D.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ef3d0b97-e1ad-4924-=
b380-16a46fd17b94@web.de?part=3D1
