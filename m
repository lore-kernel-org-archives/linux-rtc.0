Return-Path: <rtc-linux+bncBDMLZJ6I5AIBBVMZWG6QKGQETE4BYEA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com. [2a00:1450:400c:c09::242])
        by gmr-mx.google.com with ESMTPS id i198si71599wmd.2.2016.08.11.03.00.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2016 03:00:53 -0700 (PDT)
Received: by mail-wm0-x242.google.com with SMTP id i5so370701wmg.2
        for <rtc-linux@googlegroups.com>; Thu, 11 Aug 2016 03:00:53 -0700 (PDT)
From: Daniel Romell <danielromell@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	daro@hms.se,
	jao@hms.se,
	mago@hms.se
Subject: [rtc-linux] [PATCH 1/2] rtc: bq32k: Use correct mask name for
 'minutes' register.
Date: Thu, 11 Aug 2016 11:59:14 +0200
Message-Id: <1470909555-9226-2-git-send-email-daro@hms.se>
In-Reply-To: <1470909555-9226-1-git-send-email-daro@hms.se>
References: <1470909555-9226-1-git-send-email-daro@hms.se>
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
