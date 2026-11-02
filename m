Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793597825;
	b=qCSUKeAsdKn/hf1H7Qa6J2dV5Jhabj/uGzoTytI94DnkiIt6y03Z6ftcwbAxFcXfGdkm
	 Qxsm4QBY9faHs+ugoNMND8HAuRWW040eSqqKfPtAwp3FsIiU9qB+0JDeTyDkJAd1f0a7c
	 QjslZTOV8yWxIRumzAge64QDl6PxXQM5SGtwC509MhQIwiY6HUa4eY4kgy+ajF9geVpZk
	 9t/58+a9MC8CjT17Mgn9obNz1UtUVBvSpGLYH4PDtcrAg3Zal/BNxf/gGA5ufCdRzVUxG
	 wKdJPS4M24ZF5c5n5K2cyqqEmnRxVuGdykWFy+r3lSPjA5vFD60IG+T/fb7M3/hyq9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793597825;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HhCewSKEgwX1Cus/SCXdB9K4lboOHu/+xdFutYQtGRg=;
	b=X7N0tb/dwGYlR6+Jbc0/hA8t4h/ImakUJoQKvoeK7yI57MS+uke9tS4VmHVrsVwBrMp8
	 Bh3si089VlisRT0rMgNvRtxzZWamfMDSpng7Kz5J1hiV8G5rOxlJjWC42RAhw9OEalTwK
	 DrBHk+NncdyeOPTtyIfSYWhW+K29iE4gJW8+BzxSxe5kQhXtlvv3fTc5vpyoZVluM6RAw
	 8b70bLJeCHwg1V4FTmc4ePZZidP7xj8pXxpZ9MTcv3XF/HjLeZPV+81lv1tyQYIrTpBHk
	 q9aYxTOQYNnTt/XcCihYHT1ulya3Ckm+YtObCXqFqvrrInC0H5JN7Jr9gf22ankMVyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhn7zeE1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1E606A326;
	Mon,  2 Nov 2026 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhn7zeE1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BA21F000C1;
	Mon,  2 Nov 2026 05:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793597824;
	bh=HhCewSKEgwX1Cus/SCXdB9K4lboOHu/+xdFutYQtGRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fhn7zeE1CxFPy8bFF+Sy9r9y4qufbqfeGJQb//2xoJT1NMG+N2xI3JquH2XREBpIZ
	 z6T49yuvYFo7WbeiB7CLFAhcm483WIY+aJodUtiap4kYQ/j9V3jBtvhDBtNRHrvwp9
	 jvRG2sNudFE0kbg/lNInNc1Tx5Lm5buTWsYSyvK11M+XfbJqlP5YfjheneXBH5eFK9
	 OFXJLrcArt0P54clfVjdnkAteJ4VFhSQVHMmv6vp10vdCKfTL+W/hvEZY/SgR1c0iQ
	 k6ySk26lSdPMos+m7pouVaiKHZ1ITDV2HFzvM5nVVjCzUcwmlYFYZ8UiJFn7CDfFP1
	 NfxQLcik1evdA==
Message-ID: <sashiko-outbox-192926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: mediatek: mt6397: describe the
 RTC's 32 kHz output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: mfd@lists.linux.dev, linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, lee@kernel.org
In-Reply-To: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-1-9758f38d7053@gmail.com>
References: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
 <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-1-9758f38d7053@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 05:37:03 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The MT6397 RTC drives its 32 kHz clock out of the PMIC, where boards
> use it as the sleep clock of a Wi-Fi/Bluetooth combo chip. The output
> is off unless something turns it on.
>=20
> Let the RTC node provide it as a clock.
>=20
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101-rbrue-suez=
-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com?part=3D1

