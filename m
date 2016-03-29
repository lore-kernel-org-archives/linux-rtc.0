Return-Path: <rtc-linux+bncBAABBM6O5C3QKGQE3VGU77I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v68si739419wmd.1.2016.03.28.23.56.51
        for <rtc-linux@googlegroups.com>;
        Mon, 28 Mar 2016 23:56:51 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 8/8] rtc: m41t80: handle oscillator failure bit
Date: Tue, 29 Mar 2016 08:56:05 +0200
Message-Id: <bc780d98b8b242f4f3f0eb5d7ff1e9ebf36d9f0e.1459233897.git.mylene.josserand@free-electrons.com>
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

Handle the Oscillator Failure (OF) bit on each read of date-time.
If the OF is set, an error is returned (-EINVAL) instead of the date-time.
The OF bit is cleared each time the date is set.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-m41t80.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 660a734..64d66a9 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -56,6 +56,7 @@
 #define M41T80_ALMON_AFE	BIT(7)	/* AFE: AF Enable Bit */
 #define M41T80_ALMON_SQWE	BIT(6)	/* SQWE: SQW Enable Bit */
 #define M41T80_ALHOUR_HT	BIT(6)	/* HT: Halt Update Bit */
+#define M41T80_FLAGS_OF		BIT(2)	/* OF: Oscillator Failure Bit */
 #define M41T80_FLAGS_AF		BIT(6)	/* AF: Alarm Flag Bit */
 #define M41T80_FLAGS_BATT_LOW	BIT(4)	/* BL: Battery Low Bit */
 #define M41T80_WATCHDOG_RB2	BIT(7)	/* RB: Watchdog resolution */
@@ -130,7 +131,16 @@ static int m41t80_get_datetime(struct i2c_client *clie=
nt,
 			       struct rtc_time *tm)
 {
 	unsigned char buf[8];
-	int err;
+	int err, flags;
+
+	flags =3D i2c_smbus_read_byte_data(client, M41T80_REG_FLAGS);
+	if (flags < 0)
+		return flags;
+
+	if (flags & M41T80_FLAGS_OF) {
+		dev_err(&client->dev, "Oscillator failure, data is invalid.\n");
+		return -EINVAL;
+	}
=20
 	err =3D i2c_smbus_read_i2c_block_data(client, M41T80_REG_SSEC,
 					    sizeof(buf), buf);
@@ -155,7 +165,7 @@ static int m41t80_get_datetime(struct i2c_client *clien=
t,
 static int m41t80_set_datetime(struct i2c_client *client, struct rtc_time =
*tm)
 {
 	unsigned char buf[8];
-	int err;
+	int err, flags;
=20
 	if (tm->tm_year < 100 || tm->tm_year > 199)
 		return -EINVAL;
@@ -176,6 +186,17 @@ static int m41t80_set_datetime(struct i2c_client *clie=
nt, struct rtc_time *tm)
 		return err;
 	}
=20
+	/* Clear the OF bit of Flags Register */
+	flags =3D i2c_smbus_read_byte_data(client, M41T80_REG_FLAGS);
+	if (flags < 0)
+		return flags;
+
+	if (i2c_smbus_write_byte_data(client, M41T80_REG_FLAGS,
+				      flags & ~M41T80_FLAGS_OF)) {
+		dev_err(&client->dev, "Unable to write flags register\n");
+		return -EIO;
+	}
+
 	return err;
 }
=20
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
