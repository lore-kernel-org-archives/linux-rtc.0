Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421162;
	b=j/YA2Dh5F8WCrU7FAs4vHBD2vukE93fBo5Ce9v3LDxFG16kpXC8NjP1MAqBTvtRXPlcX
	 FQ0qvChXgD+IhuLgPh+lS96yIhO1RV5xJAoZsglyDzfyv4tgdr1RPBtX2cVkEYr+tyrov
	 2opQFvvjH1pypbOO+g9H9Tb7Rqf5QKzOZMQ20dBf6uyMmqiIdj8x2BUog/rbXkCMs48gw
	 +ws+Fmq+nqXJLgD6iuW7i4N9pKc0wGgw58aptRqIotBUaGf7S6vvfQ71y25wmBwAe6+U4
	 rYo1uMcBBAuqKoCnqlou3JQMWGQ/ue7NPEn8zG7IOug9lGX8DR2xH/yiC2yvLSmdJ8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421162;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=2/WyowuDlwU3Vpqir6oMz1t4kUoGoxQnAwVtqFAIOS4=;
	b=Wef1XOzrNePzFhhyREODD4WpCuTEMQfC/PNbVizVmyQdp6y6oJuEEgqkCF+qkSoZkxgZ
	 cEiQj3+ZOfjBAn9DsK6ey8OpYXXP1ZktG/x3KBhSb/RM87u5ZtGTAjOvjRyusyxLvPWiH
	 K6qKwv29WgYTs36V1k/L/JmG6v2j4tl0xTkpKO/zjAndyvuvRLnGGM3q1Ixu5sf+N28f1
	 alJM7pI8FOeqOVOEltOrrDhtShM5+s9rhT3Ae/VJNFQeh/OgcFSzhgXfRdMK/pphFMKUT
	 QJjaKOQClBVHOO9TWw4/VFOwDl34NVdqUogNPV4L74hAKhKRLC+ZCb56CTYCUJU+jEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JE6ZAxmJ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Mju+JCal;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA72606DB7C;
	Mon, 23 Nov 2026 08:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAA72606DB7C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JE6ZAxmJ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Mju+JCal
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795421160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/WyowuDlwU3Vpqir6oMz1t4kUoGoxQnAwVtqFAIOS4=;
	b=JE6ZAxmJgy8V/S+ycHXkPv4cFMrWsmihW4hZ3NPhdReG+ZxZAo9/u8mEjPY2ApH18X0V48
	52vDZm2Eb9INY1UpLxDPn+pzvPkmDhM6mdOYpF4QLp1dsUwarfEvkuJw0NLrfFKwV0M3HK
	EZdryHPbqJTNxvO+cUaSEwOmy469clhD8eY4/LEUZwAu3GjF77YBIEQMMNEoMKvgkwT/77
	yNySvia+D0c9br1B7TOYTIjehbUGXRGDbNRVBdoSkYxnjts5bBdT+jfzGdzMvHFA98WWE0
	D0QQ8TGHYeM88XeVHr/z6y4PCy4ilkcpLgKDfBQBRABhzXIs1fDOKaCxE4oKfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795421160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/WyowuDlwU3Vpqir6oMz1t4kUoGoxQnAwVtqFAIOS4=;
	b=Mju+JCalhH+LE9n+atxBvlimCKzDu8kLQ4RZjUCwuqrUxi9Hn3HSeMaeWuigTUHtriRM5e
	9Uvs/rfX+FIkF8AQ==
Date: Mon, 23 Nov 2026 09:05:11 +0100
Subject: [PATCH v2 3/4] rtc: lib: Implement time64_to_tm() in terms of
 time64_to_tm()
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
Message-Id: <20261123-time-time64-to-tm-v2-3-117cf8afebce@linutronix.de>
References: <20261123-time-time64-to-tm-v2-0-117cf8afebce@linutronix.de>
In-Reply-To: <20261123-time-time64-to-tm-v2-0-117cf8afebce@linutronix.de>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Cassio Neri <cassio.neri@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795421157; l=4923;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=b5ErLZJMYDTYspIHmjRMR0gIi9U0Wye2qhnQtgSLhV0=;
 b=UlZFI7OMcwapjio7M3G92kG560gUKh6YESaUVDb4BcG17gyHoJNBCciiS22Zb0LVza2+DSq1v
 bcwNwfMTWRLB1SfI1DnRM94NywTuq4fOQ6hmIIFvp0jib6v145uva3Z
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
2.56.1

