Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421547;
	b=2r7V2oS1usWM9N1028EoZAzda6KvrASXxKVA4Pgdnce9g2aHAw3gG+HXcYovyw5gozE+
	 MsCEC2XqXV+tfvTzXE8rLFRY+KAz7KRIpeyAP5y1OUoTvmDtXdyuEpwazXOXhH5V/QcwW
	 YrwXHqrk+OpMZ/YMOLr3rIOQ/e0L7DMOTUTUaGrs78aKGKRa+OGb1ceFYOBrvV9zTx4Se
	 8FZV1b5NDxrCBXWcjwTss44zIs86z4u6nv0K6HJU6TxUAhXwCyoPC3TvlO/nwW2+Lpiq9
	 jBSB8WHpvuo6cWhdaa8Q3LFso6sTXl58FJtbA3RwhiGESYsbWf/AD3uTmKW03Ni/WmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421547;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d9SQKySSV7Hs2cWeW/wcDJDgYmGqSnItY5sbikCT0cY=;
	b=M1iO3WF7yvrYUamjZV9xjFlHruBptxgK6iCXRyUy8NXIuY8ryVG3wY825m7ssMJ5zQwL
	 Vkpn9iUPpYHko+sUaQPHPlPO/pD1i+K5l6hy5ihqnSdk4A8ShAqV6jAa4Qf5EHX20FJUg
	 qf0fo2m/rCJqGKXU7mB7emjbkiH7Qau1deHaASi2Sgc7XLH0D1mnZMXDVJ9QdtMKbG7bL
	 rcJ3JkA70wTM+8EwrSCXumFf2zcFLuu44CRITiI+dKSQEbQWuD0GDgC2Syx2AuMzX9E5K
	 1VkFaOm7J33ZuXkT42NaNDGrih3RisWxX3Yega0CjsgRteFnRnIcLHBiZgtjb1TNAnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUVGv2WB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E5606A31A
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUVGv2WB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F200D1F000CA;
	Mon, 23 Nov 2026 08:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795421547;
	bh=d9SQKySSV7Hs2cWeW/wcDJDgYmGqSnItY5sbikCT0cY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mUVGv2WBB08IlcViyTfUAsTygNAxW+IHt7UPoYHtt45vAalCyURJpT8lJDCObH+Rc
	 j/WMdYF5x1Dpks/6qPcNNJXZfjCkYxi+BpNzvMChdwlKifo1ckpnwjIeJPwKp0DdtC
	 vK7xOZNX16MIKtZ9YvzZqEEDo2YXFVL/JNi1jaMOMyJlU0VKKsNpAddKE5DOA/kz9z
	 s/pHIpBmobfKk1uU7+VyOqV8RqrzLwCB0b2yavP+NEOUN3Tzy1b/1uIKHTFnRuvmwX
	 4rxQ2/OnhwYuePN61jwln/0J2SCzBwnTGg+uDZZJ6oo6v+/l93W9BbVIXY4wUcttVY
	 1k3H8DfNhHB7A==
Message-ID: <sashiko-outbox-228888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] rtc: lib: Implement time64_to_tm() in terms of
 time64_to_tm()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWggKFNjaG5laWRlciBFbGVjdHJpYyk=?= <thomas.weissschuh@linutronix.de>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261123-time-time64-to-tm-v2-3-117cf8afebce@linutronix.de>
References: <20261123-time-time64-to-tm-v2-0-117cf8afebce@linutronix.de>
 <20261123-time-time64-to-tm-v2-3-117cf8afebce@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 08:12:26 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] rtc: lib: unexplained noinline on rtc_time64_to_tm() and title
  typo
--

commit d52e75a7c141cd0560b1032f0c0041c5111a73da
Author: Thomas Wei=C3=9Fschuh (Schneider Electric) <thomas.weissschuh@linut=
ronix.de>

rtc: lib: Implement time64_to_tm() in terms of time64_to_tm()

This commit replaces the calendar calculation in rtc_time64_to_tm() with a
call to time64_to_tm().

> diff --git a/drivers/rtc/lib.c b/drivers/rtc/lib.c
> index f7051592a6e38..48a26b579b4c7 100644
> --- a/drivers/rtc/lib.c
> +++ b/drivers/rtc/lib.c
> @@ -46,110 +46,23 @@ EXPORT_SYMBOL(rtc_year_days);
>   * rtc_time64_to_tm - converts time64_t to rtc_time.
>   *
>   * @time:	The number of seconds since 01-01-1970 00:00:00.
> - *		Works for values since at least 1900
> - * @tm:		Pointer to the struct rtc_time.
> + * @rtc_tm:	Pointer to the struct rtc_time.
>   */
> -void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
> +noinline void rtc_time64_to_tm(time64_t time, struct rtc_time *rtc_tm)

[Severity: Low]
Why is rtc_time64_to_tm() marked noinline here?  Neither a comment nor the
commit message explains why inlining into callers in drivers/rtc/lib.c
(such as rtc_ktime_to_tm()) should be prevented.

Also, the commit subject says "Implement time64_to_tm() in terms of
time64_to_tm()" instead of "Implement rtc_time64_to_tm() in terms of
time64_to_tm()".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-time-time6=
4-to-tm-v2-0-117cf8afebce@linutronix.de?part=3D3
