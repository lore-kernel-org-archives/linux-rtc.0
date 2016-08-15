Return-Path: <rtc-linux+bncBAABBA6WYW6QKGQEJPTB2EA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30041.outbound.protection.outlook.com. [40.107.3.41])
        by gmr-mx.google.com with ESMTPS id o123si732269ith.3.2016.08.15.00.10.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 00:10:58 -0700 (PDT)
From: =?utf-8?B?SmFuIMOWc3RsdW5k?= <jao@hms.se>
To: Daniel Romell <danielromell@gmail.com>, "a.zummo@towertech.it"
	<a.zummo@towertech.it>
CC: "alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>, "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Daniel Romell <Daro@hms.se>, Magnus Olsson
	<Mago@hms.se>
Subject: [rtc-linux] RE: [PATCH v2 2/2] rtc: bq32k: Fix handling of oscillator
 failure flag
Date: Mon, 15 Aug 2016 07:10:53 +0000
Message-ID: <DB4PR06MB2530178BF4DC79773EBC09BD0120@DB4PR06MB253.eurprd06.prod.outlook.com>
References: <1470909555-9226-1-git-send-email-daro@hms.se>
 <1470915104-10683-3-git-send-email-daro@hms.se>
In-Reply-To: <1470915104-10683-3-git-send-email-daro@hms.se>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Signed-off-by: Jan =C3=96stlund <jao@hms.se>

-----Original Message-----
From: Daniel Romell [mailto:danielromell@gmail.com]=20
Sent: den 11 augusti 2016 13:32
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com; rtc-linux@googlegroups.com; linux=
-kernel@vger.kernel.org; Daniel Romell <Daro@hms.se>; Jan =C3=96stlund <jao=
@hms.se>; Magnus Olsson <Mago@hms.se>
Subject: [PATCH v2 2/2] rtc: bq32k: Fix handling of oscillator failure flag

From: Jan =C3=96stlund <jao@hms.se>

While the oscillator failure flag is set, the RTC registers
should be considered invalid. bq32k_rtc_read_time() now
returns an error instead of an invalid time.

The failure flag is cleared the next time the clock is set.

Signed-off-by: Daniel Romell <daro@hms.se>
---
 drivers/rtc/rtc-bq32k.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index 5a0c137..3977424 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -93,6 +93,13 @@ static int bq32k_rtc_read_time(struct device *dev, struc=
t rtc_time *tm)
 	if (error)
 		return error;
=20
+	/*
+	 * In case of oscillator failure, the register contents should be
+	 * considered invalid. The flag is cleared the next time the RTC is set.
+	 */
+	if (regs.minutes & BQ32K_OF)
+		return -EINVAL;
+
 	tm->tm_sec =3D bcd2bin(regs.seconds & BQ32K_SECONDS_MASK);
 	tm->tm_min =3D bcd2bin(regs.minutes & BQ32K_MINUTES_MASK);
 	tm->tm_hour =3D bcd2bin(regs.cent_hours & BQ32K_HOURS_MASK);
@@ -204,13 +211,10 @@ static int bq32k_probe(struct i2c_client *client,
=20
 	/* Check Oscillator Failure flag */
 	error =3D bq32k_read(dev, &reg, BQ32K_MINUTES, 1);
-	if (!error && (reg & BQ32K_OF)) {
-		dev_warn(dev, "Oscillator Failure. Check RTC battery.\n");
-		reg &=3D ~BQ32K_OF;
-		error =3D bq32k_write(dev, &reg, BQ32K_MINUTES, 1);
-	}
 	if (error)
 		return error;
+	if (reg & BQ32K_OF)
+		dev_warn(dev, "Oscillator Failure. Check RTC battery.\n");
=20
 	if (client->dev.of_node)
 		trickle_charger_of_init(dev, client->dev.of_node);
--=20
2.7.4

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
