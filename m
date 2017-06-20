Return-Path: <rtc-linux+bncBDKNBMNKRMJRB5GZUPFAKGQEO6MNFBQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x22f.google.com (mail-wr0-x22f.google.com. [2a00:1450:400c:c0c::22f])
        by gmr-mx.google.com with ESMTPS id m189si2689823wma.6.2017.06.20.02.37.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:56 -0700 (PDT)
Received: by mail-wr0-x22f.google.com with SMTP id y25so49021371wrd.2
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:56 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 25/51] rtc: ep93xx: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:33 +0200
Message-Id: <1497951359-13334-26-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

For the same reasons use set_mmss64 callback instead of set_mmss

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-ep93xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index 6940382..dcb71b2 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -59,15 +59,15 @@ static int ep93xx_rtc_get_swcomp(struct device *dev, unsigned short *preload,
 static int ep93xx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct ep93xx_rtc *ep93xx_rtc = dev_get_platdata(dev);
-	unsigned long time;
+	unsigned long long time;
 
-	 time = readl(ep93xx_rtc->mmio_base + EP93XX_RTC_DATA);
+	time = readl(ep93xx_rtc->mmio_base + EP93XX_RTC_DATA);
 
-	rtc_time_to_tm(time, tm);
+	rtc_time64_to_tm(time, tm);
 	return 0;
 }
 
-static int ep93xx_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int ep93xx_rtc_set_mmss64(struct device *dev, time64_t secs)
 {
 	struct ep93xx_rtc *ep93xx_rtc = dev_get_platdata(dev);
 
@@ -89,7 +89,7 @@ static int ep93xx_rtc_proc(struct device *dev, struct seq_file *seq)
 
 static const struct rtc_class_ops ep93xx_rtc_ops = {
 	.read_time	= ep93xx_rtc_read_time,
-	.set_mmss	= ep93xx_rtc_set_mmss,
+	.set_mmss64	= ep93xx_rtc_set_mmss64,
 	.proc		= ep93xx_rtc_proc,
 };
 
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
