Return-Path: <rtc-linux+bncBAABBYEQRK4QKGQENKGEUAY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k143si16275wmg.1.2016.04.28.15.02.08
        for <rtc-linux@googlegroups.com>;
        Thu, 28 Apr 2016 15:02:08 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH V2 5/6] rtc: rv3029: fix alarm support
Date: Fri, 29 Apr 2016 00:00:36 +0200
Message-Id: <110190e646c33da59f84a6e96bc656c17a878c7e.1461879175.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1461879175.git.mylene.josserand@free-electrons.com>
References: <cover.1461879175.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1461879175.git.mylene.josserand@free-electrons.com>
References: <cover.1461250479.git.mylene.josserand@free-electrons.com> <cover.1461879175.git.mylene.josserand@free-electrons.com>
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

The RTC RV3029 handles different types of alarms : seconds, minutes, ...
These alarms can be enabled or disabled individually using an AE_x bit
which is the last bit (BIT(7)) on each alarm registers.

To prepare the alarm IRQ support, the current code enables all the alarm
types by setting each AE_x to 1.
It also fixes others alarms issues :
   - month and weekday errors : it was performing -1 instead of +1.
   - wrong use of bit mask with bin2bcd

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-rv3029c2.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index cf8d465..916bbc2 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -76,6 +76,7 @@
 #define RV3029_A_DW			0x14
 #define RV3029_A_MO			0x15
 #define RV3029_A_YR			0x16
+#define RV3029_A_AE_X			BIT(7)
 #define RV3029_ALARM_SECTION_LEN	0x07
=20
 /* timer section */
@@ -436,14 +437,22 @@ static int rv3029_set_alarm(struct device *dev, struc=
t rtc_wkalrm *alarm)
 		dev_err(dev, "%s: reading SR failed\n", __func__);
 		return -EIO;
 	}
-	regs[RV3029_A_SC - RV3029_A_SC] =3D bin2bcd(tm->tm_sec & 0x7f);
-	regs[RV3029_A_MN - RV3029_A_SC] =3D bin2bcd(tm->tm_min & 0x7f);
-	regs[RV3029_A_HR - RV3029_A_SC] =3D bin2bcd(tm->tm_hour & 0x3f);
-	regs[RV3029_A_DT - RV3029_A_SC] =3D bin2bcd(tm->tm_mday & 0x3f);
-	regs[RV3029_A_MO - RV3029_A_SC] =3D bin2bcd((tm->tm_mon & 0x1f) - 1);
-	regs[RV3029_A_DW - RV3029_A_SC] =3D bin2bcd((tm->tm_wday & 7) - 1);
-	regs[RV3029_A_YR - RV3029_A_SC] =3D bin2bcd((tm->tm_year & 0x7f) - 100);
=20
+	/* Activate all the alarms with AE_x bit */
+	regs[RV3029_A_SC - RV3029_A_SC] =3D bin2bcd(tm->tm_sec) | RV3029_A_AE_X;
+	regs[RV3029_A_MN - RV3029_A_SC] =3D bin2bcd(tm->tm_min) | RV3029_A_AE_X;
+	regs[RV3029_A_HR - RV3029_A_SC] =3D (bin2bcd(tm->tm_hour) & 0x3f)
+		| RV3029_A_AE_X;
+	regs[RV3029_A_DT - RV3029_A_SC] =3D (bin2bcd(tm->tm_mday) & 0x3f)
+		| RV3029_A_AE_X;
+	regs[RV3029_A_MO - RV3029_A_SC] =3D (bin2bcd(tm->tm_mon + 1) & 0x1f)
+		| RV3029_A_AE_X;
+	regs[RV3029_A_DW - RV3029_A_SC] =3D (bin2bcd(tm->tm_wday + 1) & 0x7)
+		| RV3029_A_AE_X;
+	regs[RV3029_A_YR - RV3029_A_SC] =3D (bin2bcd(tm->tm_year - 100))
+		| RV3029_A_AE_X;
+
+	/* Write the alarm */
 	ret =3D rv3029_write_regs(dev, RV3029_A_SC, regs,
 				RV3029_ALARM_SECTION_LEN);
 	if (ret < 0)
@@ -493,7 +502,7 @@ static int rv3029_set_time(struct device *dev, struct r=
tc_time *tm)
 	regs[RV3029_W_HOURS - RV3029_W_SEC] =3D bin2bcd(tm->tm_hour);
 	regs[RV3029_W_DATE - RV3029_W_SEC] =3D bin2bcd(tm->tm_mday);
 	regs[RV3029_W_MONTHS - RV3029_W_SEC] =3D bin2bcd(tm->tm_mon + 1);
-	regs[RV3029_W_DAYS - RV3029_W_SEC] =3D bin2bcd((tm->tm_wday & 7) + 1);
+	regs[RV3029_W_DAYS - RV3029_W_SEC] =3D bin2bcd(tm->tm_wday + 1) & 0x7;
 	regs[RV3029_W_YEARS - RV3029_W_SEC] =3D bin2bcd(tm->tm_year - 100);
=20
 	ret =3D rv3029_write_regs(dev, RV3029_W_SEC, regs,
--=20
2.8.0.rc3

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
