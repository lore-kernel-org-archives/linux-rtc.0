Return-Path: <rtc-linux+bncBDJMJGESWAMRBZPVRWXAKGQEGIGUZAQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id fj7si81849wib.3.2015.08.06.08.19.00
        for <rtc-linux@googlegroups.com>;
        Thu, 06 Aug 2015 08:19:00 -0700 (PDT)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Boris BREZILLON <boris.brezillon@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>
Subject: [rtc-linux] [PATCH] rtc: armada38x: Align RTC set time procedure with
 the official errata
Date: Thu,  6 Aug 2015 17:18:48 +0200
Message-Id: <1438874328-31844-1-git-send-email-gregory.clement@free-electrons.com>
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

From: Nadav Haklai <nadavh@marvell.com>

According to the Armada38x functional errata FE-3124064, writing to
the RTC TIME register may fail. As a workaround, after writing to RTC
TIME register, issue a dummy write of 0x0 twice to the RTC Status
register.  This is the updated implementation of the Errata that
eliminates the need of the long 100ms delay during the RTC set time
procedure.

[gregory.clement@free-electrons.com]: removed the mutex and use the
spinlock again

Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Reviewed-by: Neta Zur Hershkovits <neta@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Hi,

Finally the long 100ms wait was not needed! So we can remove the mutex
introduced in an earlier commit.
It would be great if this patch could be part of the 4.2-rc.

Thanks

Gregory


 drivers/rtc/rtc-armada38x.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 2b08cac62f07..06c6bd5eab41 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -40,13 +40,6 @@ struct armada38x_rtc {
 	void __iomem	    *regs;
 	void __iomem	    *regs_soc;
 	spinlock_t	    lock;
-	/*
-	 * While setting the time, the RTC TIME register should not be
-	 * accessed. Setting the RTC time involves sleeping during
-	 * 100ms, so a mutex instead of a spinlock is used to protect
-	 * it
-	 */
-	struct mutex	    mutex_time;
 	int		    irq;
 };
 
@@ -64,9 +57,9 @@ static void rtc_delayed_write(u32 val, struct armada38x_rtc *rtc, int offset)
 static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long time, time_check;
+	unsigned long time, time_check, flags;
 
-	mutex_lock(&rtc->mutex_time);
+	spin_lock_irqsave(&rtc->lock, flags);
 	time = readl(rtc->regs + RTC_TIME);
 	/*
 	 * WA for failing time set attempts. As stated in HW ERRATA if
@@ -77,7 +70,7 @@ static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	if ((time_check - time) > 1)
 		time_check = readl(rtc->regs + RTC_TIME);
 
-	mutex_unlock(&rtc->mutex_time);
+	spin_unlock_irqrestore(&rtc->lock, flags);
 
 	rtc_time_to_tm(time_check, tm);
 
@@ -88,23 +81,23 @@ static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
 	int ret = 0;
-	unsigned long time;
+	unsigned long time, flags;
 
 	ret = rtc_tm_to_time(tm, &time);
 
 	if (ret)
 		goto out;
 	/*
-	 * Setting the RTC time not always succeeds. According to the
-	 * errata we need to first write on the status register and
-	 * then wait for 100ms before writing to the time register to be
-	 * sure that the data will be taken into account.
+	 * According to errata FE-3124064, Write to RTC TIME register
+	 * may fail. As a workaround, after writing to RTC TIME
+	 * register, issue a dummy write of 0x0 twice to RTC Status
+	 * register.
 	 */
-	mutex_lock(&rtc->mutex_time);
-	rtc_delayed_write(0, rtc, RTC_STATUS);
-	msleep(100);
+	spin_lock_irqsave(&rtc->lock, flags);
 	rtc_delayed_write(time, rtc, RTC_TIME);
-	mutex_unlock(&rtc->mutex_time);
+	rtc_delayed_write(0, rtc, RTC_STATUS);
+	rtc_delayed_write(0, rtc, RTC_STATUS);
+	spin_unlock_irqrestore(&rtc->lock, flags);
 
 out:
 	return ret;
@@ -229,7 +222,6 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spin_lock_init(&rtc->lock);
-	mutex_init(&rtc->mutex_time);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rtc");
 	rtc->regs = devm_ioremap_resource(&pdev->dev, res);
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
