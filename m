Return-Path: <rtc-linux+bncBCPM5SUWUYIRBUNLXC2QKGQEPSMM3IQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com. [2607:f8b0:400e:c00::242])
        by gmr-mx.google.com with ESMTPS id tn7si3108151pac.1.2016.01.31.06.10.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2016 06:10:24 -0800 (PST)
Received: by mail-pf0-x242.google.com with SMTP id 65so6255236pfd.1
        for <rtc-linux@googlegroups.com>; Sun, 31 Jan 2016 06:10:24 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com,
	linux-clk@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>
Subject: [rtc-linux] [PATCH] rtc: rtc-ds1307: add clock provider support for DS3231
Date: Sun, 31 Jan 2016 23:10:10 +0900
Message-Id: <1454249410-21449-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

DS3231 has programmable square-wave output signal.
This enables to use this feature as a clock provider of
common clock framework.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/rtc/maxim,ds3231.txt       |  37 +++
 drivers/rtc/rtc-ds1307.c                           | 296 ++++++++++++++++++++-
 2 files changed, 332 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim,ds3231.txt

diff --git a/Documentation/devicetree/bindings/rtc/maxim,ds3231.txt b/Documentation/devicetree/bindings/rtc/maxim,ds3231.txt
new file mode 100644
index 0000000..ddef330
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/maxim,ds3231.txt
@@ -0,0 +1,37 @@
+* Maxim DS3231 Real Time Clock
+
+Required properties:
+see: Documentation/devicetree/bindings/i2c/trivial-devices.txt
+
+Optional property:
+- #clock-cells: Should be 1.
+- clock-output-names:
+  overwrite the default clock names "ds3231_clk_sqw" and "ds3231_clk_32khz".
+
+Each clock is assigned an identifier and client nodes can use this identifier
+to specify the clock which they consume. Following indices are allowed:
+    - 0: square-wave output on the SQW pin
+    - 1: square-wave output on the 32kHz pin
+
+- interrupts: rtc alarm/event interrupt. When this property is selected,
+  clock on the SQW pin cannot be used.
+
+Example:
+
+ds3231: ds3231@51 {
+	compatible = "maxim,ds3231";
+	reg = <0x68>;
+	#clock-cells = <1>;
+};
+
+device1 {
+...
+	clocks = <&ds3231 0>;
+...
+};
+
+device2 {
+...
+	clocks = <&ds3231 1>;
+...
+};
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 34d92a0..e34ad9e 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/clk-provider.h>
 
 /*
  * We can't determine type by probing, but if we expect pre-Linux code
@@ -91,6 +92,7 @@ enum ds_type {
 #	define DS1340_BIT_OSF		0x80
 #define DS1337_REG_STATUS	0x0f
 #	define DS1337_BIT_OSF		0x80
+#	define DS3231_BIT_EN32KHZ	0x08
 #	define DS1337_BIT_A2I		0x02
 #	define DS1337_BIT_A1I		0x01
 #define DS1339_REG_ALARM1_SECS	0x07
@@ -120,6 +122,9 @@ struct ds1307 {
 			       u8 length, u8 *values);
 	s32 (*write_block_data)(const struct i2c_client *client, u8 command,
 				u8 length, const u8 *values);
+#ifdef CONFIG_COMMON_CLK
+	struct clk_hw		clks[2];
+#endif
 };
 
 struct chip_desc {
@@ -935,7 +940,295 @@ static void ds1307_hwmon_register(struct ds1307 *ds1307)
 {
 }
 
-#endif
+#endif /* CONFIG_RTC_DRV_DS1307_HWMON */
+
+/*----------------------------------------------------------------------*/
+
+/*
+ * Square-wave output support for DS3231
+ * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3231.pdf
+ */
+#ifdef CONFIG_COMMON_CLK
+
+enum {
+	DS3231_CLK_SQW = 0,
+	DS3231_CLK_32KHZ,
+};
+
+#define clk_sqw_to_ds1307(clk)	\
+	container_of(clk, struct ds1307, clks[DS3231_CLK_SQW])
+#define clk_32khz_to_ds1307(clk)	\
+	container_of(clk, struct ds1307, clks[DS3231_CLK_32KHZ])
+
+static int ds3231_clk_sqw_rates[] = {
+	1,
+	1024,
+	4096,
+	8192,
+};
+
+static int ds1337_write_control(struct ds1307 *ds1307, u8 mask, u8 value)
+{
+	struct i2c_client *client = ds1307->client;
+	struct mutex *lock = &ds1307->rtc->ops_lock;
+	int control;
+	int ret;
+
+	mutex_lock(lock);
+
+	control = i2c_smbus_read_byte_data(client, DS1337_REG_CONTROL);
+	if (control < 0) {
+		ret = control;
+		goto out;
+	}
+
+	control &= ~mask;
+	control |= value;
+
+	ret = i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL, control);
+out:
+	mutex_unlock(lock);
+
+	return ret;
+}
+
+static unsigned long ds3231_clk_sqw_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+	int control;
+	int rate_sel = 0;
+
+	control = i2c_smbus_read_byte_data(ds1307->client, DS1337_REG_CONTROL);
+	if (control < 0)
+		return control;
+	if (control & DS1337_BIT_RS1)
+		rate_sel += 1;
+	if (control & DS1337_BIT_RS2)
+		rate_sel += 2;
+
+	return ds3231_clk_sqw_rates[rate_sel];
+}
+
+static long ds3231_clk_sqw_round_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long *prate)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(ds3231_clk_sqw_rates) - 1; i >= 0; i--) {
+		if (ds3231_clk_sqw_rates[i] <= rate)
+			return ds3231_clk_sqw_rates[i];
+	}
+
+	return 0;
+}
+
+static int ds3231_clk_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+	int control = 0;
+	int rate_sel;
+
+	for (rate_sel = 0; rate_sel < ARRAY_SIZE(ds3231_clk_sqw_rates);
+			rate_sel++) {
+		if (ds3231_clk_sqw_rates[rate_sel] == rate)
+			break;
+	}
+
+	if (rate_sel == ARRAY_SIZE(ds3231_clk_sqw_rates))
+		return -EINVAL;
+
+	if (rate_sel & 1)
+		control |= DS1337_BIT_RS1;
+	if (rate_sel & 2)
+		control |= DS1337_BIT_RS2;
+
+	return ds1337_write_control(ds1307, DS1337_BIT_RS1 | DS1337_BIT_RS2,
+				control);
+}
+
+static int ds3231_clk_sqw_prepare(struct clk_hw *hw)
+{
+	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+
+	return ds1337_write_control(ds1307, DS1337_BIT_INTCN, 0);
+}
+
+static void ds3231_clk_sqw_unprepare(struct clk_hw *hw)
+{
+	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+
+	ds1337_write_control(ds1307, DS1337_BIT_INTCN, DS1337_BIT_INTCN);
+}
+
+static int ds3231_clk_sqw_is_prepared(struct clk_hw *hw)
+{
+	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+	int control;
+
+	control = i2c_smbus_read_byte_data(ds1307->client, DS1337_REG_CONTROL);
+	if (control < 0)
+		return control;
+
+	return !(control & DS1337_BIT_INTCN);
+}
+
+static const struct clk_ops ds3231_clk_sqw_ops = {
+	.prepare = ds3231_clk_sqw_prepare,
+	.unprepare = ds3231_clk_sqw_unprepare,
+	.is_prepared = ds3231_clk_sqw_is_prepared,
+	.recalc_rate = ds3231_clk_sqw_recalc_rate,
+	.round_rate = ds3231_clk_sqw_round_rate,
+	.set_rate = ds3231_clk_sqw_set_rate,
+};
+
+static unsigned long ds3231_clk_32khz_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	return 32768;
+}
+
+static int ds3231_clk_32khz_control(struct ds1307 *ds1307, bool enable)
+{
+	struct i2c_client *client = ds1307->client;
+	struct mutex *lock = &ds1307->rtc->ops_lock;
+	int status;
+	int ret;
+
+	mutex_lock(lock);
+
+	status = i2c_smbus_read_byte_data(client, DS1337_REG_STATUS);
+	if (status < 0) {
+		ret = status;
+		goto out;
+	}
+
+	if (enable)
+		status |= DS3231_BIT_EN32KHZ;
+	else
+		status &= ~DS3231_BIT_EN32KHZ;
+
+	ret = i2c_smbus_write_byte_data(client, DS1337_REG_STATUS, status);
+out:
+	mutex_unlock(lock);
+
+	return ret;
+}
+
+static int ds3231_clk_32khz_prepare(struct clk_hw *hw)
+{
+	struct ds1307 *ds1307 = clk_32khz_to_ds1307(hw);
+
+	return ds3231_clk_32khz_control(ds1307, true);
+}
+
+static void ds3231_clk_32khz_unprepare(struct clk_hw *hw)
+{
+	struct ds1307 *ds1307 = clk_32khz_to_ds1307(hw);
+
+	ds3231_clk_32khz_control(ds1307, false);
+}
+
+static int ds3231_clk_32khz_is_prepared(struct clk_hw *hw)
+{
+	struct ds1307 *ds1307 = clk_32khz_to_ds1307(hw);
+	int status;
+
+	status = i2c_smbus_read_byte_data(ds1307->client, DS1337_REG_STATUS);
+	if (status < 0)
+		return status;
+
+	return !!(status & DS3231_BIT_EN32KHZ);
+}
+
+static const struct clk_ops ds3231_clk_32khz_ops = {
+	.prepare = ds3231_clk_32khz_prepare,
+	.unprepare = ds3231_clk_32khz_unprepare,
+	.is_prepared = ds3231_clk_32khz_is_prepared,
+	.recalc_rate = ds3231_clk_32khz_recalc_rate,
+};
+
+static struct clk_init_data ds3231_clks_init[] = {
+	[DS3231_CLK_SQW] = {
+		.name = "ds3231_clk_sqw",
+		.ops = &ds3231_clk_sqw_ops,
+		.flags = CLK_IS_ROOT,
+	},
+	[DS3231_CLK_32KHZ] = {
+		.name = "ds3231_clk_32khz",
+		.ops = &ds3231_clk_32khz_ops,
+		.flags = CLK_IS_ROOT,
+	},
+};
+
+static int ds3231_clks_register(struct ds1307 *ds1307)
+{
+	struct i2c_client *client = ds1307->client;
+	struct device_node *node = client->dev.of_node;
+	struct clk_onecell_data	*onecell;
+	int i;
+
+	onecell = devm_kzalloc(&client->dev, sizeof(*onecell), GFP_KERNEL);
+	if (!onecell)
+		return -ENOMEM;
+
+	onecell->clk_num = ARRAY_SIZE(ds3231_clks_init);
+	onecell->clks = devm_kcalloc(&client->dev, onecell->clk_num,
+					sizeof(onecell->clks[0]), GFP_KERNEL);
+	if (!onecell->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(ds3231_clks_init); i++) {
+		struct clk_init_data init = ds3231_clks_init[i];
+
+		/*
+		 * Interrupt signal due to alarm conditions and square-wave
+		 * output share same pin, so don't initialize both.
+		 */
+		if (i == DS3231_CLK_SQW && test_bit(HAS_ALARM, &ds1307->flags))
+			continue;
+
+		/* optional override of the clockname */
+		of_property_read_string_index(node, "clock-output-names", i,
+						&init.name);
+		ds1307->clks[i].init = &init;
+
+		onecell->clks[i] = devm_clk_register(&client->dev,
+							&ds1307->clks[i]);
+		if (IS_ERR(onecell->clks[i]))
+			return PTR_ERR(onecell->clks[i]);
+	}
+
+	if (!node)
+		return 0;
+
+	of_clk_add_provider(node, of_clk_src_onecell_get, onecell);
+
+	return 0;
+}
+
+static void ds1307_clks_register(struct ds1307 *ds1307)
+{
+	int ret;
+
+	if (ds1307->type != ds_3231)
+		return;
+
+	ret = ds3231_clks_register(ds1307);
+	if (ret) {
+		dev_warn(&ds1307->client->dev,
+			"unable to register clock device %d\n", ret);
+	}
+}
+
+#else
+
+static void ds1307_clks_register(struct ds1307 *ds1307)
+{
+}
+
+#endif /* CONFIG_COMMON_CLK */
 
 static int ds1307_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
@@ -1278,6 +1571,7 @@ read_rtc:
 	}
 
 	ds1307_hwmon_register(ds1307);
+	ds1307_clks_register(ds1307);
 
 	return 0;
 
-- 
2.5.0

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
