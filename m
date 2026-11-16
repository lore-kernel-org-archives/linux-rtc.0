Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794789157;
	b=mv+OvxJpy370r7BseM7/SZg2ky/FZSabW56fHIxk/m+1ougEx+U0UBJ757ATlZAekc26
	 lry85vWV8LMlJjcMgniUIdVXZnCIhKxYshRiyuZvZqtEjDTivdi58W3VNNKU7P/AESfJu
	 NbSAhBjjj2td2xcFvlRmmWqSDIe8JELpJBQiweGeQiWwCMnnNgchHGveKwIeyiVlqTzqw
	 3IH5scyTWKI2+//BpGw244VxjkpUktT6Iad1rnYBSIZ6IzJrInvkwYa+B70HJoH2Rs3CX
	 sGp9mbjrUy4N6dooaMUo4AB56nPHrNfqnhNybl0AsOBc6t3YOwBzynCtEX9VkvU9+Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794789157;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3NYmLzxWRLdRJIkB/sr8O7Fs2gErBnGcgGGmw4E7Ols=;
	b=C5Bk8tVrkud8ovbsK9d2hiYHw/LVd2yjjYdxAA0/7T5DmLvHyrACf6695TFtl0fsIDIa
	 cBkiv0QGNePIaegzxL9h3aZpEGzcPldSdatkcZqFxiZ3JlAhXDXqVHZI+s5xGg0nd4l7N
	 rPzQ27XXzEWF7tAtrYDXfdnqIAQA4Kp4w+bqVHFLraA6F03yLD7NkgguX86kN63e2t9NQ
	 xd57zEdJkcZKGGx5c9XSPM+nLmKcQQZzx0LFwOj5OJMHRcTpt8oMqDN2VDJwVs+YQOf/z
	 HgyJhoIlWDEr35WO+niQLBQysCw7aBvOM7XX5ZH2BqAtS0LPJnwLet/N2RXU+8FnCkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxhXbuxW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DC7606A32C
	for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxhXbuxW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEF51F000C4;
	Mon, 16 Nov 2026 00:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794789157;
	bh=3NYmLzxWRLdRJIkB/sr8O7Fs2gErBnGcgGGmw4E7Ols=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AxhXbuxWWSLGpkgOGN5nDUUXXG6LqDbB3eB0pNUkWkqJmzHCJoBHShHPY5qm0hjDX
	 XAajczKnYH1dLdoNaw6nTLjNHEgRlGmC0BRNGJFcVtImCToakW6O5FlNfj46cuEn73
	 9yKAV8AG7hwojO4TXJNRuAHuuzJmH85QCN9X92d+wkAJsyRQ3mdrxfjCdY4L5S9nTx
	 n/4EANZA6p7Kns+A7tdR2xeiM1B0xNNJJYzLbd6MVwJPS+QqKmCu02bCcJU3MWi+yR
	 LuMYQgPO8xZPmTMjZ+fb3Zhl8atKS5orot5Biz4qDvN+vSLKQvmN96VUmW/5fD7olb
	 kSshkQzUWBn5w==
Message-ID: <sashiko-outbox-215949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] arm64: dts: amlogic: meson-sm1-odroid-hc4:
 Describe which RTC wakes the board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261116-b4-alarmtimer-rtc-priority-v2-8-b2c69721e489@iav.lv>
References: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
 <20261116-b4-alarmtimer-rtc-priority-v2-8-b2c69721e489@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 00:32:36 +0000
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
> The board has two RTCs with an alarm. The pcf8563 interrupt line goes
> to GPIOX_5, so once that interrupt is described [1], its alarm wakes the
> board from s2idle. meson-vrtc is a register the SoC firmware reads when
> the application processors suspend, so it wakes the board from deep
> sleep only, and only with a BL301 that handles its alarm.
>=20
> List the states per RTC, so that alarmtimer programs the pcf8563 for
> s2idle and meson-vrtc for deep sleep.
>=20
> Link: https://lore.kernel.org/r/20261019-hc4-rtc-alarm-irq-v1-1-078fc79e5=
96f@iav.lv [1]
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-b4-alarmti=
mer-rtc-priority-v2-0-b2c69721e489@iav.lv?part=3D8

