Return-Path: <rtc-linux+bncBDS7HNEFSALRBMWH22VQKGQEXWK3NRI@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h1si49836wiw.1.2015.06.08.07.16.18
        for <rtc-linux@googlegroups.com>;
        Mon, 08 Jun 2015 07:16:18 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH v2 2/2] rtc: mv: correct 24 hour error message
Date: Mon,  8 Jun 2015 16:16:15 +0200
Message-Id: <1433772975-15228-2-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1433772975-15228-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1433772975-15228-1-git-send-email-alexandre.belloni@free-electrons.com>
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

The driver can't accommodate the 12 hour mode but the error message states
that the 24 hour mode is not supported.
Also fix the typos (hour vs hours).

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-mv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index 7e84bb4072ad..7f50d2ef7f6e 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -78,7 +78,7 @@ static int mv_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	second = rtc_time & 0x7f;
 	minute = (rtc_time >> RTC_MINUTES_OFFS) & 0x7f;
-	hour = (rtc_time >> RTC_HOURS_OFFS) & 0x3f; /* assume 24 hours mode */
+	hour = (rtc_time >> RTC_HOURS_OFFS) & 0x3f; /* assume 24 hour mode */
 	wday = (rtc_time >> RTC_WDAY_OFFS) & 0x7;
 
 	day = rtc_date & 0x3f;
@@ -109,7 +109,7 @@ static int mv_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 	second = rtc_time & 0x7f;
 	minute = (rtc_time >> RTC_MINUTES_OFFS) & 0x7f;
-	hour = (rtc_time >> RTC_HOURS_OFFS) & 0x3f; /* assume 24 hours mode */
+	hour = (rtc_time >> RTC_HOURS_OFFS) & 0x3f; /* assume 24 hour mode */
 	wday = (rtc_time >> RTC_WDAY_OFFS) & 0x7;
 
 	day = rtc_date & 0x3f;
@@ -240,10 +240,10 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
 	if (!IS_ERR(pdata->clk))
 		clk_prepare_enable(pdata->clk);
 
-	/* make sure the 24 hours mode is enabled */
+	/* make sure the 24 hour mode is enabled */
 	rtc_time = readl(pdata->ioaddr + RTC_TIME_REG_OFFS);
 	if (rtc_time & RTC_HOURS_12H_MODE) {
-		dev_err(&pdev->dev, "24 Hours mode not supported.\n");
+		dev_err(&pdev->dev, "12 Hour mode is enabled but not supported.\n");
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.1.4

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
