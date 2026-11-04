Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793771683;
	b=O/GCYeKzaspp9+1UhvslyXeKGRzs6ZA+oeIOnJ4/alDD4wCj2q6Q1x3CWmBuVWMSR4RS
	 cz3/c0WdWJfd1moSORm2ubHcIZOYTQUpWhZraJ0yZ/+W3CSOFEuo4MivgEWXJQDKF9Y58
	 6vawRnrHg/oL9jkQXfSqnC/M1MLctwZeS5f8H6kQ3mZxAewUDsckFxJTTgy3JF3mFWEyF
	 vK+WCSMtOTD14Q7JvzqPF+QKdjIQGx1Yk5v9YZlb9XZaH8NgIof+vojYBGfsTUEX+VkMk
	 f629/56qdRlP20rUL0eIDzjObhJHgwESHYZdmBX6hOGWCFPEbnYHxjppyO82cJvSPcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793771683;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KHOjj0PbXr6bongDHHnC9y8W/QfijWhD4E/xO39TXeg=;
	b=ZZYGRJwme4bP4BfWEP/EQtdALK0XTNlBBHjR6E7s4ID1TTwdkAmIGmFbofsA6mHSleua
	 ATV9HTgK3sZAHvbgjLHN6LMLGhzhCF9zavtYs1ATYeffxwJzIm4jtVQsn5KeX9VFpyQLK
	 Llr0bD+wYVVOlzARmX0ntkTH3dGgfzSSRXByDe8mChRg0b+lK3+94CB5n4MEeYu8C9dlh
	 jdi6nEJrj0OO0Tb59VmG48Blnhd9xwIpMF92kBosIlbcWjDfFznJhKiFRxiW9aIM83Ipn
	 d4WGQwH0kyFXsedMpmHcb++Gfgn7lOZNjrWegHF9A21jn1gC0On5/IqZr1BXli0IRiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0SNKRf2;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37DC606A329;
	Wed,  4 Nov 2026 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0SNKRf2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793771682;
	b=0mutnmcl8aR1z7ZjPpTDjuCQCRuR0TLUkx3v1IBDTlmFbZiMZiLe0NsSMZWtsvliWD/W
	 rzVI0tPaJfuJ054UPzm6KnJa068hmZRsoJzIKqqce22lHZY4AHVWeHnFHejtgZ+zA91PW
	 YeQeBSQ2SZFITjwCRirpaK+rQfKIS6Y+0vpZi+kte+CnWWZs9gJxs8dUg0tSjrhAQSykK
	 l5GJ9vxotrp97M26kBPByTXmeXdWH//no/+ScVbMwl2PQsdaRuhAGCugdwdAoAmy02ES1
	 0kVIXEb5pRCGaqA8DUj77yt3xdQMMnWj6ejOzOa5p36eB99fjH7uihtHxnychb8Go0g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793771682;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KHOjj0PbXr6bongDHHnC9y8W/QfijWhD4E/xO39TXeg=;
	b=mxpB0S4YyXu7xkOWrCjywrkXg1iN1wMxCxsHdKJbOq2WC0BKAjZphiCrxeIrhxvJaTRL
	 T+J9aJtY4XZ3ktkABNSkCPc0mc5m9tCznncqLm2pOV2wIi/kVowVM/2pEnDdjZemsP8Ku
	 wlyUy9lR21pztwizY2Wrzr0W66R75E+wrC9MyBooguxSR0Q42IzSzTMNUwYtxR4j2HaEq
	 y8wvnC2aRXhxxVw8JKvF0kKnWOn3Kf5nlYTlot5t4c1eLtev02wzemfpKLDmHYQEljVbb
	 AkqP66sKV39b5O40yZZfHNywIKuUkTmPiAxafe0fOYnyjxd3iqOe6r6exhc5rEp2sOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 533901F0093A;
	Wed,  4 Nov 2026 05:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793771682;
	bh=KHOjj0PbXr6bongDHHnC9y8W/QfijWhD4E/xO39TXeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Q0SNKRf2jVK0V9VVZ7NlSwx2WfrFkVDTI7i0u8bH9lDybjA2RcXZLFngqOlNnLtzO
	 pbPRdjtfmQE78cXQUp/JtBwk2kXwwxo4gjdWjPAWWMYBo8uzA2iTg/x0zUuLziNHu5
	 J1sJXswTZRBWjRPM2DxvdEL+s0vN2LpVsM/60tXOX+XtNu/6u4mc0XEGxyzKJWPqIs
	 xIEDQfdmFcv+i7JI3xZRDgQ882/J2FTj9fBwBCqlJYB5LHLW60IQ+6kq3Ev49Sf2bv
	 yjCC/o46uJkxR/UbceqBuTB95wPtMIqHvT8ew7YqjtfNFHNjqU95CTn8zdJzafeQJ0
	 J6FN0j+3oCCbw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D488446CA3;
	Wed,  4 Nov 2026 05:54:40 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Wed, 04 Nov 2026 05:54:38 +0000
Subject: [PATCH RFC 2/3] alarmtimer: Choose the wakeup RTC by sleep state
 and priority
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
Message-Id: <20261104-b4-alarmtimer-rtc-priority-v1-2-e996681b8086@iav.lv>
References: <20261104-b4-alarmtimer-rtc-priority-v1-0-e996681b8086@iav.lv>
In-Reply-To: <20261104-b4-alarmtimer-rtc-priority-v1-0-e996681b8086@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9387; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=9wjWlAMyjuUF79W+Ia7hMoFLYykDe0HTRsYcW0vMF3Q=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFmvTsz/rXR62vL+ySI7N0Z3THx3f8GlCEXb/Sc2NiXXS
 i17rbxGqqOUhUGMi0FWTJFlwiGNWxlLrv719zB/ADOHlQlkCAMXpwBMhPcrw3+nRwIfzlQdd378
 VESF6Y3m/OmrF3vrZsYZGT/14bx4KN+Z4X9GZp/+llsnFFzOti1OUX8S5NPR0fnAr+ddmZnOc80
 l3/gA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

alarmtimer_rtc_add_device() registers a platform device under the first
RTC that has an alarm and a wakeup-capable parent, and alarmtimer_suspend()
programs that RTC. On ODROID-HC4 it is meson-vrtc, a register the firmware
reads when the application processors suspend, with no interrupt in
Linux, so an alarm set on it does not wake the board from s2idle; the
board's pcf8563 registers later and is never used.

Keep each such RTC that no earlier registered one with at least the same
priority already covers, each with its own platform device, and read
linux,wakeup-states and linux,alarmtimer-priority from its parent. In
alarmtimer_suspend() choose, among the RTCs whose linux,wakeup-states
contains pm_suspend_target_state, the one with the highest priority,
registered first among equals, and program the alarm from its platform
device only. That platform device is a child of its RTC, so the driver
core suspends it before the RTC. alarmtimer_resume() cancels the timer
from the platform device that started it.

An RTC without linux,wakeup-states qualifies for every state; without
linux,alarmtimer-priority its priority is 0. An RTC that an earlier
registered one with at least the same priority beats for every state gets
no platform device, so without the properties only the first RTC is kept.
alarmtimer does not use an RTC that lists no suspend state, as with
"none". hibernate and off count as no suspend state; nothing in this
series acts on them.

alarmtimer_get_rtcdev() returns the RTC with the highest priority.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 kernel/time/alarmtimer.c | 157 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 140 insertions(+), 17 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index ea5be5870e51..d7033fcd3178 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -19,9 +19,13 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
 #include <linux/alarmtimer.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/posix-timers.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/workqueue.h>
 #include <linux/freezer.h>
 #include <linux/compat.h>
@@ -60,13 +64,39 @@ static DEFINE_SPINLOCK(freezer_delta_lock);
 #ifdef CONFIG_RTC_CLASS
 /* rtc timer and device for setting alarm wakeups at suspend */
 static struct rtc_timer		rtctimer;
+static struct rtc_device	*rtctimer_rtc;
 static struct rtc_device	*rtcdev;
 static DEFINE_SPINLOCK(rtcdev_lock);
 
 /**
- * alarmtimer_get_rtcdev - Return selected rtcdevice
+ * struct alarmtimer_rtc - RTC that can wake the system
+ * @node:	Entry in alarmtimer_rtcs
+ * @rtc:	The RTC
+ * @priority:	linux,alarmtimer-priority of the RTC, 0 without the property
+ * @wakes_from:	Per suspend state, whether linux,wakeup-states lists it;
+ *		all set without the property
+ */
+struct alarmtimer_rtc {
+	struct list_head	node;
+	struct rtc_device	*rtc;
+	u32			priority;
+	bool			wakes_from[PM_SUSPEND_MAX];
+};
+
+/* Ordered by descending priority, registration order among equals */
+static LIST_HEAD(alarmtimer_rtcs);
+
+static const char * const alarmtimer_state_names[PM_SUSPEND_MAX] = {
+	[PM_SUSPEND_TO_IDLE] = "s2idle",
+	[PM_SUSPEND_STANDBY] = "shallow",
+	[PM_SUSPEND_MEM] = "deep",
+};
+
+/**
+ * alarmtimer_get_rtcdev - Return the preferred RTC
  *
- * This function returns the rtc device to use for wakealarms.
+ * This function returns the RTC with the highest linux,alarmtimer-priority.
+ * Which RTC alarmtimer_suspend() programs depends on the target sleep state.
  */
 struct rtc_device *alarmtimer_get_rtcdev(void)
 {
@@ -79,19 +109,95 @@ struct rtc_device *alarmtimer_get_rtcdev(void)
 }
 EXPORT_SYMBOL_GPL(alarmtimer_get_rtcdev);
 
+static struct alarmtimer_rtc *alarmtimer_rtc_for_state(suspend_state_t state)
+{
+	struct alarmtimer_rtc *ar;
+
+	lockdep_assert_held(&rtcdev_lock);
+
+	list_for_each_entry(ar, &alarmtimer_rtcs, node)
+		if (ar->wakes_from[state])
+			return ar;
+
+	return NULL;
+}
+
+static bool alarmtimer_rtc_covers(const struct alarmtimer_rtc *a,
+				  const struct alarmtimer_rtc *b)
+{
+	suspend_state_t state;
+
+	for (state = PM_SUSPEND_MIN; state < PM_SUSPEND_MAX; state++)
+		if (b->wakes_from[state] && !a->wakes_from[state])
+			return false;
+
+	return true;
+}
+
+/*
+ * Place for @ar in alarmtimer_rtcs, or NULL when an RTC ahead of it would be
+ * chosen over it for every suspend state.
+ */
+static struct list_head *alarmtimer_rtc_position(const struct alarmtimer_rtc *ar)
+{
+	struct alarmtimer_rtc *other;
+	struct list_head *pos;
+
+	lockdep_assert_held(&rtcdev_lock);
+
+	list_for_each(pos, &alarmtimer_rtcs) {
+		other = list_entry(pos, struct alarmtimer_rtc, node);
+		if (other->priority < ar->priority)
+			break;
+		if (alarmtimer_rtc_covers(other, ar))
+			return NULL;
+	}
+
+	return pos;
+}
+
 static int alarmtimer_rtc_add_device(struct device *dev)
 {
 	struct rtc_device *rtc = to_rtc_device(dev);
+	struct device *parent = rtc->dev.parent;
 	struct platform_device *pdev;
+	bool listed, wakes = false;
+	struct alarmtimer_rtc *ar;
+	struct list_head *pos;
+	suspend_state_t state;
 	int ret = 0;
 
-	if (rtcdev)
-		return -EBUSY;
-
 	if (!test_bit(RTC_FEATURE_ALARM, rtc->features))
 		return -1;
-	if (!device_may_wakeup(rtc->dev.parent))
+	if (!device_may_wakeup(parent))
+		return -1;
+
+	ar = kzalloc_obj(*ar);
+	if (!ar)
+		return -ENOMEM;
+
+	ar->rtc = rtc;
+	device_property_read_u32(parent, "linux,alarmtimer-priority",
+				 &ar->priority);
+	listed = device_property_present(parent, "linux,wakeup-states");
+	for (state = PM_SUSPEND_MIN; state < PM_SUSPEND_MAX; state++) {
+		ar->wakes_from[state] = !listed ||
+			device_property_match_string(parent, "linux,wakeup-states",
+						     alarmtimer_state_names[state]) >= 0;
+		wakes |= ar->wakes_from[state];
+	}
+	/* Wakes from no suspend state: "none", or only hibernate and off */
+	if (!wakes) {
+		kfree(ar);
 		return -1;
+	}
+
+	scoped_guard(spinlock_irqsave, &rtcdev_lock)
+		pos = alarmtimer_rtc_position(ar);
+	if (!pos) {
+		kfree(ar);
+		return -EBUSY;
+	}
 
 	pdev = platform_device_register_data(dev, "alarmtimer",
 					     PLATFORM_DEVID_AUTO, NULL, 0);
@@ -99,17 +205,22 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 		device_init_wakeup(&pdev->dev, true);
 
 	scoped_guard(spinlock_irqsave, &rtcdev_lock) {
-		if (!IS_ERR(pdev) && !rtcdev && try_module_get(rtc->owner)) {
-			rtcdev = rtc;
+		pos = IS_ERR(pdev) ? NULL : alarmtimer_rtc_position(ar);
+		if (pos && try_module_get(rtc->owner)) {
+			list_add_tail(&ar->node, pos);
+			rtcdev = list_first_entry(&alarmtimer_rtcs,
+						  struct alarmtimer_rtc, node)->rtc;
 			/* hold a reference so it doesn't go away */
 			get_device(dev);
 			pdev = NULL;
+			ar = NULL;
 		} else {
 			ret = -1;
 		}
 	}
 
 	platform_device_unregister(pdev);
+	kfree(ar);
 	return ret;
 }
 
@@ -208,20 +319,30 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
 #ifdef CONFIG_RTC_CLASS
 /**
  * alarmtimer_suspend - Suspend time callback
- * @dev: unused
+ * @dev: platform device registered under the RTC
  *
  * When we are going into suspend, we look through the bases
  * to see which is the soonest timer to expire. We then
  * set an rtc timer to fire that far into the future, which
  * will wake us from suspend.
+ *
+ * Each RTC that can wake the system has its own platform device. Only the
+ * platform device under the RTC chosen for the target sleep state programs
+ * the alarm.
  */
 static int alarmtimer_suspend(struct device *dev)
 {
+	struct rtc_device *rtc = to_rtc_device(dev->parent);
 	ktime_t min, now, expires;
-	struct rtc_device *rtc;
+	struct alarmtimer_rtc *ar;
 	struct rtc_time tm;
 	int i, ret, type;
 
+	scoped_guard(spinlock_irqsave, &rtcdev_lock)
+		ar = alarmtimer_rtc_for_state(pm_suspend_target_state);
+	if (ar && ar->rtc != rtc)
+		return 0;
+
 	scoped_guard(spinlock_irqsave, &freezer_delta_lock) {
 		min = freezer_delta;
 		expires = freezer_expires;
@@ -229,9 +350,8 @@ static int alarmtimer_suspend(struct device *dev)
 		freezer_delta = 0;
 	}
 
-	rtc = alarmtimer_get_rtcdev();
-	/* If we have no rtcdev, just return */
-	if (!rtc)
+	/* No RTC wakes the system from this state */
+	if (!ar)
 		return 0;
 
 	/* Find the soonest timer to expire */
@@ -266,7 +386,9 @@ static int alarmtimer_suspend(struct device *dev)
 	trace_alarmtimer_suspend(expires, type);
 
 	/* Setup an rtc timer to fire that far in the future */
-	rtc_timer_cancel(rtc, &rtctimer);
+	if (rtctimer_rtc)
+		rtc_timer_cancel(rtctimer_rtc, &rtctimer);
+	rtctimer_rtc = rtc;
 	rtc_read_time(rtc, &tm);
 	now = rtc_tm_to_ktime(tm);
 
@@ -291,11 +413,12 @@ static int alarmtimer_suspend(struct device *dev)
 
 static int alarmtimer_resume(struct device *dev)
 {
-	struct rtc_device *rtc;
+	struct rtc_device *rtc = to_rtc_device(dev->parent);
 
-	rtc = alarmtimer_get_rtcdev();
-	if (rtc)
+	if (rtc == rtctimer_rtc) {
 		rtc_timer_cancel(rtc, &rtctimer);
+		rtctimer_rtc = NULL;
+	}
 	return 0;
 }
 

-- 
2.43.0


