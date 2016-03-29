Return-Path: <rtc-linux+bncBAABBK6O5C3QKGQEDUXVF7Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 71si336021wmp.0.2016.03.28.23.56.42
        for <rtc-linux@googlegroups.com>;
        Mon, 28 Mar 2016 23:56:43 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 4/8] rtc: m41t80: add the use of 'BIT' macro
Date: Tue, 29 Mar 2016 08:56:01 +0200
Message-Id: <0d8a833041fb06c7b17f1acc9c7c56f5a2c6b651.1459233897.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1459188215.git.mylene.josserand@free-electrons.com>
References: <cover.1459188215.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1459233897.git.mylene.josserand@free-electrons.com>
References: <cover.1459233897.git.mylene.josserand@free-electrons.com>
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

Replace bit shifts by BIT macro.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-m41t80.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 1a76927..f991433 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -52,21 +52,21 @@
 #define M41T80_ALARM_REG_SIZE	\
 	(M41T80_REG_ALARM_SEC + 1 - M41T80_REG_ALARM_MON)
=20
-#define M41T80_SEC_ST		(1 << 7)	/* ST: Stop Bit */
-#define M41T80_ALMON_AFE	(1 << 7)	/* AFE: AF Enable Bit */
-#define M41T80_ALMON_SQWE	(1 << 6)	/* SQWE: SQW Enable Bit */
-#define M41T80_ALHOUR_HT	(1 << 6)	/* HT: Halt Update Bit */
-#define M41T80_FLAGS_AF		(1 << 6)	/* AF: Alarm Flag Bit */
-#define M41T80_FLAGS_BATT_LOW	(1 << 4)	/* BL: Battery Low Bit */
-#define M41T80_WATCHDOG_RB2	(1 << 7)	/* RB: Watchdog resolution */
-#define M41T80_WATCHDOG_RB1	(1 << 1)	/* RB: Watchdog resolution */
-#define M41T80_WATCHDOG_RB0	(1 << 0)	/* RB: Watchdog resolution */
-
-#define M41T80_FEATURE_HT	(1 << 0)	/* Halt feature */
-#define M41T80_FEATURE_BL	(1 << 1)	/* Battery low indicator */
-#define M41T80_FEATURE_SQ	(1 << 2)	/* Squarewave feature */
-#define M41T80_FEATURE_WD	(1 << 3)	/* Extra watchdog resolution */
-#define M41T80_FEATURE_SQ_ALT	(1 << 4)	/* RSx bits are in reg 4 */
+#define M41T80_SEC_ST		BIT(7)	/* ST: Stop Bit */
+#define M41T80_ALMON_AFE	BIT(7)	/* AFE: AF Enable Bit */
+#define M41T80_ALMON_SQWE	BIT(6)	/* SQWE: SQW Enable Bit */
+#define M41T80_ALHOUR_HT	BIT(6)	/* HT: Halt Update Bit */
+#define M41T80_FLAGS_AF		BIT(6)	/* AF: Alarm Flag Bit */
+#define M41T80_FLAGS_BATT_LOW	BIT(4)	/* BL: Battery Low Bit */
+#define M41T80_WATCHDOG_RB2	BIT(7)	/* RB: Watchdog resolution */
+#define M41T80_WATCHDOG_RB1	BIT(1)	/* RB: Watchdog resolution */
+#define M41T80_WATCHDOG_RB0	BIT(0)	/* RB: Watchdog resolution */
+
+#define M41T80_FEATURE_HT	BIT(0)	/* Halt feature */
+#define M41T80_FEATURE_BL	BIT(1)	/* Battery low indicator */
+#define M41T80_FEATURE_SQ	BIT(2)	/* Squarewave feature */
+#define M41T80_FEATURE_WD	BIT(3)	/* Extra watchdog resolution */
+#define M41T80_FEATURE_SQ_ALT	BIT(4)	/* RSx bits are in reg 4 */
=20
 static DEFINE_MUTEX(m41t80_rtc_mutex);
 static const struct i2c_device_id m41t80_id[] =3D {
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
