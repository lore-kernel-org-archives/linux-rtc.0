Return-Path: <rtc-linux+bncBDEKVJM7XAHRBK7QZGVAKGQE7N4QSZI@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.187])
        by gmr-mx.google.com with ESMTPS id q10si183431wiz.0.2015.05.12.15.01.14
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 15:01:14 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: alexandre.belloni@free-electrons.com
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com, Gregory CLEMENT <gregory.clement@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH] rtc: armada38x: remove unused variables
Date: Wed, 13 May 2015 00:00:33 +0200
Message-ID: <2116673.Ym6IPoTTaZ@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

A recent bugfix introduced a new compiler warning in the rtc-armada38x
driver:

drivers/rtc/rtc-armada38x.c: In function 'armada38x_rtc_read_time':
drivers/rtc/rtc-armada38x.c:67:34: warning: unused variable 'flags' [-Wunused-variable]
  unsigned long time, time_check, flags;

This removes the now obsolete variables to get rid of the warning.
As the orginal fix was marked for stable backports [4.0], this one
should be backported as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 489405fe5ed38 ("rtc: armada38x: fix concurrency access in armada38x_rtc_set_time")
Cc: stable@vger.kernel.org

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index cb70ced7e0db..2b08cac62f07 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -64,7 +64,7 @@ static void rtc_delayed_write(u32 val, struct armada38x_rtc *rtc, int offset)
 static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long time, time_check, flags;
+	unsigned long time, time_check;
 
 	mutex_lock(&rtc->mutex_time);
 	time = readl(rtc->regs + RTC_TIME);
@@ -88,7 +88,7 @@ static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
 	int ret = 0;
-	unsigned long time, flags;
+	unsigned long time;
 
 	ret = rtc_tm_to_time(tm, &time);
 

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
