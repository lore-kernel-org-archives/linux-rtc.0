Return-Path: <rtc-linux+bncBDKOBWPM5ABRBZ65QO5QKGQEWTJQFFI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com. [2607:f8b0:400e:c00::242])
        by gmr-mx.google.com with ESMTPS id tp10si3983394pac.2.2016.06.14.23.00.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 23:00:06 -0700 (PDT)
Received: by mail-pf0-x242.google.com with SMTP id c74so998094pfb.0
        for <rtc-linux@googlegroups.com>; Tue, 14 Jun 2016 23:00:06 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [rtc-linux] [PATCH 02/13] RTC: ds1307: Disable square wave and timers
 as default
Date: Tue, 14 Jun 2016 22:59:28 -0700
Message-Id: <1465970379-14703-3-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
References: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Disable square wave and timers as default for DS1337/39/41 and
DS3231. The rationale being that configuring a chip this way puts it
into a known state with lower power consumption. While it is not very
likely it is still possible that the code controlling RTCs that ran
before this driver configured it to produce square wave and left it in
such a state.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 7e65e2e..c618c22 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1320,19 +1320,17 @@ static int ds1307_probe(struct i2c_client *client,
 			ds1307->regs[0] &= ~DS1337_BIT_nEOSC;
 
 		/*
-		 * Using IRQ or defined as wakeup-source?
 		 * Disable the square wave and both alarms.
 		 * For some variants, be sure alarms can trigger when we're
 		 * running on Vbackup (BBSQI/BBSQW)
 		 */
-		if (chip->alarm && (ds1307->client->irq > 0 ||
-						ds1307_can_wakeup_device)) {
-			ds1307->regs[0] |= DS1337_BIT_INTCN
-					| bbsqi_bitpos[ds1307->type];
-			ds1307->regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
+		ds1307->regs[0] |= DS1337_BIT_INTCN
+			| bbsqi_bitpos[ds1307->type];
+		ds1307->regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
 
+		if (chip->alarm && (ds1307->client->irq > 0 ||
+				    ds1307_can_wakeup_device))
 			want_irq = true;
-		}
 
 		i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL,
 							ds1307->regs[0]);
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
