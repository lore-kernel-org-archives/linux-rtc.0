Return-Path: <rtc-linux+bncBDJ6H2FGZ4FBB24T4DAQKGQENQNPVTQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com. [193.143.230.17])
        by gmr-mx.google.com with ESMTPS id l130si1088220wmf.2.2016.11.25.01.52.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Nov 2016 01:52:43 -0800 (PST)
From: =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= <vesa.jaaskelainen@vaisala.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= <vesa.jaaskelainen@vaisala.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 1/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
Date: Fri, 25 Nov 2016 11:52:17 +0200
Message-Id: <1480067538-64415-2-git-send-email-vesa.jaaskelainen@vaisala.com>
In-Reply-To: <1480067538-64415-1-git-send-email-vesa.jaaskelainen@vaisala.com>
References: <1480067538-64415-1-git-send-email-vesa.jaaskelainen@vaisala.com>
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

Texas Instrument's TPS65910 has support for compensating RTC crystal
inaccuracies. When enabled every hour RTC counter value will be compensated
with two's complement value.

Signed-off-by: Vesa J=C3=A4=C3=A4skel=C3=A4inen <vesa.jaaskelainen@vaisala.=
com>
---
 .../ABI/testing/sysfs-bus-i2c-devices-tps65910-rtc |   9 ++
 MAINTAINERS                                        |   1 +
 drivers/rtc/rtc-tps65910.c                         | 120 +++++++++++++++++=
++++
 include/linux/mfd/tps65910.h                       |   1 +
 4 files changed, 131 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-tps6591=
0-rtc

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-tps65910-rtc b=
/Documentation/ABI/testing/sysfs-bus-i2c-devices-tps65910-rtc
new file mode 100644
index 0000000..fb97544
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-tps65910-rtc
@@ -0,0 +1,9 @@
+What:           Attribute for calibrating TPS65910's Real Time Clock
+Date:           Nov 2016
+KernelVersion:  4.10
+Contact:        rtc-linux@googlegroups.com
+Description:    The rtc_calibration attribute allows userspace to calibrat=
e the
+                Real Time Clock found in Texas Instruments TPS65910. Every=
 hour
+                the TPS65910 will correct the RTC's value by adding to it =
the
+                value of this attribute. The range of the attribute is -32=
768
+                to 32766 in units of 30.5 micro-seconds/hour.
diff --git a/MAINTAINERS b/MAINTAINERS
index 851b89b..bb2f094 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10146,6 +10146,7 @@ L:	rtc-linux@googlegroups.com
 Q:	http://patchwork.ozlabs.org/project/rtc-linux/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-i2c-devices-tps65910-rtc
 F:	Documentation/devicetree/bindings/rtc/
 F:	Documentation/rtc.txt
 F:	drivers/rtc/
diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index 5a3d53c..e1b0b0c 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -33,6 +33,9 @@ struct tps65910_rtc {
 /* Total number of RTC registers needed to set time*/
 #define NUM_TIME_REGS	(TPS65910_YEARS - TPS65910_SECONDS + 1)
=20
+/* Total number of RTC registers needed to set compensation registers */
+#define NUM_COMP_REGS	(TPS65910_RTC_COMP_MSB - TPS65910_RTC_COMP_LSB + 1)
+
 static int tps65910_rtc_alarm_irq_enable(struct device *dev, unsigned enab=
led)
 {
 	struct tps65910 *tps =3D dev_get_drvdata(dev->parent);
@@ -187,6 +190,115 @@ static int tps65910_rtc_set_alarm(struct device *dev,=
 struct rtc_wkalrm *alm)
 	return ret;
 }
=20
+static int tps65910_rtc_set_calibration(struct device *dev, int calibratio=
n)
+{
+	unsigned char comp_data[NUM_COMP_REGS];
+	struct tps65910 *tps =3D dev_get_drvdata(dev->parent);
+	s16 value;
+	int ret;
+
+	/*
+	 * TPS65910 uses two's complement 16 bit value for compensation for RTC
+	 * crystal inaccuracies. One time every hour when seconds counter
+	 * increments from 0 to 1 compensation value will be added to internal
+	 * RTC counter value.
+	 *
+	 * Compensation value 0x7FFF is prohibited value.
+	 *
+	 * Valid range for compensation value: [-32768 .. 32766]
+	 */
+	if ((calibration < -32768) || (calibration > 32766)) {
+		dev_err(dev, "RTC calibration value out of range: %d\n",
+			calibration);
+		return -EINVAL;
+	}
+
+	value =3D (s16)calibration;
+
+	comp_data[0] =3D (u16)value & 0xFF;
+	comp_data[1] =3D ((u16)value >> 8) & 0xFF;
+
+	/* Update all the compensation registers in one shot */
+	ret =3D regmap_bulk_write(tps->regmap, TPS65910_RTC_COMP_LSB,
+		comp_data, NUM_COMP_REGS);
+	if (ret < 0) {
+		dev_err(dev, "rtc_set_calibration error: %d\n", ret);
+		return ret;
+	}
+
+	/* Enable automatic compensation */
+	ret =3D regmap_update_bits(tps->regmap, TPS65910_RTC_CTRL,
+		TPS65910_RTC_CTRL_AUTO_COMP, TPS65910_RTC_CTRL_AUTO_COMP);
+	if (ret < 0)
+		dev_err(dev, "auto_comp enable failed with error: %d\n", ret);
+
+	return ret;
+}
+
+static int tps65910_rtc_get_calibration(struct device *dev, int *calibrati=
on)
+{
+	unsigned char comp_data[NUM_COMP_REGS];
+	struct tps65910 *tps =3D dev_get_drvdata(dev->parent);
+	u16 value;
+	int ret;
+
+	ret =3D regmap_bulk_read(tps->regmap, TPS65910_RTC_COMP_LSB, comp_data,
+		NUM_COMP_REGS);
+	if (ret < 0) {
+		dev_err(dev, "rtc_get_calibration error: %d\n", ret);
+		return ret;
+	}
+
+	value =3D (u16)comp_data[0] | ((u16)comp_data[1] << 8);
+
+	*calibration =3D (s16)value;
+
+	return 0;
+}
+
+static ssize_t tps65910_sysfs_store_rtc_calibration(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int calibration;
+	int ret;
+
+	ret =3D kstrtoint(buf, 0, &calibration);
+	if (ret < 0)
+		return ret;
+
+	ret =3D tps65910_rtc_set_calibration(dev, calibration);
+
+	return (ret < 0) ? ret : count;
+}
+
+static ssize_t tps65910_sysfs_show_rtc_calibration(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int calibration;
+	int ret;
+
+	ret =3D tps65910_rtc_get_calibration(dev, &calibration);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", calibration);
+}
+
+static DEVICE_ATTR(rtc_calibration, 0644,
+		   tps65910_sysfs_show_rtc_calibration,
+		   tps65910_sysfs_store_rtc_calibration);
+
+static int tps65910_sysfs_rtc_register(struct device *dev)
+{
+	return device_create_file(dev, &dev_attr_rtc_calibration);
+}
+
+static void tps65910_sysfs_rtc_unregister(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_rtc_calibration);
+}
+
 static irqreturn_t tps65910_rtc_interrupt(int irq, void *rtc)
 {
 	struct device *dev =3D rtc;
@@ -285,6 +397,12 @@ static int tps65910_rtc_probe(struct platform_device *=
pdev)
 		return ret;
 	}
=20
+	ret =3D tps65910_sysfs_rtc_register(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register to sysfs\n");
+		return ret;
+	}
+
 	return 0;
 }
=20
@@ -294,6 +412,8 @@ static int tps65910_rtc_probe(struct platform_device *p=
dev)
  */
 static int tps65910_rtc_remove(struct platform_device *pdev)
 {
+	tps65910_sysfs_rtc_unregister(&pdev->dev);
+
 	tps65910_rtc_alarm_irq_enable(&pdev->dev, 0);
=20
 	return 0;
diff --git a/include/linux/mfd/tps65910.h b/include/linux/mfd/tps65910.h
index 6483a6f..ffb21e7 100644
--- a/include/linux/mfd/tps65910.h
+++ b/include/linux/mfd/tps65910.h
@@ -134,6 +134,7 @@
=20
 /* RTC_CTRL_REG bitfields */
 #define TPS65910_RTC_CTRL_STOP_RTC			0x01 /*0=3Dstop, 1=3Drun */
+#define TPS65910_RTC_CTRL_AUTO_COMP			0x04
 #define TPS65910_RTC_CTRL_GET_TIME			0x40
=20
 /* RTC_STATUS_REG bitfields */
--=20
2.1.4

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
