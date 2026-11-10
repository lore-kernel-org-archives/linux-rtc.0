Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295778;
	b=LJMQ34XxOFy+6y+LiR+7FS2VX/vlqb46jQfXsEQecIw+LyVzEi6wgzSqqmtur6kdXxNI
	 6qvuU5L5zp4DZkSHs563+Jyi6XNSp2nYcHu0u5LHIePBz++xysvpeLQCLFG5pfOJpTKmu
	 Dzxle+IvK0UAL6+3ZGqcEaBuYYX4r+/ns69Rh5MMY/2EOzE0j9C6o8BtW82uLweNTEWU8
	 dm+mYzVWltWtGN5yGQODOV+9VYn7Wxvr374G3g0Lz4ppvFZ5Ji2pcNo06hMIAdZkT63MV
	 nqvW54tDzAUkXxGQrEgZ70ZB2hUyfjxEMSEMyUDu5hvEvGgiE21C5souZk7NAnGXwsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295778;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CKmQf76ifmnIrMdNtBMEu2cMIO1jK1eTt6wFgM9KgRY=;
	b=wushOEtLZoxNs9bX1M5kXZ/N9xafYOs2W2v79/WITk611Dbme5jJg0fgJJEGUXrn37DJ
	 UK7Io05zWDjGNnW+etonzoU8+68t3SoJsAVCnwHTED2nbGcMJ4TY/HNdmD0C4U16gfozT
	 8skdlM0s1IYgq8yqMHpgcCShEui3AtIjAwxQ+C8Gi/9bCynJzcLIt+iGTV59YBr7yfjXM
	 N4pTkkS9y2ImDZ0Y70VlCq+0c+8yBbnDj156NR7apQZTFKspfoWU8Qnu/jxzbO8CNgOuC
	 Cy5z5U3bKWWKocuL0rkXPRhYQfmX0U4dgdLDObkZPPEEsGm+fUdNM7H5W54nmAqnxEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b1p/OpYS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7922606A321
	for <linux-rtc@vger.kernel.org>; Tue, 10 Nov 2026 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b1p/OpYS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263551F0089F;
	Tue, 10 Nov 2026 07:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794295777;
	bh=CKmQf76ifmnIrMdNtBMEu2cMIO1jK1eTt6wFgM9KgRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b1p/OpYSDq2Tm1332f/NCBGYOiBFbcXHRBWpToKZxBY5yZILkEHSmZH4fFaqd5G5a
	 vJ+O9qDUfefudcCExaNWuN9zhZq40LcNJK1HmGijerVHM/DxcruE7V0sLUNy3pYcN6
	 09/ywIxuYaN4ASjbzX7AC1KoIDNuvrPwoz8ZN3MDj8VwHSGK33g41UpoScqcG+42hv
	 ElL045vggBYH5AdHt4YmIY8Vq4DQUzv2GrUZThPytE45tKk5KybIWwksqn8reEwO2R
	 V9MhYlNOiYjtwu4WH5yyjDlwBkglvYblieJWj9kzRa/N06EUfOxuUyF4R9F2pwbqBD
	 wFNEH99qpJTMA==
Message-ID: <sashiko-outbox-206494@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: Don't lose a minute-resolution alarm that rounds
 down into the past
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261110-rtc-minute-alarm-v1-1-be9d7c5227a1@gmail.com>
References: <20261110-rtc-minute-alarm-v1-1-be9d7c5227a1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:29:36 +0000
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
- [High] rtc: 32-bit signed long overflow in 60 * NSEC_PER_SEC in
  rtc_set_alarm()
--

commit 4251dabe39af884c0054960d9c538feb4fe7bb5e
Author: Arun Iyengar <aiyengar1990@gmail.com>

rtc: Don't lose a minute-resolution alarm that rounds down into the past

This commit rounds minute-resolution RTC alarms up to the next minute when
rounding down to the start of the minute would move a future alarm into the
past.

> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 96626f8068f93..004819c9a846f 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -535,18 +535,39 @@ int rtc_set_alarm(struct rtc_device *rtc, struct rt=
c_wkalrm *alarm)
>  		rtc_timer_remove(rtc, &rtc->aie_timer);
> =20
>  	alarm_time =3D rtc_tm_to_ktime(alarm->time);
> -	/*
> -	 * Round down so we never miss a deadline, checking for past deadline is
> -	 * done in __rtc_set_alarm
> -	 */
> -	if (test_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features))
> -		alarm_time =3D ktime_sub_ns(alarm_time, (u64)alarm->time.tm_sec * NSEC=
_PER_SEC);
> +	if (test_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features) &&
> +	    alarm->time.tm_sec) {
> +		ktime_t down =3D ktime_sub_ns(alarm_time,
> +					    (u64)alarm->time.tm_sec * NSEC_PER_SEC);
> +		struct rtc_time tm;
> +		ktime_t now;
> +
> +		err =3D __rtc_read_time(rtc, &tm);
> +		if (err)
> +			goto unlock;
> +		now =3D rtc_tm_to_ktime(tm);
> +
> +		/*
> +		 * Round down so we never miss a deadline. If that puts an alarm
> +		 * that is still in the future into the past, the timer would
> +		 * expire right away and the hardware alarm would never be
> +		 * armed: whoever relies on it, e.g. to wake the system from
> +		 * suspend, would wait forever. Round up to the next minute
> +		 * instead. An alarm already in the past is left alone, it is
> +		 * handled by __rtc_set_alarm.
> +		 */
> +		if (ktime_after(down, now) || !ktime_after(alarm_time, now))
> +			alarm_time =3D down;
> +		else
> +			alarm_time =3D ktime_add_ns(down, 60 * NSEC_PER_SEC);

[Severity: High]
Does 60 * NSEC_PER_SEC overflow a 32-bit signed long on 32-bit
architectures?

NSEC_PER_SEC is 1000000000L and ktime_add_ns() is a plain macro addition,
so 60 * NSEC_PER_SEC is evaluated in signed long arithmetic before promotion
to ktime_t.  On 32-bit builds this triggers a -Woverflow build warning (or
error under CONFIG_WERROR) and wraps to a negative offset at runtime,
leaving alarm_time in the past.  The ktime_sub_ns() call above casts to u64
to avoid this; using 60ULL * NSEC_PER_SEC here would match it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-rtc-minute=
-alarm-v1-1-be9d7c5227a1@gmail.com?part=3D1
