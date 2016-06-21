Return-Path: <rtc-linux+bncBDKOBWPM5ABRBYOVUO5QKGQEM7SSM4Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com. [2607:f8b0:400e:c03::244])
        by gmr-mx.google.com with ESMTPS id 62si7278635pfx.1.2016.06.21.00.21.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 00:21:04 -0700 (PDT)
Received: by mail-pa0-x244.google.com with SMTP id hf6so732601pac.2
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 00:21:04 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	cphealy@gmail.com
Subject: [rtc-linux] [PATCH v2 01/17] RTC: ds1307: Add DS1341 variant
Date: Tue, 21 Jun 2016 00:20:50 -0700
Message-Id: <1466493650-11509-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 821d9c0..7e65e2e 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -35,6 +35,7 @@ enum ds_type {
 	ds_1338,
 	ds_1339,
 	ds_1340,
+	ds_1341,
 	ds_1388,
 	ds_3231,
 	m41t00,
@@ -178,6 +179,7 @@ static const struct i2c_device_id ds1307_id[] = {
 	{ "ds1337", ds_1337 },
 	{ "ds1338", ds_1338 },
 	{ "ds1339", ds_1339 },
+	{ "ds1341", ds_1341 },
 	{ "ds1388", ds_1388 },
 	{ "ds1340", ds_1340 },
 	{ "ds3231", ds_3231 },
@@ -424,6 +426,7 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 	case ds_1337:
 	case ds_1339:
 	case ds_3231:
+	case ds_1341:
 		buf[DS1307_REG_MONTH] |= DS1337_BIT_CENTURY;
 		break;
 	case ds_1340:
@@ -1242,6 +1245,7 @@ static int ds1307_probe(struct i2c_client *client,
 
 	static const int	bbsqi_bitpos[] = {
 		[ds_1337] = 0,
+		[ds_1341] = 0,
 		[ds_1339] = DS1339_BIT_BBSQI,
 		[ds_3231] = DS3231_BIT_BBSQW,
 	};
@@ -1301,6 +1305,7 @@ static int ds1307_probe(struct i2c_client *client,
 	case ds_1337:
 	case ds_1339:
 	case ds_3231:
+	case ds_1341:
 		/* get registers that the "rtc" read below won't read... */
 		tmp = ds1307->read_block_data(ds1307->client,
 				DS1337_REG_CONTROL, 2, buf);
-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
