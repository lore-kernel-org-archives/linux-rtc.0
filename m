Return-Path: <rtc-linux+bncBAABB4PLT65QKGQEOPOYPQQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [2a01:4f8:d12:1f44::2])
        by gmr-mx.google.com with ESMTPS id f138si373080wmf.3.2016.06.20.06.56.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2016 06:56:01 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	=?UTF-8?q?Manuel=20R=C3=B6der?= <manuel_roeder@gmx.de>
Subject: [rtc-linux] [PATCH 2/5] rtc: s35390a: implement reset routine as
 suggested by the reference
Date: Mon, 20 Jun 2016 15:55:50 +0200
Message-Id: <1466430953-18659-3-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1466430953-18659-1-git-send-email-uwe@kleine-koenig.org>
References: <1466430953-18659-1-git-send-email-uwe@kleine-koenig.org>
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

There were two deviations from the reference manual: you have to wait
half a second when POC is active and you might have to repeat
initialization when POC or BLD are still set after the sequence.

Note however that as POC and BLD are cleared by read the driver might
not be able to detect that a reset is necessary. I don't have a good
idea how to fix this.

Additionally report the value read from STATUS1 to the caller. This
prepares the next patch.

Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
---
 drivers/rtc/rtc-s35390a.c | 69 ++++++++++++++++++++++++++++++++++++++-----=
----
 1 file changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index a9f108f045d6..b5f33288f837 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -15,6 +15,7 @@
 #include <linux/bitrev.h>
 #include <linux/bcd.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
=20
 #define S35390A_CMD_STATUS1	0
 #define S35390A_CMD_STATUS2	1
@@ -94,19 +95,63 @@ static int s35390a_get_reg(struct s35390a *s35390a, int=
 reg, char *buf, int len)
 	return 0;
 }
=20
-static int s35390a_reset(struct s35390a *s35390a)
+/*
+ * Returns <0 on error, 0 if rtc is setup fine and 1 if the chip was reset=
.
+ * To keep the information if an irq is pending, pass the value read from
+ * STATUS1 to the caller.
+ */
+static int s35390a_reset(struct s35390a *s35390a, char *status1)
 {
-	char buf[1];
-
-	if (s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, buf, sizeof(buf)) < 0)
-		return -EIO;
-
-	if (!(buf[0] & (S35390A_FLAG_POC | S35390A_FLAG_BLD)))
+	char buf;
+	int ret;
+	unsigned initcount =3D 0;
+
+	ret =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, status1, 1);
+	if (ret < 0)
+		return ret;
+
+	if (*status1 & S35390A_FLAG_POC)
+		/*
+		 * Do not communicate for 0.5 seconds since the power-on
+		 * detection circuit is in operation.
+		 */
+		msleep(500);
+	else if (!(*status1 & S35390A_FLAG_BLD))
+		/*
+		 * If both POC and BLD are unset everything is fine.
+		 */
 		return 0;
=20
-	buf[0] |=3D (S35390A_FLAG_RESET | S35390A_FLAG_24H);
-	buf[0] &=3D 0xf0;
-	return s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, buf, sizeof(buf));
+	/*
+	 * At least one of POC and BLD are set, so reinitialise chip. Keeping
+	 * this information in the hardware to know later that the time isn't
+	 * valid is unfortunately not possible because POC and BLD are cleared
+	 * on read. So the reset is best done now.
+	 *
+	 * The 24H bit is kept over reset, so set it already here.
+	 */
+initialize:
+	*status1 =3D S35390A_FLAG_24H;
+	buf =3D S35390A_FLAG_RESET | S35390A_FLAG_24H;
+	ret =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, &buf, 1);
+
+	if (ret < 0)
+		return ret;
+
+	ret =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, &buf, 1);
+	if (ret < 0)
+		return ret;
+
+	if (buf & (S35390A_FLAG_POC | S35390A_FLAG_BLD)) {
+		/* Try up to five times to reset the chip */
+		if (initcount < 5) {
+			++initcount;
+			goto initialize;
+		} else
+			return -EIO;
+	}
+
+	return 1;
 }
=20
 static int s35390a_disable_test_mode(struct s35390a *s35390a)
@@ -345,7 +390,7 @@ static int s35390a_probe(struct i2c_client *client,
 	unsigned int i;
 	struct s35390a *s35390a;
 	struct rtc_time tm;
-	char buf[1];
+	char buf[1], status1;
=20
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		err =3D -ENODEV;
@@ -374,7 +419,7 @@ static int s35390a_probe(struct i2c_client *client,
 		}
 	}
=20
-	err =3D s35390a_reset(s35390a);
+	err =3D s35390a_reset(s35390a, &status1);
 	if (err < 0) {
 		dev_err(&client->dev, "error resetting chip\n");
 		goto exit_dummy;
--=20
2.8.1

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
