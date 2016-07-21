Return-Path: <rtc-linux+bncBDSJR27JS4DBB66NYK6AKGQEABTC7VQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from authsmtp.register.it (authsmtp91.register.it. [195.110.122.176])
        by gmr-mx.google.com with ESMTPS id i198si139430wmd.2.2016.07.21.03.42.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Jul 2016 03:42:02 -0700 (PDT)
From: =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	=?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
Subject: =?UTF-8?Q?=5Brtc=2Dlinux=5D_=5BPATCH_4=2F6=5D_rtc=3A_rv8803=3A_Always_apply_th?=
	=?UTF-8?Q?e_I=C2=B2C_workaround?=
Date: Thu, 21 Jul 2016 12:41:30 +0200
Message-Id: <1469097692-103146-4-git-send-email-benoit@wsystem.com>
In-Reply-To: <1469097692-103146-1-git-send-email-benoit@wsystem.com>
References: <1469097692-103146-1-git-send-email-benoit@wsystem.com>
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

The I=C2=B2C NACK issue of the RV-8803 may occur after any I=C2=B2C START
condition, depending on the timings. Consequently, the workaround must
be applied for all the I=C2=B2C transfers.

This commit abstracts the I=C2=B2C transfer code into register access
functions. This avoids duplicating the I=C2=B2C workaround everywhere. This
also avoids the duplication of the code handling the return value of
i2c_smbus_read_i2c_block_data(). Error messages are issued in case of
definitive register access failures (if the workaround fails). This
change also makes the I=C2=B2C transfer return value checks consistent.

Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>
---
 drivers/rtc/rtc-rv8803.c | 179 ++++++++++++++++++++++++++++++-------------=
----
 1 file changed, 113 insertions(+), 66 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index aa1d6b6..09ab5cb 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -20,6 +20,8 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
=20
+#define RV8803_I2C_TRY_COUNT		4
+
 #define RV8803_SEC			0x00
 #define RV8803_MIN			0x01
 #define RV8803_HOUR			0x02
@@ -57,19 +59,85 @@ struct rv8803_data {
 	u8 ctrl;
 };
=20
+static int rv8803_read_reg(const struct i2c_client *client, u8 reg)
+{
+	int try =3D RV8803_I2C_TRY_COUNT;
+	s32 ret;
+
+	/*
+	 * There is a 61=C2=B5s window during which the RTC does not acknowledge =
I2C
+	 * transfers. In that case, ensure that there are multiple attempts.
+	 */
+	do
+		ret =3D i2c_smbus_read_byte_data(client, reg);
+	while ((ret =3D=3D -ENXIO || ret =3D=3D -EIO) && --try);
+	if (ret < 0)
+		dev_err(&client->dev, "Unable to read register 0x%02x\n", reg);
+
+	return ret;
+}
+
+static int rv8803_read_regs(const struct i2c_client *client,
+			    u8 reg, u8 count, u8 *values)
+{
+	int try =3D RV8803_I2C_TRY_COUNT;
+	s32 ret;
+
+	do
+		ret =3D i2c_smbus_read_i2c_block_data(client, reg, count, values);
+	while ((ret =3D=3D -ENXIO || ret =3D=3D -EIO) && --try);
+	if (ret !=3D count) {
+		dev_err(&client->dev,
+			"Unable to read registers 0x%02x..0x%02x\n",
+			reg, reg + count - 1);
+		return ret < 0 ? ret : -EIO;
+	}
+
+	return 0;
+}
+
+static int rv8803_write_reg(const struct i2c_client *client, u8 reg, u8 va=
lue)
+{
+	int try =3D RV8803_I2C_TRY_COUNT;
+	s32 ret;
+
+	do
+		ret =3D i2c_smbus_write_byte_data(client, reg, value);
+	while ((ret =3D=3D -ENXIO || ret =3D=3D -EIO) && --try);
+	if (ret)
+		dev_err(&client->dev, "Unable to write register 0x%02x\n", reg);
+
+	return ret;
+}
+
+static int rv8803_write_regs(const struct i2c_client *client,
+			     u8 reg, u8 count, const u8 *values)
+{
+	int try =3D RV8803_I2C_TRY_COUNT;
+	s32 ret;
+
+	do
+		ret =3D i2c_smbus_write_i2c_block_data(client, reg, count,
+						     values);
+	while ((ret =3D=3D -ENXIO || ret =3D=3D -EIO) && --try);
+	if (ret)
+		dev_err(&client->dev,
+			"Unable to write registers 0x%02x..0x%02x\n",
+			reg, reg + count - 1);
+
+	return ret;
+}
+
 static irqreturn_t rv8803_handle_irq(int irq, void *dev_id)
 {
 	struct i2c_client *client =3D dev_id;
 	struct rv8803_data *rv8803 =3D i2c_get_clientdata(client);
 	unsigned long events =3D 0;
-	int flags, try =3D 0;
+	int flags;
=20
 	mutex_lock(&rv8803->flags_lock);
=20
-	do {
-		flags =3D i2c_smbus_read_byte_data(client, RV8803_FLAG);
-		try++;
-	} while (((flags =3D=3D -ENXIO) || (flags =3D=3D -EIO)) && (try < 4));
+	flags =3D rv8803_read_reg(client, RV8803_FLAG);
 	if (flags <=3D 0) {
 		mutex_unlock(&rv8803->flags_lock);
 		return IRQ_NONE;
@@ -101,9 +169,8 @@ static irqreturn_t rv8803_handle_irq(int irq, void *dev=
_id)
=20
 	if (events) {
 		rtc_update_irq(rv8803->rtc, 1, events);
-		i2c_smbus_write_byte_data(client, RV8803_FLAG, flags);
-		i2c_smbus_write_byte_data(rv8803->client, RV8803_CTRL,
-					  rv8803->ctrl);
+		rv8803_write_reg(client, RV8803_FLAG, flags);
+		rv8803_write_reg(rv8803->client, RV8803_CTRL, rv8803->ctrl);
 	}
=20
 	mutex_unlock(&rv8803->flags_lock);
@@ -119,7 +186,7 @@ static int rv8803_get_time(struct device *dev, struct r=
tc_time *tm)
 	u8 *date =3D date1;
 	int ret, flags;
=20
-	flags =3D i2c_smbus_read_byte_data(rv8803->client, RV8803_FLAG);
+	flags =3D rv8803_read_reg(rv8803->client, RV8803_FLAG);
 	if (flags < 0)
 		return flags;
=20
@@ -128,16 +195,14 @@ static int rv8803_get_time(struct device *dev, struct=
 rtc_time *tm)
 		return -EINVAL;
 	}
=20
-	ret =3D i2c_smbus_read_i2c_block_data(rv8803->client, RV8803_SEC,
-					    7, date);
-	if (ret !=3D 7)
-		return ret < 0 ? ret : -EIO;
+	ret =3D rv8803_read_regs(rv8803->client, RV8803_SEC, 7, date);
+	if (ret)
+		return ret;
=20
 	if ((date1[RV8803_SEC] & 0x7f) =3D=3D bin2bcd(59)) {
-		ret =3D i2c_smbus_read_i2c_block_data(rv8803->client, RV8803_SEC,
-						    7, date2);
-		if (ret !=3D 7)
-			return ret < 0 ? ret : -EIO;
+		ret =3D rv8803_read_regs(rv8803->client, RV8803_SEC, 7, date2);
+		if (ret)
+			return ret;
=20
 		if ((date2[RV8803_SEC] & 0x7f) !=3D bin2bcd(59))
 			date =3D date2;
@@ -171,21 +236,20 @@ static int rv8803_set_time(struct device *dev, struct=
 rtc_time *tm)
 	date[RV8803_MONTH] =3D bin2bcd(tm->tm_mon + 1);
 	date[RV8803_YEAR]  =3D bin2bcd(tm->tm_year - 100);
=20
-	ret =3D i2c_smbus_write_i2c_block_data(rv8803->client, RV8803_SEC,
-					     7, date);
-	if (ret < 0)
+	ret =3D rv8803_write_regs(rv8803->client, RV8803_SEC, 7, date);
+	if (ret)
 		return ret;
=20
 	mutex_lock(&rv8803->flags_lock);
=20
-	flags =3D i2c_smbus_read_byte_data(rv8803->client, RV8803_FLAG);
+	flags =3D rv8803_read_reg(rv8803->client, RV8803_FLAG);
 	if (flags < 0) {
 		mutex_unlock(&rv8803->flags_lock);
 		return flags;
 	}
=20
-	ret =3D i2c_smbus_write_byte_data(rv8803->client, RV8803_FLAG,
-					flags & ~RV8803_FLAG_V2F);
+	ret =3D rv8803_write_reg(rv8803->client, RV8803_FLAG,
+			       flags & ~RV8803_FLAG_V2F);
=20
 	mutex_unlock(&rv8803->flags_lock);
=20
@@ -199,12 +263,11 @@ static int rv8803_get_alarm(struct device *dev, struc=
t rtc_wkalrm *alrm)
 	u8 alarmvals[3];
 	int flags, ret;
=20
-	ret =3D i2c_smbus_read_i2c_block_data(client, RV8803_ALARM_MIN,
-					    3, alarmvals);
-	if (ret !=3D 3)
-		return ret < 0 ? ret : -EIO;
+	ret =3D rv8803_read_regs(client, RV8803_ALARM_MIN, 3, alarmvals);
+	if (ret)
+		return ret;
=20
-	flags =3D i2c_smbus_read_byte_data(client, RV8803_FLAG);
+	flags =3D rv8803_read_reg(client, RV8803_FLAG);
 	if (flags < 0)
 		return flags;
=20
@@ -237,10 +300,10 @@ static int rv8803_set_alarm(struct device *dev, struc=
t rtc_wkalrm *alrm)
=20
 	mutex_lock(&rv8803->flags_lock);
=20
-	ret =3D i2c_smbus_read_i2c_block_data(client, RV8803_FLAG, 2, ctrl);
-	if (ret !=3D 2) {
+	ret =3D rv8803_read_regs(client, RV8803_FLAG, 2, ctrl);
+	if (ret) {
 		mutex_unlock(&rv8803->flags_lock);
-		return ret < 0 ? ret : -EIO;
+		return ret;
 	}
=20
 	alarmvals[0] =3D bin2bcd(alrm->time.tm_min);
@@ -249,8 +312,8 @@ static int rv8803_set_alarm(struct device *dev, struct =
rtc_wkalrm *alrm)
=20
 	if (rv8803->ctrl & (RV8803_CTRL_AIE | RV8803_CTRL_UIE)) {
 		rv8803->ctrl &=3D ~(RV8803_CTRL_AIE | RV8803_CTRL_UIE);
-		err =3D i2c_smbus_write_byte_data(rv8803->client, RV8803_CTRL,
-						rv8803->ctrl);
+		err =3D rv8803_write_reg(rv8803->client, RV8803_CTRL,
+				       rv8803->ctrl);
 		if (err) {
 			mutex_unlock(&rv8803->flags_lock);
 			return err;
@@ -258,13 +321,12 @@ static int rv8803_set_alarm(struct device *dev, struc=
t rtc_wkalrm *alrm)
 	}
=20
 	ctrl[1] &=3D ~RV8803_FLAG_AF;
-	err =3D i2c_smbus_write_byte_data(rv8803->client, RV8803_FLAG, ctrl[1]);
+	err =3D rv8803_write_reg(rv8803->client, RV8803_FLAG, ctrl[1]);
 	mutex_unlock(&rv8803->flags_lock);
 	if (err)
 		return err;
=20
-	err =3D i2c_smbus_write_i2c_block_data(rv8803->client, RV8803_ALARM_MIN,
-					     3, alarmvals);
+	err =3D rv8803_write_regs(rv8803->client, RV8803_ALARM_MIN, 3, alarmvals)=
;
 	if (err)
 		return err;
=20
@@ -274,8 +336,8 @@ static int rv8803_set_alarm(struct device *dev, struct =
rtc_wkalrm *alrm)
 		if (rv8803->rtc->aie_timer.enabled)
 			rv8803->ctrl |=3D RV8803_CTRL_AIE;
=20
-		err =3D i2c_smbus_write_byte_data(rv8803->client, RV8803_CTRL,
-						rv8803->ctrl);
+		err =3D rv8803_write_reg(rv8803->client, RV8803_CTRL,
+				       rv8803->ctrl);
 		if (err)
 			return err;
 	}
@@ -304,21 +366,20 @@ static int rv8803_alarm_irq_enable(struct device *dev=
, unsigned int enabled)
 	}
=20
 	mutex_lock(&rv8803->flags_lock);
-	flags =3D i2c_smbus_read_byte_data(client, RV8803_FLAG);
+	flags =3D rv8803_read_reg(client, RV8803_FLAG);
 	if (flags < 0) {
 		mutex_unlock(&rv8803->flags_lock);
 		return flags;
 	}
 	flags &=3D ~(RV8803_FLAG_AF | RV8803_FLAG_UF);
-	err =3D i2c_smbus_write_byte_data(client, RV8803_FLAG, flags);
+	err =3D rv8803_write_reg(client, RV8803_FLAG, flags);
 	mutex_unlock(&rv8803->flags_lock);
 	if (err)
 		return err;
=20
 	if (ctrl !=3D rv8803->ctrl) {
 		rv8803->ctrl =3D ctrl;
-		err =3D i2c_smbus_write_byte_data(client, RV8803_CTRL,
-						rv8803->ctrl);
+		err =3D rv8803_write_reg(client, RV8803_CTRL, rv8803->ctrl);
 		if (err)
 			return err;
 	}
@@ -334,7 +395,7 @@ static int rv8803_ioctl(struct device *dev, unsigned in=
t cmd, unsigned long arg)
=20
 	switch (cmd) {
 	case RTC_VL_READ:
-		flags =3D i2c_smbus_read_byte_data(client, RV8803_FLAG);
+		flags =3D rv8803_read_reg(client, RV8803_FLAG);
 		if (flags < 0)
 			return flags;
=20
@@ -353,16 +414,16 @@ static int rv8803_ioctl(struct device *dev, unsigned =
int cmd, unsigned long arg)
=20
 	case RTC_VL_CLR:
 		mutex_lock(&rv8803->flags_lock);
-		flags =3D i2c_smbus_read_byte_data(client, RV8803_FLAG);
+		flags =3D rv8803_read_reg(client, RV8803_FLAG);
 		if (flags < 0) {
 			mutex_unlock(&rv8803->flags_lock);
 			return flags;
 		}
=20
 		flags &=3D ~(RV8803_FLAG_V1F | RV8803_FLAG_V2F);
-		ret =3D i2c_smbus_write_byte_data(client, RV8803_FLAG, flags);
+		ret =3D rv8803_write_reg(client, RV8803_FLAG, flags);
 		mutex_unlock(&rv8803->flags_lock);
-		if (ret < 0)
+		if (ret)
 			return ret;
=20
 		return 0;
@@ -380,8 +441,8 @@ static ssize_t rv8803_nvram_write(struct file *filp, st=
ruct kobject *kobj,
 	struct i2c_client *client =3D to_i2c_client(dev);
 	int ret;
=20
-	ret =3D i2c_smbus_write_byte_data(client, RV8803_RAM, buf[0]);
-	if (ret < 0)
+	ret =3D rv8803_write_reg(client, RV8803_RAM, buf[0]);
+	if (ret)
 		return ret;
=20
 	return 1;
@@ -395,7 +456,7 @@ static ssize_t rv8803_nvram_read(struct file *filp, str=
uct kobject *kobj,
 	struct i2c_client *client =3D to_i2c_client(dev);
 	int ret;
=20
-	ret =3D i2c_smbus_read_byte_data(client, RV8803_RAM);
+	ret =3D rv8803_read_reg(client, RV8803_RAM);
 	if (ret < 0)
 		return ret;
=20
@@ -425,7 +486,7 @@ static int rv8803_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adapter =3D to_i2c_adapter(client->dev.parent);
 	struct rv8803_data *rv8803;
-	int err, flags, try =3D 0;
+	int err, flags;
=20
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_I2C_BLOCK)) {
@@ -442,16 +503,7 @@ static int rv8803_probe(struct i2c_client *client,
 	rv8803->client =3D client;
 	i2c_set_clientdata(client, rv8803);
=20
-	/*
-	 * There is a 60=C2=B5s window where the RTC may not reply on the i2c bus=
 in
-	 * that case, the transfer is not ACKed. In that case, ensure there are
-	 * multiple attempts.
-	 */
-	do {
-		flags =3D i2c_smbus_read_byte_data(client, RV8803_FLAG);
-		try++;
-	} while (((flags =3D=3D -ENXIO) || (flags =3D=3D -EIO)) && (try < 4));
-
+	flags =3D rv8803_read_reg(client, RV8803_FLAG);
 	if (flags < 0)
 		return flags;
=20
@@ -486,12 +538,7 @@ static int rv8803_probe(struct i2c_client *client,
 		return PTR_ERR(rv8803->rtc);
 	}
=20
-	try =3D 0;
-	do {
-		err =3D i2c_smbus_write_byte_data(rv8803->client, RV8803_EXT,
-						RV8803_EXT_WADA);
-		try++;
-	} while (((err =3D=3D -ENXIO) || (flags =3D=3D -EIO)) && (try < 4));
+	err =3D rv8803_write_reg(rv8803->client, RV8803_EXT, RV8803_EXT_WADA);
 	if (err)
 		return err;
=20
--=20
2.5.0

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
