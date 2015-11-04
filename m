Return-Path: <rtc-linux+bncBCNNJWF7RUMRBJWM5CYQKGQEWBCQ5AI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com. [2607:f8b0:400e:c03::22d])
        by gmr-mx.google.com with ESMTPS id el2si190828pbb.0.2015.11.04.07.37.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 07:37:08 -0800 (PST)
Received: by mail-pa0-x22d.google.com with SMTP id z6so57706706pas.2
        for <rtc-linux@googlegroups.com>; Wed, 04 Nov 2015 07:37:08 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH 4/9] rtc-pcf2123: replace magic numbers with defines
Date: Wed,  4 Nov 2015 07:36:35 -0800
Message-Id: <e239e183b907e072b2360a138f52fbdc201e1997.1446587705.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1446587705.git.stillcompiling@gmail.com>
References: <cover.1446587705.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1446587705.git.stillcompiling@gmail.com>
References: <cover.1446587705.git.stillcompiling@gmail.com>
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

All of the magic numbers pertain to register CTRL1.
document all the values in CTRL1 with defines from the datasheet

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/rtc/rtc-pcf2123.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 3acb2c8..257ce7d 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -234,7 +234,7 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
 			tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 
 	/* Stop the counter first */
-	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, 0x20);
+	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_STOP);
 	if (ret < 0)
 		return ret;
 
@@ -253,7 +253,7 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		return ret;
 
 	/* Start the counter */
-	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, 0x00);
+	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_CLEAR);
 	if (ret < 0)
 		return ret;
 
@@ -280,13 +280,13 @@ static int pcf2123_probe(struct spi_device *spi)
 
 	/* Send a software reset command */
 	dev_dbg(&spi->dev, "resetting RTC\n");
-	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, 0x58);
+	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, CTRL1_SW_RESET);
 	if (ret < 0)
 		goto kfree_exit;
 
 	/* Stop the counter */
 	dev_dbg(&spi->dev, "stopping RTC\n");
-	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, 0x20);
+	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, CTRL1_STOP);
 	if (ret < 0)
 		goto kfree_exit;
 
@@ -298,7 +298,7 @@ static int pcf2123_probe(struct spi_device *spi)
 	if (ret < 0)
 		goto kfree_exit;
 
-	if (!(rxbuf[0] & 0x20)) {
+	if (!(rxbuf[0] & CTRL1_STOP)) {
 		dev_err(&spi->dev, "chip not found\n");
 		ret = -ENODEV;
 		goto kfree_exit;
@@ -309,7 +309,7 @@ static int pcf2123_probe(struct spi_device *spi)
 			(spi->max_speed_hz + 500) / 1000);
 
 	/* Start the counter */
-	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, 0x00);
+	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, CTRL1_CLEAR);
 	if (ret < 0)
 		goto kfree_exit;
 
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
