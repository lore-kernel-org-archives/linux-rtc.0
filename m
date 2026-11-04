Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772219;
	b=PELJKT3vKayrpVLA3td+WTPIgcEmQjtNvghQCCwAedBc/YoitG5mvMzw9RH9pVGkC3LP
	 nOkZbwqzeW1CX0j+9xfattmDSB9lfZ33UnDHrS5sAX9eGCbF3mTDBwSIfRvwVX4A+SaDM
	 mze3MWeiVJSPnbJJdsuE3U+cAOYP1Uyo/ztEudQ+4mqNLxpGJ2IfDthotx9sfM8Jg9DCm
	 ca4AudkSgEr3ZRki+gYUaLK3/nvMx9JsbO9Ts1Rt1Pp/Lblw1liZZIVBSlW4/CgMA33Ry
	 VnBlN2oAcQQNfvhf8dR5RoSv6aHbGDiU4h40O6XPwLFQW58zfC5AJGqu+dcAxtmX90A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772219;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LDjGaqQsu9j5jf+yQtyIOvQ8pl/g8hBed9Z/rYNKDNA=;
	b=m2XNa+1/yWdsya68CRTv7nnkRO38rELkD2IPVpE/fKF9RNoxQfCdwS3CSeFl4mR0vZOt
	 Gw0QE6HTxjdICm9rWaRsLVsfwcql9vaz05VJivbDUft7p8YDRjy7hVfHfTNrc/Y3M2OqA
	 HdAvTX4j+oSgzL4ZvYro2+DXOxtuD4bDNMPlhp806CU10zWWgMtt+kSyzrHOqz1nC6qTc
	 +PGvUOlzjyCLuKuEV44INDlXjkbX7Wy/ACn5UGAqFS8ilYZ+kUkj8FkQ2Ih8449HoKiXY
	 itiwp71dszRTMmynZBaaN+xHCuhkXxBuLIibZaZpK/PpnVQ2d/ntdKuW13/FmnI09+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZMG8ofw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124C606A31B
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZMG8ofw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E094C1F000C1;
	Wed,  4 Nov 2026 06:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793772219;
	bh=LDjGaqQsu9j5jf+yQtyIOvQ8pl/g8hBed9Z/rYNKDNA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZMG8ofwtJDdh0JQDFZt4tgTVEFunQRqnqHF6XrNSgTWjPhceF7r68U8HwbuNuBxN
	 dyb3bEGZ5RXgM1lcs7Gk4zEg4psYJXB6ZTU5PAE1kFuSo/zUbCd39nzeO+hJjBD7WY
	 3ecw02l9ZlXwkbtJLebvHxFxQjLgzOfZnjicFeNJO3y2o2Rulcy0Q5xWg1yszTd00U
	 9CDN8XLN7FZmt/NRlFmLohhdTZGsbd9iyjTpWmrqD4yBQNA2+MsYTwuysLFmozyQaB
	 W2yv6x2edfDTfhEkaquJEFl03Jjx9C2m6tdw6RSoQLZPsF/SPsiFNBa7n6yThmd0vj
	 T8lixK0rygohA==
Message-ID: <sashiko-outbox-196719@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/3] alarmtimer: Choose the wakeup RTC by sleep
 state and priority
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261104-b4-alarmtimer-rtc-priority-v1-2-e996681b8086@iav.lv>
References: <20261104-b4-alarmtimer-rtc-priority-v1-0-e996681b8086@iav.lv>
 <20261104-b4-alarmtimer-rtc-priority-v1-2-e996681b8086@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 06:03:38 +0000
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
> alarmtimer_rtc_add_device() registers a platform device under the first
> RTC that has an alarm and a wakeup-capable parent, and alarmtimer_suspend=
()
> programs that RTC. On ODROID-HC4 it is meson-vrtc, a register the firmware
> reads when the application processors suspend, with no interrupt in
> Linux, so an alarm set on it does not wake the board from s2idle; the
> board's pcf8563 registers later and is never used.
>=20
> Keep each such RTC that no earlier registered one with at least the same
> priority already covers, each with its own platform device, and read
> linux,wakeup-states and linux,alarmtimer-priority from its parent. In
> alarmtimer_suspend() choose, among the RTCs whose linux,wakeup-states
> contains pm_suspend_target_state, the one with the highest priority,
> registered first among equals, and program the alarm from its platform
> device only. That platform device is a child of its RTC, so the driver
> core suspends it before the RTC. alarmtimer_resume() cancels the timer
> from the platform device that started it.
>=20
> An RTC without linux,wakeup-states qualifies for every state; without
> linux,alarmtimer-priority its priority is 0. An RTC that an earlier
> registered one with at least the same priority beats for every state gets
> no platform device, so without the properties only the first RTC is kept.
> alarmtimer does not use an RTC that lists no suspend state, as with
> "none". hibernate and off count as no suspend state; nothing in this
> series acts on them.
>=20
> alarmtimer_get_rtcdev() returns the RTC with the highest priority.
>=20
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-alarmti=
mer-rtc-priority-v1-0-e996681b8086@iav.lv?part=3D2

