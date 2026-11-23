Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421163;
	b=0Cw7TNih2yRRYRPyGvhimToJ9PQq/DPbjU2R/+EbeTVJUMZHW4rChVW2fswuP8YaxGlf
	 LsQz4hueXmhL08pIdAj0xOHyqVnFFPn8TKFm+hNieFrcxbtsVYaJTUiWh8pUxsT2rz3/n
	 fLBM5urHCOpHQUE6y/A+RTbjQwVabfF+rIJ4MKrzsHQuGUtp3pEdx9Y2540SANK7UN5Y5
	 5hDLKMt1Yo8i/nZUrZ7vDkApPQZgs8BvxoJ3yZSkUua4Y1NYKewfKe6MUji22cGh1KR21
	 hyUpOzj/EEYFeqW1Q+MfRQvBDlatNl2IqBpVhrzr8NJJOXqDH+XRq2cOMk2gBKNUUBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421163;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=saRGmW0YdaPOf9B38hsjs9ddd9rhpPBqExqDY8kvRlk=;
	b=tqxVf8ZKI45taJwZzVQuXY4/lYGcPkMt4Bo1AtRS/i0Bxlyk8ruRkzn4wrZ+CbShR306
	 SRARgadMrWZd49vafIueeQJ+osgZE/Yw3FrVwXX8rWqBcueedRNvHFSKmP8O+hJOjUfyr
	 +NXVYyJ+yl1xUn4UKfmqKjRPkBPLtYgmf7pGG9GaRcw48c2qHqqrxNemgeiCbjRKC89PH
	 lqooLur+0XIrk8ddOtnjvFN6UeP9IDiMC19RE+swoXtTxms9SGNtF+MaOJf0Zh+iZjwQ0
	 29tRNvsonM+p42oqpBw1eFANwoaQkbYaGYCCNqIFTC6lSlvtl5vcepMfQnMPm6lnZ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pL0IIQpG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="MX0MH/kJ";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1F6070A0C;
	Mon, 23 Nov 2026 08:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EC1F6070A0C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pL0IIQpG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=MX0MH/kJ
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795421160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saRGmW0YdaPOf9B38hsjs9ddd9rhpPBqExqDY8kvRlk=;
	b=pL0IIQpGW6RGKxvEjbj559GaC+94KefHpITKEKpOSHIHOmeAmIRwlGm4u1MtF3YLgP+PFv
	f0f54JhTrjLep4dK2ozpgi4TW2UtoNqM8LFM9miMPFbuuf0knH8NyRv/2Nf6mxAymfLICY
	WryEk4NMYLD5TSMgLsELmALOuTsSlWKxuJCsLjIWIYrTl7jXq/W6vlvJIxxtjh8TeycE1h
	79MoQqMkCwnrtc3bo/QnKXJwmhYP+afhRXFBR/6hK200NAXBKpbGwjWvyrMqCR0MApPY6s
	fNSSOyBMtsIK2+azCZcErzk7HGXVUcDHXJeY8DaXuC1qunnfV351FL3RJEsjjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795421160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saRGmW0YdaPOf9B38hsjs9ddd9rhpPBqExqDY8kvRlk=;
	b=MX0MH/kJWzPwwpekIHeTeOTlfSas/vdKILMvnnId8WsY7f6kuMiNyTHSHPFRL+Sx7DY/pL
	ETKkQ/nmWppDmpBg==
Date: Mon, 23 Nov 2026 09:05:12 +0100
Subject: [PATCH v2 4/4] rtc: test: Remove test_rtc_lib.c
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-time-time64-to-tm-v2-4-117cf8afebce@linutronix.de>
References: <20261123-time-time64-to-tm-v2-0-117cf8afebce@linutronix.de>
In-Reply-To: <20261123-time-time64-to-tm-v2-0-117cf8afebce@linutronix.de>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Cassio Neri <cassio.neri@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795421157; l=4664;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lpLdoqurV8Q9KUZahlozvSDnmTawZdmVljIkY0BOJYU=;
 b=1wACDgoJITvKsWM2M4Ud8BBPebJ/N9M++3W6fCKobHLXpa6s1FSoQDYIll81cvWbSBGKFzoT8
 9X3UC9hDGmvDojh08WaEnJlhFkRMDHHDTk355+96ddBrJY8Gi9XKQkp
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Now that rtc_time64_to_tm() is only a thin wrapper around time64_to_tm()
the dedicated test is not necessary anymore. time64_to_tm() is already
tested with a similar test in kernel/time/time_test.c

Remove it.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 drivers/rtc/Kconfig        |   9 ----
 drivers/rtc/Makefile       |   2 -
 drivers/rtc/test_rtc_lib.c | 106 ---------------------------------------------
 3 files changed, 117 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 73ec9230edfd..3fd586aef1ec 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -96,15 +96,6 @@ config RTC_DEBUG
 	  Say yes here to enable debugging support in the RTC framework
 	  and individual RTC drivers.
 
-config RTC_LIB_KUNIT_TEST
-	tristate "KUnit test for RTC lib functions" if !KUNIT_ALL_TESTS
-	depends on KUNIT
-	default KUNIT_ALL_TESTS
-	help
-	  Enable this option to test RTC library functions.
-
-	  If unsure, say N.
-
 config RTC_NVMEM
 	bool "RTC non volatile storage support"
 	select NVMEM
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 46f1a0fc2416..51e2ca2d2a57 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -15,8 +15,6 @@ rtc-core-$(CONFIG_RTC_INTF_DEV)		+= dev.o
 rtc-core-$(CONFIG_RTC_INTF_PROC)	+= proc.o
 rtc-core-$(CONFIG_RTC_INTF_SYSFS)	+= sysfs.o
 
-obj-$(CONFIG_RTC_LIB_KUNIT_TEST)	+= test_rtc_lib.o
-
 # Keep the list ordered.
 
 obj-$(CONFIG_RTC_DRV_88PM80X)	+= rtc-88pm80x.o
diff --git a/drivers/rtc/test_rtc_lib.c b/drivers/rtc/test_rtc_lib.c
deleted file mode 100644
index 0eebad1fe2a0..000000000000
--- a/drivers/rtc/test_rtc_lib.c
+++ /dev/null
@@ -1,106 +0,0 @@
-// SPDX-License-Identifier: LGPL-2.1+
-
-#include <kunit/test.h>
-#include <linux/rtc.h>
-
-/*
- * Advance a date by one day.
- */
-static void advance_date(int *year, int *month, int *mday, int *yday, int *wday)
-{
-	*wday = (*wday + 1) % 7;
-
-	if (*mday != rtc_month_days(*month - 1, *year)) {
-		++*mday;
-		++*yday;
-		return;
-	}
-
-	*mday = 1;
-	if (*month != 12) {
-		++*month;
-		++*yday;
-		return;
-	}
-
-	*month = 1;
-	*yday  = 1;
-	++*year;
-}
-
-/*
- * Check every day in specified number of years interval starting on 1970-01-01
- * against the expected result.
- */
-static void rtc_time64_to_tm_test_date_range(struct kunit *test, int years)
-{
-	/*
-	 * years	= (years / 400) * 400 years
-	 *		= (years / 400) * 146097 days
-	 *		= (years / 400) * 146097 * 86400 seconds
-	 */
-	time64_t total_secs = ((time64_t)years) / 400 * 146097 * 86400;
-
-	int year	= 1900;
-	int month	= 1;
-	int mday	= 1;
-	int yday	= 1;
-	int wday	= 1; /* Jan 1st 1900 was a Monday */
-
-	struct rtc_time result;
-	time64_t secs;
-	const time64_t sec_offset = RTC_TIMESTAMP_BEGIN_1900 + ((1 * 60) + 2) * 60 + 3;
-
-	for (secs = 0; secs <= total_secs; secs += 86400) {
-
-		rtc_time64_to_tm(secs + sec_offset, &result);
-
-		#define FAIL_MSG "%d/%02d/%02d (%2d, %d) : %lld", \
-			year, month, mday, yday, wday, secs + sec_offset
-
-		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
-		KUNIT_ASSERT_EQ_MSG(test, month - 1, result.tm_mon, FAIL_MSG);
-		KUNIT_ASSERT_EQ_MSG(test, mday, result.tm_mday, FAIL_MSG);
-		KUNIT_ASSERT_EQ_MSG(test, yday, result.tm_yday, FAIL_MSG);
-		KUNIT_ASSERT_EQ_MSG(test, 1, result.tm_hour, FAIL_MSG);
-		KUNIT_ASSERT_EQ_MSG(test, 2, result.tm_min, FAIL_MSG);
-		KUNIT_ASSERT_EQ_MSG(test, 3, result.tm_sec, FAIL_MSG);
-		KUNIT_ASSERT_EQ_MSG(test, wday, result.tm_wday, FAIL_MSG);
-
-		advance_date(&year, &month, &mday, &yday, &wday);
-	}
-}
-
-/*
- * Checks every day in a 160000 years interval starting on 1900-01-01
- * against the expected result.
- */
-static void rtc_time64_to_tm_test_date_range_160000(struct kunit *test)
-{
-	rtc_time64_to_tm_test_date_range(test, 160000);
-}
-
-/*
- * Checks every day in a 1000 years interval starting on 1900-01-01
- * against the expected result.
- */
-static void rtc_time64_to_tm_test_date_range_1000(struct kunit *test)
-{
-	rtc_time64_to_tm_test_date_range(test, 1000);
-}
-
-static struct kunit_case rtc_lib_test_cases[] = {
-	KUNIT_CASE(rtc_time64_to_tm_test_date_range_1000),
-	KUNIT_CASE_SLOW(rtc_time64_to_tm_test_date_range_160000),
-	{}
-};
-
-static struct kunit_suite rtc_lib_test_suite = {
-	.name = "rtc_lib_test_cases",
-	.test_cases = rtc_lib_test_cases,
-};
-
-kunit_test_suite(rtc_lib_test_suite);
-
-MODULE_DESCRIPTION("KUnit test for RTC lib functions");
-MODULE_LICENSE("GPL");

-- 
2.56.1

