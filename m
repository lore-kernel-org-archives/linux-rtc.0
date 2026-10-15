Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6084D2EC4
	for <linux-rtc@vger.kernel.org>; Thu, 15 Oct 2026 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086150; cv=none; b=O1DCprbOQWixnWpM7824EOjcm8zUdN930bqy5ETCCcs9gjGSLDYvTlQrM7KI+/4LZg1jrRGgJK6EUhwgvZdvVQfxpD1dnbLIO4OuJM4NH3Y/17bAlN26Do07cvkfK031IvKzD6h0th2tVJ/jx+H+xVVE5Kc2UbN2fQG/8ZdF2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086150; c=relaxed/simple;
	bh=jWw0MCnlNpCZnQ3XOTw9G+iIJhZdnpHppjTK+7/AtkY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KvHZqKDTT4kR/nl4Hjx1sZSQPECSZLANBIB1PsFyBBKeqmnDZ+YoyYUAa2bRvISwBfvSIMl7Mc9BaqVSttbgq9/LJOQRSwRePSJpAFmaGQ51atd4VGjCyt0dq81wTE67nPsvL4HOe4KzBpwaTv+rijqQxI0TBTD3uC4s5irxxbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5XnmcW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5XnmcW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E98E1F000C4;
	Thu, 15 Oct 2026 17:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792086140;
	bh=EJjFH2yJgQz1xwJZhAPJVil7MTvN+zp3bti7eX13GE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P5XnmcW7Yted50LCuff81kc5XM1q1x0BNZx9AdeMwo7nerHhXT1IYeDduFnufQkaV
	 zdW0o0xNNol/pSFS7kOpdnLbDfLQxVn4biS3OcofQaaB7kPQTrW40kNfmfd5fNbmn+
	 CxhB1KBiHVgFZwNcZ3FDVjSm1Alw9RoWBWoza8/s4viekEfHui5bNbgzd7R+ChFngP
	 NOyRF/zrz5IY5SCNgQIM5DT2oupTsQuXGwz0HAALyYxp3BTGf835rYPeX6gr1UneMP
	 MjQUlO9YXBrFLOOq4AgjgPsP3F5YMwy3kXiXP5b7H8hAL/x05oQsbe+wcZEdI7ARHw
	 gJCVv081RQyLg==
Message-ID: <sashiko-outbox-173261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH 1/2] rtc: cmos: Disable ACPI RTC event before
 handling it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261015173029.3091872-2-gourry@gourry.net>
References: <20261015173029.3091872-1-gourry@gourry.net>
 <20261015173029.3091872-2-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 17:42:19 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rtc: cmos: TOCTOU race in ACPI RTC event toggle leads to lost al=
arms
--

commit 73bcc5b0dfcf900941896af4381bb8051c9589e0
Author: Gregory Price <gourry@gourry.net>

rtc: cmos: Disable ACPI RTC event before handling it

Users of RTC_UIE_ON can stop receiving update interrupts when rtc-cmos
handles alarms through ACPI. Clear and disable the current ACPI RTC event
before cmos_interrupt() schedules the work to avoid a race where the handler
undoes the worker's event enablement.

> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index fa04ece151b8b..fe514b1aa3433 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -758,7 +758,9 @@ static u32 rtc_handler(void *context)
>  	unsigned char rtc_intr;
>  	unsigned long flags;
> =20
> -
> +	/* Quiesce this event before rtc->irqwork can arm the next one. */
> +	acpi_clear_event(ACPI_EVENT_RTC);
> +	acpi_disable_event(ACPI_EVENT_RTC, 0);

[Severity: Medium]
Could this unconditional disablement create a race with concurrent userspace
threads setting a new alarm?

If a concurrent userspace thread calls ioctl(RTC_ALM_SET), it acquires the
necessary locks and enables the ACPI event for the newly configured alarm:

drivers/rtc/rtc-cmos.c:rtc_wake_on() {
        acpi_clear_event(ACPI_EVENT_RTC);
        acpi_enable_event(ACPI_EVENT_RTC, 0);
}

While the patch successfully resolves a similar race with the worker thread
by moving the disablement before cmos_interrupt(), it seems to leave the
asynchronous userspace race unhandled.

If the userspace thread enables the event after the SCI thread has been
triggered, but before the SCI thread executes acpi_disable_event() here in
rtc_handler(), will the SCI thread mistakenly disable the newly set alarm?

This could cause the newly configured alarm to be dropped, as the disableme=
nt
happens without holding locks such as rtc_lock or rtc->ops_lock.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015173029.3091=
872-1-gourry@gourry.net?part=3D1
