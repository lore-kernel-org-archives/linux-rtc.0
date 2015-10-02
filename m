Return-Path: <rtc-linux+bncBAABBO4XXGYAKGQEWQUDFVA@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id c1si202403wiv.3.2015.10.02.02.17.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 02 Oct 2015 02:17:47 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v1 3/4 RFC] rtc: pcf2127: implement reading
 battery status bits
Date: Fri,  2 Oct 2015 11:17:21 +0200
Message-Id: <1443777442-15920-4-git-send-email-u.kleine-koenig@pengutronix.de>
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

The rtc features a battery switch-over function. Export battery status
and if a switch-over occured via sysfs.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---

Notes:
    Note this patch is wrong, don't merge!
   =20
    Calling sysfs_create_files in the driver's probe is too late. I didn't
    find a nice alternative though. But in case someone feels like pointing
    me in the right direction or using this even with this being wrong, her=
e
    comes the patch anyhow.

 drivers/rtc/rtc-pcf2127.c | 132 ++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 7eb6ff26185e..db057db88031 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -22,7 +22,11 @@
=20
 #define PCF2127_REG_CTRL1       (0x00)  /* Control Register 1 */
 #define PCF2127_REG_CTRL2       (0x01)  /* Control Register 2 */
+
 #define PCF2127_REG_CTRL3       (0x02)  /* Control Register 3 */
+#define PCF2127_REG_CTRL3_BF		0x08
+#define PCF2127_REG_CTRL3_BLF		0x04
+
 #define PCF2127_REG_SC          (0x03)  /* datetime */
 #define PCF2127_REG_MN          (0x04)
 #define PCF2127_REG_HR          (0x05)
@@ -54,7 +58,7 @@ static int pcf2127_get_datetime(struct i2c_client *client=
, struct rtc_time *tm)
 		return -EIO;
 	}
=20
-	if (buf[PCF2127_REG_CTRL3] & 0x04)
+	if (buf[PCF2127_REG_CTRL3] & PCF2127_REG_CTRL3_BLF)
 		dev_info(&client->dev,
 			"low voltage detected, check/replace RTC battery.\n");
=20
@@ -186,10 +190,116 @@ static const struct rtc_class_ops pcf2127_rtc_ops =
=3D {
 	.set_time	=3D pcf2127_rtc_set_time,
 };
=20
+struct pcf2127_bitattr {
+	struct device_attribute attr;
+	unsigned bitmask;
+};
+
+static ssize_t pcf2127_bitattr_clear(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	unsigned char i2cbuf[2] =3D { PCF2127_REG_CTRL3, };
+	struct pcf2127_bitattr *bitattr =3D
+		container_of(attr, struct pcf2127_bitattr, attr);
+	int ret;
+	long val;
+
+	if (!count)
+		return 0;
+
+	ret =3D kstrtol(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	/* we only accept writing 0 */
+	if (val !=3D 0)
+		return -EINVAL;
+
+	ret =3D i2c_master_send(client, i2cbuf, 1);
+	if (!ret)
+		ret =3D -EIO;
+	if (ret < 0)
+		return ret;
+
+	ret =3D i2c_master_recv(client, i2cbuf + 1, 1);
+	if (!ret)
+		ret =3D -EIO;
+	if (ret < 0)
+		return ret;
+
+	i2cbuf[1] &=3D ~bitattr->bitmask;
+
+	ret =3D i2c_master_send(client, i2cbuf, 2);
+	if (!ret)
+		ret =3D -EIO;
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t pcf2127_bitattr_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	unsigned char reg =3D PCF2127_REG_CTRL3;
+	struct pcf2127_bitattr *bitattr =3D
+		container_of(attr, struct pcf2127_bitattr, attr);
+	int ret;
+
+	ret =3D i2c_master_send(client, &reg, 1);
+	if (!ret)
+		ret =3D -EIO;
+	if (ret < 0)
+		return ret;
+
+	ret =3D i2c_master_recv(client, &reg, 1);
+	if (!ret)
+		ret =3D -EIO;
+	if (ret < 0)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE,
+			 "%d\n", !!(reg & bitattr->bitmask));
+}
+
+static struct pcf2127_bitattr pcf2127_battery_low =3D {
+	.attr =3D {
+		.attr =3D {
+			.name =3D "battery_low",
+			.mode =3D S_IRUGO,
+		},
+		.show =3D pcf2127_bitattr_show,
+	},
+	.bitmask =3D PCF2127_REG_CTRL3_BLF,
+};
+
+static struct pcf2127_bitattr pcf2127_battery_switch_over =3D {
+	.attr =3D {
+		.attr =3D {
+			.name =3D "battery_switch_over",
+			.mode =3D S_IWUSR | S_IRUGO,
+		},
+		.show =3D pcf2127_bitattr_show,
+		.store =3D pcf2127_bitattr_clear,
+	},
+	.bitmask =3D PCF2127_REG_CTRL3_BF,
+};
+
+static const struct attribute *pcf2127_attributes[] =3D {
+	&pcf2127_battery_low.attr.attr,
+	&pcf2127_battery_switch_over.attr.attr,
+	NULL
+};
+
 static int pcf2127_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	struct pcf2127 *pcf2127;
+	int ret;
=20
 	dev_dbg(&client->dev, "%s\n", __func__);
=20
@@ -203,11 +313,28 @@ static int pcf2127_probe(struct i2c_client *client,
=20
 	i2c_set_clientdata(client, pcf2127);
=20
+	ret =3D sysfs_create_files(&client->dev.kobj, pcf2127_attributes);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to register sysfs attributes\n");
+		return ret;
+	}
+
 	pcf2127->rtc =3D devm_rtc_device_register(&client->dev,
 				pcf2127_driver.driver.name,
 				&pcf2127_rtc_ops, THIS_MODULE);
=20
-	return PTR_ERR_OR_ZERO(pcf2127->rtc);
+	if (IS_ERR(pcf2127->rtc)) {
+		ret =3D PTR_ERR(pcf2127->rtc);
+		sysfs_remove_files(&client->dev.kobj, pcf2127_attributes);
+	}
+
+	return ret;
+}
+
+static int pcf2127_remove(struct i2c_client *client)
+{
+	sysfs_remove_files(&client->dev.kobj, pcf2127_attributes);
+	return 0;
 }
=20
 static const struct i2c_device_id pcf2127_id[] =3D {
@@ -231,6 +358,7 @@ static struct i2c_driver pcf2127_driver =3D {
 		.of_match_table =3D of_match_ptr(pcf2127_of_match),
 	},
 	.probe		=3D pcf2127_probe,
+	.remove		=3D pcf2127_remove,
 	.id_table	=3D pcf2127_id,
 };
=20
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
