Return-Path: <rtc-linux+bncBAABBU6R4TEQKGQE5RUSNQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail01.prevas.se (mail01.prevas.se. [62.95.78.3])
        by gmr-mx.google.com with ESMTPS id v127si457974wmd.4.2017.06.08.03.37.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2017 03:37:07 -0700 (PDT)
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <rtc-linux@googlegroups.com>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: [rtc-linux] [PATCH 2/2] rtc: ds1307: disable square wave output from ds1308
Date: Thu, 8 Jun 2017 12:36:55 +0200
Message-ID: <20170608103655.20043-2-sean.nyekjaer@prevas.dk>
In-Reply-To: <20170608103655.20043-1-sean.nyekjaer@prevas.dk>
References: <20170608103655.20043-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Disable sqw output from ds1308 in order to reduce
the power consumption by ~50%.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 drivers/rtc/rtc-ds1307.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index a4ef03ad9395..8d9f25a3c757 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -78,6 +78,7 @@ enum ds_type {
 #	define DS1307_BIT_OUT		0x80
 #	define DS1338_BIT_OSF		0x20
 #	define DS1307_BIT_SQWE		0x10
+#	define DS1308_BIT_BBCLK		0x04
 #	define DS1307_BIT_RS1		0x02
 #	define DS1307_BIT_RS0		0x01
 #define DS1337_REG_CONTROL	0x0e
@@ -1454,6 +1455,11 @@ static int ds1307_probe(struct i2c_client *client,
 		}
 		break;
 	case ds_1308:
+		/* disable sqw when driven from battery backup */
+		if (ds1307->regs[DS1307_REG_CONTROL] & DS1308_BIT_BBCLK)
+			i2c_smbus_write_byte_data(client, DS1307_REG_CONTROL,
+					ds1307->regs[DS1307_REG_CONTROL]
+					& ~DS1338_BIT_BBCLK);
 	case ds_1338:
 		/* clock halted?  turn it on, so clock can tick. */
 		if (tmp & DS1307_BIT_CH)
-- 
2.13.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
