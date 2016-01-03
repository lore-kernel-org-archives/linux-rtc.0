Return-Path: <rtc-linux+bncBCOML4NU3EDRBK6EUO2AKGQELP7ZATY@googlegroups.com>
Received: from mout.web.de (mout.web.de. [212.227.17.12])
        by gmr-mx.google.com with ESMTPS id b4si904554wme.3.2016.01.03.00.56.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2016 00:56:10 -0800 (PST)
Subject: [rtc-linux] [PATCH 7/8] rtc-ab-b5ze-s3: Delete an unnecessary
 variable in _abb5zes3_rtc_interrupt()
To: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5688DF2D.6090204@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5688E229.4010400@users.sourceforge.net>
Date: Sun, 3 Jan 2016 09:56:09 +0100
MIME-Version: 1.0
In-Reply-To: <5688DF2D.6090204@users.sourceforge.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 3 Jan 2016 09:00:30 +0100

Pass the address of the data structure element "time" directly in calls
of the function "rtc_update_irq" instead of an extra initialisation
for one local variable at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index e3a015a..88f1d0b 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -816,7 +816,6 @@ static irqreturn_t _abb5zes3_rtc_interrupt(int irq, void *data)
 	struct i2c_client *client = data;
 	struct device *dev = &client->dev;
 	struct abb5zes3_rtc_data *rtc_data = dev_get_drvdata(dev);
-	struct rtc_device *rtc = rtc_data->rtc;
 	u8 regs[ABB5ZES3_CTRL_SEC_LEN];
 	int ret, handled = IRQ_NONE;
 
@@ -844,8 +843,7 @@ static irqreturn_t _abb5zes3_rtc_interrupt(int irq, void *data)
 	/* Check alarm flag */
 	if (regs[ABB5ZES3_REG_CTRL2] & ABB5ZES3_REG_CTRL2_AF) {
 		dev_dbg(dev, "RTC alarm!\n");
-
-		rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
+		rtc_update_irq(rtc_data->rtc, 1, RTC_IRQF | RTC_AF);
 
 		/* Acknowledge and disable the alarm */
 		_abb5zes3_rtc_clear_alarm(dev);
@@ -857,8 +855,7 @@ static irqreturn_t _abb5zes3_rtc_interrupt(int irq, void *data)
 	/* Check watchdog Timer A flag */
 	if (regs[ABB5ZES3_REG_CTRL2] & ABB5ZES3_REG_CTRL2_WTAF) {
 		dev_dbg(dev, "RTC timer!\n");
-
-		rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
+		rtc_update_irq(rtc_data->rtc, 1, RTC_IRQF | RTC_AF);
 
 		/*
 		 * Acknowledge and disable the alarm. Note: WTAF
-- 
2.6.3

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
