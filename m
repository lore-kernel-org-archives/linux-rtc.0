Return-Path: <rtc-linux+bncBAABBD6S764AKGQEF5UFPYI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id d141si105956pfd.1.2016.04.26.15.17.51
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Apr 2016 15:17:51 -0700 (PDT)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH] rtc: Use IS_ENABLED() instead of checking for
 built-in or module
Date: Tue, 26 Apr 2016 18:17:35 -0400
Message-Id: <1461709055-28312-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
built-in or as a module, use that macro instead of open coding the same.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/rtc/rtc-cmos.c    | 2 +-
 drivers/rtc/rtc-mrst.c    | 2 +-
 drivers/rtc/rtc-rs5c372.c | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 84fb541038be..fbe9c72438e1 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -401,7 +401,7 @@ static int cmos_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	return 0;
 }
 
-#if defined(CONFIG_RTC_INTF_PROC) || defined(CONFIG_RTC_INTF_PROC_MODULE)
+#if IS_ENABLED(CONFIG_RTC_INTF_PROC)
 
 static int cmos_procfs(struct device *dev, struct seq_file *seq)
 {
diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index 548ea6f6f384..0094d9bdd1e6 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -266,7 +266,7 @@ static int mrst_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 }
 
 
-#if defined(CONFIG_RTC_INTF_PROC) || defined(CONFIG_RTC_INTF_PROC_MODULE)
+#if IS_ENABLED(CONFIG_RTC_INTF_PROC)
 
 static int mrst_procfs(struct device *dev, struct seq_file *seq)
 {
diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 12270c789088..aaebe10876e8 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -237,11 +237,11 @@ static int rs5c372_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	return 0;
 }
 
-#if defined(CONFIG_RTC_INTF_PROC) || defined(CONFIG_RTC_INTF_PROC_MODULE)
+#if IS_ENABLED(CONFIG_RTC_INTF_PROC)
 #define	NEED_TRIM
 #endif
 
-#if defined(CONFIG_RTC_INTF_SYSFS) || defined(CONFIG_RTC_INTF_SYSFS_MODULE)
+#if IS_ENABLED(CONFIG_RTC_INTF_SYSFS)
 #define	NEED_TRIM
 #endif
 
@@ -409,7 +409,7 @@ static int rs5c_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	return 0;
 }
 
-#if defined(CONFIG_RTC_INTF_PROC) || defined(CONFIG_RTC_INTF_PROC_MODULE)
+#if IS_ENABLED(CONFIG_RTC_INTF_PROC)
 
 static int rs5c372_rtc_proc(struct device *dev, struct seq_file *seq)
 {
@@ -438,7 +438,7 @@ static const struct rtc_class_ops rs5c372_rtc_ops = {
 	.alarm_irq_enable = rs5c_rtc_alarm_irq_enable,
 };
 
-#if defined(CONFIG_RTC_INTF_SYSFS) || defined(CONFIG_RTC_INTF_SYSFS_MODULE)
+#if IS_ENABLED(CONFIG_RTC_INTF_SYSFS)
 
 static ssize_t rs5c372_sysfs_show_trim(struct device *dev,
 				struct device_attribute *attr, char *buf)
-- 
2.5.5

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
