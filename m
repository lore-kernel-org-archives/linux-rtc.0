Return-Path: <rtc-linux+bncBDQNTZVC44FBB3EGQG4AKGQEVWLHP6I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailhost.home (mailhost.ilcode.fr. [2a01:240:fe87:2::2])
        by gmr-mx.google.com with ESMTPS id 185si141424wml.0.2016.04.02.15.10.51
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 15:10:51 -0700 (PDT)
Date: Sun, 3 Apr 2016 00:10:47 +0200
From: Nicolas Boullis <nboullis@debian.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 2/2] rtc: ds1307: clear the interrupts on probe
Message-ID: <20160402221047.GB3600@haddock.home>
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

When the alarm is used to switch the computer on, the interrupts are 
disabled, but the interrupt flags are not cleared.

When the alarm is set, later, the interrupt is enabled and the interrupt 
flags are cleared. Unfortunately, at least with my DS1339 chip, it 
behaves as if the interrupt was enabled before the flag was cleared, so 
the interrupt is triggered.

With this patch, the interrupt flags are cleared when the chip is 
probed, so an interrupt is not triggered when the alarm is set.

Signed-off-by: Nicolas Boullis <nboullis@debian.org>

---

Not sure if I should check for errors with (tmp != 2) to be consistent 
with the check after reading the same block, a few lines above, or with 
(tmp < 0)...

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index b2156ee..19e7353 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1320,19 +1324,24 @@ static int ds1307_probe(struct i2c_client *client,
 			ds1307->regs[0] |= DS1337_BIT_INTCN
 					| bbsqi_bitpos[ds1307->type];
 			ds1307->regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
+			ds1307->regs[1] &= ~(DS1337_BIT_A2I | DS1337_BIT_A1I);
 
 			want_irq = true;
 		}
 
-		i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL,
-							ds1307->regs[0]);
-
 		/* oscillator fault?  clear flag, and warn */
 		if (ds1307->regs[1] & DS1337_BIT_OSF) {
-			i2c_smbus_write_byte_data(client, DS1337_REG_STATUS,
-				ds1307->regs[1] & ~DS1337_BIT_OSF);
 			dev_warn(&client->dev, "SET TIME!\n");
 		}
+
+		tmp = ds1307->write_block_data(ds1307->client,
+				DS1337_REG_CONTROL, 2, buf);
+		if (tmp != 2) {
+			dev_dbg(&client->dev, "write error %d\n", tmp);
+			err = -EIO;
+			goto exit;
+		}
+
 		break;
 
 	case rx_8025:

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
