Return-Path: <rtc-linux+bncBAABBFF3365QKGQEB3R3IQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [2a01:4f8:d12:1f44::2])
        by gmr-mx.google.com with ESMTPS id r10si153565wmf.0.2016.07.02.08.28.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jul 2016 08:28:20 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	=?UTF-8?q?Manuel=20R=C3=B6der?= <manuel_roeder@gmx.de>
Subject: [rtc-linux] [PATCH v2 3/5] rtc: s35390a: improve irq handling
Date: Sat,  2 Jul 2016 17:28:10 +0200
Message-Id: <1467473292-26371-4-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1467473292-26371-1-git-send-email-uwe@kleine-koenig.org>
References: <1467473292-26371-1-git-send-email-uwe@kleine-koenig.org>
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

On some QNAP NAS devices the rtc can wake the machine. Several people
noticed that once the machine was woken this way it fails to shut down.
That's because the driver fails to acknowledge the interrupt and so it
keeps active and restarts the machine immediatly after shutdown. See
https://bugs.debian.org/794266 for a bug report.

Doing this correctly requires to interpret the INT2 flag of the first read
of the STATUS1 register because this bit is cleared by read.

Note this is not maximally robust though because a pending irq isn't
detected when the STATUS1 register was already read (and so INT2 is not
set) but the irq was not disabled. But that is a hardware imposed problem
that cannot easily be fixed by software.

Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
---
 drivers/rtc/rtc-s35390a.c | 48 ++++++++++++++++++++++++++++++-------------=
----
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 6c90c9f48cab..d5b572266a72 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -35,10 +35,14 @@
 #define S35390A_ALRM_BYTE_HOURS	1
 #define S35390A_ALRM_BYTE_MINS	2
=20
+/* flags for STATUS1 */
 #define S35390A_FLAG_POC	0x01
 #define S35390A_FLAG_BLD	0x02
+#define S35390A_FLAG_INT2	0x04
 #define S35390A_FLAG_24H	0x40
 #define S35390A_FLAG_RESET	0x80
+
+/* flag for STATUS2 */
 #define S35390A_FLAG_TEST	0x01
=20
 #define S35390A_INT2_MODE_MASK		0xF0
@@ -394,11 +398,11 @@ static struct i2c_driver s35390a_driver;
 static int s35390a_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	int err;
+	int err, err_reset;
 	unsigned int i;
 	struct s35390a *s35390a;
 	struct rtc_time tm;
-	char buf[1], status1;
+	char buf, status1;
=20
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		err =3D -ENODEV;
@@ -427,29 +431,35 @@ static int s35390a_probe(struct i2c_client *client,
 		}
 	}
=20
-	err =3D s35390a_reset(s35390a, &status1);
-	if (err < 0) {
+	err_reset =3D s35390a_reset(s35390a, &status1);
+	if (err_reset < 0) {
+		err =3D err_reset;
 		dev_err(&client->dev, "error resetting chip\n");
 		goto exit_dummy;
 	}
=20
-	err =3D s35390a_disable_test_mode(s35390a);
-	if (err < 0) {
-		dev_err(&client->dev, "error disabling test mode\n");
-		goto exit_dummy;
-	}
-
-	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, buf, sizeof(buf));
-	if (err < 0) {
-		dev_err(&client->dev, "error checking 12/24 hour mode\n");
-		goto exit_dummy;
-	}
-	if (buf[0] & S35390A_FLAG_24H)
+	if (status1 & S35390A_FLAG_24H)
 		s35390a->twentyfourhour =3D 1;
 	else
 		s35390a->twentyfourhour =3D 0;
=20
-	if (s35390a_get_datetime(client, &tm) < 0)
+	if (status1 & S35390A_FLAG_INT2) {
+		/* disable alarm (and maybe test mode) */
+		buf =3D 0;
+		err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
+		if (err < 0) {
+			dev_err(&client->dev, "error disabling alarm");
+			goto exit_dummy;
+		}
+	} else {
+		err =3D s35390a_disable_test_mode(s35390a);
+		if (err < 0) {
+			dev_err(&client->dev, "error disabling test mode\n");
+			goto exit_dummy;
+		}
+	}
+
+	if (err_reset > 0 || s35390a_get_datetime(client, &tm) < 0)
 		dev_warn(&client->dev, "clock needs to be set\n");
=20
 	device_set_wakeup_capable(&client->dev, 1);
@@ -462,6 +472,10 @@ static int s35390a_probe(struct i2c_client *client,
 		err =3D PTR_ERR(s35390a->rtc);
 		goto exit_dummy;
 	}
+
+	if (status1 & S35390A_FLAG_INT2)
+		rtc_update_irq(s35390a->rtc, 1, RTC_AF);
+
 	return 0;
=20
 exit_dummy:
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
