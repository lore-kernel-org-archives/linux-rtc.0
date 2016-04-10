Return-Path: <rtc-linux+bncBDQNTZVC44FBBIHPVC4AKGQEN6GWMHY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailhost.home (mailhost.ilcode.fr. [2a01:240:fe87:2::2])
        by gmr-mx.google.com with ESMTPS id u137si327186wmd.1.2016.04.10.04.23.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 10 Apr 2016 04:23:12 -0700 (PDT)
Date: Sun, 10 Apr 2016 13:23:05 +0200
From: Nicolas Boullis <nboullis@debian.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH] rtc: ds1307: ensure that any pending alarm is
 cleared before a new alarm is enabled
Message-ID: <20160410112305.GB3603@haddock.home>
References: <20160402221047.GB3600@haddock.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160402221047.GB3600@haddock.home>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

If a previously-set alarm was disabled and then triggered, it may still=20
be pending when a new alarm is configured.

Then, if the alarm is enabled before the pending alarm is cleared, then=20
an interrupt is immediately raised.

Unfortunately, when the alarm is cleared and enabled during the same I=C2=
=B2C=20
block write, the chip (at least the DS1339 I have) considers that the=20
alarm is enabled before it is cleared, and raises an interrupt.

This patch ensures that the pending alarm is cleared before the alarm is=20
enabled.

Signed-off-by: Nicolas Boullis <nboullis@debian.org>

---

This solves the same problem my =E2=80=9Crtc: ds1307: clear the interrupts =
on=20
probe=E2=80=9D patch was meant to solve, but I think in a better way since =
the=20
alarm may be triggered after power-on.

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index b2156ee..cceac0f 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -538,12 +542,8 @@ static int ds1337_set_alarm(struct device *dev, struct=
 rtc_wkalrm *t)
 	buf[5] =3D 0;
 	buf[6] =3D 0;
=20
-	/* optionally enable ALARM1 */
+	/* disable alarms */
 	buf[7] =3D control & ~(DS1337_BIT_A1IE | DS1337_BIT_A2IE);
-	if (t->enabled) {
-		dev_dbg(dev, "alarm IRQ armed\n");
-		buf[7] |=3D DS1337_BIT_A1IE;	/* only ALARM1 is used */
-	}
 	buf[8] =3D status & ~(DS1337_BIT_A1I | DS1337_BIT_A2I);
=20
 	ret =3D ds1307->write_block_data(client,
@@ -553,6 +553,13 @@ static int ds1337_set_alarm(struct device *dev, struct=
 rtc_wkalrm *t)
 		return ret;
 	}
=20
+	/* optionally enable ALARM1 */
+	if (t->enabled) {
+		dev_dbg(dev, "alarm IRQ armed\n");
+		buf[7] |=3D DS1337_BIT_A1IE;	/* only ALARM1 is used */
+		i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL, buf[7]);
+	}
+
 	return 0;
 }
=20

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
