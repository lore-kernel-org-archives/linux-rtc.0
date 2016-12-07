Return-Path: <rtc-linux+bncBCW4XG6ATMLBB5VVULBAKGQEBL4MVZY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com. [2a00:1450:400c:c09::241])
        by gmr-mx.google.com with ESMTPS id o77si1201360wme.0.2016.12.07.15.27.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 15:27:50 -0800 (PST)
Received: by mail-wm0-x241.google.com with SMTP id m203so31018352wma.3
        for <rtc-linux@googlegroups.com>; Wed, 07 Dec 2016 15:27:50 -0800 (PST)
From: Emil Bartczak <emilbart@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Emil Bartczak <emilbart@gmail.com>
Subject: [rtc-linux] [PATCH v2 2/6] rtc: mcp795: fix bitmask value for leap
 year (LP).
Date: Thu,  8 Dec 2016 00:27:38 +0100
Message-Id: <f21295c3c85abdeff2ffa62146ccc0ad4faee72b.1481151278.git.emilbart@gmail.com>
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

According the datasheet the leap year is a fifth bit in month register.

Signed-off-by: Emil Bartczak <emilbart@gmail.com>
---
 drivers/rtc/rtc-mcp795.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 0389ee0..5fbdb4c 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -40,6 +40,7 @@
 
 #define MCP795_ST_BIT	0x80
 #define MCP795_24_BIT	0x40
+#define MCP795_LP_BIT	BIT(5)
 
 static int mcp795_rtcc_read(struct device *dev, u8 addr, u8 *buf, u8 count)
 {
@@ -109,7 +110,7 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 	data[1] = (data[1] & 0x80) | bin2bcd(tim->tm_min);
 	data[2] = bin2bcd(tim->tm_hour);
 	data[4] = bin2bcd(tim->tm_mday);
-	data[5] = (data[5] & 0x10) | bin2bcd(tim->tm_mon);
+	data[5] = (data[5] & MCP795_LP_BIT) | bin2bcd(tim->tm_mon);
 
 	if (tim->tm_year > 100)
 		tim->tm_year -= 100;
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
