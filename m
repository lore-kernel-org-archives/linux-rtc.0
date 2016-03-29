Return-Path: <rtc-linux+bncBAABBJGO5C3QKGQEKS74LYQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si711336wmd.1.2016.03.28.23.56.36
        for <rtc-linux@googlegroups.com>;
        Mon, 28 Mar 2016 23:56:36 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 1/8] rtc: m41t80: update sysfs entries export
Date: Tue, 29 Mar 2016 08:55:58 +0200
Message-Id: <22b92b72dadda01ba6297ad368e3bb660b033556.1459233897.git.mylene.josserand@free-electrons.com>
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

The driver used an old sysfs entry export.
Update it to use the DEVICE_ATTR_XX macro and remove the unnecessary
CONFIG_RTC_INTF_SYSFS macro.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-m41t80.c | 56 +++++++++++++++++++++++++++-----------------=
----
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index d107a8e..2721789 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -230,9 +230,8 @@ static struct rtc_class_ops m41t80_rtc_ops =3D {
 	.proc =3D m41t80_rtc_proc,
 };
=20
-#if defined(CONFIG_RTC_INTF_SYSFS) || defined(CONFIG_RTC_INTF_SYSFS_MODULE=
)
-static ssize_t m41t80_sysfs_show_flags(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t flags_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	int val;
@@ -242,10 +241,10 @@ static ssize_t m41t80_sysfs_show_flags(struct device =
*dev,
 		return val;
 	return sprintf(buf, "%#x\n", val);
 }
-static DEVICE_ATTR(flags, S_IRUGO, m41t80_sysfs_show_flags, NULL);
+static DEVICE_ATTR_RO(flags);
=20
-static ssize_t m41t80_sysfs_show_sqwfreq(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t sqwfreq_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct m41t80_data *clientdata =3D i2c_get_clientdata(client);
@@ -272,9 +271,10 @@ static ssize_t m41t80_sysfs_show_sqwfreq(struct device=
 *dev,
 	}
 	return sprintf(buf, "%d\n", val);
 }
-static ssize_t m41t80_sysfs_set_sqwfreq(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
+
+static ssize_t sqwfreq_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct m41t80_data *clientdata =3D i2c_get_clientdata(client);
@@ -324,8 +324,7 @@ static ssize_t m41t80_sysfs_set_sqwfreq(struct device *=
dev,
 	}
 	return count;
 }
-static DEVICE_ATTR(sqwfreq, S_IRUGO | S_IWUSR,
-		   m41t80_sysfs_show_sqwfreq, m41t80_sysfs_set_sqwfreq);
+static DEVICE_ATTR_RW(sqwfreq);
=20
 static struct attribute *attrs[] =3D {
 	&dev_attr_flags.attr,
@@ -336,17 +335,6 @@ static struct attribute_group attr_group =3D {
 	.attrs =3D attrs,
 };
=20
-static int m41t80_sysfs_register(struct device *dev)
-{
-	return sysfs_create_group(&dev->kobj, &attr_group);
-}
-#else
-static int m41t80_sysfs_register(struct device *dev)
-{
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_RTC_DRV_M41T80_WDT
 /*
  *************************************************************************=
****
@@ -636,6 +624,14 @@ static struct notifier_block wdt_notifier =3D {
  *
  *************************************************************************=
****
  */
+
+static void m41t80_remove_sysfs_group(void *_dev)
+{
+	struct device *dev =3D _dev;
+
+	sysfs_remove_group(&dev->kobj, &attr_group);
+}
+
 static int m41t80_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -697,9 +693,21 @@ static int m41t80_probe(struct i2c_client *client,
 		return rc;
 	}
=20
-	rc =3D m41t80_sysfs_register(&client->dev);
-	if (rc)
+	/* Export sysfs entries */
+	rc =3D sysfs_create_group(&(&client->dev)->kobj, &attr_group);
+	if (rc) {
+		dev_err(&client->dev, "Failed to create sysfs group: %d\n", rc);
 		return rc;
+	}
+
+	rc =3D devm_add_action(&client->dev, m41t80_remove_sysfs_group,
+			     &client->dev);
+	if (rc) {
+		m41t80_remove_sysfs_group(&client->dev);
+		dev_err(&client->dev,
+			"Failed to add sysfs cleanup action: %d\n", rc);
+		return rc;
+	}
=20
 #ifdef CONFIG_RTC_DRV_M41T80_WDT
 	if (clientdata->features & M41T80_FEATURE_HT) {
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
