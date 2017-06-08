Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23856 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbdFHNsi (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:38 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 14/25] rtc: pm8xxx: Switch to use %pt
Date: Thu,  8 Jun 2017 16:48:00 +0300
Message-Id: <20170608134811.60786-15-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-pm8xxx.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index fac835530671..370d10d589b8 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -196,9 +196,7 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return rc;
 	}
 
-	dev_dbg(dev, "secs = %lu, h:m:s == %d:%d:%d, d/m/y = %d/%d/%d\n",
-		secs, tm->tm_hour, tm->tm_min, tm->tm_sec,
-		tm->tm_mday, tm->tm_mon, tm->tm_year);
+	dev_dbg(dev, "secs = %lu, h:m:s == %ptt, y-m-d = %ptdr\n", secs, tm, tm);
 
 	return 0;
 }
@@ -243,10 +241,8 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		goto rtc_rw_fail;
 	}
 
-	dev_dbg(dev, "Alarm Set for h:r:s=%d:%d:%d, d/m/y=%d/%d/%d\n",
-		alarm->time.tm_hour, alarm->time.tm_min,
-		alarm->time.tm_sec, alarm->time.tm_mday,
-		alarm->time.tm_mon, alarm->time.tm_year);
+	dev_dbg(dev, "Alarm Set for h:m:s=%ptt, y-m-d=%ptdr\n",
+		&alarm->time, &alarm->time);
 rtc_rw_fail:
 	spin_unlock_irqrestore(&rtc_dd->ctrl_reg_lock, irq_flags);
 	return rc;
@@ -277,10 +273,8 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		return rc;
 	}
 
-	dev_dbg(dev, "Alarm set for - h:r:s=%d:%d:%d, d/m/y=%d/%d/%d\n",
-		alarm->time.tm_hour, alarm->time.tm_min,
-		alarm->time.tm_sec, alarm->time.tm_mday,
-		alarm->time.tm_mon, alarm->time.tm_year);
+	dev_dbg(dev, "Alarm set for - h:m:s=%ptt, y-m-d=%ptdr\n",
+		&alarm->time, &alarm->time);
 
 	return 0;
 }
-- 
2.11.0
