Return-Path: <rtc-linux+bncBCNNJWF7RUMRBDXVVK2AKGQEY2JFU5I@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com. [2607:f8b0:400e:c00::244])
        by gmr-mx.google.com with ESMTPS id ui7si3849854pab.0.2016.01.04.10.31.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2016 10:31:42 -0800 (PST)
Received: by mail-pf0-x244.google.com with SMTP id 65so16354733pff.1
        for <rtc-linux@googlegroups.com>; Mon, 04 Jan 2016 10:31:42 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH v2 5/8] rtc-pcf2123: avoid resetting the clock if possible
Date: Mon,  4 Jan 2016 10:31:23 -0800
Message-Id: <5cf4df19b95b0bdacd2472cf68eef3e9aa04804c.1451929910.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1451928661.git.stillcompiling@gmail.com>
References: <cover.1451928661.git.stillcompiling@gmail.com>
In-Reply-To: <0000-cover-letter.patch>
References: <0000-cover-letter.patch>
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
 drivers/rtc/rtc-pcf2123.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 2d886d4..d9a44ad 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -215,6 +215,11 @@ static int pcf2123_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	if (ret < 0)
 		return ret;
 
+	if (rxbuf[0] & OSC_HAS_STOPPED) {
+		dev_info(dev, "clock was stopped. Time is not valid\n");
+		return -EINVAL;
+	}
+
 	tm->tm_sec = bcd2bin(rxbuf[0] & 0x7F);
 	tm->tm_min = bcd2bin(rxbuf[1] & 0x7F);
 	tm->tm_hour = bcd2bin(rxbuf[2] & 0x3F); /* rtc hr 0-23 */
@@ -314,6 +319,7 @@ static const struct rtc_class_ops pcf2123_rtc_ops = {
 static int pcf2123_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
+	struct rtc_time tm;
 	struct pcf2123_plat_data *pdata;
 	int ret, i;
 
@@ -323,10 +329,13 @@ static int pcf2123_probe(struct spi_device *spi)
 		return -ENOMEM;
 	spi->dev.platform_data = pdata;
 
-	ret = pcf2123_reset(&spi->dev);
+	ret = pcf2123_rtc_read_time(&spi->dev, &tm);
 	if (ret < 0) {
-		dev_err(&spi->dev, "chip not found\n");
-		goto kfree_exit;
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
