Return-Path: <rtc-linux+bncBAABB65QY7CAKGQEQR2GDMQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail02.prevas.se (mail02.prevas.se. [62.95.78.10])
        by gmr-mx.google.com with ESMTPS id q4si1666316wma.3.2017.02.01.04.45.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2017 04:45:46 -0800 (PST)
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: rtc-linux@googlegroups.com
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	alexandre.belloni@free-electrons.com
Subject: [rtc-linux] [PATCH] rtc: pcf2127: bulk read only date and time registers.
Date: Wed,  1 Feb 2017 13:45:25 +0100
Message-Id: <20170201124525.36578-1-sean.nyekjaer@prevas.dk>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Read control registers one by one and bulk read time registers.
This fixes when the clock is read, the watchdog counter register is zeroed.

The problem is latent without the watchdog patch

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
Only tested on pcf2127.
I think the pcf2127 have an issue when the register auto-incr is used,
when bulk reading the time the watchdog counter is zeroed and stopped.

 drivers/rtc/rtc-pcf2127.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 8abc4eb8f289..f54a42b419b5 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -403,9 +403,21 @@ static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
 	unsigned char buf[10];
 	int ret;
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		ret =
+		    regmap_read(pcf2127->regmap, PCF2127_REG_CTRL1 + i,
+				(unsigned int *)(buf + i));
+		if (ret) {
+			dev_err(dev, "%s: read error\n", __func__);
+			return ret;
+		}
+	}
 
-	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL1, buf,
-				sizeof(buf));
+	ret =
+	    regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL1 + 3, (buf + 3),
+			     7);
 	if (ret) {
 		dev_err(dev, "%s: read error\n", __func__);
 		return ret;
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
