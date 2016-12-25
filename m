Return-Path: <rtc-linux+bncBCW4XG6ATMLBBXPYQDBQKGQEKOXG4SY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id l66si3086755wml.0.2016.12.25.13.38.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Dec 2016 13:38:37 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id d16so11763631lfb.1
        for <rtc-linux@googlegroups.com>; Sun, 25 Dec 2016 13:38:37 -0800 (PST)
From: Emil Bartczak <emilbart@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Emil Bartczak <emilbart@gmail.com>
Subject: [rtc-linux] [PATCH 1/2] rtc: mcp795: Add support for weekday.
Date: Sun, 25 Dec 2016 22:38:28 +0100
Message-Id: <1482701909-8714-1-git-send-email-emilbart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patch adds support for saving/loading weekday value from the chip.

Signed-off-by: Emil Bartczak <emilbart@gmail.com>
---
 drivers/rtc/rtc-mcp795.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index ce75e42..8107fc0 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -170,6 +170,7 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 	data[0] = (data[0] & 0x80) | bin2bcd(tim->tm_sec);
 	data[1] = (data[1] & 0x80) | bin2bcd(tim->tm_min);
 	data[2] = bin2bcd(tim->tm_hour);
+	data[3] = (data[3] & 0xF8) | bin2bcd(tim->tm_wday + 1);
 	data[4] = bin2bcd(tim->tm_mday);
 	data[5] = (data[5] & MCP795_LP_BIT) | bin2bcd(tim->tm_mon + 1);
 
@@ -198,9 +199,9 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 	if (ret)
 		return ret;
 
-	dev_dbg(dev, "Set mcp795: %04d-%02d-%02d %02d:%02d:%02d\n",
+	dev_dbg(dev, "Set mcp795: %04d-%02d-%02d(%d) %02d:%02d:%02d\n",
 			tim->tm_year + 1900, tim->tm_mon, tim->tm_mday,
-			tim->tm_hour, tim->tm_min, tim->tm_sec);
+			tim->tm_wday, tim->tm_hour, tim->tm_min, tim->tm_sec);
 
 	return 0;
 }
@@ -218,13 +219,14 @@ static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
 	tim->tm_sec	= bcd2bin(data[0] & 0x7F);
 	tim->tm_min	= bcd2bin(data[1] & 0x7F);
 	tim->tm_hour	= bcd2bin(data[2] & 0x3F);
+	tim->tm_wday	= bcd2bin(data[3] & 0x07) - 1;
 	tim->tm_mday	= bcd2bin(data[4] & 0x3F);
 	tim->tm_mon	= bcd2bin(data[5] & 0x1F) - 1;
 	tim->tm_year	= bcd2bin(data[6]) + 100; /* Assume we are in 20xx */
 
-	dev_dbg(dev, "Read from mcp795: %04d-%02d-%02d %02d:%02d:%02d\n",
-				tim->tm_year + 1900, tim->tm_mon, tim->tm_mday,
-				tim->tm_hour, tim->tm_min, tim->tm_sec);
+	dev_dbg(dev, "Read from mcp795: %04d-%02d-%02d(%d) %02d:%02d:%02d\n",
+			tim->tm_year + 1900, tim->tm_mon, tim->tm_mday,
+			tim->tm_wday, tim->tm_hour, tim->tm_min, tim->tm_sec);
 
 	return rtc_valid_tm(tim);
 }
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
