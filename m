Return-Path: <rtc-linux+bncBDJMJGESWAMRB4GHVCVAKGQEAQ333EA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id p9si76113wiz.3.2015.05.06.07.23.43
        for <rtc-linux@googlegroups.com>;
        Wed, 06 May 2015 07:23:43 -0700 (PDT)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>,
	<stable@vger.kernel.org>
Subject: [rtc-linux] [PATCH] rtc: armada38x: Remove the unused variables
Date: Wed,  6 May 2015 16:23:30 +0200
Message-Id: <1430922210-9606-1-git-send-email-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

When applying the fix "rtc: armada38x: Fix concurrency access in
armada38x_rtc_set_time", some spinlock using the flags variable have
been removed, but not the flags variable themselves. This commit fixes
it.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: <stable@vger.kernel.org> #v4.0
---
 drivers/rtc/rtc-armada38x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
2.1.0

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
