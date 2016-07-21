Return-Path: <rtc-linux+bncBDSJR27JS4DBB6WNYK6AKGQEZZNIOQQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from authsmtp.register.it (authsmtp77.register.it. [195.110.122.162])
        by gmr-mx.google.com with ESMTPS id p199si12237wmd.1.2016.07.21.03.42.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Jul 2016 03:42:02 -0700 (PDT)
From: =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	=?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
Subject: [rtc-linux] [PATCH 3/6] rtc: rv8803: Fix read day of week
Date: Thu, 21 Jul 2016 12:41:29 +0200
Message-Id: <1469097692-103146-3-git-send-email-benoit@wsystem.com>
In-Reply-To: <1469097692-103146-1-git-send-email-benoit@wsystem.com>
References: <1469097692-103146-1-git-send-email-benoit@wsystem.com>
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

The Weekday register is encoded as 2^tm_wday, with tm_wday in 0..6, so
using tm_wday =3D ffs(reg) to fill tm_wday from the register value is
wrong because this gives the expected value + 1. This could be fixed as
tm_wday =3D ffs(reg) - 1, but tm_wday =3D ilog2(reg) works as well and is
more direct.

Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>
---
 drivers/rtc/rtc-rv8803.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index e740c83..aa1d6b6 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -13,6 +13,7 @@
=20
 #include <linux/bcd.h>
 #include <linux/bitops.h>
+#include <linux/log2.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -145,7 +146,7 @@ static int rv8803_get_time(struct device *dev, struct r=
tc_time *tm)
 	tm->tm_sec  =3D bcd2bin(date[RV8803_SEC] & 0x7f);
 	tm->tm_min  =3D bcd2bin(date[RV8803_MIN] & 0x7f);
 	tm->tm_hour =3D bcd2bin(date[RV8803_HOUR] & 0x3f);
-	tm->tm_wday =3D ffs(date[RV8803_WEEK] & 0x7f);
+	tm->tm_wday =3D ilog2(date[RV8803_WEEK] & 0x7f);
 	tm->tm_mday =3D bcd2bin(date[RV8803_DAY] & 0x3f);
 	tm->tm_mon  =3D bcd2bin(date[RV8803_MONTH] & 0x1f) - 1;
 	tm->tm_year =3D bcd2bin(date[RV8803_YEAR]) + 100;
--=20
2.5.0

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
