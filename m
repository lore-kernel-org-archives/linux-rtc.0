Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792557430;
	b=KYWeUqWHWcYP52z2imjAkdM+CHV1vtCwmD7EhKX6pp5AScgRT3dwXtWLqmfeQpGRHM+n
	 4Zeu8UI4Y0icN5SonR4CLoWtdt7a3Wn+xegc+ADKVOIgbtY22OcBYaWZjaNApsAcEcM0N
	 F0n5biJRanZsYPi1PidVep7333gnu6GZLZMNplScxo8ciVwMQniRyCmlqWXaXVAQjYgn9
	 PH7287BwfRJqgJHhfdmliL9LyTXhOTtbKSMEkFiMjl8pZG8zTQgVdoZjzFD98Zbultyc6
	 1v7sQ5GayGYEj4lsQO5mfxR8vWSef2M+YC9KuxwVisCvrHzIRc6mydFBrYU918ipwRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792557430;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wZWpAWViaV+xVAnYrK/uu0HWhyDZAfsarAsW+gCuEfc=;
	b=h6FrZAtgaiEGTTcNfBE3BQpY9u9nsKMK57tEUbPtiFchfjoIUf4npHIaFc7fC9/VW9Xr
	 sgUB+S7VIvpB/kqto7FbqYdI9+iXnDp2BP2jm9MQSCWMJhwvP3s4ykihgxzFDpVyUfC6+
	 UgbkC3kTJDUzoB8pmr+W5eUdwY2saiL9bqlWqXH6WWE7ZHaFVHmqsvCewy2UHRHOgqfsX
	 1ag68ydyrTDtRn1qvnZcdcygP55VIgo4Nt1F36h1CBElkikFHYZHW0EwYMNJ/fIOfZp1X
	 BmFG3DrPoYAwzsdr1TbvKofkaCIkIB/sG5jUThFzHKKA4luE57ba6BGcXiVwUv109Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyhButF8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326DF606A319
	for <linux-rtc@vger.kernel.org>; Wed, 21 Oct 2026 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyhButF8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654CB1F000C9;
	Wed, 21 Oct 2026 04:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792557429;
	bh=wZWpAWViaV+xVAnYrK/uu0HWhyDZAfsarAsW+gCuEfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EyhButF8bqHfWKeU36NsuqFVs5avoqmBfkmkMZ8RnMbeJU4iTilobyeMIUquuX7EY
	 /GnYrNzn/0xb8EBwiBDOLslsr4F55UL6QMR7vmld/TwC2pzGOeqGHiPzdxEQDOTXTl
	 Ir6CPBvbRixbtogI7ZbkjQb3WgNUxudCrY9yeWR2HBHeQsaBozmsQrl0VzGi3TvxqB
	 gns6ukZIN2v/YCf+RFrP3oS/Qo3ihm1CUIfQFJZIwOo6kk4Zs5h+/9SvoEnS3zeHfT
	 PRmzbH0OUdmck3JWI7EWoeAOoUB1Ox46NrJeqSk0EbzSqiQwaFn/PiKHQbDteBRkDl
	 LU5E8svM11ntA==
Message-ID: <sashiko-outbox-179788@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] rtc: Add flag for dynamic hctosys control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akashdeep Kaur" <a-kaur@ti.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261021042435.3895543-2-a-kaur@ti.com>
References: <20261021042435.3895543-1-a-kaur@ti.com>
 <20261021042435.3895543-2-a-kaur@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:37:08 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rtc: checking time_is_valid only in rtc_hctosys() exposes invali=
d RTC time
--

commit 378dbc5f51408e7a59e18fa3e61590784e92a232
Author: Akashdeep Kaur <a-kaur@ti.com>

rtc: Add flag for dynamic hctosys control

This commit adds a time_is_valid flag to struct rtc_device and checks it in
rtc_hctosys() so drivers can prevent setting the system clock from an
uninitialized or power-lost hardware clock at boot.

> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
> index 01ba04028f1f1..cec27c476545e 100644
> --- a/drivers/rtc/class.c
> +++ b/drivers/rtc/class.c
> @@ -63,6 +63,18 @@ static void rtc_hctosys(struct rtc_device *rtc)
>  		.tv_nsec =3D NSEC_PER_SEC >> 1,
>  	};
> =20
> +	/*
> +	 * If the RTC does not have valid time, do not set system time at boot.
> +	 * This can happen when RTC loses power or has never been initialized.
> +	 * PM resume compensation will still work via rtc_resume().
> +	 */
> +	if (!rtc->time_is_valid) {
> +		dev_info(rtc->dev.parent,
> +			 "hctosys: RTC time not valid, skipping\n");
> +		err =3D -EINVAL;
> +		goto err_read;
> +	}
> +
>  	err =3D rtc_read_time(rtc, &tm);
>  	if (err) {
>  		dev_err(rtc->dev.parent,

[Severity: Medium]
When a driver sets rtc->time_is_valid to false instead of returning an error
from ops->read_time(), checking rtc->time_is_valid only in rtc_hctosys()
leaves rtc_read_time() in drivers/rtc/interface.c returning 0 with bogus
1970-01-01 time to all other callers:

drivers/rtc/interface.c:rtc_read_time() {
	err =3D mutex_lock_interruptible(&rtc->ops_lock);
	if (err)
		return err;

	err =3D __rtc_read_time(rtc, tm);
	mutex_unlock(&rtc->ops_lock);
	...
	return err;
}

drivers/rtc/dev.c:rtc_dev_ioctl() {
	case RTC_RD_TIME:
		mutex_unlock(&rtc->ops_lock);

		err =3D rtc_read_time(rtc, &tm);
		if (err < 0)
			return err;
}

On boot before rtc_set_time() is called, any userspace read via
rtc_dev_ioctl() -> rtc_read_time() (such as hwclock --hctosys, timedatectl,
or chronyd), sysfs reads in date_show(), time_show(), and since_epoch_show()
in drivers/rtc/sysfs.c, procfs reads in rtc_proc_show(), and alarm
initialization in __devm_rtc_register_device() -> __rtc_read_alarm() ->
rtc_initialize_alarm() -> rtc_read_time() will all succeed and consume the
uninitialized 1970-01-01 timestamp.

Additionally, rtc_set_time() in drivers/rtc/interface.c never updates
rtc->time_is_valid to true once a valid time is written.

Could drivers return -EINVAL from ops->read_time() until ops->set_time() is
called (which already causes rtc_hctosys() to skip setting system time via
rtc_read_time()), or should __rtc_read_time() and rtc_set_time() check and
update this flag so all callers see consistent validity reporting?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042435.3895=
543-1-a-kaur@ti.com?part=3D1
