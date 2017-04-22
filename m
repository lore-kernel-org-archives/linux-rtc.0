Return-Path: <rtc-linux+bncBAABBI5F53DQKGQE7K7PYHQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from know-smtprelay-omc-8.server.virginmedia.net (know-smtprelay-omc-8.server.virginmedia.net. [80.0.253.72])
        by gmr-mx.google.com with ESMTPS id f194si266825wmg.0.2017.04.22.10.28.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 22 Apr 2017 10:28:02 -0700 (PDT)
Date: Sat, 22 Apr 2017 18:28:00 +0100
From: David Lowe <dave-lowe@ntlworld.com>
To: rtc-linux <rtc-linux@googlegroups.com>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [Patch] rtc: rtc-ds1307: enable support for mcp794xx as a
 wakeup source without IRQ
Message-ID: <20170422182800.460265ba@pixelzero>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patch extends the fixes for ds1337, ds1339, ds3231 in 8bc2a40730ec
to mcp794xx devices, so that those parts can similarly be used as a wakeup
source without an IRQ to the processor.

Tested on Raspberry Pi ZeroW with MCP79400.

Signed-off-by: David Lowe <dave-lowe@ntlworld.com>
---
--- a/drivers/rtc/rtc-ds1307.c	2017-03-28 16:16:38.158076224 +0100
+++ b/drivers/rtc/rtc-ds1307.c	2017-03-28 16:16:52.248431799 +0100
@@ -1487,7 +1487,8 @@ static int ds1307_probe(struct i2c_clien
 		break;
 	case mcp794xx:
 		rtc_ops = &mcp794xx_rtc_ops;
-		if (ds1307->client->irq > 0 && chip->alarm) {
+		if (chip->alarm && (ds1307->client->irq > 0 ||
+						ds1307_can_wakeup_device)) {
 			irq_handler = mcp794xx_irq;
 			want_irq = true;
 		}

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
