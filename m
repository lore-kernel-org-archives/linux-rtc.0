Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033974;
	b=ewMTPYCTDN6h2/dguz3gdVCO/FDbex7/NU/Mbo98oO57Khf6XCUZ0Zf7Ov8SV6RnyGp1
	 DMkq4B5J6tSSOREacmKJJIxfgiG84Y3kHaqPiqsXHKPwrZ/IpSm1SBP5IlVdrr3K8c1ES
	 kmz+tk7Dr8sbmG+OnhNX2Ew9nPaDSI7r/Sqka/w7RCmElvwqshXYA32CbeIN5fvO9zVta
	 NI7xr6p1xmMRjIciwnrla8XHmrk44c7g8+P/HLt1nQS/z+XLg2EwJ7VQOT51YiN7wqB8z
	 w9iIY4VS4QEJVnjb2/LK1xB/itaCJ3ld3pw2ltuU7XpRyJKI4k6H7x6peJ9H6E6o32g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033974;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8WdPOtTne62VXduv3tm5a17ameYBfWg10C3v3boBMWI=;
	b=meCVLQ67+lyI9a/SginzfjAaw6YSrjlN2EAkS19sOwbJfeU/2Vkzqa3rkapXktVn3KWW
	 ubbahPdbzOe4jeEmj1l6Jv3G3wJ9BBFdg2aytQt3l3vK/+/Okor89ueVU8bX9/CIVq6AJ
	 g6EJdLRdq27vsg+FMc6LqZMD4ViGKFltQhM4TDiqz0moCup5oXtVeXDYjtyKqIz7KbJt/
	 cr7yB/VQBLF3j/c723cowdFpIoTT7zWzEH+dXO3ZIh4hKB+l3Dm3mjljy/RqeZAeZHJ9X
	 8bq5tRwh3+A3jWwCSGzozuGB/alqmAFwdld3gs1P2NcXFw9UytRxfffoegJuzT8DMBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSXeHOPa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C708E606A32D
	for <linux-rtc@vger.kernel.org>; Sat,  7 Nov 2026 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSXeHOPa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218261F0089F;
	Sat,  7 Nov 2026 06:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794033973;
	bh=8WdPOtTne62VXduv3tm5a17ameYBfWg10C3v3boBMWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cSXeHOPaopgWzbmREvydyA02UlGI24UTAbzqIMAxj69ptNz1MqPkYUBK97a7ERxoO
	 ygpg2ZC2jqbqj9+j69jbfBJ9/t1mL1+MAO7Th218kPUh20TZjJXXXg3bQ6o2Z48Mh5
	 jRH7FRY5ilAJmZYTKvP8Qq7QRq5e/bdCgEnwwmFscPRLJJxhRlz2Z/HGffyaZIrZdy
	 Sw9amlI5wn34VSyp8MtcUqHb785CyFTkkhz3E5BTCRZ+3DBXy6GGHJqjbSfrHfNQG8
	 Q6UiBJsHJMNzcwU0hIQwCTz+WV5sANl3YLb3jQpyb1hJJ3/LIpWINrFsOg2YcRSJJ0
	 QCNjUpmwvQSqQ==
Message-ID: <sashiko-outbox-202667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: atcrtc100: drain the alarm work before the RTC
 device is freed
Reply-To: sashiko-reviews@lists.linux.dev
To: hyunjungg <hj351016@gmail.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261107063711.3388440-1-hj351016@gmail.com>
References: <20261107063711.3388440-1-hj351016@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 06:46:12 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Hyunjung Ko <hj351016@gmail.com>
>=20
> atcrtc_alarm_isr() schedules atcrtc_dev->rtc_work (atcrtc_alarm_clear),
> whose handler obtains the atcrtc_dev via container_of() and dereferences
> rtc->rtc_dev (guard(rtc_ops)(rtc->rtc_dev)).
>=20
> atcrtc_probe() requested the alarm IRQ with devm_request_irq() *before*
> allocating rtc_dev with devm_rtc_allocate_device(), and INIT_WORK()'d
> rtc_work last with no teardown cancel.  Because devres unwinds in reverse
> registration order, on unbind the RTC device is freed before the IRQ, and
> rtc_work is never cancelled at all: an alarm interrupt arriving around
> unbind can run atcrtc_alarm_clear() after rtc->rtc_dev (and the devm
> driver data) have been freed -> use-after-free.
>=20
> Allocate the RTC device first, then register rtc_work for device-managed
> cancellation with devm_work_autocancel(), and only then request the IRQ.
> devres now frees the IRQ first (so it can no longer schedule the work),
> then drains the work while rtc_dev is still valid, then frees rtc_dev and
> the driver data.
>=20
> Found by code review; not reproduced (requires ATCRTC100 hardware and an
> alarm interrupt racing device unbind).
>=20
> Fixes: 7adca706fe16 ("rtc: atcrtc100: Add ATCRTC100 RTC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107063711.3388=
440-1-hj351016@gmail.com?part=3D1

