Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794788711;
	b=B3HCYG3F0N074HCbbzbXXR5nf1HWjTn97Cjt8niHz5KBZB5LVFADn94SJ8ug3kxoRSBX
	 7u7eiwmNcoCQNDUmUMJLRYGIXYg3Zpke1GiBceKn6P338KjO5PgkrNk1iy4HtKWQRidqy
	 xrpPpyKFxlm0hRZv1M+KqkkGV2m7qx6YYoW6z2KXv4OuYDUFDgo39XMP+eS+il7nGS/9z
	 t/yjXEAPgxZxuVA8Mv9KDpfTvaR4N9NxN4UnWUFPG08rNLr6Vk82aO52bxCBIhOYSAjFG
	 iyT4IsxzpMJ9T3PtDiegkACeCLHEGs5+o+c+efXyikWeyptyqJfagxlfZZW3EqKNOZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794788711;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+xI9NgUf4o2KSEdFDaA+NOd4E6VfsuZrbaaEvbQwxOA=;
	b=mwOE1keVOn5PmheuSWx1Myn6kZZwHVXnWaf++Y8mM9HVjo1U439utUvzw8346BKbz5h8
	 NXeJnX5DzAeIelOA4g0CQUGY3TuO3zcPSYmL+hGce1tCXTUMhy6cKPcR112bkN88m2Xj7
	 OEwBV5fknuImxufL4s4t17eflMynA9Qe6zBkAAApb/ibg14+OgaShMTTb920hY92RaUmQ
	 vnXWcktGNlHRIPd2R1t0x6GLax2HkazFRrR6RtTUoV2DXkESIOeooDBkK7T9WKw0V3xcV
	 a6qG1uJT8o7U4FNfIophl9GtUCns7kVLBDwX2+pngnx6BI7cRcjIXIrygT65K6E6/5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OgVqcvMQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C9606A337;
	Mon, 16 Nov 2026 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OgVqcvMQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794788710;
	b=fmzP+FPDBx579dmGMAAM7zeZOo/hUfMo8wI5hOIuslrd6COaNfcqhiyosduipJpXerQg
	 NXyNAsL+blAuGj4/k/gDKj4qVy19hfMbMxDWp2FMTK3iZSyLcJPNR6IgA/l26+1FG+U3I
	 tI6DC6xhawOzNZf9vQb8CWG8P7pQ1d5tNZTH7GUPqZzpTSs/vjSk5k7kubzYQkCsGfMNI
	 DrE1LgOJoRkIGI4WpNtDDoYV1S07oy7ANMw7+fw9wksh2fBn4/jj+MSo4YxHss2eM5CBe
	 YSeUothfO1VtddtA4oV9WCmu62jmtlcZ4ky5Rh/s4MDKl94FDUAShR99X2FKm54OEyw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794788710;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+xI9NgUf4o2KSEdFDaA+NOd4E6VfsuZrbaaEvbQwxOA=;
	b=yu8Qrv7zonGf7+33gFGBb6US0FetuZMXn+p6R6ju2Htbe4OZCS4RjzwbsDudIwIQSyEV
	 nHw8+6eBeu1pz/jVx61htvwvfstuYV22XRkldh9EHF89/kWqYPxXpzy43N6k5QCdfu5qS
	 UOi3JSt37IIUGGMHQ1J8wVYg0JhS/eNTneRXDrWz/T7+le0PRvv0SKk8H1/Gz6WP1oIqZ
	 tDc1Im3ft8Bk2ZiqnmTa1eBv38XaScmCWZ+KmQCLGPgW6fEnIEFv5OZGBP3/5Kjn95mbL
	 vur+PVHTnbkYjau17uPVmOF5ax1JLMbv3FdV3LHhXlccX8v+IKuf/NnFKqFZxuczwpw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 31F301F000C5;
	Mon, 16 Nov 2026 00:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794788710;
	bh=+xI9NgUf4o2KSEdFDaA+NOd4E6VfsuZrbaaEvbQwxOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OgVqcvMQd6BaZ9UAC447VZx2q0roSmJHquiO4WnifbenuMckxYHHxosKodl5Kv/Uc
	 CH3CyJDtvD3O+mHYke8wvOLHaBuVRiBe4Vsuh8V+9ZaThtuG3D7Jeb4cNP0JXRHj5e
	 RqQvUaWH2YTgpYo7UiTB9YONUgQ52AsqvDwRAP1BcN3Z5iPBZlX+zQr5cASJJqjlEy
	 4vq50qe6FmPwqw+qCf/OK2QgjfRsE8wxIQDWHGnW4ovnqV0AMP6Dq7r3IYpL0s1QRQ
	 AxT9i7kd9jz5nGaVEm6wCv7WcHdozUBcyoaIshWDhZkYQJvY/enQxfQOKWsm2boTm6
	 ldr6IokM5MrNQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B550B4A28F;
	Mon, 16 Nov 2026 00:25:08 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 16 Nov 2026 00:25:00 +0000
Subject: [PATCH v2 1/8] alarmtimer: Replace alarmtimer_get_rtcdev() with
 alarmtimer_has_rtcdev()
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
Message-Id: <20261116-b4-alarmtimer-rtc-priority-v2-1-b2c69721e489@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4917; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=f68xLwZpTjZGNfu+rVHvQZiRfGedR9updFcLDrGikhA=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFm/fONvcPx+xR396dn2Hta1Fl8k/SyWs6f/maqinT5ls
 sue1WoFHaUsDGJcDLJiiiwTDmncylhy9a+/h/kDmDmsTCBDGLg4BWAin/cz/DNVqtTRt52s+l7p
 6UPWRkdh5sztfyI2p5+wjp+28wPTfS1Ghq699v9k7011MdlwQbFzvtl75nccKlU6wsGandckpSR
 3MwAA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

alarmtimer_get_rtcdev() returns the wakeup RTC without taking a reference.
Apart from alarmtimer_suspend() and alarmtimer_resume(), its callers only
test the result for NULL: the alarm clock functions to tell whether alarm
clocks are supported, and charger-manager to decide whether to set up its
alarm.

A later patch lets a different RTC wake the system from each suspend
state, so there is no single RTC to return.

Provide alarmtimer_has_rtcdev() for these tests and read rtcdev directly
in alarmtimer_suspend() and alarmtimer_resume().

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/power/supply/charger-manager.c |  2 +-
 include/linux/alarmtimer.h             |  7 ++-----
 kernel/time/alarmtimer.c               | 24 ++++++++++++------------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 8e8c5109401a..754ff4b3de1a 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1456,7 +1456,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	psy_cfg.drv_data = cm;
 
 	/* Initialize alarm timer */
-	if (alarmtimer_get_rtcdev()) {
+	if (alarmtimer_has_rtcdev()) {
 		cm_timer = devm_kzalloc(cm->dev, sizeof(*cm_timer), GFP_KERNEL);
 		if (!cm_timer)
 			return -ENOMEM;
diff --git a/include/linux/alarmtimer.h b/include/linux/alarmtimer.h
index 2014288ca2f4..3dd6d8762a73 100644
--- a/include/linux/alarmtimer.h
+++ b/include/linux/alarmtimer.h
@@ -6,8 +6,6 @@
 #include <linux/hrtimer.h>
 #include <linux/timerqueue.h>
 
-struct rtc_device;
-
 enum alarmtimer_type {
 	ALARM_REALTIME,
 	ALARM_BOOTTIME,
@@ -58,10 +56,9 @@ u64 alarm_forward_now(struct alarm *alarm, ktime_t interval);
 ktime_t alarm_expires_remaining(const struct alarm *alarm);
 
 #ifdef CONFIG_RTC_CLASS
-/* Provide way to access the rtc device being used by alarmtimers */
-struct rtc_device *alarmtimer_get_rtcdev(void);
+bool alarmtimer_has_rtcdev(void);
 #else
-static inline struct rtc_device *alarmtimer_get_rtcdev(void) { return NULL; }
+static inline bool alarmtimer_has_rtcdev(void) { return false; }
 #endif
 
 #endif
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index ecf8c89f7eaf..6c663f7d93c2 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -63,15 +63,15 @@ static struct rtc_timer		rtctimer;
 static struct rtc_device	*rtcdev;
 
 /**
- * alarmtimer_get_rtcdev - Return selected rtcdevice
+ * alarmtimer_has_rtcdev - Check whether an RTC can wake the system for alarms
  *
- * This function returns the rtc device to use for wakealarms.
+ * Return: True when alarmtimer has an RTC to program on suspend
  */
-struct rtc_device *alarmtimer_get_rtcdev(void)
+bool alarmtimer_has_rtcdev(void)
 {
-	return READ_ONCE(rtcdev);
+	return !!READ_ONCE(rtcdev);
 }
-EXPORT_SYMBOL_GPL(alarmtimer_get_rtcdev);
+EXPORT_SYMBOL_GPL(alarmtimer_has_rtcdev);
 
 static int alarmtimer_rtc_add_device(struct device *dev)
 {
@@ -221,7 +221,7 @@ static int alarmtimer_suspend(struct device *dev)
 		freezer_delta = 0;
 	}
 
-	rtc = alarmtimer_get_rtcdev();
+	rtc = READ_ONCE(rtcdev);
 	/* If we have no rtcdev, just return */
 	if (!rtc)
 		return 0;
@@ -285,7 +285,7 @@ static int alarmtimer_resume(struct device *dev)
 {
 	struct rtc_device *rtc;
 
-	rtc = alarmtimer_get_rtcdev();
+	rtc = READ_ONCE(rtcdev);
 	if (rtc)
 		rtc_timer_cancel(rtc, &rtctimer);
 	return 0;
@@ -591,7 +591,7 @@ static bool alarm_timer_arm(struct k_itimer *timr, ktime_t expires,
  */
 static int alarm_clock_getres(const clockid_t which_clock, struct timespec64 *tp)
 {
-	if (!alarmtimer_get_rtcdev())
+	if (!alarmtimer_has_rtcdev())
 		return -EINVAL;
 
 	tp->tv_sec = 0;
@@ -610,7 +610,7 @@ static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp
 {
 	struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
 
-	if (!alarmtimer_get_rtcdev())
+	if (!alarmtimer_has_rtcdev())
 		return -EINVAL;
 
 	base->get_timespec(tp);
@@ -628,7 +628,7 @@ static ktime_t alarm_clock_get_ktime(clockid_t which_clock)
 {
 	struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
 
-	if (!alarmtimer_get_rtcdev())
+	if (!alarmtimer_has_rtcdev())
 		return -EINVAL;
 
 	return base->get_ktime();
@@ -644,7 +644,7 @@ static int alarm_timer_create(struct k_itimer *new_timer)
 {
 	enum  alarmtimer_type type;
 
-	if (!alarmtimer_get_rtcdev())
+	if (!alarmtimer_has_rtcdev())
 		return -EOPNOTSUPP;
 
 	if (!capable(CAP_WAKE_ALARM))
@@ -763,7 +763,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 	ktime_t exp;
 	int ret;
 
-	if (!alarmtimer_get_rtcdev())
+	if (!alarmtimer_has_rtcdev())
 		return -EOPNOTSUPP;
 
 	if (flags & ~TIMER_ABSTIME)

-- 
2.43.0


