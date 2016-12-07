Return-Path: <rtc-linux+bncBCW4XG6ATMLBB6FVULBAKGQEVLHBFBI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com. [2a00:1450:400c:c09::244])
        by gmr-mx.google.com with ESMTPS id s81si1012557wmf.3.2016.12.07.15.27.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 15:27:52 -0800 (PST)
Received: by mail-wm0-x244.google.com with SMTP id a20so31171327wme.2
        for <rtc-linux@googlegroups.com>; Wed, 07 Dec 2016 15:27:52 -0800 (PST)
From: Emil Bartczak <emilbart@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Emil Bartczak <emilbart@gmail.com>
Subject: [rtc-linux] [PATCH v2 3/6] rtc: mcp795: fix time range difference
 between linux and RTC chip.
Date: Thu,  8 Dec 2016 00:27:39 +0100
Message-Id: <20cd15adcd8ffcf603987f6d928f6b7762eb1e58.1481151278.git.emilbart@gmail.com>
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

In linux rtc_time struct, tm_mon range is 0~11, while in RTC HW REG,
month range is 1~12. This patch adjusts difference of them.

Signed-off-by: Emil Bartczak <emilbart@gmail.com>
---
 drivers/rtc/rtc-mcp795.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 5fbdb4c..4618f4f 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -110,7 +110,7 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 	data[1] = (data[1] & 0x80) | bin2bcd(tim->tm_min);
 	data[2] = bin2bcd(tim->tm_hour);
 	data[4] = bin2bcd(tim->tm_mday);
-	data[5] = (data[5] & MCP795_LP_BIT) | bin2bcd(tim->tm_mon);
+	data[5] = (data[5] & MCP795_LP_BIT) | bin2bcd(tim->tm_mon + 1);
 
 	if (tim->tm_year > 100)
 		tim->tm_year -= 100;
@@ -143,7 +143,7 @@ static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
 	tim->tm_min	= bcd2bin(data[1] & 0x7F);
 	tim->tm_hour	= bcd2bin(data[2] & 0x3F);
 	tim->tm_mday	= bcd2bin(data[4] & 0x3F);
-	tim->tm_mon	= bcd2bin(data[5] & 0x1F);
+	tim->tm_mon	= bcd2bin(data[5] & 0x1F) - 1;
 	tim->tm_year	= bcd2bin(data[6]) + 100; /* Assume we are in 20xx */
 
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
