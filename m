Return-Path: <rtc-linux+bncBAABBS4XXGYAKGQEEOTLLIY@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id c1si202429wiv.3.2015.10.02.02.18.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 02 Oct 2015 02:18:03 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v1 1/4] rtc: pcf2127: fix reading uninitialized
 value on RTC_READ_VL ioctl
Date: Fri,  2 Oct 2015 11:17:19 +0200
Message-Id: <1443777442-15920-2-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1443777442-15920-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1443777442-15920-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

The flag reported on the RTC_READ_VL ioctl is only initialized when the
date is read out. So the voltage low value doesn't represent reality but
the status at the time the date was read (or 0 if the date was not read
yet).

Moreover when userspace requests a value via an ioctl there is no added
benefit to also make a prosa representation of this (and other) values
appear in the kernel log so remove the calls to dev_info and the driver
data members to track their state.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---

Notes:
    While this is a fix I don't think it is critical enough to backport it =
to
    stable (or apply it during the rc phase).
   =20
    Looking at
   =20
    	http://codesearch.debian.net/perpackage-results/RTC_VL_READ
   =20
    this ioctl isn't used much.

 drivers/rtc/rtc-pcf2127.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 4c7738f706c1..4f66c4216b5a 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -39,8 +39,6 @@ static struct i2c_driver pcf2127_driver;
=20
 struct pcf2127 {
 	struct rtc_device *rtc;
-	int voltage_low; /* indicates if a low_voltage was detected */
-	int oscillator_failed; /* OSF was detected and date is unreliable */
 };
=20
 /*
@@ -49,7 +47,6 @@ struct pcf2127 {
  */
 static int pcf2127_get_datetime(struct i2c_client *client, struct rtc_time=
 *tm)
 {
-	struct pcf2127 *pcf2127 =3D i2c_get_clientdata(client);
 	unsigned char buf[10] =3D { PCF2127_REG_CTRL1 };
=20
 	/* read registers */
@@ -59,18 +56,15 @@ static int pcf2127_get_datetime(struct i2c_client *clie=
nt, struct rtc_time *tm)
 		return -EIO;
 	}
=20
-	if (buf[PCF2127_REG_CTRL3] & 0x04) {
-		pcf2127->voltage_low =3D 1;
+	if (buf[PCF2127_REG_CTRL3] & 0x04)
 		dev_info(&client->dev,
 			"low voltage detected, check/replace RTC battery.\n");
-	}
=20
 	if (buf[PCF2127_REG_SC] & PCF2127_OSF) {
 		/*
 		 * no need clear the flag here,
 		 * it will be cleared once the new date is saved
 		 */
-		pcf2127->oscillator_failed =3D 1;
 		dev_warn(&client->dev,
 			 "oscillator stop detected, date/time is not reliable\n");
 		return -EINVAL;
@@ -107,7 +101,6 @@ static int pcf2127_get_datetime(struct i2c_client *clie=
nt, struct rtc_time *tm)
=20
 static int pcf2127_set_datetime(struct i2c_client *client, struct rtc_time=
 *tm)
 {
-	struct pcf2127 *pcf2127 =3D i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int i =3D 0, err;
=20
@@ -141,9 +134,6 @@ static int pcf2127_set_datetime(struct i2c_client *clie=
nt, struct rtc_time *tm)
 		return -EIO;
 	}
=20
-	/* clear OSF flag in client data */
-	pcf2127->oscillator_failed =3D 0;
-
 	return 0;
 }
=20
@@ -151,17 +141,27 @@ static int pcf2127_set_datetime(struct i2c_client *cl=
ient, struct rtc_time *tm)
 static int pcf2127_rtc_ioctl(struct device *dev,
 				unsigned int cmd, unsigned long arg)
 {
-	struct pcf2127 *pcf2127 =3D i2c_get_clientdata(to_i2c_client(dev));
+	struct i2c_client *client =3D to_i2c_client(dev);
+	unsigned char buf =3D PCF2127_REG_CTRL3;
+	int ret;
=20
 	switch (cmd) {
 	case RTC_VL_READ:
-		if (pcf2127->voltage_low)
-			dev_info(dev, "low voltage detected, check/replace battery\n");
-		if (pcf2127->oscillator_failed)
-			dev_info(dev, "oscillator stop detected, date/time is not reliable\n");
+		ret =3D i2c_master_send(client, &buf, 1);
+		if (!ret)
+			ret =3D -EIO;
+		if (ret < 0)
+			return ret;
+
+		ret =3D i2c_master_recv(client, &buf, 1);
+		if (!ret)
+			ret =3D -EIO;
+		if (ret < 0)
+			return ret;
+
+		buf =3D buf & PCF2127_REG_CTRL3_BLF ? 1 : 0;
=20
-		if (copy_to_user((void __user *)arg, &pcf2127->voltage_low,
-					sizeof(int)))
+		if (copy_to_user((void __user *)arg, &buf, sizeof(int)))
 			return -EFAULT;
 		return 0;
 	default:
--=20
2.6.0

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
