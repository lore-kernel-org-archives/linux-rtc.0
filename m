Return-Path: <rtc-linux+bncBAABBXVV4S4AKGQEPEAPBOI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e78si87957wmc.3.2016.04.21.11.24.29
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Apr 2016 11:24:29 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 1/6] rtc: rv3029: remove 'i2c' in functions names
Date: Thu, 21 Apr 2016 20:24:14 +0200
Message-Id: <c5e88822cdd41fea5530d9fe1c0c0b1830049bde.1461250479.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1461250479.git.mylene.josserand@free-electrons.com>
References: <cover.1461250479.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1461250479.git.mylene.josserand@free-electrons.com>
References: <cover.1461250479.git.mylene.josserand@free-electrons.com>
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

To prepare the use of regmap to add the support of RV-3049, all the
'i2c' in functions's names are removed.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-rv3029c2.c | 132 ++++++++++++++++++++---------------------=
----
 1 file changed, 57 insertions(+), 75 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index d0cbf08..091be48 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -116,9 +116,8 @@
 #define RV3029_USR2_RAM_PAGE		0x3C
 #define RV3029_USR2_SECTION_LEN		0x04
=20
-static int
-rv3029_i2c_read_regs(struct i2c_client *client, u8 reg, u8 *buf,
-		     unsigned len)
+static int rv3029_read_regs(struct i2c_client *client, u8 reg, u8 *buf,
+			    unsigned len)
 {
 	int ret;
=20
@@ -134,9 +133,8 @@ rv3029_i2c_read_regs(struct i2c_client *client, u8 reg,=
 u8 *buf,
 	return 0;
 }
=20
-static int
-rv3029_i2c_write_regs(struct i2c_client *client, u8 reg, u8 const buf[],
-		      unsigned len)
+static int rv3029_write_regs(struct i2c_client *client, u8 reg, u8 const b=
uf[],
+			     unsigned len)
 {
 	if ((reg > RV3029_USR1_RAM_PAGE + 7) ||
 		(reg + len > RV3029_USR1_RAM_PAGE + 8))
@@ -145,28 +143,27 @@ rv3029_i2c_write_regs(struct i2c_client *client, u8 r=
eg, u8 const buf[],
 	return i2c_smbus_write_i2c_block_data(client, reg, len, buf);
 }
=20
-static int
-rv3029_i2c_update_bits(struct i2c_client *client, u8 reg, u8 mask, u8 set)
+static int rv3029_update_bits(struct i2c_client *client, u8 reg, u8 mask,
+			      u8 set)
 {
 	u8 buf;
 	int ret;
=20
-	ret =3D rv3029_i2c_read_regs(client, reg, &buf, 1);
+	ret =3D rv3029_read_regs(client, reg, &buf, 1);
 	if (ret < 0)
 		return ret;
 	buf &=3D ~mask;
 	buf |=3D set & mask;
-	ret =3D rv3029_i2c_write_regs(client, reg, &buf, 1);
+	ret =3D rv3029_write_regs(client, reg, &buf, 1);
 	if (ret < 0)
 		return ret;
=20
 	return 0;
 }
=20
-static int
-rv3029_i2c_get_sr(struct i2c_client *client, u8 *buf)
+static int rv3029_get_sr(struct i2c_client *client, u8 *buf)
 {
-	int ret =3D rv3029_i2c_read_regs(client, RV3029_STATUS, buf, 1);
+	int ret =3D rv3029_read_regs(client, RV3029_STATUS, buf, 1);
=20
 	if (ret < 0)
 		return -EIO;
@@ -174,14 +171,13 @@ rv3029_i2c_get_sr(struct i2c_client *client, u8 *buf)
 	return 0;
 }
=20
-static int
-rv3029_i2c_set_sr(struct i2c_client *client, u8 val)
+static int rv3029_set_sr(struct i2c_client *client, u8 val)
 {
 	u8 buf[1];
 	int sr;
=20
 	buf[0] =3D val;
-	sr =3D rv3029_i2c_write_regs(client, RV3029_STATUS, buf, 1);
+	sr =3D rv3029_write_regs(client, RV3029_STATUS, buf, 1);
 	dev_dbg(&client->dev, "status =3D 0x%.2x (%d)\n", buf[0], buf[0]);
 	if (sr < 0)
 		return -EIO;
@@ -194,7 +190,7 @@ static int rv3029_eeprom_busywait(struct i2c_client *cl=
ient)
 	u8 sr;
=20
 	for (i =3D 100; i > 0; i--) {
-		ret =3D rv3029_i2c_get_sr(client, &sr);
+		ret =3D rv3029_get_sr(client, &sr);
 		if (ret < 0)
 			break;
 		if (!(sr & RV3029_STATUS_EEBUSY))
@@ -212,9 +208,9 @@ static int rv3029_eeprom_busywait(struct i2c_client *cl=
ient)
 static int rv3029_eeprom_exit(struct i2c_client *client)
 {
 	/* Re-enable eeprom refresh */
-	return rv3029_i2c_update_bits(client, RV3029_ONOFF_CTRL,
-				      RV3029_ONOFF_CTRL_EERE,
-				      RV3029_ONOFF_CTRL_EERE);
+	return rv3029_update_bits(client, RV3029_ONOFF_CTRL,
+				  RV3029_ONOFF_CTRL_EERE,
+				  RV3029_ONOFF_CTRL_EERE);
 }
=20
 static int rv3029_eeprom_enter(struct i2c_client *client)
@@ -223,7 +219,7 @@ static int rv3029_eeprom_enter(struct i2c_client *clien=
t)
 	u8 sr;
=20
 	/* Check whether we are in the allowed voltage range. */
-	ret =3D rv3029_i2c_get_sr(client, &sr);
+	ret =3D rv3029_get_sr(client, &sr);
 	if (ret < 0)
 		return ret;
 	if (sr & (RV3029_STATUS_VLOW1 | RV3029_STATUS_VLOW2)) {
@@ -232,11 +228,11 @@ static int rv3029_eeprom_enter(struct i2c_client *cli=
ent)
 		 */
 		sr &=3D ~RV3029_STATUS_VLOW1;
 		sr &=3D ~RV3029_STATUS_VLOW2;
-		ret =3D rv3029_i2c_set_sr(client, sr);
+		ret =3D rv3029_set_sr(client, sr);
 		if (ret < 0)
 			return ret;
 		usleep_range(1000, 10000);
-		ret =3D rv3029_i2c_get_sr(client, &sr);
+		ret =3D rv3029_get_sr(client, &sr);
 		if (ret < 0)
 			return ret;
 		if (sr & (RV3029_STATUS_VLOW1 | RV3029_STATUS_VLOW2)) {
@@ -247,8 +243,8 @@ static int rv3029_eeprom_enter(struct i2c_client *clien=
t)
 	}
=20
 	/* Disable eeprom refresh. */
-	ret =3D rv3029_i2c_update_bits(client, RV3029_ONOFF_CTRL,
-				     RV3029_ONOFF_CTRL_EERE, 0);
+	ret =3D rv3029_update_bits(client, RV3029_ONOFF_CTRL,
+				 RV3029_ONOFF_CTRL_EERE, 0);
 	if (ret < 0)
 		return ret;
=20
@@ -269,7 +265,7 @@ static int rv3029_eeprom_read(struct i2c_client *client=
, u8 reg,
 	if (err < 0)
 		return err;
=20
-	ret =3D rv3029_i2c_read_regs(client, reg, buf, len);
+	ret =3D rv3029_read_regs(client, reg, buf, len);
=20
 	err =3D rv3029_eeprom_exit(client);
 	if (err < 0)
@@ -290,11 +286,11 @@ static int rv3029_eeprom_write(struct i2c_client *cli=
ent, u8 reg,
 		return err;
=20
 	for (i =3D 0; i < len; i++, reg++) {
-		ret =3D rv3029_i2c_read_regs(client, reg, &tmp, 1);
+		ret =3D rv3029_read_regs(client, reg, &tmp, 1);
 		if (ret < 0)
 			break;
 		if (tmp !=3D buf[i]) {
-			ret =3D rv3029_i2c_write_regs(client, reg, &buf[i], 1);
+			ret =3D rv3029_write_regs(client, reg, &buf[i], 1);
 			if (ret < 0)
 				break;
 		}
@@ -328,21 +324,20 @@ static int rv3029_eeprom_update_bits(struct i2c_clien=
t *client,
 	return 0;
 }
=20
-static int
-rv3029_i2c_read_time(struct i2c_client *client, struct rtc_time *tm)
+static int rv3029_read_time(struct i2c_client *client, struct rtc_time *tm=
)
 {
 	u8 buf[1];
 	int ret;
 	u8 regs[RV3029_WATCH_SECTION_LEN] =3D { 0, };
=20
-	ret =3D rv3029_i2c_get_sr(client, buf);
+	ret =3D rv3029_get_sr(client, buf);
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
 		return -EIO;
 	}
=20
-	ret =3D rv3029_i2c_read_regs(client, RV3029_W_SEC, regs,
-				   RV3029_WATCH_SECTION_LEN);
+	ret =3D rv3029_read_regs(client, RV3029_W_SEC, regs,
+			       RV3029_WATCH_SECTION_LEN);
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading RTC section failed\n",
 			__func__);
@@ -375,24 +370,24 @@ rv3029_i2c_read_time(struct i2c_client *client, struc=
t rtc_time *tm)
=20
 static int rv3029_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	return rv3029_i2c_read_time(to_i2c_client(dev), tm);
+	return rv3029_read_time(to_i2c_client(dev), tm);
 }
=20
-static int
-rv3029_i2c_read_alarm(struct i2c_client *client, struct rtc_wkalrm *alarm)
+static int rv3029_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *al=
arm)
 {
+	struct i2c_client *client =3D to_i2c_client(dev);
 	struct rtc_time *const tm =3D &alarm->time;
 	int ret;
 	u8 regs[8];
=20
-	ret =3D rv3029_i2c_get_sr(client, regs);
+	ret =3D rv3029_get_sr(client, regs);
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
 		return -EIO;
 	}
=20
-	ret =3D rv3029_i2c_read_regs(client, RV3029_A_SC, regs,
-				   RV3029_ALARM_SECTION_LEN);
+	ret =3D rv3029_read_regs(client, RV3029_A_SC, regs,
+			       RV3029_ALARM_SECTION_LEN);
=20
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading alarm section failed\n",
@@ -411,21 +406,14 @@ rv3029_i2c_read_alarm(struct i2c_client *client, stru=
ct rtc_wkalrm *alarm)
 	return 0;
 }
=20
-static int
-rv3029_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
-{
-	return rv3029_i2c_read_alarm(to_i2c_client(dev), alarm);
-}
-
-static int rv3029_rtc_i2c_alarm_set_irq(struct i2c_client *client,
-					int enable)
+static int rv3029_rtc_alarm_set_irq(struct i2c_client *client, int enable)
 {
 	int ret;
=20
 	/* enable/disable AIE irq */
-	ret =3D rv3029_i2c_update_bits(client, RV3029_IRQ_CTRL,
-				     RV3029_IRQ_CTRL_AIE,
-				     (enable ? RV3029_IRQ_CTRL_AIE : 0));
+	ret =3D rv3029_update_bits(client, RV3029_IRQ_CTRL,
+				 RV3029_IRQ_CTRL_AIE,
+				 (enable ? RV3029_IRQ_CTRL_AIE : 0));
 	if (ret < 0) {
 		dev_err(&client->dev, "can't update INT reg\n");
 		return ret;
@@ -434,9 +422,9 @@ static int rv3029_rtc_i2c_alarm_set_irq(struct i2c_clie=
nt *client,
 	return 0;
 }
=20
-static int rv3029_rtc_i2c_set_alarm(struct i2c_client *client,
-				    struct rtc_wkalrm *alarm)
+static int rv3029_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *ala=
rm)
 {
+	struct i2c_client *client =3D to_i2c_client(dev);
 	struct rtc_time *const tm =3D &alarm->time;
 	int ret;
 	u8 regs[8];
@@ -449,7 +437,7 @@ static int rv3029_rtc_i2c_set_alarm(struct i2c_client *=
client,
 	if (tm->tm_year < 100)
 		return -EINVAL;
=20
-	ret =3D rv3029_i2c_get_sr(client, regs);
+	ret =3D rv3029_get_sr(client, regs);
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
 		return -EIO;
@@ -462,28 +450,28 @@ static int rv3029_rtc_i2c_set_alarm(struct i2c_client=
 *client,
 	regs[RV3029_A_DW-RV3029_A_SC] =3D bin2bcd((tm->tm_wday & 7) - 1);
 	regs[RV3029_A_YR-RV3029_A_SC] =3D bin2bcd((tm->tm_year & 0x7f) - 100);
=20
-	ret =3D rv3029_i2c_write_regs(client, RV3029_A_SC, regs,
-				    RV3029_ALARM_SECTION_LEN);
+	ret =3D rv3029_write_regs(client, RV3029_A_SC, regs,
+				RV3029_ALARM_SECTION_LEN);
 	if (ret < 0)
 		return ret;
=20
 	if (alarm->enabled) {
 		/* clear AF flag */
-		ret =3D rv3029_i2c_update_bits(client, RV3029_IRQ_FLAGS,
-					     RV3029_IRQ_FLAGS_AF, 0);
+		ret =3D rv3029_update_bits(client, RV3029_IRQ_FLAGS,
+					 RV3029_IRQ_FLAGS_AF, 0);
 		if (ret < 0) {
 			dev_err(&client->dev, "can't clear alarm flag\n");
 			return ret;
 		}
 		/* enable AIE irq */
-		ret =3D rv3029_rtc_i2c_alarm_set_irq(client, 1);
+		ret =3D rv3029_rtc_alarm_set_irq(client, 1);
 		if (ret)
 			return ret;
=20
 		dev_dbg(&client->dev, "alarm IRQ armed\n");
 	} else {
 		/* disable AIE irq */
-		ret =3D rv3029_rtc_i2c_alarm_set_irq(client, 0);
+		ret =3D rv3029_rtc_alarm_set_irq(client, 0);
 		if (ret)
 			return ret;
=20
@@ -493,13 +481,7 @@ static int rv3029_rtc_i2c_set_alarm(struct i2c_client =
*client,
 	return 0;
 }
=20
-static int rv3029_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *ala=
rm)
-{
-	return rv3029_rtc_i2c_set_alarm(to_i2c_client(dev), alarm);
-}
-
-static int
-rv3029_i2c_set_time(struct i2c_client *client, struct rtc_time const *tm)
+static int rv3029_set_time(struct i2c_client *client, struct rtc_time cons=
t *tm)
 {
 	u8 regs[8];
 	int ret;
@@ -520,18 +502,18 @@ rv3029_i2c_set_time(struct i2c_client *client, struct=
 rtc_time const *tm)
 	regs[RV3029_W_DAYS-RV3029_W_SEC] =3D bin2bcd((tm->tm_wday & 7)+1);
 	regs[RV3029_W_YEARS-RV3029_W_SEC] =3D bin2bcd(tm->tm_year - 100);
=20
-	ret =3D rv3029_i2c_write_regs(client, RV3029_W_SEC, regs,
-				    RV3029_WATCH_SECTION_LEN);
+	ret =3D rv3029_write_regs(client, RV3029_W_SEC, regs,
+				RV3029_WATCH_SECTION_LEN);
 	if (ret < 0)
 		return ret;
=20
-	ret =3D rv3029_i2c_get_sr(client, regs);
+	ret =3D rv3029_get_sr(client, regs);
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
 		return ret;
 	}
 	/* clear PON bit */
-	ret =3D rv3029_i2c_set_sr(client, (regs[0] & ~RV3029_STATUS_PON));
+	ret =3D rv3029_set_sr(client, (regs[0] & ~RV3029_STATUS_PON));
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
 		return ret;
@@ -542,7 +524,7 @@ rv3029_i2c_set_time(struct i2c_client *client, struct r=
tc_time const *tm)
=20
 static int rv3029_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	return rv3029_i2c_set_time(to_i2c_client(dev), tm);
+	return rv3029_set_time(to_i2c_client(dev), tm);
 }
=20
 static const struct rv3029_trickle_tab_elem {
@@ -646,7 +628,7 @@ static int rv3029_read_temp(struct i2c_client *client, =
int *temp_mC)
 	int ret;
 	u8 temp;
=20
-	ret =3D rv3029_i2c_read_regs(client, RV3029_TEMP_PAGE, &temp, 1);
+	ret =3D rv3029_read_regs(client, RV3029_TEMP_PAGE, &temp, 1);
 	if (ret < 0)
 		return ret;
=20
@@ -743,8 +725,8 @@ static void rv3029_hwmon_register(struct i2c_client *cl=
ient)
 		&client->dev, client->name, client, rv3029_hwmon_groups);
 	if (IS_ERR(hwmon_dev)) {
 		dev_warn(&client->dev,
-			"unable to register hwmon device %ld\n",
-			PTR_ERR(hwmon_dev));
+			 "unable to register hwmon device %ld\n",
+			 PTR_ERR(hwmon_dev));
 	}
 }
=20
@@ -780,7 +762,7 @@ static int rv3029_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_EMUL))
 		return -ENODEV;
=20
-	rc =3D rv3029_i2c_get_sr(client, buf);
+	rc =3D rv3029_get_sr(client, buf);
 	if (rc < 0) {
 		dev_err(&client->dev, "reading status failed\n");
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
