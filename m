Return-Path: <rtc-linux+bncBAABBLV7525QKGQESDMDMKQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.phycard.co.uk. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id a6si169152wma.1.2016.07.05.04.53.18
        for <rtc-linux@googlegroups.com>;
        Tue, 05 Jul 2016 04:53:18 -0700 (PDT)
From: Stefan Christ <s.christ@phytec.de>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com, rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 1/2] rtc: m41t80: make it a real error message
Date: Tue, 5 Jul 2016 13:53:16 +0200
Message-Id: <1467719597-5593-1-git-send-email-s.christ@phytec.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

It should be a real error message, when the driver cannot enable the IRQ
of the device.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
 drivers/rtc/rtc-m41t80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index d1bf93a..04e8577 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -244,7 +244,7 @@ static int m41t80_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 	retval = i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON, flags);
 	if (retval < 0) {
-		dev_info(dev, "Unable to enable alarm IRQ %d\n", retval);
+		dev_err(dev, "Unable to enable alarm IRQ %d\n", retval);
 		return retval;
 	}
 	return 0;
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
