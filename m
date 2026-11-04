Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772065;
	b=zkaE7xntCkbUEh3eJgF1RfRXrcGUs2n0CiGdoxW2xVUQqwuBJJZronM9lbmEa9OoSbmd
	 rYENzXT6Dslb/YENbDRb0Ao8oUf91IdWfgOFMbgCqo/tJu6jFhbYDU2kwOnuArGa1nbZT
	 BIEDu1ojvtjVNcK9P/Ycwyjr9zefljfEDAlXuyAOFXf9W7Zy171rhNrquxM1qLxzXdf7j
	 D8sXBobkIoFoXiS7muuSVWtrDPrczPbsNBbT/xOeCrImFdslvcGCY0JrFkJJOWzfeWFLz
	 /MI/5jZkUYBagHknuDNHM4u2bZSEI/g167Yk5scp88VUF0t6Q95pjYVrNpI/kBI/Ddw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772065;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4K72cME3x8jToQbRol9x8CmEdANjWEgPvDSC/UmLPhg=;
	b=QIqXxMPcGWO5JaOTcUPMOMaKQjDmCa85yfCtK6U/4KjzbdyoDK1ECCBryPe2+i38R0vn
	 O3pBrk6I68XWmgyZs/pLbKjFzg5kHbMJKnl9QTOMiQbo8GScF9uAppwEFXFNDOPKuoOyq
	 xLMXypImLjXD5ig0acNNFF3wvl5+a6qcebxHlbMiHCrdpSK36o7Q3U6ylOaYd2vcbOLVl
	 Yj6ZibvWQA6CWbZgnLR0dYFbYt6HsnT6MVR6CJ4Nk6abfEz1PdrDql4kqkgpzfdYNevR/
	 nl36RiUsPpGgZaLkFio1hKTkytp7oTqGYkMGz7McWfZKtJVaeRGHp9qvDfTcbYZR/Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyZ9i5P4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B6606A31B
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyZ9i5P4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A421F000C1;
	Wed,  4 Nov 2026 06:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793772064;
	bh=4K72cME3x8jToQbRol9x8CmEdANjWEgPvDSC/UmLPhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EyZ9i5P4XumOKN1Yzbz6vTONiSKRYoclEIh7ieC1w6ctlmFIVjGsgq4eI1OMiFqVv
	 WX+lVdtyWCwch7PE3Ro33Z+jJvoAymc1Q5QxzOwJohrBzf/ZzrWBLy24OyJtsWI41h
	 La8Fdw+VEYLuLinYvWZDKMvFiJmyHYmXjYXoMx/xutIRpnUG9TkAv+0RNWRgL+O8yL
	 B7om65yoEDgavMV+lifyOWDYE2zGF/RuhLnpwz4bvXYk/C8PE6VZqPwB6rw6zRy96n
	 65BS8KpaTxijrSntHHlLSIwEtIe30kWPkigqJASQngTBvx3SNUlBqgGVr72Rt4OD8s
	 lG13B72GCANBw==
Message-ID: <sashiko-outbox-196713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/3] arm64: dts: amlogic: meson-sm1-odroid-hc4:
 Describe which RTC wakes the board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261104-b4-alarmtimer-rtc-priority-v1-3-e996681b8086@iav.lv>
References: <20261104-b4-alarmtimer-rtc-priority-v1-0-e996681b8086@iav.lv>
 <20261104-b4-alarmtimer-rtc-priority-v1-3-e996681b8086@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 06:01:03 +0000
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
> board from s2idle but not from deep sleep. meson-vrtc is a register the
> SoC firmware reads when the application processors suspend, so it wakes
> the board from deep sleep only, and only with a BL301 that handles its
> alarm.
>=20
> List the states per RTC, so that alarmtimer programs the pcf8563 for
> s2idle and meson-vrtc for deep sleep.
>=20
> Link: https://lore.kernel.org/r/20261020-hc4-rtc-alarm-irq-v1-1-b2b8c68d5=
4f5@iav.lv [1]
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-alarmti=
mer-rtc-priority-v1-0-e996681b8086@iav.lv?part=3D3

