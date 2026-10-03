Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2838AC90
	for <linux-rtc@vger.kernel.org>; Sat,  3 Oct 2026 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791045131; cv=none; b=pTALJIitaVyuXRCFaf5VqTvZSdum8A40lfaIFgaVVObHG5RR63IaDophiGBH6RbN4GqRs5r9//makHH5LCHQOX25PDBUZgJFlHI3XppeE/2liyLms/isrR+6ifKaWbY0/F+Qt/etESPXJaYkjo4wkfZTEr9bVwkhMfbUsQAgwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791045131; c=relaxed/simple;
	bh=IhE3164pqnwDVlrLYLS5DuRzJZYRQk1UwOmjjl318Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gM46SZQaBNDVktf6TZW6Dz5Y6osj/EEBrrlLsKdoQ6y6pRj0TyQJAySI5Q9rQIY2RvAFsKs1a5MQ5TCBpDX5rAiGQ41bRWHW5TjBmNZgGjsBJH97dpWsf/GLxvLECGcfY06BI5c3x6MSoxGVmz6g9ocgDrzIIpiSdntKZ4/Qw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzDPfKwu; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzDPfKwu"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so2271365e9.1
        for <linux-rtc@vger.kernel.org>; Sat, 03 Oct 2026 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791045127; x=1791649927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ArphHShfkBLQGM2MhWD9bg0FR3KYRMbbt9Y3FJHC1jU=;
        b=QzDPfKwutN48jYPIWv8nCEEFmyln03RYaeOVha34Z9E2j+8Us+7OlSHhJuqnOYbkLR
         MXB3w72Uaj8MxkPAw/ttTV4Qqt+zUyAgmIFVqVx7XHVzRNcR7E4K9nVDhkGHL1tuuF6y
         gwGifsvmBGH3y5A8ip9s1RiEd4pg70nx1l02ewCU7zof5W40xvL9+fZ4DLPNlrESB4dz
         nsbsKv4VBYvM0bmhoBJJEyCEMl94jZrYmhdlV2cs3dP86LtiZ41MW5ABrwsF/msa3nXC
         mCa0BGl0KSQsvwySlSqHyE0SpqmtOJ7veN010p6dDziGvmjTZaN+7t+T9D0BzuFArLcM
         zcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791045127; x=1791649927;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ArphHShfkBLQGM2MhWD9bg0FR3KYRMbbt9Y3FJHC1jU=;
        b=fGw5awE2aHmUCXQ0yA8iczz8ctx/0+Tx2lmVH3AFAzcZhUWkN2fD+OH9o3FTQa7E1k
         LyYAcbP0F5F0VcdQknWFjdlBL0+EwyfFYq5/uiDn3pwDlNvjaldR+J3LbmT6b8qguqij
         QFdYE+56S6uiLQJyW8wldoxnDTbzqjkQy386e6MpU34fCPE9g9rfFtz50z8CtNkkYzLS
         25M+3a2bvp2Z6J06VST16yNZdK95WlqPWl3uv7XIynIk01rPCJtReCCHSOiCdDsMGIeD
         t1c5TbK3kzVD8Z3ZuBu0FrpOPvUZCVy98B7qi4nylkUJmC3zHe2bm5kq0640QGqw92nL
         VSWw==
X-Gm-Message-State: AFuF++mVxj0b9DCC2kbQX5Qvla03hjDW4jL+Mo0X7NVh7dG6UNxHWFFF
	ROCR9grfEJZxVokDzvCSugp60bi3wWRq0N2bXzMCG4OYL1/siYjeKW+z
X-Gm-Gg: AYBFou1AO6kgu2EOnAGUqxL0FGICYYPCafBGbDMZwLsh3hQQK9DgXtkEjbXM8J+W5Lm
	T9AMvZqo1tRixpINiVebGENgGTAYX6RjY7eFSnTZ/+hXCi+qqyTi46QRI4HLfCKs9hxbuUzs2rg
	UcHuvthOIenwh5wHeM7gXiBfFjrKMdB3yF0LxYscTSiXndtm9+CwoXdE0fK4hkhIW9KvObVru6h
	mMHkLpp2fZFpYt1H01MVDzC7gHRE/J2T7TngidCaLQju2kOWApAAbB3Ry6/7jIxgLJu82aUoc4+
	XQ5n3dzNQyZVSyImEqzCRyOnzIMIKTzE6ctek9AupJSCx3JuZy1cmyGg0+Udt9E1lCPSjuD7ZAu
	LuH8WUOvPX9TGdAArbszk2dc2C37ALep1ICOaz7zTSUwUGwWz222d/VK+8iF73PNvb3B7FrDPk5
	rIGDyoYbSR6P8mfFbwFSjNeNKcBd3DTpzPsvkuxiXiVqgbn/33NFNCs/KVTT8ue07B8A==
X-Received: by 2002:a05:600c:3e19:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-4a027534b98mr105166935e9.3.1791045126570;
        Sat, 03 Oct 2026 09:32:06 -0700 (PDT)
Received: from fedora ([77.92.21.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0e1afbc44sm174308795e9.4.2026.10.03.09.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 09:32:06 -0700 (PDT)
From: =?UTF-8?q?Alperen=20K=C4=B1l=C4=B1=C3=A7?= <sabri.alperen03@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alperen=20K=C4=B1l=C4=B1=C3=A7?= <sabri.alperen03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rtc: class: Do not inject sleep time without a suspend snapshot
Date: Sat,  3 Oct 2026 19:31:38 +0300
Message-ID: <20261003163138.14221-1-sabri.alperen03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rtc_suspend() returns early when timekeeping_rtc_skipsuspend() is true,
which is the case on every system with a persistent clock. old_rtc and
old_system are then never written and stay zero.

rtc_resume() is skipped under a different condition,
timekeeping_rtc_skipresume(), which is only true once
timekeeping_resume() has injected sleep time. timekeeping_resume() does
that if a nonstop clocksource reports elapsed time or if the persistent
clock is ahead of timekeeping_suspend_time. If neither holds, it injects
nothing and rtc_resume() runs. With old_rtc and old_system being zero,
rtc_resume() computes

	sleep_time = new_rtc - new_system

and injects it when it is not negative. For an RTC kept in UTC this is
about zero. For an RTC kept in local time east of UTC it is the UTC
offset, so CLOCK_REALTIME and CLOCK_BOOTTIME jump ahead by that amount.

This happens with suspend-to-idle on x86. The persistent clock is the
CMOS RTC with a resolution of one second, and the TSC is only flagged
CLOCK_SOURCE_SUSPEND_NONSTOP on CPUs with X86_FEATURE_NONSTOP_TSC_S3.
timekeeping_suspend() and timekeeping_resume() are called for every pass
through the s2idle loop, and when the last pass freezes timekeeping for
less than a second, the persistent clock may not have advanced past
timekeeping_suspend_time.

Seen on a Lenovo ThinkBook 16p G5 (Core i9-14900HX, s2idle only) with the
RTC in local time at UTC+3: on some resumes the system clock jumped
three hours ahead and chronyd then slewed it back for more than a day.
A kprobe on timekeeping_inject_sleeptime64() shows the call coming from
rtc_resume() with a delta of 10798 seconds.

Record in rtc_suspend() whether the snapshot was taken and return early
from rtc_resume() when it was not. This also covers the case where
rtc_suspend() failed to read the RTC. The device name check moves in
front of timekeeping_rtc_skipsuspend() so that the flag is cleared on
every suspend of the hctosys device.

A freeze too short to be seen by the persistent clock is not accounted
after this change. With the RTC in UTC the injected value used to be the
sub-second difference between the RTC and the system time, not the time
spent suspended.

Tested on v7.3-rc5 with a script that shifts the system clock by less
than a second relative to the RTC and then suspends to idle with a wake
alarm a few seconds ahead, 30 times. Unpatched, 4 cycles jumped by the
UTC offset, each of them with timekeeping frozen for less than 0.9
seconds. Patched, no cycle jumped although 6 of them met that condition.

Fixes: 0fa88cb4b82b ("time, drivers/rtc: Don't bother with rtc_resume() for the nonstop clocksource")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2543517
Cc: stable@vger.kernel.org
Signed-off-by: Alperen Kılıç <sabri.alperen03@gmail.com>
---

Notes:
    The jump was found and measured on my own laptop (suspend hook log in
    the Bugzilla report). An LLM assisted in analyzing the RTC and timekeeping
    resume path, writing the reproducer script and drafting this patch and
    its changelog. I reviewed the change and ran the reproducer on unpatched
    and patched v7.3-rc5 builds myself.

 drivers/rtc/class.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 01ba04028..c1a949252 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -96,6 +96,8 @@ static void rtc_hctosys(struct rtc_device *rtc)
  */
 
 static struct timespec64 old_rtc, old_system, old_delta;
+/* Set when rtc_suspend() took the snapshot rtc_resume() relies on */
+static bool old_rtc_valid;
 
 static int rtc_suspend(struct device *dev)
 {
@@ -104,10 +106,12 @@ static int rtc_suspend(struct device *dev)
 	struct timespec64	delta, delta_delta;
 	int err;
 
-	if (timekeeping_rtc_skipsuspend())
+	if (strcmp(dev_name(&rtc->dev), CONFIG_RTC_HCTOSYS_DEVICE) != 0)
 		return 0;
 
-	if (strcmp(dev_name(&rtc->dev), CONFIG_RTC_HCTOSYS_DEVICE) != 0)
+	old_rtc_valid = false;
+
+	if (timekeeping_rtc_skipsuspend())
 		return 0;
 
 	/* snapshot the current RTC and system time at suspend*/
@@ -119,6 +123,7 @@ static int rtc_suspend(struct device *dev)
 
 	ktime_get_real_ts64(&old_system);
 	old_rtc.tv_sec = rtc_tm_to_time64(&tm);
+	old_rtc_valid = true;
 
 	/*
 	 * To avoid drift caused by repeated suspend/resumes,
@@ -153,6 +158,18 @@ static int rtc_resume(struct device *dev)
 	if (timekeeping_rtc_skipresume())
 		return 0;
 
+	/*
+	 * rtc_suspend() takes no snapshot when the persistent clock is in
+	 * charge of the sleep time or when the RTC could not be read. The
+	 * timekeeping core still asks for sleep time if the persistent clock
+	 * did not advance, which happens when the system was suspended for
+	 * less than a second. Without a snapshot there is nothing to compute
+	 * the sleep time from. Using the stale old_rtc and old_system would
+	 * inject the offset between the RTC and system time.
+	 */
+	if (!old_rtc_valid)
+		return 0;
+
 	rtc_hctosys_ret = -ENODEV;
 	if (strcmp(dev_name(&rtc->dev), CONFIG_RTC_HCTOSYS_DEVICE) != 0)
 		return 0;

base-commit: e767a4ea70a3992c37ed604157d32f0dfbf9b1e3
-- 
2.55.0

