Return-Path: <rtc-linux+bncBAABBL6O5C3QKGQEGMLA3DY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a126si403368wmd.2.2016.03.28.23.56.47
        for <rtc-linux@googlegroups.com>;
        Mon, 28 Mar 2016 23:56:47 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 6/8] rtc: m41t80: add alarm functionality
Date: Tue, 29 Mar 2016 08:56:03 +0200
Message-Id: <1932c2b8c5f0c5d89c0578c300c9e18a283e8df0.1459233897.git.mylene.josserand@free-electrons.com>
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

Previous 'commit c3b79770e51a ("Expire alarms after the time is set")'
and 'commit 48e9766726eb ("remove disabled alarm functionality")' removed
the alarm support because the alarm irq was not functional.

Add the alarm IRQ functionality with newer functions than previous
code. Tested with 'rtctest' and the alarm is functional.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-m41t80.c | 176 +++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 163 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 1575b08..4255449 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -90,6 +90,42 @@ struct m41t80_data {
 	struct rtc_device *rtc;
 };
=20
+static irqreturn_t m41t80_handle_irq(int irq, void *dev_id)
+{
+	struct i2c_client *client =3D dev_id;
+	struct m41t80_data *m41t80 =3D i2c_get_clientdata(client);
+	struct mutex *lock =3D &m41t80->rtc->ops_lock;
+	unsigned long events =3D 0;
+	int flags, flags_afe;
+
+	mutex_lock(lock);
+
+	flags_afe =3D i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
+	if (flags_afe < 0)
+		return IRQ_NONE;
+
+	flags =3D i2c_smbus_read_byte_data(client, M41T80_REG_FLAGS);
+	if (flags <=3D 0)
+		return IRQ_NONE;
+
+	if (flags & M41T80_FLAGS_AF) {
+		flags &=3D ~M41T80_FLAGS_AF;
+		flags_afe &=3D ~M41T80_ALMON_AFE;
+		events |=3D RTC_AF;
+	}
+
+	if (events) {
+		rtc_update_irq(m41t80->rtc, 1, events);
+		i2c_smbus_write_byte_data(client, M41T80_REG_FLAGS, flags);
+		i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON,
+					  flags_afe);
+	}
+
+	mutex_unlock(lock);
+
+	return IRQ_HANDLED;
+}
+
 static int m41t80_get_datetime(struct i2c_client *client,
 			       struct rtc_time *tm)
 {
@@ -167,10 +203,109 @@ static int m41t80_rtc_set_time(struct device *dev, s=
truct rtc_time *tm)
 	return m41t80_set_datetime(to_i2c_client(dev), tm);
 }
=20
-/*
- * XXX - m41t80 alarm functionality is reported broken.
- * until it is fixed, don't register alarm functions.
- */
+static int m41t80_alarm_irq_enable(struct device *dev, unsigned int enable=
d)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	int flags, retval;
+
+	flags =3D i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
+	if (flags < 0)
+		return flags;
+
+	if (enabled)
+		flags |=3D M41T80_ALMON_AFE;
+	else
+		flags &=3D ~M41T80_ALMON_AFE;
+
+	retval =3D i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON, flags)=
;
+	if (retval < 0) {
+		dev_info(dev, "Unable to enable alarm IRQ %d\n", retval);
+		return retval;
+	}
+	return 0;
+}
+
+static int m41t80_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	u8 alarmvals[5];
+	int ret, err;
+
+	alarmvals[0] =3D bin2bcd(alrm->time.tm_mon + 1);
+	alarmvals[1] =3D bin2bcd(alrm->time.tm_mday);
+	alarmvals[2] =3D bin2bcd(alrm->time.tm_hour);
+	alarmvals[3] =3D bin2bcd(alrm->time.tm_min);
+	alarmvals[4] =3D bin2bcd(alrm->time.tm_sec);
+
+	/* Clear AF and AFE flags */
+	ret =3D i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
+	if (ret < 0)
+		return ret;
+	err =3D i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON,
+					ret & ~(M41T80_ALMON_AFE));
+	if (err < 0) {
+		dev_err(dev, "Unable to clear AFE bit\n");
+		return err;
+	}
+
+	ret =3D i2c_smbus_read_byte_data(client, M41T80_REG_FLAGS);
+	if (ret < 0)
+		return ret;
+
+	err =3D i2c_smbus_write_byte_data(client, M41T80_REG_FLAGS,
+					ret & ~(M41T80_FLAGS_AF));
+	if (err < 0) {
+		dev_err(dev, "Unable to clear AF bit\n");
+		return err;
+	}
+
+	/* Write the alarm */
+	err =3D i2c_smbus_write_i2c_block_data(client, M41T80_REG_ALARM_MON,
+					     5, alarmvals);
+	if (err)
+		return err;
+
+	/* Enable the alarm interrupt */
+	if (alrm->enabled) {
+		alarmvals[0] |=3D M41T80_ALMON_AFE;
+		err =3D i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON,
+						alarmvals[0]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int m41t80_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	u8 alarmvals[5];
+	int flags, ret;
+
+	ret =3D i2c_smbus_read_i2c_block_data(client, M41T80_REG_ALARM_MON,
+					    5, alarmvals);
+	if (ret !=3D 5)
+		return ret < 0 ? ret : -EIO;
+
+	flags =3D i2c_smbus_read_byte_data(client, M41T80_REG_FLAGS);
+	if (flags < 0)
+		return flags;
+
+	alrm->time.tm_sec  =3D bcd2bin(alarmvals[4] & 0x7f);
+	alrm->time.tm_min  =3D bcd2bin(alarmvals[3] & 0x7f);
+	alrm->time.tm_hour =3D bcd2bin(alarmvals[2] & 0x3f);
+	alrm->time.tm_wday =3D -1;
+	alrm->time.tm_mday =3D bcd2bin(alarmvals[1] & 0x3f);
+	alrm->time.tm_mon  =3D bcd2bin(alarmvals[0] & 0x3f);
+	alrm->time.tm_year =3D -1;
+
+	alrm->enabled =3D !!(alarmvals[0] & M41T80_ALMON_AFE);
+	alrm->pending =3D (flags & M41T80_FLAGS_AF) && alrm->enabled;
+
+	return 0;
+}
+
 static struct rtc_class_ops m41t80_rtc_ops =3D {
 	.read_time =3D m41t80_rtc_read_time,
 	.set_time =3D m41t80_rtc_set_time,
@@ -591,7 +726,7 @@ static int m41t80_probe(struct i2c_client *client,
 	int rc =3D 0;
 	struct rtc_device *rtc =3D NULL;
 	struct rtc_time tm;
-	struct m41t80_data *clientdata =3D NULL;
+	struct m41t80_data *m41t80_data =3D NULL;
=20
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK |
 				     I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -599,26 +734,41 @@ static int m41t80_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
=20
-	clientdata =3D devm_kzalloc(&client->dev, sizeof(*clientdata),
-				  GFP_KERNEL);
-	if (!clientdata)
+	m41t80_data =3D devm_kzalloc(&client->dev, sizeof(*m41t80_data),
+				   GFP_KERNEL);
+	if (!m41t80_data)
 		return -ENOMEM;
=20
-	clientdata->features =3D id->driver_data;
-	i2c_set_clientdata(client, clientdata);
+	m41t80_data->features =3D id->driver_data;
+	i2c_set_clientdata(client, m41t80_data);
+
+	if (client->irq > 0) {
+		rc =3D devm_request_threaded_irq(&client->dev, client->irq,
+					       NULL, m41t80_handle_irq,
+					       IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					       "m41t80", client);
+		if (rc) {
+			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
+			client->irq =3D 0;
+		} else {
+			m41t80_rtc_ops.read_alarm =3D m41t80_read_alarm;
+			m41t80_rtc_ops.set_alarm =3D m41t80_set_alarm;
+			m41t80_rtc_ops.alarm_irq_enable =3D m41t80_alarm_irq_enable;
+		}
+	}
=20
 	rtc =3D devm_rtc_device_register(&client->dev, client->name,
 				       &m41t80_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
=20
-	clientdata->rtc =3D rtc;
+	m41t80_data->rtc =3D rtc;
=20
 	/* Make sure HT (Halt Update) bit is cleared */
 	rc =3D i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_HOUR);
=20
 	if (rc >=3D 0 && rc & M41T80_ALHOUR_HT) {
-		if (clientdata->features & M41T80_FEATURE_HT) {
+		if (m41t80_data->features & M41T80_FEATURE_HT) {
 			m41t80_get_datetime(client, &tm);
 			dev_info(&client->dev, "HT bit was set!\n");
 			dev_info(&client->dev,
@@ -664,7 +814,7 @@ static int m41t80_probe(struct i2c_client *client,
 	}
=20
 #ifdef CONFIG_RTC_DRV_M41T80_WDT
-	if (clientdata->features & M41T80_FEATURE_HT) {
+	if (m41t80_data->features & M41T80_FEATURE_HT) {
 		save_client =3D client;
 		rc =3D misc_register(&wdt_dev);
 		if (rc)
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
