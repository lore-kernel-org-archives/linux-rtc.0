Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:50385 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbdFHNsk (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:40 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v1 23/25] Input: hp_sdc_rtc - Switch to use %pt
Date: Thu,  8 Jun 2017 16:48:09 +0300
Message-Id: <20170608134811.60786-24-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/misc/hp_sdc_rtc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/hp_sdc_rtc.c b/drivers/input/misc/hp_sdc_rtc.c
index 1c8c56efc995..9a6afc3a4775 100644
--- a/drivers/input/misc/hp_sdc_rtc.c
+++ b/drivers/input/misc/hp_sdc_rtc.c
@@ -441,12 +441,10 @@ static int hp_sdc_rtc_proc_show(struct seq_file *m, void *v)
 		seq_puts(m, "BBRTC\t\t: READ FAILED!\n");
 	} else {
 		seq_printf(m,
-			     "rtc_time\t: %02d:%02d:%02d\n"
-			     "rtc_date\t: %04d-%02d-%02d\n"
+			     "rtc_time\t: %ptt\n"
+			     "rtc_date\t: %ptd\n"
 			     "rtc_epoch\t: %04lu\n",
-			     tm.tm_hour, tm.tm_min, tm.tm_sec,
-			     tm.tm_year + 1900, tm.tm_mon + 1, 
-			     tm.tm_mday, epoch);
+			     &tm, &tm, epoch);
 	}
 
 	if (hp_sdc_rtc_read_rt(&tv)) {
-- 
2.11.0
