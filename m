Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA02C237C
	for <linux-rtc@vger.kernel.org>; Tue, 29 Sep 2026 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695840; cv=none; b=oIxXEafMIcU05jhXMnDvcPlMdqNxtiVcTzfdlW1D4hm7WwygZL2yCsydwJNinMEM0qbsO4fsVRhhjwYqKY7TpVrVHseN6nUUAfuhSztmJrAqGbvttVpZWAijmu4QzH1efO8OPU32YmsqGLT9HN1RF9CkhjUAzSIx6Nn0a/b+trI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695840; c=relaxed/simple;
	bh=kYzGx9n8yuES84EQxhIZd90FIEu7vtnu+GmBbiXaxug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MBu+nQUSWp62q4AEQiDO9b/AdmKTTPtgAZwQEjsriBr9S7iPRLIiMW6pb2U1lv+ZEMHH8YlZ5/sw9+TARQ1delyU3Ur9QWVAHp3jiJfx6Jkxpxzi93DelupdToQuLP1GulHycvn10S9vV1RnEW9z9H1tROsUo34r94cqPURTTsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5HXoohz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5HXoohz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CF31F000FF;
	Tue, 29 Sep 2026 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790695839;
	bh=ZhudZKR/fhpfZz6DyzeBPXTNdbNF5H2nW8Tc2qvvUqo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5HXoohzUc52ATI8mS80q+EgSqu2NpYWVWUAEWIxdqopsEMD5SrRSQjxmVuM1wDxk
	 vKvnYkU4wwBT06yTx3glCy3chQW+DSg0aBumisi23Nm7bljyBvpJncTOxXn2ZRDEv7
	 nhUnXyytvhNnp5z/O5TaMugkRF3Ndr4VwB2orRjYA8eNszGEjkAog//QvlIhOYgICM
	 q5dGmKO81Ha72A/xonMLnxs5j+rBs6gSpWPcPAstua/l/Ih+aDcg7Gn/Gk+4seMhJr
	 J6kCU0ZWJfNvKXb1QsKioZjO9DoeRLa90Ql9LHsIu3pPQOcYAyolhA80J3gy57DtzO
	 tOk5zstbK4Wpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] selftests: rtc: fix flaky date_read_loop test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wake Liu" <wakel@google.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260929152212.2092062-1-wakel@google.com>
References: <20260929152212.2092062-1-wakel@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 15:30:38 +0000
Message-Id: <20260929153038.E0CF31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests: rtc: preemption race between ioctl and clock_gettime
- [Medium] selftests: rtc: CLOCK_MONOTONIC does not account for system susp=
end
--

commit 470d20b138e75cc7483b890fe5b4c4fbcf96a62c
Author: Wake Liu <wakel@google.com>

selftests: rtc: fix flaky date_read_loop test

This commit modifies the rtc.date_read_loop test to measure real elapsed ti=
me
between iterations using CLOCK_MONOTONIC. It then dynamically adjusts the
test assertion to make the test more resilient against OS scheduling delays.

> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selfte=
sts/rtc/rtctest.c
> index 8047d9879039c..54eb5c255a452 100644
> --- a/tools/testing/selftests/rtc/rtctest.c
> +++ b/tools/testing/selftests/rtc/rtctest.c
[ ... ]
> @@ -126,25 +127,31 @@ TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURAT=
ION_SEC + 2) {
> =20
>  	rc =3D ioctl(self->fd, RTC_RD_TIME, &rtc_tm);
>  	ASSERT_NE(-1, rc);
> +	clock_gettime(CLOCK_MONOTONIC, &prev_mono);

[Severity: Medium]
Does CLOCK_MONOTONIC adequately account for system suspend in this test?

Since CLOCK_MONOTONIC stops incrementing during suspend while the hardware
RTC continues ticking, if the system suspends during the sleep loop, could
the RTC advance significantly without delta_s reflecting it?

Would using CLOCK_BOOTTIME avoid this regression and correctly track elapsed
time across suspends?

>  	start_rtc_read =3D rtc_time_to_timestamp(&rtc_tm);
>  	prev_rtc_read =3D start_rtc_read;
> =20
>  	do  {
>  		time_t rtc_read;
> +		time_t delta_s =3D 0;
> =20
>  		rc =3D ioctl(self->fd, RTC_RD_TIME, &rtc_tm);
>  		ASSERT_NE(-1, rc);
> +		clock_gettime(CLOCK_MONOTONIC, &cur_mono);

[Severity: Medium]
Could a preemption between the ioctl() and clock_gettime() calls cause
spurious assertion failures?

If the thread is preempted immediately after ioctl(RTC_RD_TIME) in iteration
N, cur_mono will be delayed. When this delayed cur_mono is assigned to
prev_mono for iteration N+1, it artificially shrinks the measured delta_s f=
or
the next iteration.

Could this make delta_s smaller than the actual elapsed RTC time, causing
the assertion below to fail?

> =20
>  		rtc_read =3D rtc_time_to_timestamp(&rtc_tm);
> +		delta_s =3D cur_mono.tv_sec - prev_mono.tv_sec;
> +
>  		/* Time should not go backwards */
>  		ASSERT_LE(prev_rtc_read, rtc_read);
> -		/* Time should not increase more then 1s at a time */
> -		ASSERT_GE(prev_rtc_read + 1, rtc_read);
> +		/* Time should not increase more then elapsed time + 1s */
> +		ASSERT_GE(prev_rtc_read + delta_s + 1, rtc_read);
> =20
>  		/* Sleep 11ms to avoid killing / overheating the RTC */
>  		nanosleep_with_retries(READ_LOOP_SLEEP_MS * 1000000);
> =20
>  		prev_rtc_read =3D rtc_read;
> +		prev_mono =3D cur_mono;
>  		iter_count++;
>  	} while (prev_rtc_read <=3D start_rtc_read + READ_LOOP_DURATION_SEC);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929152212.2092=
062-1-wakel@google.com?part=3D1
