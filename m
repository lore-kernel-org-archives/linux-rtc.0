Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947027;
	b=oTWr0Gmah99IBCCNeXo9Iv4E+GEx5UCl84Q394t3TnQQ4npW4FubsaXLRtlT9WAAW4pl
	 Ux+PQZifm4Lkr2MxfFgsoHhY5qCCibHFo+88yrDIsN2EVdhcY5v2x4ffvVzQ+Uf1JZ3g5
	 tmsvnv9R6Zh30b+5k3B3xOGU+cE3E43h+Jc1vb37xT2T08xDkyIkuwta2V9zcXDkNMNsr
	 Rxr9RyHO+uX9h7XGe63t6Aa/Q4igKgRMUEEjj8wPL11ANPL2yPEoMTEevDnrliIe7x17g
	 dL6V0tZOhND46C8VHD42cJfmIfn1Bjmbzm42Bl6YG8iog1dry55fvtMiDirEXBEYswQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947027;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LSehxJHSO4IZ0KjN7H+HVEVl8V1ubTnjCki39y5VSPc=;
	b=sOtlpRotanVZrdZAwPfNLzvTa+AAmPfnhN9lj01FUCwNpc00ZcNSQyxcbF6IbyBcSDv4
	 xoIheZWTze5T7mM5W8s7XQksArgcVwuhH0XffTc1TA5JKnO5sC50F/1Pu+lslmhvJGKnw
	 RjWEJeAdwrx+tn1J1DFVvmn9Mj5YHSQvlAHVw64mAU3RDVT6PjfN8VKno6OTumd1tME5G
	 Wv4BUsTJiKxjIAFDfqHZ+XF0fBh8yLyhzXL+0aY/hPR9Z9xt/SgkZ0yeAerQRpcQGc8ZL
	 JdQj+BJRr/BXdPPNlIrmX2FFi8ag2pxUX5fz4N4pznyqYKzMSiMZbBgAPd6vsHPg3vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9qTpmSC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357F606A31C
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9qTpmSC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2943B1F000C5;
	Tue, 17 Nov 2026 20:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947027;
	bh=LSehxJHSO4IZ0KjN7H+HVEVl8V1ubTnjCki39y5VSPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D9qTpmSC6Ivnh6JIx34pZ9zRsVye/BiF25L0X0ExT1E4qyVphohNyb62H2Esa+t4L
	 mA+TJ4O8VMtJbJx1JVGyLmJXlM6qikXfS9Z+8QtWB/LQ5OEGNC150AX6l9bQfBdpQx
	 YcB7nxNgxVxhw1WVa7uQv1y5rQZ+Af4/ZfypNWm6IL+VUJbDu4V3cqG86L3eJ2S15C
	 S6L5Gufw3ROzzHNjGIj40Xfj88jEtSiLvev5mxmTvRlVDXrQEtJ5q50M8/gL2J7rIK
	 sJe316nkImDxPquPKojHZV/2cXxxxu7TZXZMWYxhiu326nXFUnwC5tuj8P7kRDYcCZ
	 jiI25zPxUykHg==
Message-ID: <sashiko-outbox-219594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: meson-vrtc: keep the alarm across the hibernation
 snapshot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261117-meson-vrtc-thaw-v1-1-b58a2c3919d3@iav.lv>
References: <20261117-meson-vrtc-thaw-v1-1-b58a2c3919d3@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:23:46 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Igor Velkov <iav@iav.lv>
>=20
> SIMPLE_DEV_PM_OPS also installs meson_vrtc_resume() as the .thaw
> callback, so the alarm is cleared as soon as the hibernation image has
> been created. An alarm set through the RTC (rtcwake, wakealarm) is then
> lost: with hybrid-sleep the system suspends with a zero wakeup time in
> the SCP and does not wake on it. The alarmtimer is not affected, as it
> sets the alarm again from its own suspend callback.
>=20
> Set only the suspend/resume and poweroff/restore callbacks, so freeze
> and thaw leave the alarm alone.
>=20
> Tested on ODROID-HC4 with v7.4-rc3, rtcwake -m no before hybrid-sleep:
> BL301 printed alarm=3D0S before this change and the remaining time with
> it, and woke the board on the alarm 3 of 3 times. Waking needs a BL301
> that acts on this alarm; the stock one for HC4 does not. Deep suspend
> still wakes on the alarm.
>=20
> Fixes: 6ef35398e827 ("rtc: Add Amlogic Virtual Wake RTC")
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-meson-vrtc=
-thaw-v1-1-b58a2c3919d3@iav.lv?part=3D1

