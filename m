Return-Path: <rtc-linux+bncBDS7HNEFSALRBMXVUK3AKGQEUUXLIMI@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c143si679674wmd.1.2016.02.20.11.12.50
        for <rtc-linux@googlegroups.com>;
        Sat, 20 Feb 2016 11:12:50 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Arnd Bergmann <arnd@arndb.de>,
	Willy Tarreau <w@1wt.eu>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: Add an option to invalidate dates in 2038
Date: Sat, 20 Feb 2016 20:10:44 +0100
Message-Id: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

hctosys is setting the system time from the kernel. This means that 32bit
system can get their time set to a date after the 31bit time_t overflow.

This is currently an issue as userspace is not yet ready to handle those
dates and may break. For example systemd's usage of timerfd shows that the
timerfd will always fire immediately because it can't be set at a date
after the current date.

The new RTC_INVALID_2038 option will make sure that date after 03:09:07 on
Jan 19 2038 are invalid. This is 5 minutes before the 31bit overflow. This
leaves enough time for userspace to react and is short enough to make the
issue visible.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/Kconfig   | 10 ++++++++++
 drivers/rtc/rtc-lib.c |  5 ++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 376322f71fd5..fc087855e6a9 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -73,6 +73,16 @@ config RTC_DEBUG
 	  Say yes here to enable debugging support in the RTC framework
 	  and individual RTC drivers.
 
+config RTC_INVALID_2038
+	bool "Invalidate dates after 2038"
+	depends on !64BIT
+	default y
+	help
+	  Saying yes here will make any date after 03:09:07 on Jan 19 2038
+	  invalid (this is 5 minutes before the 31 bits overflow of a time_t).
+	  This is useful if your userspace is not yet ready to handle 64 bits
+	  times.
+
 comment "RTC interfaces"
 
 config RTC_INTF_SYSFS
diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index e6bfb9c42a10..1ba148256afc 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -107,7 +107,10 @@ int rtc_valid_tm(struct rtc_time *tm)
 		|| ((unsigned)tm->tm_min) >= 60
 		|| ((unsigned)tm->tm_sec) >= 60)
 		return -EINVAL;
-
+#ifdef CONFIG_RTC_INVALID_2038
+	if (rtc_tm_to_time64(tm) > 0x7FFFFED4) /* 5 minutes before overflow */
+		return -EINVAL;
+#endif
 	return 0;
 }
 EXPORT_SYMBOL(rtc_valid_tm);
-- 
2.7.0

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
