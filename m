Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794901515;
	b=EkVncUFTbuOfeLwM5pCMVUrQH/RDhNlhFPf5Lv+1ev60eHI/Yu2Y4aIc+ixG72NMj/13
	 xM0OlcCZOOhSqo8I8rki8IAQ6P1dN7g+eQ6Xo7du7U6EW82yMyGUkjN7eIUNVJsXBEmje
	 nWqt4wzLT1PAWrk4O0aGJNw1Es8XatlGV0uIJXEO/fFwz1+h7/6/J/ADXmG9cu0qy2EJs
	 l6EWiRbQRbf8pDQ+7JZjBqznLSRD/xR8W2bNjdRtIO23DaZmj9j4cG5kv0FnWaIXGKbSg
	 /Xw82lbcZuTsKTk85Qez/+C6w0xmQmfxT0JYeEFjV//1a0lr9tlnORek2u2psggPeyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794901515;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tlFxJ8nVwFFmANKXAstpW+F8HlH473oONCsUsI8DEaA=;
	b=RcPF9IUoKTX1B493t0S7XpF40v2MyE8Qmj7t/TPgE8GL9wrSL7fuJ5TuckY5wd8bplpz
	 IYraLFJuGClU3bepHWDDTKALN9pPjAr+jlPMRs70dPonzTyrAgeeBTAXPJSXPqMzM5cSq
	 7XjPNbM4hGoEzXEWy2eBC86Bd10SDvdxWUJNqvwlm1/gLbsR7HBbHlXhvare45N6s6UWd
	 683SSqejbqLm5uaukzMdNmnuaeed9dEPRTGY/0g7xNJNnT41okJsfshMe9VgZtCstXcew
	 qiYrbFaLtjxD7tDC8VM8+YeEdmG3cykdXIn2wyPkhJj5GVvzEf9YNVKhEfv9266ioEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SA14nuop;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C495606A31C
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SA14nuop
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C561F000C4;
	Tue, 17 Nov 2026 07:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794901514;
	bh=tlFxJ8nVwFFmANKXAstpW+F8HlH473oONCsUsI8DEaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SA14nuopmjkYMpvtQFkzNHbXNWJX/LBT9Ei31ZLFCPOv/i68WBi4N3vsdRzW0lXNR
	 QiZcttXrd8UsNjQOdcSoYGTT9m1OgxyAPV7hlkwkgHk9S6VXty/3jxz08VLfewJU3t
	 uCtJRA2vLXg74I1k6lOkl5mRzWyyGd4e+9mFKBbZx6kMii2B4UMwGVsJKhw9KArOBL
	 o2+YlK2n8iMQMB/FK22W10AN9N+aGywvKZ+y9g9bG3mXAFqEFkKSqj3901x6+SAhsd
	 cDgzDCzB7ldBMq1yZAsli8ZP0tKZ3axPlhKeRaA+i4Pt2naowPbl1iGYc0hZMBeNL7
	 jNwDPRopPF5Gw==
Message-ID: <sashiko-outbox-218375@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] rtc: Add Qualcomm GIO RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261116-gio-framework-rtc-driver-2026-10-12-v2-3-b60e6fe33831@oss.qualcomm.com>
References: <20261116-gio-framework-rtc-driver-2026-10-12-v2-0-b60e6fe33831@oss.qualcomm.com>
 <20261116-gio-framework-rtc-driver-2026-10-12-v2-3-b60e6fe33831@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 07:45:14 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> On the Glymur platform, the GIO (General I/O) interface communicates
> with the SoCCP battery-management firmware and provides a set of TAD
> (Time-Alarm-Device) registers for reading and writing RTC time. The
> platform also includes registers for configuring an alarm timer and
> initiating device boot-up into different power stages, such as:
> charging only or fully powered-on system, based on the applied power
> source (AC/DC). However, repurposing this alarm timer has very limited
> value for an RTC driver because it does not expose an interrupt when
> the timer expires.
>=20
> Add an auxiliary RTC driver that corresponds to the auxiliary device
> created by the GIO driver, "pmic_gio.rtc", which manages the RTC timer
> by accessing to the TAD real-time register block through the regmap
> interface exposed by the GIO device.
>=20
> Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # Zenbook A16
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-gio-framew=
ork-rtc-driver-2026-10-12-v2-0-b60e6fe33831@oss.qualcomm.com?part=3D3

