Return-Path: <rtc-linux+bncBCO7J6GN7ELBBA45U64QKGQENS3MJDA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com. [2607:f8b0:400e:c00::244])
        by gmr-mx.google.com with ESMTPS id d141si589810pfd.1.2016.05.04.03.27.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 May 2016 03:27:15 -0700 (PDT)
Received: by mail-pf0-x244.google.com with SMTP id y7so4526909pfb.0
        for <rtc-linux@googlegroups.com>; Wed, 04 May 2016 03:27:15 -0700 (PDT)
From: venkat.prashanth2498@gmail.com
To: a.zummo@towertech.it
Cc: rtc-linux@googlegroups.com,
	inux-kernel@vger.kernel.org,
	venkat-prashanth <venkat.prashanth2498@gmail.com>
Subject: [rtc-linux] [PATCH] rtc:add support for maxim rtc max6916
Date: Wed,  4 May 2016 03:26:54 -0700
Message-Id: <1462357614-10957-1-git-send-email-venkat.prashanth2498@gmail.com>
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

From: venkat-prashanth <venkat.prashanth2498@gmail.com>

This is a patch to add support for
maxim rtc max6916
Signed-off-by:Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
 Kconfig       |   9 ++++
 Makefile      |   6 +++
 rtc-max6916.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 148 insertions(+)
 create mode 100644 Kconfig
 create mode 100644 Makefile
 create mode 100644 rtc-max6916.c
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
new file mode 100644
index 0000000..fa7a2fa
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -0,0 +1,9 @@
+config RTC_DRV_MAX6916
+tristate "Maxim MAX6916"
+ help
+  If you say yes here you get support for the
+  Maxim MAX6916 chips.
+  This driver only supports the RTC feature, and not other chip
+  features such as alarms.
+  This driver can also be built as a module. If so, the module
+  will be called rtc=E2=80=90max6916.
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
new file mode 100644
index 0000000..db34a02
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -0,0 +1,6 @@
+CONFIG_MODULE_SIG=3Dn
+obj-m+=3Drtc-max6916.o
+all:
+	make -C /lib/modules/$(shell uname -r)/build M=3D$(PWD) modules
+clean:
+	make -C /lib/modules/$(shell uname -r)/build M=3D$(PWD) clean
diff --git a/drivers/rtc/rtc-max6916.c b/drivers/rtc/rtc-max6916.c
new file mode 100644
index 0000000..8e9bcdc
--- a/drivers/rtc/rtc-max6916.c
+++ b/drivers/rtc/rtc-max6916.c
@@ -0,0 +1,133 @@
+/* rtc-max6916.c
+ *
+ * Driver for MAXIM  max6916 Low Current, SPI Compatible
+ * Real Time Clock
+ *
+ * Author : Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/spi/spi.h>
+#include <linux/bcd.h>
+/* Registers in max6916 rtc */
+#define MAX6916_SECONDS_REG	0x01
+#define MAX6916_MINUTES_REG	0x02
+#define MAX6916_HOURS_REG	0x03
+#define MAX6916_DATE_REG	0x04
+#define MAX6916_MONTH_REG	0x05
+#define MAX6916_DAY_REG	0x06
+#define MAX6916_YEAR_REG	0x07
+#define MAX6916_CONTROL_REG	0x08
+#define MAX6916_STATUS_REG	0x0C
+#define MAX6916_CLOCK_BURST	0x00
+
+static int max6916_read_reg(struct device *dev, unsigned char address, uns=
igned char *data)
+{
+	struct spi_device *spi =3D to_spi_device(dev);
+	*data =3D address | 0x80;
+	return spi_write_then_read(spi, data, 1, data, 1);
+}
+
+static int max6916_write_reg(struct device *dev, unsigned char address, un=
signed char data)
+{
+	struct spi_device *spi =3D to_spi_device(dev);
+	unsigned char buf[2];
+
+	buf[0] =3D address&0x7F;
+	buf[1] =3D data;
+	return spi_write_then_read(spi, buf, 2, NULL, 0);
+}
+
+static int max6916_read_time(struct device *dev, struct rtc_time *dt)
+{
+	struct spi_device *spi =3D to_spi_device(dev);
+	int err;
+	unsigned char buf[8];
+
+	buf[0] =3D MAX6916_CLOCK_BURST | 0x80;
+	err =3D spi_write_then_read(spi, buf, 1, buf, 8);
+	if (err)
+	return err;
+	dt->tm_sec =3D bcd2bin(buf[0]);
+	dt->tm_min =3D bcd2bin(buf[1]);
+	dt->tm_hour =3D bcd2bin(buf[2] & MAX6916_CLOCK_BURST);
+	dt->tm_mday =3D bcd2bin(buf[3]);
+	dt->tm_mon =3D bcd2bin(buf[4]) - 1;
+	dt->tm_wday =3D bcd2bin(buf[5]) - 1;
+	dt->tm_year =3D bcd2bin(buf[6]) + 100;
+	return rtc_valid_tm(dt);
+}
+static int max6916_set_time(struct device *dev, struct rtc_time *dt)
+{
+	struct spi_device *spi =3D to_spi_device(dev);
+	unsigned char buf[9];
+
+	buf[0] =3D MAX6916_CLOCK_BURST & 0x7F;
+	buf[1] =3D bcd2bin(dt->tm_sec);
+	buf[2] =3D bcd2bin(dt->tm_min);
+	buf[3] =3D (bcd2bin(dt->tm_hour)&MAX6916_CLOCK_BURST);
+	buf[4] =3D bcd2bin(dt->tm_mday);
+	buf[5] =3D bcd2bin(dt->tm_mon + 1);
+	buf[6] =3D bcd2bin(dt->tm_wday + 1);
+	/* year from 1900-range of 100 in rtc from 00 to 99 */
+	dt->tm_year =3D dt->tm_year % 100;
+	buf[7] =3D bcd2bin(dt->tm_year);
+	buf[8] =3D bcd2bin(0x00);
+	/* write the rtc settings */
+	return spi_write_then_read(spi, buf, 9, NULL, 0);
+}
+static const struct rtc_class_ops max6916_rtc_ops =3D {
+	.read_time =3D max6916_read_time,
+	.set_time =3D max6916_set_time,
+};
+static int max6916_probe(struct spi_device *spi)
+{
+	struct rtc_device *rtc;
+	unsigned char data;
+	int res;
+
+	/* spi setup with max6916 in mode 3 and bits per word as 8 */
+	spi->mode =3D SPI_MODE_3;
+	spi->bits_per_word =3D 8;
+	spi_setup(spi);
+	/* RTC Settings */
+	res =3D max6916_read_reg(&spi->dev, MAX6916_SECONDS_REG, &data);
+	if (res)
+	return res;
+	/* Disable the write protect of rtc */
+	max6916_read_reg(&spi->dev, MAX6916_CONTROL_REG, &data);
+	data =3D data & ~(1<<7);
+	max6916_write_reg(&spi->dev, MAX6916_CONTROL_REG, data);
+	/* Enable the oscillator,disable the oscillator stop flag,and glitch filt=
er to reduce current consumption */
+	max6916_read_reg(&spi->dev, MAX6916_STATUS_REG, &data);
+	data =3D data & 0x1B;
+	max6916_write_reg(&spi->dev, MAX6916_STATUS_REG, data);
+	/* display the settings */
+	max6916_read_reg(&spi->dev, MAX6916_CONTROL_REG, &data);
+	dev_info(&spi->dev, "MAX6916 RTC CTRL Reg =3D 0x%02x\n", data);
+	max6916_read_reg(&spi->dev, MAX6916_STATUS_REG, &data);
+	dev_info(&spi->dev, "MAX6916 RTC Status Reg =3D 0x%02x\n", data);
+	rtc =3D devm_rtc_device_register(&spi->dev, "max6916", &max6916_rtc_ops, =
THIS_MODULE);
+	if (IS_ERR(rtc))
+	return PTR_ERR(rtc);
+	spi_set_drvdata(spi, rtc);
+	return 0;
+}
+static struct spi_driver max6916_driver =3D {
+	.driver =3D {
+	.name =3D "max6916",
+	},
+	.probe =3D max6916_probe,
+};
+module_spi_driver(max6916_driver);
+MODULE_DESCRIPTION("MAX6916 SPI RTC DRIVER");
+MODULE_AUTHOR("Venkat Prashanth B U <venkat.prashanth2498@gmail.com>");
+MODULE_LICENSE("GPL v2");
--=20
1.9.2

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
