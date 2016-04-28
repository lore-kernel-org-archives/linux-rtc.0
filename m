Return-Path: <rtc-linux+bncBAABBWMQRK4QKGQEGFX64UQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id r72si11222wmd.2.2016.04.28.15.02.01
        for <rtc-linux@googlegroups.com>;
        Thu, 28 Apr 2016 15:02:01 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH V2 2/6] rtc: rv3029: convert to use regmap
Date: Fri, 29 Apr 2016 00:00:33 +0200
Message-Id: <c6af062da839b65021ee494261d0cbca8c28437d.1461879175.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1461879175.git.mylene.josserand@free-electrons.com>
References: <cover.1461879175.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1461879175.git.mylene.josserand@free-electrons.com>
References: <cover.1461250479.git.mylene.josserand@free-electrons.com> <cover.1461879175.git.mylene.josserand@free-electrons.com>
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

To add support of rv3049, the current driver is converted to use regmap.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-rv3029c2.c | 275 +++++++++++++++++++++++------------------=
----
 1 file changed, 142 insertions(+), 133 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 091be48..96dd166 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -20,7 +20,7 @@
 #include <linux/of.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
-
+#include <linux/regmap.h>
=20
 /* Register map */
 /* control section */
@@ -116,81 +116,84 @@
 #define RV3029_USR2_RAM_PAGE		0x3C
 #define RV3029_USR2_SECTION_LEN		0x04
=20
-static int rv3029_read_regs(struct i2c_client *client, u8 reg, u8 *buf,
+struct rv3029_data {
+	struct device		*dev;
+	struct rtc_device	*rtc;
+	struct regmap		*regmap;
+	int irq;
+};
+
+static int rv3029_read_regs(struct device *dev, u8 reg, u8 *buf,
 			    unsigned len)
 {
-	int ret;
+	struct rv3029_data *rv3029 =3D dev_get_drvdata(dev);
=20
 	if ((reg > RV3029_USR1_RAM_PAGE + 7) ||
 		(reg + len > RV3029_USR1_RAM_PAGE + 8))
 		return -EINVAL;
=20
-	ret =3D i2c_smbus_read_i2c_block_data(client, reg, len, buf);
-	if (ret < 0)
-		return ret;
-	if (ret < len)
-		return -EIO;
-	return 0;
+	return regmap_bulk_read(rv3029->regmap, reg, buf, len);
 }
=20
-static int rv3029_write_regs(struct i2c_client *client, u8 reg, u8 const b=
uf[],
+static int rv3029_write_regs(struct device *dev, u8 reg, u8 const buf[],
 			     unsigned len)
 {
+	struct rv3029_data *rv3029 =3D dev_get_drvdata(dev);
+
 	if ((reg > RV3029_USR1_RAM_PAGE + 7) ||
 		(reg + len > RV3029_USR1_RAM_PAGE + 8))
 		return -EINVAL;
=20
-	return i2c_smbus_write_i2c_block_data(client, reg, len, buf);
+	return regmap_bulk_write(rv3029->regmap, reg, buf, len);
 }
=20
-static int rv3029_update_bits(struct i2c_client *client, u8 reg, u8 mask,
-			      u8 set)
+static int rv3029_update_bits(struct device *dev, u8 reg, u8 mask, u8 set)
 {
 	u8 buf;
 	int ret;
=20
-	ret =3D rv3029_read_regs(client, reg, &buf, 1);
+	ret =3D rv3029_read_regs(dev, reg, &buf, 1);
 	if (ret < 0)
 		return ret;
 	buf &=3D ~mask;
 	buf |=3D set & mask;
-	ret =3D rv3029_write_regs(client, reg, &buf, 1);
+	ret =3D rv3029_write_regs(dev, reg, &buf, 1);
 	if (ret < 0)
 		return ret;
=20
 	return 0;
 }
=20
-static int rv3029_get_sr(struct i2c_client *client, u8 *buf)
+static int rv3029_get_sr(struct device *dev, u8 *buf)
 {
-	int ret =3D rv3029_read_regs(client, RV3029_STATUS, buf, 1);
+	int ret =3D rv3029_read_regs(dev, RV3029_STATUS, buf, 1);
=20
 	if (ret < 0)
 		return -EIO;
-	dev_dbg(&client->dev, "status =3D 0x%.2x (%d)\n", buf[0], buf[0]);
+	dev_dbg(dev, "status =3D 0x%.2x (%d)\n", buf[0], buf[0]);
 	return 0;
 }
=20
-static int rv3029_set_sr(struct i2c_client *client, u8 val)
+static int rv3029_set_sr(struct device *dev, u8 val)
 {
 	u8 buf[1];
 	int sr;
=20
 	buf[0] =3D val;
-	sr =3D rv3029_write_regs(client, RV3029_STATUS, buf, 1);
-	dev_dbg(&client->dev, "status =3D 0x%.2x (%d)\n", buf[0], buf[0]);
+	sr =3D rv3029_write_regs(dev, RV3029_STATUS, buf, 1);
+	dev_dbg(dev, "status =3D 0x%.2x (%d)\n", buf[0], buf[0]);
 	if (sr < 0)
 		return -EIO;
 	return 0;
 }
=20
-static int rv3029_eeprom_busywait(struct i2c_client *client)
+static int rv3029_eeprom_busywait(struct device *dev)
 {
 	int i, ret;
 	u8 sr;
=20
 	for (i =3D 100; i > 0; i--) {
-		ret =3D rv3029_get_sr(client, &sr);
+		ret =3D rv3029_get_sr(dev, &sr);
 		if (ret < 0)
 			break;
 		if (!(sr & RV3029_STATUS_EEBUSY))
@@ -198,28 +201,28 @@ static int rv3029_eeprom_busywait(struct i2c_client *=
client)
 		usleep_range(1000, 10000);
 	}
 	if (i <=3D 0) {
-		dev_err(&client->dev, "EEPROM busy wait timeout.\n");
+		dev_err(dev, "EEPROM busy wait timeout.\n");
 		return -ETIMEDOUT;
 	}
=20
 	return ret;
 }
=20
-static int rv3029_eeprom_exit(struct i2c_client *client)
+static int rv3029_eeprom_exit(struct device *dev)
 {
 	/* Re-enable eeprom refresh */
-	return rv3029_update_bits(client, RV3029_ONOFF_CTRL,
+	return rv3029_update_bits(dev, RV3029_ONOFF_CTRL,
 				  RV3029_ONOFF_CTRL_EERE,
 				  RV3029_ONOFF_CTRL_EERE);
 }
=20
-static int rv3029_eeprom_enter(struct i2c_client *client)
+static int rv3029_eeprom_enter(struct device *dev)
 {
 	int ret;
 	u8 sr;
=20
 	/* Check whether we are in the allowed voltage range. */
-	ret =3D rv3029_get_sr(client, &sr);
+	ret =3D rv3029_get_sr(dev, &sr);
 	if (ret < 0)
 		return ret;
 	if (sr & (RV3029_STATUS_VLOW1 | RV3029_STATUS_VLOW2)) {
@@ -228,119 +231,118 @@ static int rv3029_eeprom_enter(struct i2c_client *c=
lient)
 		 */
 		sr &=3D ~RV3029_STATUS_VLOW1;
 		sr &=3D ~RV3029_STATUS_VLOW2;
-		ret =3D rv3029_set_sr(client, sr);
+		ret =3D rv3029_set_sr(dev, sr);
 		if (ret < 0)
 			return ret;
 		usleep_range(1000, 10000);
-		ret =3D rv3029_get_sr(client, &sr);
+		ret =3D rv3029_get_sr(dev, &sr);
 		if (ret < 0)
 			return ret;
 		if (sr & (RV3029_STATUS_VLOW1 | RV3029_STATUS_VLOW2)) {
-			dev_err(&client->dev,
+			dev_err(dev,
 				"Supply voltage is too low to safely access the EEPROM.\n");
 			return -ENODEV;
 		}
 	}
=20
 	/* Disable eeprom refresh. */
-	ret =3D rv3029_update_bits(client, RV3029_ONOFF_CTRL,
-				 RV3029_ONOFF_CTRL_EERE, 0);
+	ret =3D rv3029_update_bits(dev, RV3029_ONOFF_CTRL, RV3029_ONOFF_CTRL_EERE=
,
+				 0);
 	if (ret < 0)
 		return ret;
=20
 	/* Wait for any previous eeprom accesses to finish. */
-	ret =3D rv3029_eeprom_busywait(client);
+	ret =3D rv3029_eeprom_busywait(dev);
 	if (ret < 0)
-		rv3029_eeprom_exit(client);
+		rv3029_eeprom_exit(dev);
=20
 	return ret;
 }
=20
-static int rv3029_eeprom_read(struct i2c_client *client, u8 reg,
+static int rv3029_eeprom_read(struct device *dev, u8 reg,
 			      u8 buf[], size_t len)
 {
 	int ret, err;
=20
-	err =3D rv3029_eeprom_enter(client);
+	err =3D rv3029_eeprom_enter(dev);
 	if (err < 0)
 		return err;
=20
-	ret =3D rv3029_read_regs(client, reg, buf, len);
+	ret =3D rv3029_read_regs(dev, reg, buf, len);
=20
-	err =3D rv3029_eeprom_exit(client);
+	err =3D rv3029_eeprom_exit(dev);
 	if (err < 0)
 		return err;
=20
 	return ret;
 }
=20
-static int rv3029_eeprom_write(struct i2c_client *client, u8 reg,
+static int rv3029_eeprom_write(struct device *dev, u8 reg,
 			       u8 const buf[], size_t len)
 {
 	int ret, err;
 	size_t i;
 	u8 tmp;
=20
-	err =3D rv3029_eeprom_enter(client);
+	err =3D rv3029_eeprom_enter(dev);
 	if (err < 0)
 		return err;
=20
 	for (i =3D 0; i < len; i++, reg++) {
-		ret =3D rv3029_read_regs(client, reg, &tmp, 1);
+		ret =3D rv3029_read_regs(dev, reg, &tmp, 1);
 		if (ret < 0)
 			break;
 		if (tmp !=3D buf[i]) {
-			ret =3D rv3029_write_regs(client, reg, &buf[i], 1);
+			ret =3D rv3029_write_regs(dev, reg, &buf[i], 1);
 			if (ret < 0)
 				break;
 		}
-		ret =3D rv3029_eeprom_busywait(client);
+		ret =3D rv3029_eeprom_busywait(dev);
 		if (ret < 0)
 			break;
 	}
=20
-	err =3D rv3029_eeprom_exit(client);
+	err =3D rv3029_eeprom_exit(dev);
 	if (err < 0)
 		return err;
=20
 	return ret;
 }
=20
-static int rv3029_eeprom_update_bits(struct i2c_client *client,
+static int rv3029_eeprom_update_bits(struct device *dev,
 				     u8 reg, u8 mask, u8 set)
 {
 	u8 buf;
 	int ret;
=20
-	ret =3D rv3029_eeprom_read(client, reg, &buf, 1);
+	ret =3D rv3029_eeprom_read(dev, reg, &buf, 1);
 	if (ret < 0)
 		return ret;
 	buf &=3D ~mask;
 	buf |=3D set & mask;
-	ret =3D rv3029_eeprom_write(client, reg, &buf, 1);
+	ret =3D rv3029_eeprom_write(dev, reg, &buf, 1);
 	if (ret < 0)
 		return ret;
=20
 	return 0;
 }
=20
-static int rv3029_read_time(struct i2c_client *client, struct rtc_time *tm=
)
+static int rv3029_read_time(struct device *dev, struct rtc_time *tm)
 {
 	u8 buf[1];
 	int ret;
 	u8 regs[RV3029_WATCH_SECTION_LEN] =3D { 0, };
=20
-	ret =3D rv3029_get_sr(client, buf);
+	ret =3D rv3029_get_sr(dev, buf);
 	if (ret < 0) {
-		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
+		dev_err(dev, "%s: reading SR failed\n", __func__);
 		return -EIO;
 	}
=20
-	ret =3D rv3029_read_regs(client, RV3029_W_SEC, regs,
+	ret =3D rv3029_read_regs(dev, RV3029_W_SEC, regs,
 			       RV3029_WATCH_SECTION_LEN);
 	if (ret < 0) {
-		dev_err(&client->dev, "%s: reading RTC section failed\n",
-			__func__);
+		dev_err(dev, "%s: reading RTC section failed\n", __func__);
 		return ret;
 	}
=20
@@ -368,30 +370,23 @@ static int rv3029_read_time(struct i2c_client *client=
, struct rtc_time *tm)
 	return 0;
 }
=20
-static int rv3029_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	return rv3029_read_time(to_i2c_client(dev), tm);
-}
-
-static int rv3029_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *al=
arm)
+static int rv3029_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
-	struct i2c_client *client =3D to_i2c_client(dev);
 	struct rtc_time *const tm =3D &alarm->time;
 	int ret;
 	u8 regs[8];
=20
-	ret =3D rv3029_get_sr(client, regs);
+	ret =3D rv3029_get_sr(dev, regs);
 	if (ret < 0) {
-		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
+		dev_err(dev, "%s: reading SR failed\n", __func__);
 		return -EIO;
 	}
=20
-	ret =3D rv3029_read_regs(client, RV3029_A_SC, regs,
+	ret =3D rv3029_read_regs(dev, RV3029_A_SC, regs,
 			       RV3029_ALARM_SECTION_LEN);
=20
 	if (ret < 0) {
-		dev_err(&client->dev, "%s: reading alarm section failed\n",
-			__func__);
+		dev_err(dev, "%s: reading alarm section failed\n", __func__);
 		return ret;
 	}
=20
@@ -406,25 +401,23 @@ static int rv3029_rtc_read_alarm(struct device *dev, =
struct rtc_wkalrm *alarm)
 	return 0;
 }
=20
-static int rv3029_rtc_alarm_set_irq(struct i2c_client *client, int enable)
+static int rv3029_rtc_alarm_set_irq(struct device *dev, int enable)
 {
 	int ret;
=20
 	/* enable/disable AIE irq */
-	ret =3D rv3029_update_bits(client, RV3029_IRQ_CTRL,
-				 RV3029_IRQ_CTRL_AIE,
+	ret =3D rv3029_update_bits(dev, RV3029_IRQ_CTRL, RV3029_IRQ_CTRL_AIE,
 				 (enable ? RV3029_IRQ_CTRL_AIE : 0));
 	if (ret < 0) {
-		dev_err(&client->dev, "can't update INT reg\n");
+		dev_err(dev, "can't update INT reg\n");
 		return ret;
 	}
=20
 	return 0;
 }
=20
-static int rv3029_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *ala=
rm)
+static int rv3029_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
-	struct i2c_client *client =3D to_i2c_client(dev);
 	struct rtc_time *const tm =3D &alarm->time;
 	int ret;
 	u8 regs[8];
@@ -437,9 +430,9 @@ static int rv3029_rtc_set_alarm(struct device *dev, str=
uct rtc_wkalrm *alarm)
 	if (tm->tm_year < 100)
 		return -EINVAL;
=20
-	ret =3D rv3029_get_sr(client, regs);
+	ret =3D rv3029_get_sr(dev, regs);
 	if (ret < 0) {
-		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
+		dev_err(dev, "%s: reading SR failed\n", __func__);
 		return -EIO;
 	}
 	regs[RV3029_A_SC-RV3029_A_SC] =3D bin2bcd(tm->tm_sec & 0x7f);
@@ -450,38 +443,38 @@ static int rv3029_rtc_set_alarm(struct device *dev, s=
truct rtc_wkalrm *alarm)
 	regs[RV3029_A_DW-RV3029_A_SC] =3D bin2bcd((tm->tm_wday & 7) - 1);
 	regs[RV3029_A_YR-RV3029_A_SC] =3D bin2bcd((tm->tm_year & 0x7f) - 100);
=20
-	ret =3D rv3029_write_regs(client, RV3029_A_SC, regs,
+	ret =3D rv3029_write_regs(dev, RV3029_A_SC, regs,
 				RV3029_ALARM_SECTION_LEN);
 	if (ret < 0)
 		return ret;
=20
 	if (alarm->enabled) {
 		/* clear AF flag */
-		ret =3D rv3029_update_bits(client, RV3029_IRQ_FLAGS,
+		ret =3D rv3029_update_bits(dev, RV3029_IRQ_FLAGS,
 					 RV3029_IRQ_FLAGS_AF, 0);
 		if (ret < 0) {
-			dev_err(&client->dev, "can't clear alarm flag\n");
+			dev_err(dev, "can't clear alarm flag\n");
 			return ret;
 		}
 		/* enable AIE irq */
-		ret =3D rv3029_rtc_alarm_set_irq(client, 1);
+		ret =3D rv3029_rtc_alarm_set_irq(dev, 1);
 		if (ret)
 			return ret;
=20
-		dev_dbg(&client->dev, "alarm IRQ armed\n");
+		dev_dbg(dev, "alarm IRQ armed\n");
 	} else {
 		/* disable AIE irq */
-		ret =3D rv3029_rtc_alarm_set_irq(client, 0);
+		ret =3D rv3029_rtc_alarm_set_irq(dev, 0);
 		if (ret)
 			return ret;
=20
-		dev_dbg(&client->dev, "alarm IRQ disabled\n");
+		dev_dbg(dev, "alarm IRQ disabled\n");
 	}
=20
 	return 0;
 }
=20
-static int rv3029_set_time(struct i2c_client *client, struct rtc_time cons=
t *tm)
+static int rv3029_set_time(struct device *dev, struct rtc_time *tm)
 {
 	u8 regs[8];
 	int ret;
@@ -502,31 +495,25 @@ static int rv3029_set_time(struct i2c_client *client,=
 struct rtc_time const *tm)
 	regs[RV3029_W_DAYS-RV3029_W_SEC] =3D bin2bcd((tm->tm_wday & 7)+1);
 	regs[RV3029_W_YEARS-RV3029_W_SEC] =3D bin2bcd(tm->tm_year - 100);
=20
-	ret =3D rv3029_write_regs(client, RV3029_W_SEC, regs,
+	ret =3D rv3029_write_regs(dev, RV3029_W_SEC, regs,
 				RV3029_WATCH_SECTION_LEN);
 	if (ret < 0)
 		return ret;
=20
-	ret =3D rv3029_get_sr(client, regs);
+	ret =3D rv3029_get_sr(dev, regs);
 	if (ret < 0) {
-		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
+		dev_err(dev, "%s: reading SR failed\n", __func__);
 		return ret;
 	}
 	/* clear PON bit */
-	ret =3D rv3029_set_sr(client, (regs[0] & ~RV3029_STATUS_PON));
+	ret =3D rv3029_set_sr(dev, (regs[0] & ~RV3029_STATUS_PON));
 	if (ret < 0) {
-		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
+		dev_err(dev, "%s: reading SR failed\n", __func__);
 		return ret;
 	}
=20
 	return 0;
 }
-
-static int rv3029_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	return rv3029_set_time(to_i2c_client(dev), tm);
-}
-
 static const struct rv3029_trickle_tab_elem {
 	u32 r;		/* resistance in ohms */
 	u8 conf;	/* trickle config bits */
@@ -584,9 +571,9 @@ static const struct rv3029_trickle_tab_elem {
 	},
 };
=20
-static void rv3029_trickle_config(struct i2c_client *client)
+static void rv3029_trickle_config(struct device *dev)
 {
-	struct device_node *of_node =3D client->dev.of_node;
+	struct device_node *of_node =3D dev->of_node;
 	const struct rv3029_trickle_tab_elem *elem;
 	int i, err;
 	u32 ohms;
@@ -608,27 +595,26 @@ static void rv3029_trickle_config(struct i2c_client *=
client)
 				break;
 		}
 		trickle_set_bits =3D elem->conf;
-		dev_info(&client->dev,
+		dev_info(dev,
 			 "Trickle charger enabled at %d ohms resistance.\n",
 			 elem->r);
 	}
-	err =3D rv3029_eeprom_update_bits(client, RV3029_CONTROL_E2P_EECTRL,
+	err =3D rv3029_eeprom_update_bits(dev, RV3029_CONTROL_E2P_EECTRL,
 					RV3029_TRICKLE_MASK,
 					trickle_set_bits);
 	if (err < 0) {
-		dev_err(&client->dev,
-			"Failed to update trickle charger config\n");
+		dev_err(dev, "Failed to update trickle charger config\n");
 	}
 }
=20
 #ifdef CONFIG_RTC_DRV_RV3029_HWMON
=20
-static int rv3029_read_temp(struct i2c_client *client, int *temp_mC)
+static int rv3029_read_temp(struct device *dev, int *temp_mC)
 {
 	int ret;
 	u8 temp;
=20
-	ret =3D rv3029_read_regs(client, RV3029_TEMP_PAGE, &temp, 1);
+	ret =3D rv3029_read_regs(dev, RV3029_TEMP_PAGE, &temp, 1);
 	if (ret < 0)
 		return ret;
=20
@@ -641,10 +627,9 @@ static ssize_t rv3029_hwmon_show_temp(struct device *d=
ev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	struct i2c_client *client =3D dev_get_drvdata(dev);
 	int ret, temp_mC;
=20
-	ret =3D rv3029_read_temp(client, &temp_mC);
+	ret =3D rv3029_read_temp(dev, &temp_mC);
 	if (ret < 0)
 		return ret;
=20
@@ -656,7 +641,6 @@ static ssize_t rv3029_hwmon_set_update_interval(struct =
device *dev,
 						const char *buf,
 						size_t count)
 {
-	struct i2c_client *client =3D dev_get_drvdata(dev);
 	unsigned long interval_ms;
 	int ret;
 	u8 th_set_bits =3D 0;
@@ -670,7 +654,7 @@ static ssize_t rv3029_hwmon_set_update_interval(struct =
device *dev,
 		if (interval_ms >=3D 16000)
 			th_set_bits |=3D RV3029_EECTRL_THP;
 	}
-	ret =3D rv3029_eeprom_update_bits(client, RV3029_CONTROL_E2P_EECTRL,
+	ret =3D rv3029_eeprom_update_bits(dev, RV3029_CONTROL_E2P_EECTRL,
 					RV3029_EECTRL_THE | RV3029_EECTRL_THP,
 					th_set_bits);
 	if (ret < 0)
@@ -683,11 +667,10 @@ static ssize_t rv3029_hwmon_show_update_interval(stru=
ct device *dev,
 						 struct device_attribute *attr,
 						 char *buf)
 {
-	struct i2c_client *client =3D dev_get_drvdata(dev);
 	int ret, interval_ms;
 	u8 eectrl;
=20
-	ret =3D rv3029_eeprom_read(client, RV3029_CONTROL_E2P_EECTRL,
+	ret =3D rv3029_eeprom_read(dev, RV3029_CONTROL_E2P_EECTRL,
 				 &eectrl, 1);
 	if (ret < 0)
 		return ret;
@@ -717,32 +700,32 @@ static struct attribute *rv3029_hwmon_attrs[] =3D {
 };
 ATTRIBUTE_GROUPS(rv3029_hwmon);
=20
-static void rv3029_hwmon_register(struct i2c_client *client)
+static void rv3029_hwmon_register(struct device *dev, const char *name)
 {
+	struct rv3029_data *rv3029 =3D dev_get_drvdata(dev);
 	struct device *hwmon_dev;
=20
-	hwmon_dev =3D devm_hwmon_device_register_with_groups(
-		&client->dev, client->name, client, rv3029_hwmon_groups);
+	hwmon_dev =3D devm_hwmon_device_register_with_groups(dev, name, rv3029,
+							   rv3029_hwmon_groups);
 	if (IS_ERR(hwmon_dev)) {
-		dev_warn(&client->dev,
-			 "unable to register hwmon device %ld\n",
+		dev_warn(dev, "unable to register hwmon device %ld\n",
 			 PTR_ERR(hwmon_dev));
 	}
 }
=20
 #else /* CONFIG_RTC_DRV_RV3029_HWMON */
=20
-static void rv3029_hwmon_register(struct i2c_client *client)
+static void rv3029_hwmon_register(struct device *dev, const char *name)
 {
 }
=20
 #endif /* CONFIG_RTC_DRV_RV3029_HWMON */
=20
 static const struct rtc_class_ops rv3029_rtc_ops =3D {
-	.read_time	=3D rv3029_rtc_read_time,
-	.set_time	=3D rv3029_rtc_set_time,
-	.read_alarm	=3D rv3029_rtc_read_alarm,
-	.set_alarm	=3D rv3029_rtc_set_alarm,
+	.read_time	=3D rv3029_read_time,
+	.set_time	=3D rv3029_set_time,
+	.read_alarm	=3D rv3029_read_alarm,
+	.set_alarm	=3D rv3029_set_alarm,
 };
=20
 static struct i2c_device_id rv3029_id[] =3D {
@@ -752,41 +735,67 @@ static struct i2c_device_id rv3029_id[] =3D {
 };
 MODULE_DEVICE_TABLE(i2c, rv3029_id);
=20
-static int rv3029_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int rv3029_probe(struct device *dev, struct regmap *regmap, int irq=
,
+			const char *name)
 {
-	struct rtc_device *rtc;
+	struct rv3029_data *rv3029;
 	int rc =3D 0;
 	u8 buf[1];
=20
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_EMUL))
-		return -ENODEV;
+	rv3029 =3D devm_kzalloc(dev, sizeof(*rv3029), GFP_KERNEL);
+	if (!rv3029)
+		return -ENOMEM;
+
+	rv3029->regmap =3D regmap;
+	rv3029->irq =3D irq;
+	rv3029->dev =3D dev;
+	dev_set_drvdata(dev, rv3029);
=20
-	rc =3D rv3029_get_sr(client, buf);
+	rc =3D rv3029_get_sr(dev, buf);
 	if (rc < 0) {
-		dev_err(&client->dev, "reading status failed\n");
+		dev_err(dev, "reading status failed\n");
 		return rc;
 	}
=20
-	rv3029_trickle_config(client);
-	rv3029_hwmon_register(client);
+	rv3029_trickle_config(dev);
+	rv3029_hwmon_register(dev, name);
+
+	rv3029->rtc =3D devm_rtc_device_register(dev, name, &rv3029_rtc_ops,
+					       THIS_MODULE);
=20
-	rtc =3D devm_rtc_device_register(&client->dev, client->name,
-				       &rv3029_rtc_ops, THIS_MODULE);
+	return PTR_ERR_OR_ZERO(rv3029->rtc);
+}
=20
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
+static int rv3029_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	static const struct regmap_config config =3D {
+		.reg_bits =3D 8,
+		.val_bits =3D 8,
+	};
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK |
+				     I2C_FUNC_SMBUS_BYTE)) {
+		dev_err(&client->dev, "Adapter does not support SMBUS_I2C_BLOCK or SMBUS=
_I2C_BYTE\n");
+		return -ENODEV;
+	}
=20
-	i2c_set_clientdata(client, rtc);
+	regmap =3D devm_regmap_init_i2c(client, &config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "%s: regmap allocation failed: %ld\n",
+			__func__, PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
=20
-	return 0;
+	return rv3029_probe(&client->dev, regmap, client->irq, client->name);
 }
=20
 static struct i2c_driver rv3029_driver =3D {
 	.driver =3D {
 		.name =3D "rtc-rv3029c2",
 	},
-	.probe		=3D rv3029_probe,
+	.probe		=3D rv3029_i2c_probe,
 	.id_table	=3D rv3029_id,
 };
=20
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
