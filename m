Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467953;
	b=yOZwZ7aZAJxKvqYvpP444gL5vcNhS+z1hsD5nJ6loMxFXY9ABtaUZFCssaIDtCtLdVcY
	 O05nABF78S53IiMWmjEUc1Lx/yG7w7u0tnD8MfVOoUIphunz3TksYR0KqFLrBV2Tbneoa
	 1MU03t3c4SnQH4YWnBR3GI0yvuDvjBrI44XsGnasckHprMued4uDr3p4wr0qQBdJ8M5ho
	 7mIUKJbGpp45WNlu5WisH6Nv9VjTfA62VGu3WaJ05lgl7exMRjgHw/x0OlmqJBMc7AxHq
	 DROkuuCSU/6JUgKUcrFUSFMECLqp0LnQ826v2MrWBdAPivU6NwBkiB2zl6Jf8UfyneA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467953;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Dl3Ak9i3mlwH/cuGK5GS0z6gksSR/oIuRBryzuYIWRw=;
	b=ObMmYtsPA36A61+vaTdyGd0dmMAJsBWqNL8oHupltosYC8Gsi1XrOlNRJi3MJ/cPgfOH
	 56sluxmpd/UZ14Ndp9gMo7p5SXAkmdckskgIBFMlXcRRiiyZsHFEUgZujIEMYV+9RLAfi
	 pJFC7zxlV2H+LcexyasPs7A3T7SowMemPN1hzV+qB4cv7yjIEamJrtQh1u/UHDC/FZhJn
	 5nnaGVD9mXJ27h9JE68Uro3UxkWiO79qLNhXubqV/jV3n35kZ+XfBZAhcn555wMhd7eJ7
	 V+/F7nWtQIVlCfH2YDspk61mTJ1KpAMoNWNkH+aAVw8Yh7jNFNYWrH1N9L6JgLncZgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SlV1R3RU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7EA606A321
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SlV1R3RU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C24B1F00A05;
	Thu, 12 Nov 2026 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794467952;
	bh=Dl3Ak9i3mlwH/cuGK5GS0z6gksSR/oIuRBryzuYIWRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SlV1R3RU15IdVkURl6X0qlKSaMtboo8TNFIwyp9wzfST79pdlB7scObsgTWz0fBHz
	 owEtye7Ev1UDVt4btv+VyL5lNpPEs1YFyvnPeTWW8v+6yYxawir7TldJm1gUyvQvwG
	 LoFxQlZwgRzeavZMSqmSOJrHhaflUtpvB9jfDPOcEEoeliy+d6WUvX9+yvZdAr3ww/
	 Dn4WakHCjiP9RUcqj0eekRUCpYfEbyQ/1fze1j2AWAlVSI3EDhhsphGS4UFiK7KUQB
	 LBxW4+Fj1zz8ACxsjcpge1HaBrDNimysCQ3CGquugJvE6DvgZc8ifoZF9lPar6dFtg
	 EDTK8a4Ze2dUw==
Message-ID: <sashiko-outbox-210587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ds1307: Check the calibration register read result
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Jun" <zhujun2@cmss.chinamobile.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261112071627.154412-1-zhujun2@cmss.chinamobile.com>
References: <20261112071627.154412-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:19:12 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> m41txx_rtc_read_offset() ignores regmap_read() failures and calculates
> the calibration offset from an uninitialized control register value.
> An I2C transfer error can therefore be reported as a successful offset
> read with an arbitrary result.
>=20
> Return the read error before decoding the register or updating the
> caller's offset.
>=20
> Fixes: 79230ff64167 ("rtc: ds1307: add offset sysfs for mt41txx chips.")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112071627.1544=
12-1-zhujun2@cmss.chinamobile.com?part=3D1

