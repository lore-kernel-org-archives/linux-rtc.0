Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14D43B3DE;
	Thu,  3 Sep 2026 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421620; cv=none; b=WQYMAeqBMyENsfRC6gVMQ3PtqNNPsildm7S45FGkT8i2pIB2N4zxpxoGyI2Dd+UY3qbIbsZrtkXRoTA5Luvb0YNSPMbtjSfCLu5mtykkc9rx0fbj1cOX2D3D4dsQUn6vZ7ZXe0km1Jq1sokFp8s95HF5iuHpFV2WEw6KaADxT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421620; c=relaxed/simple;
	bh=Cl0NZ3XpAP7HfxvIn/bTq7M/efP9DEVbCTug8RKQaHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajl3w27wy9GCgUG7BmjnqN9Une0N2IVfrkWp936sy5hkP4re3jET3BT77XIFWFw+rCKNA/E1wP0V4TMQfh3W3e16lRrpWfo++YNvZe3nxToF+Pt2esFAiloFMlTHZj5YZ06Oog+RdM0bw3+UtEIOK+NhB9nZTGCZvnWGQTuIaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jkg2wMsO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SDDldus3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jkg2wMsO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SDDldus3"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4R5tcvzIFsy/xQEdT5mJzi52ucmMu7YwKbCKoveVzY=;
	b=Jkg2wMsON1/8sRsHupBIMCoTq1VdSzHs2k2xOHeUOKINR1ncXNjkfIIdqaiOU0YYKIM9eI
	Rsn60txv9ulKbO7czvGfTA15JEq59w300G5ED6Heu1KXRSLispFCwkSd5M3SZRifAGKdhc
	7o6AmlR2gviSEIlSeDPUmJ23a/DY5clmzfxX3scSI0MvJ/eawC0YrejqYLZy1Bc71Wp+He
	6vY+KNVOJBd6Oun+FuzrRA7dRIrtAph/tNcS+AKY5DGO0o3jGtr0hqiRwunfeSKJEJEufD
	2muYuDjq6S7J5XD59LdjZtZDTd6DLWNdb6UpuqT/v10Q9YdfEANOd6RSJmZEOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4R5tcvzIFsy/xQEdT5mJzi52ucmMu7YwKbCKoveVzY=;
	b=SDDldus3VjMAxc51eHRue8WDB6/ESlzEWc1vCDCABIyXMdJLvRRL1iwriK568nscg1Nz3E
	Gj/wOahpWKnlJhCw==
Date: Thu, 03 Sep 2026 09:46:53 +0200
Subject: [PATCH 4/4] rtc: test: Remove test_rtc_lib.c
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-time-time64-to-tm-v1-4-660be972adfc@linutronix.de>
References: <20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de>
In-Reply-To: <20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421614; l=4664;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Cl0NZ3XpAP7HfxvIn/bTq7M/efP9DEVbCTug8RKQaHo=;
 b=BEdoLpCuJtsb3Ws4e141oeIV3LFNIv1TrQqDxWSijM/RkDSdN3Cylx1rtWb42fngJYqFmBSdf
 HCVvTxVlXZRArJiOycJBG4piURungwmhy+s7MCqJ04KkOe8vNuBcGzn
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
index 05b9233b9418..b507ed2f10e7 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -75,15 +75,6 @@ config RTC_DEBUG
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
index 0347645b021f..a3b336432df1 100644
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
2.55.0

