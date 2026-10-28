Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793149847;
	b=q63uFGbKRo3qQ2ArQpHOCvbWQaoMjS/q3CMgoF2/rXPJ6bcr64aFGeVTo/NYND/C2Yjx
	 bWR5de6Gq1tp9aeDKstfORnZHcizb10yxGWIz63Iymy+7SjUPOpgLJIa0nw9UVyPMa8GS
	 jZapkkBBQL1eGzluc+x6dWIQKhPaI/AXtrBc0A8RBwhn3FjDArVtKmU4rS54VrswJg01p
	 dJD4eQyrJM/DrnAmpwtT61xB+rBdF1K3rmQuIw8H1yIhAOiwzSOsjVJBjP+KHDd/e9MXc
	 kWIJh12JkjSAMn8tSg4cCyE2oW0SZFwEfDtuC5tNmbS/2UEwfT63Phssoc1DhtaASmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=paD1Gs9oe5lBIAH8jeCBi+QZbXRKgvUx1PrQ7auYFV4=;
	b=uFHIVAZlwxfWBgqWIor6sVBxKds0DG2CxzCQt/ZGQP1Xl2hErJ9fQLld619ST5e7odVK
	 ouj5j6y0TaxX148jbI2lPL+Hvj57+7eXs8ZIP6ksaWgyhFYmryKk/4bHOCYNKjJT/KMMm
	 LTUpMzVWUXjg4k4dAjIl9o62my8ECejjbT/O9wRvChhPvSpQSjz8T0Mc8/WPbsnS/RYUt
	 f9WQMm2SGkfCMYEb4uOEtM0UtRP3sFWVazv4iu7+eRkclzP/kZAhgmcE7Q0/ziNiE8QJx
	 YZinyX+QSq6Oy6KD0ciWInr6+9s/R1NI4L/bpBPW7YecesVTj3/JZjJmpL2OCsN50lA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=boake.ca;
	spf=pass smtp.mailfrom=boake.ca;
	dkim=pass header.d=boake.ca header.i=@boake.ca header.a=rsa-sha256 header.s=google header.b=LUAnqYIw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF40606A31D
	for <linux-rtc@vger.kernel.org>; Wed, 28 Oct 2026 01:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DF40606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=boake.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boake.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=boake.ca header.i=@boake.ca header.a=rsa-sha256 header.s=google header.b=LUAnqYIw
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6f5a0893610so438778eaf.1
        for <linux-rtc@vger.kernel.org>; Tue, 27 Oct 2026 18:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793149846; cv=none;
        d=google.com; s=arc-20260327;
        b=HMrgf4X+oookKRHZMknYo2ewqWXjv0IVxZHkepJKMdYvOC2FfuvsGsGIZlxdpgyDRr
         cY8EN9Ag2ACCtYtZRsE8ncZ29qnQ7dBGZhJqB0K0dQoBIzCDXTij2xZvA01yx2W1Sy1D
         41iGTeBE5k9lvGXtH9F0OAq/fPzKvLwNAR/vj8ssw6w1Q/mrEq1EZDsAcyCJrRrFbsAN
         9BDwERhEo1b/fgbOCh6zk6rU1VU8O9+xX1pbVeuwpldzKhtsWUGZy/QLxbfrVJ5vsNQH
         qiQ4DzY3ETHA1WbPtmbPTLHBLe67jBDOhdHw0uWSDxfCCFIzS74iTcKvp16Tq39CL9zc
         D7lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=paD1Gs9oe5lBIAH8jeCBi+QZbXRKgvUx1PrQ7auYFV4=;
        fh=fUk/1fcVsbXn13aKnQq9EZqsD8vWR8tWfdCB+pr+h3Q=;
        b=Y/Ti/qBc1kVxmHUQCbWP/12Ca2l/ASHDkhHQKcHoM4TMkDXr4xl9yXc6/NaSVXtnRc
         A+u1YmCCg4AKmWEEbUhbDiuYjtGGpsamyBHSsAV5hI4IxUHUr9bcwzbEoTiSuy57KpEX
         fxps+pNbyyebjRh2oLFF1jdBVtpwKT6X1LGfL8QX4v25p2QQeCJN9zrB36lf9isXM2md
         rc6Tl9cTAoJZsFZqWBFskjVaIRUiphfpPtDZULMSbL/qVkWUJ/0S0LOqaUoB3AJfjla7
         sDV4IAPt5MPkYthU/FU+6NLI4Q8wtR71f428mkUM3zWjlgIuTrz+TLGM0TuomO5d6Ku0
         nhpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=boake.ca; s=google; t=1793149846; x=1793754646; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=paD1Gs9oe5lBIAH8jeCBi+QZbXRKgvUx1PrQ7auYFV4=;
        b=LUAnqYIwcHM4axKFXsYGb4p2e8zxx463azTpUQYicP211MhSvuyN04J/abZnXyyorF
         bYU1swzeJY//6CC3sCjQWquY4JSRLy+E+Q+nI8BauRlVy0USQbI59cyoYtkpLz0fGDWh
         +ddaZwyQ9qQFzrK882Q2hC/fIEqkbtf5/rVvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793149846; x=1793754646;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=paD1Gs9oe5lBIAH8jeCBi+QZbXRKgvUx1PrQ7auYFV4=;
        b=jMOQy3HgqKqLcBLzDjHwousC4cByZ6M/qkgQ0kXbHvgVG53nGWf/4AqTvyGuj3k5vh
         Y4PMwrLl2ZMmO18HKlELQuJ9JhrINt77abNEwymftO8t2Sv++EHg1l6JPaCtbqE/BRjD
         UEVMXHw2qlDbwznnAZyzVr6HbSwUAi8cJAcy+eUCJw1czHuoCJ97wL1lFB8QRqEXAWhn
         6Bcr9RGyOfGb8qrHwWDbFkaovdj3j0QMg1ChXtAMk8E4kDeUg8mBo71NU8uZuLd2Q+rz
         3BtTehiqqAJjMkESUykszizc2Pxi8k9pu0PtP2kqZHxjGTnUUJrzgOxVLPFlZa6EXHmC
         jPRw==
X-Gm-Message-State: AFq9FYKHKOntFFJYRH+XXpoLskty4XjY3+92Ywa7qaH7ZZWedMx54yBa
	+Ghr+oH5aZu7DQC40nFjywyVZW1nEthcfx8JaMRQ5HLtmrZjtx8od7kK44hjU6it7ecmZhhftw1
	AxIWiYwVGB6HstUndZ0ut3/CN/wXdimuNns23snnw1i5OpSAXqShXKyG+zg==
X-Gm-Gg: AYBFou2e83VKzFIKZVLaTI+OPPZRzyNs9wKcStWj+/Lb5IvaZE3+CoCQQK1uY3BHPJx
	BuRIOav8rrlzRck3ZpirR0cPDd00z+ksQygu3InKNw/3EOO4UzrRpjGD3CqJ7X+92FAthX7XHLp
	606dEbSm9kMlOvXndtmQ1lekcQYZ6jaAx5Q41pe+YdYEccC6rU7kQluTZgMG7foJOGjQmq3v1g1
	Wa4TYLHYBI6TNsfBRcUQdAYhvStBzaYDID9aQQUj/dWRTdc7W5N9wX9xuj12mtjw0xzA9/7yUzc
	H8FJlNLuXgCatdnSiVcyY5+3N0694iTRl6A+nB7dFbuqyOIM+TPju/+/J/t4XOZJEGEHxmGw+rV
	YtwB0HO4GChZDwGydW1HB6xmPD2cdBWJVsqHpoz/RZ7m29rpFQY5SYz/qU/vqZQIKuCOM7LLneJ
	mWeiZsfRj6qSQawoNp4UUQrBm/FSu5IArxxKfZug==
X-Received: by 2002:a05:6820:a293:20b0:6de:d2c1:e96c with SMTP id
 006d021491bc7-713efc0f973mr326258eaf.82.1793149846321; Tue, 27 Oct 2026
 18:10:46 -0700 (PDT)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Patrick Boake <patrick@boake.ca>
Date: Tue, 27 Oct 2026 21:10:09 -0400
X-Gm-Features: AclHuK8--JiPg3LimKbDZ81eROCACpkdU88EqTfjVO427bDfv9Lxg9qlOI0qcx8
Message-ID: <CAGzrbapmYnv-zMWrrEWF9n6yWaL9sjsRvfCDGamsesTDerr4bw@mail.gmail.com>
Subject: Re: [PATCH 0/2] rtc: cmos: Fix ACPI RTC alarm handling
To: linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Gregory,

We independently ran into a symptom that looks like exactly what patch
1/2 describes, on unrelated hardware, and wanted to pass along what we
found in case it's useful corroboration for review.

Background: this is a Panasonic Toughbook CF-33 (Intel Skylake-era)
running an unattended nightly wake (systemd WakeSystem=true timer,
hibernate, rtc_cmos.use_acpi_alarm=1). The machine ran this exact
setup for 62 consecutive nights (2026-06-01 through 2026-08-01) with
zero failures, every single one firing within a minute of the
scheduled time. The first-ever failure happened immediately after that
streak, and it's been intermittent ever since -- so this reads as a
real regression against a known-good baseline, not chronic hardware
flakiness. Every failure shows the same shape: the alarm write
succeeds and the readback matches the target exactly, but the machine
simply never wakes -- which matches your patch's description of the
race (status set, delivery disabled) far better than anything else we
found while investigating.

What we did, in case it's useful:
- Applied patch 1/2 (rtc: cmos: Disable ACPI RTC event before handling
it) directly to plain upstream v6.1.187 -- applied cleanly with no
fuzz, target function at a nearby line offset only.
- Built it and confirmed rtc_cmos initializes normally with no
regression (RTC can wake from S4, registered as rtc0, alarms up to one
day, y3k, ...).
- Ran a real suspend + RTC-wake-alarm test under QEMU: armed the
wakealarm 20s out, suspended (echo mem > /sys/power/state), and the
machine resumed at exactly the armed target second (kernel log: PM:
suspend entry (deep) / PM: suspend exit, wall-clock timestamps
before/after confirm exact match). Basic alarm set/readback/delivery
all correct post-patch.

Separately: our machine ran unchanged on kernel 6.1.158 for that
entire 62-night streak, then jumped to 6.1.180 (22 point releases in
one upgrade) the same day the first failure occurred. In that version
range, two separate follow-up fixes (6.1.165 and 6.1.175) landed
correcting an earlier commit titled "rtc: interface: Fix long-standing
race when setting alarm" (795cda8338ea) -- real evidence the RTC
alarm-race code was actively unstable across this range, though we
can't say those specific commits are our root cause (their described
issues don't obviously match our symptom on inspection).

One more thing, since it bears directly on whether we should actually
run this patch here: we noticed the automated review on patch 1/2
flagged a high-severity concern -- that unconditionally
clearing/disabling the ACPI RTC event could permanently lose RTC
wakeup events across a suspend/resume cycle -- and the thread's been
quiet since your October 2 ping. Our whole use case is exactly that
kind of cycle (wake from hibernate every night), so we'd want to
understand whether that flagged risk applies to a hibernate-based
setup like ours before we'd trust this patch on real hardware here.
Has that concern been looked at, or is there a newer version in
progress?

Caveat, to be upfront about it: we have not captured kernel-level
tracing proving our specific hardware hits this exact code path --
QEMU's emulated RTC doesn't reproduce the real hardware timing this
race depends on, so this isn't a reproduction of the bug, just
confirmation the fix applies cleanly and doesn't regress normal
operation on a widely-deployed stable branch (6.1.y). We also haven't
tested suspend/resume cycling specifically, which is exactly the
scenario the flagged review comment is about.

Full investigation is here if useful context:
https://www.google.com/url?q=https://gitlab.com/NetScr1be/linux-sysadmin/-/work_items/158&source=gmail&ust=1793200867534000&sa=E

Happy to test further if there's something specific that would help
move this forward -- including the suspend/resume case the review
flagged, if that would help.

Thanks for the patch.

->>---Patrick-Boake---->
patrick@boake.ca
+1-416-873-8770
