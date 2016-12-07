Return-Path: <rtc-linux+bncBCW4XG6ATMLBB5FVULBAKGQE6HZQLGI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com. [2a00:1450:400c:c09::241])
        by gmr-mx.google.com with ESMTPS id p138si1166924wme.1.2016.12.07.15.27.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 15:27:48 -0800 (PST)
Received: by mail-wm0-x241.google.com with SMTP id g23so31106476wme.1
        for <rtc-linux@googlegroups.com>; Wed, 07 Dec 2016 15:27:48 -0800 (PST)
From: Emil Bartczak <emilbart@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Emil Bartczak <emilbart@gmail.com>
Subject: [rtc-linux] [PATCH v2 1/6] rtc: mcp795: use bcd2bin/bin2bcd.
Date: Thu,  8 Dec 2016 00:27:37 +0100
Message-Id: <943d1f040287db44d7bf674eb959c707d056c31c.1481151278.git.emilbart@gmail.com>
In-Reply-To: <cover.1481151278.git.emilbart@gmail.com>
References: <cover.1481151278.git.emilbart@gmail.com>
In-Reply-To: <cover.1481151278.git.emilbart@gmail.com>
References: <cover.1481151278.git.emilbart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Change rtc-mcp795.c to use the bcd2bin/bin2bcd functions.
This change fixes the wrong conversion of month value
from binary to BCD (missing right shift operation for 10 month).

Signed-off-by: Emil Bartczak <emilbart@gmail.com>
---
 drivers/rtc/rtc-mcp795.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 4021fd0..0389ee0 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -21,6 +21,7 @@
 #include <linux/spi/spi.h>
 #include <linux/rtc.h>
 #include <linux/of.h>
+#include <linux/bcd.h>
 
 /* MCP795 Instructions, see datasheet table 3-1 */
 #define MCP795_EEREAD	0x03
@@ -104,16 +105,16 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 	if (ret)
 		return ret;
 
-	data[0] = (data[0] & 0x80) | ((tim->tm_sec / 10) << 4) | (tim->tm_sec % 10);
-	data[1] = (data[1] & 0x80) | ((tim->tm_min / 10) << 4) | (tim->tm_min % 10);
-	data[2] = ((tim->tm_hour / 10) << 4) | (tim->tm_hour % 10);
-	data[4] = ((tim->tm_mday / 10) << 4) | ((tim->tm_mday) % 10);
-	data[5] = (data[5] & 0x10) | (tim->tm_mon / 10) | (tim->tm_mon % 10);
+	data[0] = (data[0] & 0x80) | bin2bcd(tim->tm_sec);
+	data[1] = (data[1] & 0x80) | bin2bcd(tim->tm_min);
+	data[2] = bin2bcd(tim->tm_hour);
+	data[4] = bin2bcd(tim->tm_mday);
+	data[5] = (data[5] & 0x10) | bin2bcd(tim->tm_mon);
 
 	if (tim->tm_year > 100)
 		tim->tm_year -= 100;
 
-	data[6] = ((tim->tm_year / 10) << 4) | (tim->tm_year % 10);
+	data[6] = bin2bcd(tim->tm_year);
 
 	ret = mcp795_rtcc_write(dev, 0x01, data, sizeof(data));
 
@@ -137,12 +138,12 @@ static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
 	if (ret)
 		return ret;
 
-	tim->tm_sec		= ((data[0] & 0x70) >> 4) * 10 + (data[0] & 0x0f);
-	tim->tm_min		= ((data[1] & 0x70) >> 4) * 10 + (data[1] & 0x0f);
-	tim->tm_hour	= ((data[2] & 0x30) >> 4) * 10 + (data[2] & 0x0f);
-	tim->tm_mday	= ((data[4] & 0x30) >> 4) * 10 + (data[4] & 0x0f);
-	tim->tm_mon		= ((data[5] & 0x10) >> 4) * 10 + (data[5] & 0x0f);
-	tim->tm_year	= ((data[6] & 0xf0) >> 4) * 10 + (data[6] & 0x0f) + 100; /* Assume we are in 20xx */
+	tim->tm_sec	= bcd2bin(data[0] & 0x7F);
+	tim->tm_min	= bcd2bin(data[1] & 0x7F);
+	tim->tm_hour	= bcd2bin(data[2] & 0x3F);
+	tim->tm_mday	= bcd2bin(data[4] & 0x3F);
+	tim->tm_mon	= bcd2bin(data[5] & 0x1F);
+	tim->tm_year	= bcd2bin(data[6]) + 100; /* Assume we are in 20xx */
 
 	dev_dbg(dev, "Read from mcp795: %04d-%02d-%02d %02d:%02d:%02d\n",
 				tim->tm_year + 1900, tim->tm_mon, tim->tm_mday,
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
