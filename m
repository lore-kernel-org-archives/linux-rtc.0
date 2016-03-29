Return-Path: <rtc-linux+bncBAABBLOO5C3QKGQEGMT7P5I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id g11si440380wmf.0.2016.03.28.23.56.45
        for <rtc-linux@googlegroups.com>;
        Mon, 28 Mar 2016 23:56:45 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 5/8] rtc: m41t80: remove warnings and replace
 obsolete function
Date: Tue, 29 Mar 2016 08:56:02 +0200
Message-Id: <3d756d63af27c4b369783eae322e53eb73361d38.1459233897.git.mylene.josserand@free-electrons.com>
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

Replace the obsolete "simple_strtoul" function to "kstrtoul".
Remove some checkpatch's errors, warnings and checks :
   - alignment with open parenthesis
   - spaces around '<' and '<<'
   - blank line after structure
   - quoted string split across lines

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-m41t80.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index f991433..1575b08 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -226,7 +226,11 @@ static ssize_t sqwfreq_store(struct device *dev,
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct m41t80_data *clientdata =3D i2c_get_clientdata(client);
 	int almon, sqw, reg_sqw, rc;
-	int val =3D simple_strtoul(buf, NULL, 0);
+	unsigned long val;
+
+	rc =3D kstrtoul(buf, 0, &val);
+	if (rc < 0)
+		return rc;
=20
 	if (!(clientdata->features & M41T80_FEATURE_SQ))
 		return -EINVAL;
@@ -255,7 +259,7 @@ static ssize_t sqwfreq_store(struct device *dev,
 	sqw =3D (sqw & 0x0f) | (val << 4);
=20
 	rc =3D i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON,
-				      almon & ~M41T80_ALMON_SQWE);
+				       almon & ~M41T80_ALMON_SQWE);
 	if (rc < 0)
 		return rc;
=20
@@ -265,8 +269,8 @@ static ssize_t sqwfreq_store(struct device *dev,
 			return rc;
=20
 		rc =3D i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON,
-					     almon | M41T80_ALMON_SQWE);
-		if (rc <0)
+					       almon | M41T80_ALMON_SQWE);
+		if (rc < 0)
 			return rc;
 	}
 	return count;
@@ -278,6 +282,7 @@ static struct attribute *attrs[] =3D {
 	&dev_attr_sqwfreq.attr,
 	NULL,
 };
+
 static struct attribute_group attr_group =3D {
 	.attrs =3D attrs,
 };
@@ -329,7 +334,7 @@ static void wdt_ping(void)
 		/*
 		 * WDS =3D 1 (0x80), mulitplier =3D WD_TIMO, resolution =3D 1s (0x02)
 		 */
-		i2c_data[1] =3D wdt_margin<<2 | 0x82;
+		i2c_data[1] =3D wdt_margin << 2 | 0x82;
=20
 	/*
 	 * M41T65 has three bits for watchdog resolution.  Don't set bit 7, as
@@ -595,7 +600,7 @@ static int m41t80_probe(struct i2c_client *client,
 	}
=20
 	clientdata =3D devm_kzalloc(&client->dev, sizeof(*clientdata),
-				GFP_KERNEL);
+				  GFP_KERNEL);
 	if (!clientdata)
 		return -ENOMEM;
=20
@@ -603,7 +608,7 @@ static int m41t80_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, clientdata);
=20
 	rtc =3D devm_rtc_device_register(&client->dev, client->name,
-					&m41t80_rtc_ops, THIS_MODULE);
+				       &m41t80_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
=20
@@ -617,14 +622,13 @@ static int m41t80_probe(struct i2c_client *client,
 			m41t80_get_datetime(client, &tm);
 			dev_info(&client->dev, "HT bit was set!\n");
 			dev_info(&client->dev,
-				 "Power Down at "
-				 "%04i-%02i-%02i %02i:%02i:%02i\n",
+				 "Power Down at %04i-%02i-%02i %02i:%02i:%02i\n",
 				 tm.tm_year + 1900,
 				 tm.tm_mon + 1, tm.tm_mday, tm.tm_hour,
 				 tm.tm_min, tm.tm_sec);
 		}
 		rc =3D i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_HOUR,
-					      rc & ~M41T80_ALHOUR_HT);
+					       rc & ~M41T80_ALHOUR_HT);
 	}
=20
 	if (rc < 0) {
@@ -637,7 +641,7 @@ static int m41t80_probe(struct i2c_client *client,
=20
 	if (rc >=3D 0 && rc & M41T80_SEC_ST)
 		rc =3D i2c_smbus_write_byte_data(client, M41T80_REG_SEC,
-					      rc & ~M41T80_SEC_ST);
+					       rc & ~M41T80_SEC_ST);
 	if (rc < 0) {
 		dev_err(&client->dev, "Can't clear ST bit\n");
 		return rc;
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
