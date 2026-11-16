Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794788711;
	b=uJMbdInIFpd/XEjxAGKIFqaURr6UZVqOkr5kV/EIVGXXqt4fVtYIorAUaJAZJfrPZMde
	 xqdT6CBLDxzRquMpiTtcZzrSDHwquYrjdYjnrLRF4ocr9A5EdR/+KRerAmzAgpulB5qmp
	 hIxYLAEBNq77oEcDAYwViFPJrDn4QHl99U0sHyQTI+DVu67eUJEbds6Vy6CTz+vL15e2S
	 nPzf2F5uhNox5DhakN2T2rzd2N1b9cc7770K2sWwkycHHj3pOY6i5/v0CXmdhraTZ+8q7
	 FWvGBIFoANJmCqkIVnhF7qycwRMRZ0Q9tfc7J/aWsCxIWDgooO7ch5IT5TIQt81AFKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794788711;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rirVYvb0Vf05+DRVeRKU7V2cMMh3I2fW09eMK+/NRC4=;
	b=txTGXTRm31tZoozryYy0P7Re1fnhmeqvenYRr95ZNNRQoos47Bd5sgGqfkNVUMZLRjOi
	 qDS51msMci+GXY3fELimcdt9u+4yyp8uU2HWpHzU+8/BN3TxmSI75QU8yq42OYCXMF2xw
	 qnF8+VUNjJKdlwqsiE6YNOtiVeLQqSeNMZvPlYr31BDZwfKlHywjP4cinGj1v+RSx5Lte
	 s7AMZV+/tZBxVd1qtQzexnajOSYIWKiLjD5uFXz4jMf1sy44JnFFMycJWh1eKaSMZq7m0
	 rc1JoQ41yRDaD2k/bqXEaaO/ofB1SbBKSw3Bz43FszvJN1RoOUjoRXuvXVLTsnU4ueg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0mScnLT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2DB606A338;
	Mon, 16 Nov 2026 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0mScnLT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794788710;
	b=JS+dqnqP32/W60cly8qx/fCC3OvFN+2vwB7HdwojvZ84ipJlNkPn/MQ8fCM6QAk9TlU0
	 z176egRmOH4o5ZkCtmLtqrxFvIb08NyCrHBaPj0Tu2AWEnqfGatugAt9lLp9HpIhvCYLO
	 UGqdVrLAGShWah6iw5xky73IblQJRIcRb/DqWzflK5Mrsl72cELJ9DuweoyRwHLsbta52
	 4ZEjCW/+XH5/SZFgDF5I0dhY56HDhKDusAUschIOpNlFWpdCbN6ARR65A7z6b911ywwEl
	 KnWGPwL7lA1km5P79uAudE37PyAXuEEuzVttiwT4/sKv0rM1kyy5FYBpMJ6ILYitK/g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794788710;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rirVYvb0Vf05+DRVeRKU7V2cMMh3I2fW09eMK+/NRC4=;
	b=OgIexMMp6rJYTOewZR3RAReXrC9N0DhilUTU634NBeb9hi7jAuIRvSlOoRsC7A6uLlBO
	 HXUPMd44c6no6vJJFpb+1lLTkeu4LHX/EA0G63pDe+OLvR1z/8L4fXtKLFt5JU2V+fcwL
	 NOKG+e/3bINS3tnJbGmTp/w8+9Xexq0o8vEg0VEps7fymu5t1z4gAKr8ZBvoTvpRiPu/e
	 eke5BGfJk3+jLeOpN2Z/gN0fVu85+ntWgtMJDKakB6vG9R9O8r/ZMjJUSuPn9ouuc9WtV
	 WszaG+jyH3Ww+05V3k5tvLCgmKJszelC909UsoP1kYyE0Q3hPuyg/3+wxnDuj5OGVGQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4609F1F000C6;
	Mon, 16 Nov 2026 00:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794788710;
	bh=rirVYvb0Vf05+DRVeRKU7V2cMMh3I2fW09eMK+/NRC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=E0mScnLTeMQeAratVx9A4xpevtl0r9nym9IdMLbVOWj4gKxJUlxlgYg+WyuF+rm9z
	 NgYWByo+QLkgSl8/FbGMosZf/EfClNBQw78Oh8W24RBYV3Qd7EHBrPfvUZxuFq7olP
	 YHjL7vs4/M0LFRZMxdUnJfc6Jkpol3VMgxlcuEWOvao131fgnm9jHyZjDDzMsBng2A
	 59CfnuMUHZPN7xdMvhYjYrr8rkFQw7iLpsLK9daTykNSCqyUXWK5UheVfnRnopB/D2
	 nrIFcv3XckHqEBMIgcAlPCAmxKAU+QhCFpPvOWz1CO8tRBxGzTY9cpwkoGPdmto/Xn
	 8lT8uKpkxLmGQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CA8A94A297;
	Mon, 16 Nov 2026 00:25:08 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 16 Nov 2026 00:25:01 +0000
Subject: [PATCH v2 2/8] alarmtimer: Move the wakeup state into struct
 rtc_wakeup
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
Message-Id: <20261116-b4-alarmtimer-rtc-priority-v2-2-b2c69721e489@iav.lv>
References: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
In-Reply-To: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4962; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=R5at3LK7fTK6K4LRahVDuBX7FkZ6ca0VBOT54AfqeeQ=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFm/fBPEOnTfLOquEeKTYs67HFBV7zTvVWrJtoPnHBhvn
 jW5u2hmRykLgxgXg6yYIsuEQxq3MpZc/evvYf4AZg4rE8gQBi5OAZgI+0pGhj8p03O2vw/+93NG
 +pXfK6ZEK+QGiz/o6li77dekmZ18U2oZGVoSz94IVDOTlN+tVrBsvcVqtl/T/t06YhG98KPdJZv
 THxkA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

The RTC and the RTC timer which alarmtimer programs on suspend and the
record of the clock_nanosleep() call the freezer interrupted are separate
static variables.

Collect them in one struct to prepare for an RTC per suspend state. No
functional change.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 kernel/time/alarmtimer.c | 60 +++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 6c663f7d93c2..35630f0ff566 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -50,17 +50,29 @@ static struct alarm_base {
 } alarm_bases[ALARM_NUMTYPE];
 
 #if defined(CONFIG_POSIX_TIMERS) || defined(CONFIG_RTC_CLASS)
-/* freezer information to handle clock_nanosleep triggered wakeups */
-static enum alarmtimer_type freezer_alarmtype;
-static ktime_t freezer_expires;
-static ktime_t freezer_delta;
+/**
+ * struct rtc_wakeup - State for waking the system from suspend on alarms
+ * @rtc:		RTC programmed on suspend, NULL if none
+ * @timer:		RTC timer started on suspend
+ * @freezer_delta:	Least remaining time of the clock_nanosleep() calls
+ *			which the freezer interrupted, 0 if none
+ * @freezer_expires:	Expiry of that call
+ * @freezer_type:	Alarm type of that call
+ */
+struct rtc_wakeup {
+	struct rtc_device	*rtc;
+	struct rtc_timer	timer;
+	ktime_t			freezer_delta;
+	ktime_t			freezer_expires;
+	enum alarmtimer_type	freezer_type;
+};
+
+static struct rtc_wakeup wakeup_ctl;
+
 static DEFINE_SPINLOCK(freezer_delta_lock);
 #endif
 
 #ifdef CONFIG_RTC_CLASS
-/* rtc timer and device for setting alarm wakeups at suspend */
-static struct rtc_timer		rtctimer;
-static struct rtc_device	*rtcdev;
 
 /**
  * alarmtimer_has_rtcdev - Check whether an RTC can wake the system for alarms
@@ -69,7 +81,7 @@ static struct rtc_device	*rtcdev;
  */
 bool alarmtimer_has_rtcdev(void)
 {
-	return !!READ_ONCE(rtcdev);
+	return !!READ_ONCE(wakeup_ctl.rtc);
 }
 EXPORT_SYMBOL_GPL(alarmtimer_has_rtcdev);
 
@@ -78,7 +90,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 	struct rtc_device *rtc = to_rtc_device(dev);
 	struct platform_device *pdev;
 
-	if (rtcdev)
+	if (wakeup_ctl.rtc)
 		return -EBUSY;
 
 	if (!test_bit(RTC_FEATURE_ALARM, rtc->features))
@@ -98,7 +110,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 		return -1;
 	}
 
-	WRITE_ONCE(rtcdev, rtc);
+	WRITE_ONCE(wakeup_ctl.rtc, rtc);
 	/* Hold a reference so it doesn't go away */
 	get_device(dev);
 
@@ -107,7 +119,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 
 static inline void alarmtimer_rtc_timer_init(void)
 {
-	rtc_timer_init(&rtctimer, NULL, NULL);
+	rtc_timer_init(&wakeup_ctl.timer, NULL, NULL);
 }
 
 static struct class_interface alarmtimer_rtc_interface = {
@@ -215,13 +227,13 @@ static int alarmtimer_suspend(struct device *dev)
 	int i, ret, type;
 
 	scoped_guard(spinlock_irqsave, &freezer_delta_lock) {
-		min = freezer_delta;
-		expires = freezer_expires;
-		type = freezer_alarmtype;
-		freezer_delta = 0;
+		min = wakeup_ctl.freezer_delta;
+		expires = wakeup_ctl.freezer_expires;
+		type = wakeup_ctl.freezer_type;
+		wakeup_ctl.freezer_delta = 0;
 	}
 
-	rtc = READ_ONCE(rtcdev);
+	rtc = READ_ONCE(wakeup_ctl.rtc);
 	/* If we have no rtcdev, just return */
 	if (!rtc)
 		return 0;
@@ -258,7 +270,7 @@ static int alarmtimer_suspend(struct device *dev)
 	trace_alarmtimer_suspend(expires, type);
 
 	/* Setup an rtc timer to fire that far in the future */
-	rtc_timer_cancel(rtc, &rtctimer);
+	rtc_timer_cancel(rtc, &wakeup_ctl.timer);
 	rtc_read_time(rtc, &tm);
 	now = rtc_tm_to_ktime(tm);
 
@@ -275,7 +287,7 @@ static int alarmtimer_suspend(struct device *dev)
 	now = ktime_add(now, min);
 
 	/* Set alarm, if in the past reject suspend briefly to handle */
-	ret = rtc_timer_start(rtc, &rtctimer, now, 0);
+	ret = rtc_timer_start(rtc, &wakeup_ctl.timer, now, 0);
 	if (ret < 0)
 		pm_wakeup_event(dev, MSEC_PER_SEC);
 	return ret;
@@ -285,9 +297,9 @@ static int alarmtimer_resume(struct device *dev)
 {
 	struct rtc_device *rtc;
 
-	rtc = READ_ONCE(rtcdev);
+	rtc = READ_ONCE(wakeup_ctl.rtc);
 	if (rtc)
-		rtc_timer_cancel(rtc, &rtctimer);
+		rtc_timer_cancel(rtc, &wakeup_ctl.timer);
 	return 0;
 }
 
@@ -462,10 +474,10 @@ static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
 	delta = ktime_sub(absexp, base->get_ktime());
 
 	guard(spinlock_irqsave)(&freezer_delta_lock);
-	if (!freezer_delta || (delta < freezer_delta)) {
-		freezer_delta = delta;
-		freezer_expires = absexp;
-		freezer_alarmtype = type;
+	if (!wakeup_ctl.freezer_delta || (delta < wakeup_ctl.freezer_delta)) {
+		wakeup_ctl.freezer_delta = delta;
+		wakeup_ctl.freezer_expires = absexp;
+		wakeup_ctl.freezer_type = type;
 	}
 }
 

-- 
2.43.0


