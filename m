Return-Path: <rtc-linux+bncBAABBK4XXGYAKGQEG4CTDNA@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id bj4si218638wib.1.2015.10.02.02.17.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 02 Oct 2015 02:17:31 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v1 4/4 RFC] rtc: pcf2127: implement access to nvram
Date: Fri,  2 Oct 2015 11:17:22 +0200
Message-Id: <1443777442-15920-5-git-send-email-u.kleine-koenig@pengutronix.de>
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

The rtc features a 512 byte battery backed RAM. Make it available via
sysfs.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---

Notes:
    This patch is broken in the same way as the previous one. Don't merge!

 drivers/rtc/rtc-pcf2127.c | 114 ++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index db057db88031..e21dc5dfc9fb 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -35,6 +35,10 @@
 #define PCF2127_REG_MO          (0x08)
 #define PCF2127_REG_YR          (0x09)
=20
+#define PCF2127_REG_RAM_addr_MSB	0x1a
+#define PCF2127_REG_RAM_wrt_cmd		0x1c
+#define PCF2127_REG_RAM_rd_cmd		0x1d
+
 #define PCF2127_OSF             BIT(7)  /* Oscillator Fail flag */
=20
 static struct i2c_driver pcf2127_driver;
@@ -295,6 +299,106 @@ static const struct attribute *pcf2127_attributes[] =
=3D {
 	NULL
 };
=20
+#define PCF2127_NVRAM_SIZE 512
+
+static ssize_t pcf2127_nvram_read(struct file *filp, struct kobject *kobj,
+				  struct bin_attribute *attr, char *buf,
+				  loff_t off, size_t count)
+{
+	struct i2c_client *client;
+	int ret;
+	unsigned char i2cbuf[3] =3D { PCF2127_REG_RAM_addr_MSB, off >> 8, off };
+
+	if (off >=3D PCF2127_NVRAM_SIZE)
+		return 0;
+
+	if (count > PCF2127_NVRAM_SIZE - off)
+		count =3D PCF2127_NVRAM_SIZE - off;
+
+	if (!count)
+		return 0;
+
+	client =3D kobj_to_i2c_client(kobj);
+
+	/* set offset */
+	ret =3D i2c_master_send(client, i2cbuf, 3);
+	if (!ret)
+		ret =3D -EIO;
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to set RAM address\n");
+		return ret;
+	}
+
+	i2cbuf[0] =3D PCF2127_REG_RAM_rd_cmd;
+	ret =3D i2c_master_send(client, i2cbuf, 1);
+	if (!ret)
+		ret =3D -EIO;
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to issue read command\n");
+		return ret;
+	}
+
+	ret =3D i2c_master_recv(client, buf, count);
+	if (!ret)
+		ret =3D -EIO;
+	if (ret < 0)
+		dev_err(&client->dev, "failed to read data\n");
+
+	return ret;
+}
+
+static ssize_t pcf2127a_nvram_write(struct file *filp, struct kobject *kob=
j,
+				    struct bin_attribute *attr, char *buf,
+				    loff_t off, size_t count)
+{
+	struct i2c_client *client;
+	int ret;
+	unsigned char i2cbuf[PCF2127_NVRAM_SIZE + 1] =3D {
+		PCF2127_REG_RAM_addr_MSB, off >> 8, off };
+
+	if (off >=3D PCF2127_NVRAM_SIZE)
+		return 0;
+
+	if (count > PCF2127_NVRAM_SIZE - off)
+		count =3D PCF2127_NVRAM_SIZE - off;
+
+	if (!count)
+		return 0;
+
+	client =3D kobj_to_i2c_client(kobj);
+
+	/* set offset */
+	ret =3D i2c_master_send(client, i2cbuf, 3);
+	if (!ret)
+		ret =3D -EIO;
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to set RAM address\n");
+		return ret;
+	}
+
+	i2cbuf[0] =3D PCF2127_REG_RAM_wrt_cmd;
+	memcpy(i2cbuf + 1, buf, count);
+	ret =3D i2c_master_send(client, i2cbuf, count + 1);
+	if (!ret)
+		ret =3D -EIO;
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to issue write command\n");
+		return ret;
+	}
+
+	return ret - 1;
+}
+
+static const struct bin_attribute pcf2127_nvram =3D {
+	.attr =3D {
+		.name =3D "nvram",
+		.mode =3D S_IWUSR | S_IRUGO,
+	},
+	.read =3D pcf2127_nvram_read,
+	.write =3D pcf2127a_nvram_write,
+	.size =3D PCF2127_NVRAM_SIZE,
+};
+
 static int pcf2127_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
@@ -319,12 +423,21 @@ static int pcf2127_probe(struct i2c_client *client,
 		return ret;
 	}
=20
+	ret =3D sysfs_create_bin_file(&client->dev.kobj, &pcf2127_nvram);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"failed to register sysfs nvram attribute\n");
+		goto err_create_bin_file;
+	}
+
 	pcf2127->rtc =3D devm_rtc_device_register(&client->dev,
 				pcf2127_driver.driver.name,
 				&pcf2127_rtc_ops, THIS_MODULE);
=20
 	if (IS_ERR(pcf2127->rtc)) {
 		ret =3D PTR_ERR(pcf2127->rtc);
+		sysfs_remove_bin_file(&client->dev.kobj, &pcf2127_nvram);
+err_create_bin_file:
 		sysfs_remove_files(&client->dev.kobj, pcf2127_attributes);
 	}
=20
@@ -333,6 +446,7 @@ static int pcf2127_probe(struct i2c_client *client,
=20
 static int pcf2127_remove(struct i2c_client *client)
 {
+	sysfs_remove_bin_file(&client->dev.kobj, &pcf2127_nvram);
 	sysfs_remove_files(&client->dev.kobj, pcf2127_attributes);
 	return 0;
 }
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
