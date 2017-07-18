Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34607 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbdGRR0I (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 18 Jul 2017 13:26:08 -0400
Received: by mail-pg0-f42.google.com with SMTP id 123so16294362pgj.1
        for <linux-rtc@vger.kernel.org>; Tue, 18 Jul 2017 10:26:08 -0700 (PDT)
From: Mark Salyzyn <salyzyn@android.com>
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org,
        Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH 3/4] PM: Print wall time at suspend entry and exit
Date: Tue, 18 Jul 2017 10:25:58 -0700
Message-Id: <20170718172600.114761-1-salyzyn@android.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Permits power state and battery life diagnosis.

Feature activated by CONFIG_RTC_SHOW_TIME.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 kernel/power/suspend.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 3ecf275d7e44..f44d2152ab3f 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -26,6 +26,7 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/ftrace.h>
+#include <linux/rtc.h>
 #include <trace/events/power.h>
 #include <linux/compiler.h>
 #include <linux/moduleparam.h>
@@ -579,6 +580,7 @@ int pm_suspend(suspend_state_t state)
 	if (state <= PM_SUSPEND_ON || state >= PM_SUSPEND_MAX)
 		return -EINVAL;
 
+	rtc_show_time("PM: suspend entry");
 	error = enter_state(state);
 	if (error) {
 		suspend_stats.fail++;
@@ -586,6 +588,7 @@ int pm_suspend(suspend_state_t state)
 	} else {
 		suspend_stats.success++;
 	}
+	rtc_show_time("PM: suspend exit");
 	return error;
 }
 EXPORT_SYMBOL(pm_suspend);
-- 
2.13.2.932.g7449e964c-goog
