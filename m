Return-Path: <rtc-linux+bncBCNNJWF7RUMRBKGM5CYQKGQE7DUQOFQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com. [2607:f8b0:400e:c03::232])
        by gmr-mx.google.com with ESMTPS id fa8si182608pab.1.2015.11.04.07.37.11
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 07:37:11 -0800 (PST)
Received: by mail-pa0-x232.google.com with SMTP id fh17so56007588pab.0
        for <rtc-linux@googlegroups.com>; Wed, 04 Nov 2015 07:37:11 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH 6/9] rtc-pcf2123: avoid resetting the clock if possible
Date: Wed,  4 Nov 2015 07:36:37 -0800
Message-Id: <f801d4f26d4c4944b1a5353d5b5fde4e507b45b2.1446587705.git.stillcompiling@gmail.com>
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

pcf2123 data sheet recommends a software reset when the chip
is first powered on. This change avoids resetting the chip
every time the driver is loaded, which has some negative effects.

There are several registers including a clock rate adjustment that really
should survive a reload of the driver (or reboot).

In addition, stopping and restarting the clock to verify the chip is
there is not a good thing once the time is set.

According to the data sheet, the seconds register has a 1 in
the high bit when the voltage has gotten low. We check for this
condition, as well as whether the time retrieved from the chip is
valid. We reset the rtc only if the time is not reliable and valid.
This is sufficient for checking for the presence of the chip,
as either all zeros or all 0xff will result in an invalid time/date

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/rtc/rtc-pcf2123.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index d3c1447..4964d5c 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -260,6 +260,33 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
+static bool pcf2123_time_valid(struct device *dev)
+{
+	u8 seconds;
+	struct rtc_time tm;
+	int ret;
+
+	ret = pcf2123_read(dev, PCF2123_REG_SC, &seconds, 1);
+	if (ret < 0)
+		return false;
+
+	if (seconds & OSC_HAS_STOPPED) {
+		dev_info(dev, "clock was stopped. seconds: 0x%02X\n", seconds);
+		return false;
+	}
+
+	ret = pcf2123_rtc_read_time(dev, &tm);
+	if (ret < 0)
+		return false;
+
+	if (rtc_valid_tm(&tm) < 0) {
+		dev_err(dev, "retrieved date/time is not valid.\n");
+		return false;
+	}
+
+	return true;
+}
+
 static int pcf2123_reset(struct device *dev)
 {
 	int ret;
@@ -311,10 +338,12 @@ static int pcf2123_probe(struct spi_device *spi)
 		return -ENOMEM;
 	spi->dev.platform_data = pdata;
 
-	ret = pcf2123_reset(&spi->dev);
-	if (ret < 0) {
-		dev_err(&spi->dev, "chip not found\n");
-		goto kfree_exit;
+	if (!pcf2123_time_valid(&spi->dev)) {
+		ret = pcf2123_reset(&spi->dev);
+		if (ret < 0) {
+			dev_err(&spi->dev, "chip not found\n");
+			goto kfree_exit;
+		}
 	}
 
 	dev_info(&spi->dev, "chip found, driver version " DRV_VERSION "\n");
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
