Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704063;
	b=bX6QAoZ5kjr9lDziQ4yzXhCbWY/vjh36Yq+STfxIxL/zckY2z6WZ/NWdz0nxaVxkjItY
	 2fp/iBnn241j06jFKtFVt97pbg2fFqK+LeczpJEhm4Cqvb0XNCXVvx6vuPdR4CWX/1SvQ
	 UGNrBu7JWBEByerXhPhnfzx9fYSz0VD47ySGGz3dA2aXHrUTXaxLKeOMAEKPmZf67lKnB
	 7BvhlmAaSwIDMHDrlzGjbRpUJjcINbUcMVjY3b5SQO7qIvDvFkzLPmtLoiPEp2zmIREeI
	 aGwLbuAR3D0kDg3Td26ZwKzuUoNThnEfukmHOtJyyDj7AKjGEZf5kRmuuYf1/MACVBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704063;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NzTwyki8QkCnTK5WoEN90Y8xy3JOaZWGcNdKIlDLOfg=;
	b=5I69haT8BqcW5wRNdVuuQonjo5BrqmZQYYRD9dXQ27EGNLnEjtn/ONeWbyDlYYV13g7S
	 3fXlUVpwCyRW/RqqkwSgvIBm/zKsVFC36mqips39xS5/88pLnaQh5LKqsTCtIgxqH/YSV
	 M9pAiGysEK4QGuQGLAnTVlXEBAYueL/LA+x6PDnQ3Vz1CipK5dxmz81bJugnuHnc3H9n3
	 +MNdHR3Qq/ieszg+4giC7ucrPiuFQnsBUun0OPfxFma58b1besKzk0N9goYoWsT/x/Wn/
	 yB46pyLI9ycZNLlJdpCLPV7yVtZeLoTaHhsQ/ZBZiseP1wkdnd95SySQnfP5Boc6GKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knuOeq+t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBEA606C5DC
	for <linux-rtc@vger.kernel.org>; Tue,  3 Nov 2026 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knuOeq+t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CFA1F000C1;
	Tue,  3 Nov 2026 11:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704062;
	bh=NzTwyki8QkCnTK5WoEN90Y8xy3JOaZWGcNdKIlDLOfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knuOeq+tBM6LAR1/DzaudNQHKlU3jHl1bQXURgOLXE8aWN2FSeyXbIkgNnsTn0pOd
	 AwAm+YFof+P03PQNS78fZXe23WNSIhjNPtydygdm6zSJnCzF68Qj31gUTm9gqsMvfN
	 S90vV9YiGaw73VB/sQcJFTz09sQeM5B5AgbyuC03xzUPabW1+TWXPs3vbHwQ78x6Et
	 xLdzTMxupcGQ0BoKFGpGzlFjYv06KIWbx6z27YCXEzwL5+9tspG4VKq4rqPFM8+6d0
	 xyp/uN6rg3dhViGA/mL4b7DALqu3ZZUe5gOJXeMBZtk17iYSRo5gwbwIKUn5xSzmX7
	 oA5m60Jbi38pQ==
Message-ID: <sashiko-outbox-195112@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: m41t80: use devm for the square wave clock
 provider
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261103105808.1395292-1-vulab@iscas.ac.cn>
References: <20261103105808.1395292-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:07:41 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> m41t80_sqw_register_clk() registers the square wave clock with
> clk_register() and publishes it with of_clk_add_provider(), but neither is
> ever torn down again: m41t80_remove() only unregisters the watchdog.
>=20
> The provider therefore keeps a reference to the device node and points at
> m41t80->sqw, which lives in devm-allocated driver data that is freed when
> the device is unbound. Resolving the clock afterwards dereferences freed
> memory.
>=20
> Switch to devm_clk_hw_register() and devm_of_clk_add_hw_provider() so that
> the clock and its provider are released with the device. The function no
> longer returns a struct clk pointer, so make it return an int instead.
>=20
> Fixes: 1373e77b4f10 ("rtc: m41t80: add clock provider support")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103105808.1395=
292-1-vulab@iscas.ac.cn?part=3D1

