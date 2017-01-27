Return-Path: <rtc-linux+bncBC2IF264UIPRBW4NV3CAKGQEB7UCIOQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [46.235.227.227])
        by gmr-mx.google.com with ESMTPS id d207si708110wmd.1.2017.01.27.09.43.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jan 2017 09:43:54 -0800 (PST)
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH] rtc: bq32000: add support to enable disable the
 trickle charge FET bypass.
Date: Fri, 27 Jan 2017 18:43:46 +0100
Message-Id: <20170127174346.30131-1-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The bq32000 includes a trickle charge circuit to maintain the charge of the
backup supply when a super capacitor is used.

You can enable the charging circuit by setting 'trickle-resistor-ohms',
additionally you can set TCFE to 1 to bypass the internal diode and boost
the charge voltage of the backup supply. You might want to enable/disable
the TCFE switch from userspace (e.g when device is only connected to a
battery)

This patch introduces a new sysfs entry to enable and disable this FET
form userspace.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 .../ABI/testing/sysfs-bus-i2c-devices-bq32k        |  7 ++
 drivers/rtc/rtc-bq32k.c                            | 76 ++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-bq32k

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-bq32k b/Documentation/ABI/testing/sysfs-bus-i2c-devices-bq32k
new file mode 100644
index 0000000..398b258
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-bq32k
@@ -0,0 +1,7 @@
+What:		/sys/bus/i2c/devices/.../trickle_charge_bypass
+Date:		Jan 2017
+KernelVersion:	4.11
+Contact:	Enric Balletbo i Serra <eballetbo@gmail.com>
+Description:    Attribute for enable/disable the trickle charge bypass
+		The trickle_charge_bypass attribute allows the userspace to
+                enable/disable the Trickle charge FET bypass.
diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index 3977424..2b22393 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -34,6 +34,7 @@
 #define BQ32K_CALIBRATION	0x07	/* CAL_CFG1, calibration and control */
 #define BQ32K_TCH2		0x08	/* Trickle charge enable */
 #define BQ32K_CFG2		0x09	/* Trickle charger control */
+#define BQ32K_TCFE		BIT(6)	/* Trickle charge FET bypass */
 
 struct bq32k_regs {
 	uint8_t		seconds;
@@ -188,6 +189,65 @@ static int trickle_charger_of_init(struct device *dev, struct device_node *node)
 	return 0;
 }
 
+static ssize_t bq32k_sysfs_show_tricklecharge_bypass(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	int reg, error;
+
+	error = bq32k_read(dev, &reg, BQ32K_CFG2, 1);
+	if (error)
+		return error;
+
+	return sprintf(buf, "%d\n", (reg & BQ32K_TCFE) ? 1 : 0);
+}
+
+static ssize_t bq32k_sysfs_store_tricklecharge_bypass(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	int reg, enable, error;
+
+	if (kstrtoint(buf, 0, &enable))
+		return -EINVAL;
+
+	error = bq32k_read(dev, &reg, BQ32K_CFG2, 1);
+	if (error)
+		return error;
+
+	if (enable) {
+		reg |= BQ32K_TCFE;
+		error = bq32k_write(dev, &reg, BQ32K_CFG2, 1);
+		if (error)
+			return error;
+
+		dev_info(dev, "Enabled trickle charge FET bypass.\n");
+	} else {
+		reg &= ~BQ32K_TCFE;
+		error = bq32k_write(dev, &reg, BQ32K_CFG2, 1);
+		if (error)
+			return error;
+
+		dev_info(dev, "Disabled trickle charge FET bypass.\n");
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(trickle_charge_bypass, 0644,
+		   bq32k_sysfs_show_tricklecharge_bypass,
+		   bq32k_sysfs_store_tricklecharge_bypass);
+
+static int bq32k_sysfs_register(struct device *dev)
+{
+	return device_create_file(dev, &dev_attr_trickle_charge_bypass);
+}
+
+static void bq32k_sysfs_unregister(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_trickle_charge_bypass);
+}
+
 static int bq32k_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
@@ -224,11 +284,26 @@ static int bq32k_probe(struct i2c_client *client,
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	error = bq32k_sysfs_register(&client->dev);
+	if (error) {
+		dev_err(&client->dev,
+			"Unable to create sysfs entries for rtc bq32000\n");
+		return error;
+	}
+
+
 	i2c_set_clientdata(client, rtc);
 
 	return 0;
 }
 
+static int bq32k_remove(struct i2c_client *client)
+{
+	bq32k_sysfs_unregister(&client->dev);
+
+	return 0;
+}
+
 static const struct i2c_device_id bq32k_id[] = {
 	{ "bq32000", 0 },
 	{ }
@@ -240,6 +315,7 @@ static struct i2c_driver bq32k_driver = {
 		.name	= "bq32k",
 	},
 	.probe		= bq32k_probe,
+	.remove		= bq32k_remove,
 	.id_table	= bq32k_id,
 };
 
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
