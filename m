Return-Path: <rtc-linux+bncBCMNZUWXYYORB7GMUOVQKGQEQBHPN2Q@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com. [209.85.192.176])
        by gmr-mx.google.com with ESMTPS id ei3si737191pdb.1.2015.05.29.15.21.48
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2015 15:21:48 -0700 (PDT)
Received: by pdbki1 with SMTP id ki1so63010585pdb.1
        for <rtc-linux@googlegroups.com>; Fri, 29 May 2015 15:21:48 -0700 (PDT)
From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	sameo@linux.intel.com,
	lee.jones@linaro.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	Vaibhav Hiremath <vaibhav.hiremath@linaro.org>,
	Chao Xie <chao.xie@marvell.com>
Subject: [rtc-linux] [PATCH 1/4] mfd: 88pm800: add device tree support
Date: Sat, 30 May 2015 03:49:19 +0530
Message-Id: <1432937962-4537-2-git-send-email-vaibhav.hiremath@linaro.org>
In-Reply-To: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Add DT support to the 88pm800 driver along with below properties
	- marvell,88pm800-irq-write-clear :
	  Idicates whether interrupt status is cleared by write

Also, creates the DT binding text file,
Documentation/devicetree/bindings/mfd/88pm800.txt

Signed-off-by: Chao Xie <chao.xie@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 Documentation/devicetree/bindings/mfd/88pm800.txt | 57 +++++++++++++++++++++++
 drivers/mfd/88pm800.c                             | 39 ++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt

diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Documentation/devicetree/bindings/mfd/88pm800.txt
new file mode 100644
index 0000000..094951b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
@@ -0,0 +1,57 @@
+* Marvell 88PM800 Power Management IC
+
+Required parent device properties:
+- compatible : "marvell,88pm800"
+- reg : the I2C slave address for the 88pm800 chip
+- interrupts : IRQ line for the 88pm800 chip
+- interrupt-controller: describes the 88pm800 as an interrupt controller
+- #interrupt-cells : should be 1.
+		- The cell is the 88pm800 local IRQ number
+
+Optional parent device properties:
+- marvell,88pm800-irq-write-clr: indicates whether interrupt status is cleared by write
+
+88pm800 consists of a large and varied group of sub-devices:
+
+Device			 Supply Names	 Description
+------			 ------------	 -----------
+88pm80x-onkey		:		: On key
+88pm80x-rtc		:		: RTC
+88pm80x			:		: Regulators
+
+Note: More device list will follow
+
+Example:
+
+	pmic: 88pm800@30 {
+		compatible = "marvell,88pm800";
+		reg = <0x30>;
+		interrupts = <0 77 0x4>;
+		interrupt-parent = <&gic>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		marvell,88pm800-irq-write-clr;
+
+		regulators {
+			compatible = "marvell,88pm80x-regulator";
+
+			buck1a: BUCK1A {
+				regulator-compatible = "88PM800-BUCK1A";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			ldo1: LDO1 {
+				regulator-compatible = "88PM800-LDO1";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+		rtc {
+			compatible = "marvell,88pm80x-rtc";
+		};
+	};
diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 841717a..06ee058 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -27,6 +27,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/88pm80x.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 
 /* Interrupt Registers */
 #define PM800_INT_STATUS1		(0x05)
@@ -121,6 +122,11 @@ static const struct i2c_device_id pm80x_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
 
+static const struct of_device_id pm80x_of_match_table[] = {
+	{ .compatible = "marvell,88pm800", },
+	{},
+};
+
 static struct resource rtc_resources[] = {
 	{
 	 .name = "88pm80x-rtc",
@@ -133,6 +139,7 @@ static struct resource rtc_resources[] = {
 static struct mfd_cell rtc_devs[] = {
 	{
 	 .name = "88pm80x-rtc",
+	 .of_compatible = "marvell,88pm80x-rtc",
 	 .num_resources = ARRAY_SIZE(rtc_resources),
 	 .resources = &rtc_resources[0],
 	 .id = -1,
@@ -151,6 +158,7 @@ static struct resource onkey_resources[] = {
 static const struct mfd_cell onkey_devs[] = {
 	{
 	 .name = "88pm80x-onkey",
+	 .of_compatible = "marvell,88pm80x-onkey",
 	 .num_resources = 1,
 	 .resources = &onkey_resources[0],
 	 .id = -1,
@@ -160,6 +168,7 @@ static const struct mfd_cell onkey_devs[] = {
 static const struct mfd_cell regulator_devs[] = {
 	{
 	 .name = "88pm80x-regulator",
+	 .of_compatible = "marvell,88pm80x-regulator",
 	 .id = -1,
 	},
 };
@@ -538,14 +547,43 @@ out:
 	return ret;
 }
 
+static int pm800_probe_dt(struct device_node *np,
+			 struct device *dev,
+			 struct pm80x_platform_data *pdata)
+{
+	pdata->irq_mode =
+		of_property_read_bool(np, "marvell,88pm800-irq-write-clear");
+
+	return 0;
+}
+
+
 static int pm800_probe(struct i2c_client *client,
 				 const struct i2c_device_id *id)
 {
 	int ret = 0;
 	struct pm80x_chip *chip;
 	struct pm80x_platform_data *pdata = dev_get_platdata(&client->dev);
+	struct device_node *node = client->dev.of_node;
 	struct pm80x_subchip *subchip;
 
+	if (!pdata && !node) {
+		dev_err(&client->dev,
+			"pm80x requires platform data or of_node\n");
+		return -EINVAL;
+	}
+
+	if (!pdata) {
+		pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&client->dev, "failed to allocaate memory\n");
+			return -ENOMEM;
+		}
+		ret = pm800_probe_dt(node, &client->dev, pdata);
+		if (ret)
+			return ret;
+	}
+
 	ret = pm80x_init(client);
 	if (ret) {
 		dev_err(&client->dev, "pm800_init fail\n");
@@ -611,6 +649,7 @@ static struct i2c_driver pm800_driver = {
 		.name = "88PM800",
 		.owner = THIS_MODULE,
 		.pm = &pm80x_pm_ops,
+		.of_match_table	= pm80x_of_match_table,
 		},
 	.probe = pm800_probe,
 	.remove = pm800_remove,
-- 
1.9.1

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
