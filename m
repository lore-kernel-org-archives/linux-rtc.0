Return-Path: <rtc-linux+bncBAABB2OVYW6QKGQEYLGNFVY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on0044.outbound.protection.outlook.com. [104.47.1.44])
        by gmr-mx.google.com with ESMTPS id ph9si2106674pac.1.2016.08.15.00.10.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 00:10:31 -0700 (PDT)
From: =?utf-8?B?SmFuIMOWc3RsdW5k?= <jao@hms.se>
To: Daniel Romell <danielromell@gmail.com>, "a.zummo@towertech.it"
	<a.zummo@towertech.it>
CC: "alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>, "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Daniel Romell <Daro@hms.se>, Magnus Olsson
	<Mago@hms.se>
Subject: [rtc-linux] RE: [PATCH v2 1/2] rtc: bq32k: Use correct mask name for
 'minutes' register.
Date: Mon, 15 Aug 2016 07:10:27 +0000
Message-ID: <DB4PR06MB2537EC6DC587FBA458D09FAD0120@DB4PR06MB253.eurprd06.prod.outlook.com>
References: <1470909555-9226-1-git-send-email-daro@hms.se>
 <1470915104-10683-2-git-send-email-daro@hms.se>
In-Reply-To: <1470915104-10683-2-git-send-email-daro@hms.se>
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
Subject: [PATCH v2 1/2] rtc: bq32k: Use correct mask name for 'minutes' reg=
ister.

From: Jan =C3=96stlund <jao@hms.se>

The BQ32K_SECONDS_MASK and BQ32K_MINUTES_MASK both has the same
value. This is no functional change.

Signed-off-by: Daniel Romell <daro@hms.se>
---
 drivers/rtc/rtc-bq32k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index 0299988..5a0c137 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -94,7 +94,7 @@ static int bq32k_rtc_read_time(struct device *dev, struct=
 rtc_time *tm)
 		return error;
=20
 	tm->tm_sec =3D bcd2bin(regs.seconds & BQ32K_SECONDS_MASK);
-	tm->tm_min =3D bcd2bin(regs.minutes & BQ32K_SECONDS_MASK);
+	tm->tm_min =3D bcd2bin(regs.minutes & BQ32K_MINUTES_MASK);
 	tm->tm_hour =3D bcd2bin(regs.cent_hours & BQ32K_HOURS_MASK);
 	tm->tm_mday =3D bcd2bin(regs.date);
 	tm->tm_wday =3D bcd2bin(regs.day) - 1;
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
