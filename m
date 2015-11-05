Return-Path: <rtc-linux+bncBD7YLCN32UNBBNWD5SYQKGQE5CGYXJA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wm0-x234.google.com (mail-wm0-x234.google.com. [2a00:1450:400c:c09::234])
        by gmr-mx.google.com with ESMTPS id t2si269177wme.1.2015.11.05.01.30.30
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2015 01:30:30 -0800 (PST)
Received: by mail-wm0-x234.google.com with SMTP id g8so7644241wme.1
        for <rtc-linux@googlegroups.com>; Thu, 05 Nov 2015 01:30:30 -0800 (PST)
From: LABBE Corentin <clabbe.montjoie@gmail.com>
To: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it,
	linux-arm-kernel@lists.infradead.org,
	maxime.ripard@free-electrons.com,
	wens@csie.org
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH] rtc: sunxi: fix some misceanellous problems
Date: Thu,  5 Nov 2015 10:29:49 +0100
Message-Id: <1446715789-10460-1-git-send-email-clabbe.montjoie@gmail.com>
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

year must be set as unsigned since it is use with
sunxi_rtc_data_year{.min|.max} and as parameter of is_leap_year() which
wait for unsigned int.
Only tm_year is not unsigned, but it is long.
This patch fix also the format of printing of min/max. (must %u since
they are unsigned)

The parameter to of sunxi_rtc_setaie() must be set to uint since callers
give always uint data.

The struct data_year_param is never modified, so it can be set const.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/rtc/rtc-sunxi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index 52543ae..9287afc 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -133,7 +133,7 @@ struct sunxi_rtc_data_year {
 	unsigned char leap_shift;	/* bit shift to get the leap year */
 };
 
-static struct sunxi_rtc_data_year data_year_param[] = {
+static const struct sunxi_rtc_data_year data_year_param[] = {
 	[0] = {
 		.min		= 2010,
 		.max		= 2073,
@@ -175,7 +175,7 @@ static irqreturn_t sunxi_rtc_alarmirq(int irq, void *id)
 	return IRQ_NONE;
 }
 
-static void sunxi_rtc_setaie(int to, struct sunxi_rtc_dev *chip)
+static void sunxi_rtc_setaie(unsigned int to, struct sunxi_rtc_dev *chip)
 {
 	u32 alrm_val = 0;
 	u32 alrm_irq_val = 0;
@@ -343,7 +343,7 @@ static int sunxi_rtc_settime(struct device *dev, struct rtc_time *rtc_tm)
 	struct sunxi_rtc_dev *chip = dev_get_drvdata(dev);
 	u32 date = 0;
 	u32 time = 0;
-	int year;
+	unsigned int year;
 
 	/*
 	 * the input rtc_tm->tm_year is the offset relative to 1900. We use
@@ -353,8 +353,8 @@ static int sunxi_rtc_settime(struct device *dev, struct rtc_time *rtc_tm)
 
 	year = rtc_tm->tm_year + 1900;
 	if (year < chip->data_year->min || year > chip->data_year->max) {
-		dev_err(dev, "rtc only supports year in range %d - %d\n",
-				chip->data_year->min, chip->data_year->max);
+		dev_err(dev, "rtc only supports year in range %u - %u\n",
+			chip->data_year->min, chip->data_year->max);
 		return -EINVAL;
 	}
 
-- 
2.4.10

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
