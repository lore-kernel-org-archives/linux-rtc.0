Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36772 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbdGRR0Z (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 18 Jul 2017 13:26:25 -0400
Received: by mail-pg0-f53.google.com with SMTP id u5so16168081pgq.3
        for <linux-rtc@vger.kernel.org>; Tue, 18 Jul 2017 10:26:25 -0700 (PDT)
From: Mark Salyzyn <salyzyn@android.com>
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org,
        Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH 4/4] PM: Print wall time at hibernate entry and exit
Date: Tue, 18 Jul 2017 10:26:16 -0700
Message-Id: <20170718172617.114825-1-salyzyn@android.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Permits power state and battery life diagnosis.

Feature activated by CONFIG_RTC_SHOW_TIME.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 kernel/power/hibernate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e1914c7b85b1..0b5460f9189b 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -32,11 +32,11 @@
 #include <linux/ctype.h>
 #include <linux/genhd.h>
 #include <linux/ktime.h>
+#include <linux/rtc.h>
 #include <trace/events/power.h>
 
 #include "power.h"
 
-
 static int nocompress;
 static int noresume;
 static int nohibernate;
@@ -342,6 +342,7 @@ int hibernation_snapshot(int platform_mode)
 	pm_message_t msg;
 	int error;
 
+	rtc_show_time("PM: hibernation entry");
 	pm_suspend_clear_flags();
 	error = platform_begin(platform_mode);
 	if (error)
@@ -409,6 +410,7 @@ int hibernation_snapshot(int platform_mode)
 	thaw_kernel_threads();
  Cleanup:
 	swsusp_free();
+	rtc_show_time("PM: hibernation exit");
 	goto Close;
 }
 
-- 
2.13.2.932.g7449e964c-goog
