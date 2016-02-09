Return-Path: <rtc-linux+bncBCC6ZWOPXENRBHEM462QKGQEDUABYWI@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id w128si525336wmd.0.2016.02.09.02.57.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 02:57:31 -0800 (PST)
From: Juergen Borleis <jbe@pengutronix.de>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [rtc-linux] [PATCH v2 2/3] RTC/PCF85063: fix time/date reading
Date: Tue,  9 Feb 2016 11:57:26 +0100
Message-Id: <1455015447-13886-3-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1455015447-13886-1-git-send-email-jbe@pengutronix.de>
References: <1455015447-13886-1-git-send-email-jbe@pengutronix.de>
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

Check if the RTC signals an invalid time/date (due to a battery power loss
for example). In this case ignore the time/date until it is really set again.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/rtc/rtc-pcf85063.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 7f9caee..e0343e6 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -22,6 +22,7 @@
 #define PCF85063_REG_CTRL2		0x01
 
 #define PCF85063_REG_SC			0x04 /* datetime */
+#define PCF85063_REG_SC_OS		0x80
 #define PCF85063_REG_MN			0x05
 #define PCF85063_REG_HR			0x06
 #define PCF85063_REG_DM			0x07
@@ -62,6 +63,12 @@ static int pcf85063_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 		return -EIO;
 	}
 
+	/* if the clock has lost its power it makes no sense to use its time */
+	if (regs[0] & PCF85063_REG_SC_OS) {
+		dev_warn(&client->dev, "Power loss detected, invalid time\n");
+		return -EINVAL;
+	}
+
 	tm->tm_sec = bcd2bin(regs[0] & 0x7F);
 	tm->tm_min = bcd2bin(regs[1] & 0x7F);
 	tm->tm_hour = bcd2bin(regs[2] & 0x3F); /* rtc hr 0-23 */
-- 
2.7.0.rc3

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
