Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EA94398F5;
	Thu,  3 Sep 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421620; cv=none; b=bxllHhuWVEwRLXIQqt8/UQrm/p95nF3DJYSLcg1PRk12iIO+BJDB72OtJPSo6p8W6TJRewqVZrYj2aPlAbXNYMCdfkYVskJ9e+nAl08ifYgQYx8Ptl1mNctOY4olYZhJCgXds+pU7AEPANWTeviqnTit5+MxThESDKHlW1Wc+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421620; c=relaxed/simple;
	bh=cR6f72Tfcuz3QSyNNEltgA9XJez2MtCdr8UsBuCs8+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWlplg9pYiQOZcJha5s2H2TYbwHSnS7wzdTq1kYNYsCYT2L8k4HqDME3Frm6Qr3OHDaTK26kGz9v13+AmJSo0kWKq+nA/q6andaa/cTTlqwFv/7ki0PIt7OxGdO6uMXX9KpQoYVmtwOr8Zq//gGDDpV2Pjt4VKQa2oU1dZD/eno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yatAfVui; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yEkP2wY7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yatAfVui";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yEkP2wY7"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL5wPnj8borcXzUO1qzOBq1eWT6u2thlTBhYgpzs9/Y=;
	b=yatAfVuirbklpD3FyReIw0vAzqXmxHRansse+Y9ipyzRWSQ+csWar6+AELYv+jWwiOaeXZ
	+5fxuwsSibM1PJyU2nEbdtuL4s++JzCSM2QcBAhMY/wFMEALFomPFQobzmzEYmbFfvtLli
	57lu3UYHsvIPJb0cPjfpLCphuZZR08GaYXv6s0N/AQFZVgGveN8G5zTZDN5zoXOGizTKKq
	LubjXGHtwhOIJIp9OROGi1rGOciHUOW1pTrWntIWybcO2tgG/o1mlutVdsF+owPJAbKtz8
	nG69xEvsz0lJYdaXbpyAIlrwRihba/INm96VFIrZNb35MA+KeaaO7oBzKwGDXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL5wPnj8borcXzUO1qzOBq1eWT6u2thlTBhYgpzs9/Y=;
	b=yEkP2wY7Rt2WlKV91o9jdnk9JRlhGqiJPXnrPDhN+MtBVWb5o89O/hkk+FZ5nsQrXGTFjh
	5i5V3YN5UO8XuGAw==
Date: Thu, 03 Sep 2026 09:46:52 +0200
Subject: [PATCH 3/4] rtc: lib: Implement time64_to_tm() in terms of
 time64_to_tm()
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-time-time64-to-tm-v1-3-660be972adfc@linutronix.de>
References: <20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de>
In-Reply-To: <20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421614; l=4923;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cR6f72Tfcuz3QSyNNEltgA9XJez2MtCdr8UsBuCs8+M=;
 b=UB2hO3nHk5ZLbpGzks+4GiEJFWhz1oKnhav6hzSO8rTNB4VWy2EhdtuDGsciDwIUT7gf0VYiu
 1YB9fLlVH9NBAKx9/DnYigNIdAlI+mkny9AkAjATAY7KYwxccDHST1u
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The core timekeeping code already provides a function to convert seconds
since the epoch to a 'struct tm'. This can be reused for a the
'struct rtc_time' conversion.

time64_to_tm() can handle a larger range of dates. It is also
20% slower, but this function is not a hot-path anyways.
On the other hand this saves ~600 bytes of .text.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 drivers/rtc/lib.c | 117 +++++++-----------------------------------------------
 1 file changed, 15 insertions(+), 102 deletions(-)

diff --git a/drivers/rtc/lib.c b/drivers/rtc/lib.c
index f7051592a6e3..48a26b579b4c 100644
--- a/drivers/rtc/lib.c
+++ b/drivers/rtc/lib.c
@@ -46,110 +46,23 @@ EXPORT_SYMBOL(rtc_year_days);
  * rtc_time64_to_tm - converts time64_t to rtc_time.
  *
  * @time:	The number of seconds since 01-01-1970 00:00:00.
- *		Works for values since at least 1900
- * @tm:		Pointer to the struct rtc_time.
+ * @rtc_tm:	Pointer to the struct rtc_time.
  */
-void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
+noinline void rtc_time64_to_tm(time64_t time, struct rtc_time *rtc_tm)
 {
-	int secs;
-
-	u64 u64tmp;
-	u32 u32tmp, udays, century, day_of_century, year_of_century, year,
-		day_of_year, month, day;
-	bool is_Jan_or_Feb, is_leap_year;
-
-	/*
-	 * The time represented by `time` is given in seconds since 1970-01-01
-	 * (UTC). As the division done below might misbehave for negative
-	 * values, we convert it to seconds since 0000-03-01 and then assume it
-	 * will be non-negative.
-	 * Below we do 4 * udays + 3 which should fit into a 32 bit unsigned
-	 * variable. So the latest date this algorithm works for is 1073741823
-	 * days after 0000-03-01 which is in the year 2939805.
-	 */
-	time += (u64)719468 * 86400;
-
-	udays = div_s64_rem(time, 86400, &secs);
-
-	/*
-	 * day of the week, 0000-03-01 was a Wednesday (in the proleptic
-	 * Gregorian calendar)
-	 */
-	tm->tm_wday = (udays + 3) % 7;
-
-	/*
-	 * The following algorithm is, basically, Figure 12 of Neri
-	 * and Schneider [1]. In a few words: it works on the computational
-	 * (fictitious) calendar where the year starts in March, month = 2
-	 * (*), and finishes in February, month = 13. This calendar is
-	 * mathematically convenient because the day of the year does not
-	 * depend on whether the year is leap or not. For instance:
-	 *
-	 * March 1st		0-th day of the year;
-	 * ...
-	 * April 1st		31-st day of the year;
-	 * ...
-	 * January 1st		306-th day of the year; (Important!)
-	 * ...
-	 * February 28th	364-th day of the year;
-	 * February 29th	365-th day of the year (if it exists).
-	 *
-	 * After having worked out the date in the computational calendar
-	 * (using just arithmetics) it's easy to convert it to the
-	 * corresponding date in the Gregorian calendar.
-	 *
-	 * [1] Neri C, Schneider L. Euclidean affine functions and their
-	 *     application to calendar algorithms. Softw Pract Exper.
-	 *     2023;53(4):937-970. doi: 10.1002/spe.3172
-	 *     https://doi.org/10.1002/spe.3172
-	 *
-	 * (*) The numbering of months follows rtc_time more closely and
-	 * thus, is slightly different from [1].
-	 */
-
-	u32tmp		= 4 * udays + 3;
-	century		= u32tmp / 146097;
-	day_of_century	= u32tmp % 146097 / 4;
-
-	u32tmp		= 4 * day_of_century + 3;
-	u64tmp		= 2939745ULL * u32tmp;
-	year_of_century	= upper_32_bits(u64tmp);
-	day_of_year	= lower_32_bits(u64tmp) / 2939745 / 4;
-
-	year		= 100 * century + year_of_century;
-	is_leap_year	= year_of_century != 0 ?
-		year_of_century % 4 == 0 : century % 4 == 0;
-
-	u32tmp		= 2141 * day_of_year + 132377;
-	month		= u32tmp >> 16;
-	day		= ((u16) u32tmp) / 2141;
-
-	/*
-	 * Recall that January 01 is the 306-th day of the year in the
-	 * computational (not Gregorian) calendar.
-	 */
-	is_Jan_or_Feb	= day_of_year >= 306;
-
-	/* Converts to the Gregorian calendar. */
-	year		= year + is_Jan_or_Feb;
-	month		= is_Jan_or_Feb ? month - 12 : month;
-	day		= day + 1;
-
-	day_of_year	= is_Jan_or_Feb ?
-		day_of_year - 306 : day_of_year + 31 + 28 + is_leap_year;
-
-	/* Converts to rtc_time's format. */
-	tm->tm_year	= (int) (year - 1900);
-	tm->tm_mon	= (int) month;
-	tm->tm_mday	= (int) day;
-	tm->tm_yday	= (int) day_of_year + 1;
-
-	tm->tm_hour = secs / 3600;
-	secs -= tm->tm_hour * 3600;
-	tm->tm_min = secs / 60;
-	tm->tm_sec = secs - tm->tm_min * 60;
-
-	tm->tm_isdst = 0;
+	struct tm tm;
+
+	time64_to_tm(time, 0, &tm);
+
+	rtc_tm->tm_wday		= tm.tm_wday;
+	rtc_tm->tm_year		= tm.tm_year;
+	rtc_tm->tm_mon		= tm.tm_mon;
+	rtc_tm->tm_mday		= tm.tm_mday;
+	rtc_tm->tm_yday		= tm.tm_yday + 1;
+	rtc_tm->tm_hour		= tm.tm_hour;
+	rtc_tm->tm_min		= tm.tm_min;
+	rtc_tm->tm_sec		= tm.tm_sec;
+	rtc_tm->tm_isdst	= 0;
 }
 EXPORT_SYMBOL(rtc_time64_to_tm);
 

-- 
2.55.0

