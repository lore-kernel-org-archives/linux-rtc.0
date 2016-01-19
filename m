Return-Path: <rtc-linux+bncBDS7HNEFSALRB44T622AKGQEQS6C6UY@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h123si536361wmd.0.2016.01.18.16.57.23
        for <rtc-linux@googlegroups.com>;
        Mon, 18 Jan 2016 16:57:23 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Rob Herring <robh@kernel.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: sa1100: detect rcnr overflow with dates
 after 2038
Date: Tue, 19 Jan 2016 01:57:11 +0100
Message-Id: <1453165031-29194-1-git-send-email-alexandre.belloni@free-electrons.com>
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

rcnr will overflow in 2038, detect that overflow when setting the time and
get rid of the deprecated rtc_tm_to_time()

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-sa1100.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index c2187bf6c7e4..239dd3d7df1b 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -162,13 +162,16 @@ static int sa1100_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int sa1100_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct sa1100_rtc *info = dev_get_drvdata(dev);
-	unsigned long time;
+	time64_t time;
 	int ret;
 
-	ret = rtc_tm_to_time(tm, &time);
-	if (ret == 0)
-		writel_relaxed(time, info->rcnr);
-	return ret;
+	time = rtc_tm_to_time64(tm);
+	if (time > U32_MAX)
+		return -EINVAL;
+
+	writel_relaxed(time, info->rcnr);
+
+	return 0;
 }
 
 static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
-- 
2.5.0

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
