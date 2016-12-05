Return-Path: <rtc-linux+bncBCW4XG6ATMLBBH6PSXBAKGQEC35EN5Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com. [2607:f8b0:400d:c0d::244])
        by gmr-mx.google.com with ESMTPS id v18si206536ywc.5.2016.12.05.05.11.59
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2016 05:11:59 -0800 (PST)
Received: by mail-qt0-x244.google.com with SMTP id l20so35728588qta.1
        for <rtc-linux@googlegroups.com>; Mon, 05 Dec 2016 05:11:59 -0800 (PST)
From: Emil Bartczak <emilbart@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Emil Bartczak <emilbart@gmail.com>
Subject: [rtc-linux] [PATCH 2/4] rtc: mcp795: fix time range difference
 between linux and RTC chip
Date: Mon,  5 Dec 2016 14:11:51 +0100
Message-Id: <392135d01f90d405b3b5aceb6bcbb51ccf1be378.1480939487.git.emilbart@gmail.com>
In-Reply-To: <cover.1480939487.git.emilbart@gmail.com>
References: <cover.1480939487.git.emilbart@gmail.com>
In-Reply-To: <cover.1480939487.git.emilbart@gmail.com>
References: <cover.1480939487.git.emilbart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

In linux rtc_time struct, tm_mon range is 0~11, while in RTC HW REG,
month range is 1~12. This patch adjusts difference of them.
---
 drivers/rtc/rtc-mcp795.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 266328b..d15072c 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -96,6 +96,7 @@ static int mcp795_rtcc_set_bits(struct device *dev, u8 addr, u8 mask, u8 state)
 
 static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 {
+	int month;
 	int ret;
 	u8 data[7];
 
@@ -109,8 +110,9 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 	data[1] = (data[1] & 0x80) | ((tim->tm_min / 10) << 4) | (tim->tm_min % 10);
 	data[2] = ((tim->tm_hour / 10) << 4) | (tim->tm_hour % 10);
 	data[4] = ((tim->tm_mday / 10) << 4) | ((tim->tm_mday) % 10);
+	month = tim->tm_mon + 1;
 	data[5] = (data[5] & MCP795_LP_BIT) |
-			((tim->tm_mon / 10) << 4) | (tim->tm_mon % 10);
+			((month / 10) << 4) | (month % 10);
 
 	if (tim->tm_year > 100)
 		tim->tm_year -= 100;
@@ -143,7 +145,7 @@ static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
 	tim->tm_min	= ((data[1] & 0x70) >> 4) * 10 + (data[1] & 0x0f);
 	tim->tm_hour	= ((data[2] & 0x30) >> 4) * 10 + (data[2] & 0x0f);
 	tim->tm_mday	= ((data[4] & 0x30) >> 4) * 10 + (data[4] & 0x0f);
-	tim->tm_mon	= ((data[5] & 0x10) >> 4) * 10 + (data[5] & 0x0f);
+	tim->tm_mon	= ((data[5] & 0x10) >> 4) * 10 + (data[5] & 0x0f) - 1;
 	tim->tm_year	= ((data[6] & 0xf0) >> 4) * 10 + (data[6] & 0x0f) + 100; /* Assume we are in 20xx */
 
 	dev_dbg(dev, "Read from mcp795: %04d-%02d-%02d %02d:%02d:%02d\n",
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
