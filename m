Return-Path: <rtc-linux+bncBAABB7HKUG4QKGQENRLV2XY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id u18si669658wmd.1.2016.05.03.02.55.08
        for <rtc-linux@googlegroups.com>;
        Tue, 03 May 2016 02:55:08 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH V3 3/7] rtc: rv3029: Add support of RV3049
Date: Tue,  3 May 2016 11:54:34 +0200
Message-Id: <48896bffe8ece47523bd4989c7f16901266482e6.1462268107.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1462268107.git.mylene.josserand@free-electrons.com>
References: <cover.1462268107.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1462268107.git.mylene.josserand@free-electrons.com>
References: <cover.1462268107.git.mylene.josserand@free-electrons.com>
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

Add support of Microcrystal RV3049 RTC (SPI) using regmap on the
RV3029 (I2C) driver.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/Kconfig        |  37 ++++++++--------
 drivers/rtc/rtc-rv3029c2.c | 108 +++++++++++++++++++++++++++++++++++++++++=
++--
 2 files changed, 124 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index f1e1f50..18639e0 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -573,24 +573,6 @@ config RTC_DRV_EM3027
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-em3027.
=20
-config RTC_DRV_RV3029C2
-	tristate "Micro Crystal RV3029"
-	help
-	  If you say yes here you get support for the Micro Crystal
-	  RV3029 RTC chips.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-rv3029c2.
-
-config RTC_DRV_RV3029_HWMON
-	bool "HWMON support for RV3029"
-	depends on RTC_DRV_RV3029C2 && HWMON
-	depends on !(RTC_DRV_RV3029C2=3Dy && HWMON=3Dm)
-	default y
-	help
-	  Say Y here if you want to expose temperature sensor data on
-	  rtc-rv3029.
-
 config RTC_DRV_RV8803
 	tristate "Micro Crystal RV8803"
 	help
@@ -786,6 +768,25 @@ config RTC_DRV_PCF2127
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf2127.
=20
+config RTC_DRV_RV3029C2
+	tristate "Micro Crystal RV3029/3049"
+	depends on RTC_I2C_AND_SPI
+	help
+	  If you say yes here you get support for the Micro Crystal
+	  RV3029 and RV3049 RTC chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-rv3029c2.
+
+config RTC_DRV_RV3029_HWMON
+	bool "HWMON support for RV3029/3049"
+	depends on RTC_DRV_RV3029C2 && HWMON
+	depends on !(RTC_DRV_RV3029C2=3Dy && HWMON=3Dm)
+	default y
+	help
+	  Say Y here if you want to expose temperature sensor data on
+	  rtc-rv3029.
+
 comment "Platform RTC drivers"
=20
 # this 'CMOS' RTC driver is arch dependent because <asm-generic/rtc.h>
diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 96dd166..1310646 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -1,5 +1,5 @@
 /*
- * Micro Crystal RV-3029 rtc class driver
+ * Micro Crystal RV-3029 / RV-3049 rtc class driver
  *
  * Author: Gregory Hermant <gregory.hermant@calao-systems.com>
  *         Michael Buesch <m@bues.ch>
@@ -14,6 +14,7 @@
=20
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 #include <linux/bcd.h>
 #include <linux/rtc.h>
 #include <linux/delay.h>
@@ -766,6 +767,8 @@ static int rv3029_probe(struct device *dev, struct regm=
ap *regmap, int irq,
 	return PTR_ERR_OR_ZERO(rv3029->rtc);
 }
=20
+#if IS_ENABLED(CONFIG_I2C)
+
 static int rv3029_i2c_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
@@ -799,9 +802,108 @@ static struct i2c_driver rv3029_driver =3D {
 	.id_table	=3D rv3029_id,
 };
=20
-module_i2c_driver(rv3029_driver);
+static int rv3029_register_driver(void)
+{
+	return i2c_add_driver(&rv3029_driver);
+}
+
+static void rv3029_unregister_driver(void)
+{
+	i2c_del_driver(&rv3029_driver);
+}
+
+#else
+
+static int rv3029_register_driver(void)
+{
+	return 0;
+}
+
+static void rv3029_unregister_driver(void)
+{
+}
+
+#endif
+
+#if IS_ENABLED(CONFIG_SPI_MASTER)
+
+static int rv3049_probe(struct spi_device *spi)
+{
+	static const struct regmap_config config =3D {
+		.reg_bits =3D 8,
+		.val_bits =3D 8,
+	};
+	struct regmap *regmap;
+
+	regmap =3D devm_regmap_init_spi(spi, &config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "%s: regmap allocation failed: %ld\n",
+			__func__, PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return rv3029_probe(&spi->dev, regmap, spi->irq, "rv3049");
+}
+
+static struct spi_driver rv3049_driver =3D {
+	.driver =3D {
+		.name    =3D "rv3049",
+	},
+	.probe   =3D rv3049_probe,
+};
+
+static int rv3049_register_driver(void)
+{
+	return spi_register_driver(&rv3049_driver);
+}
+
+static void rv3049_unregister_driver(void)
+{
+	spi_unregister_driver(&rv3049_driver);
+}
+
+#else
+
+static int rv3049_register_driver(void)
+{
+	return 0;
+}
+
+static void rv3049_unregister_driver(void)
+{
+}
+
+#endif
+
+static int __init rv30x9_init(void)
+{
+	int ret;
+
+	ret =3D rv3029_register_driver();
+	if (ret) {
+		pr_err("Failed to register rv3029 driver: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D rv3049_register_driver();
+	if (ret) {
+		pr_err("Failed to register rv3049 driver: %d\n", ret);
+		rv3029_unregister_driver();
+	}
+
+	return ret;
+}
+module_init(rv30x9_init)
+
+static void __exit rv30x9_exit(void)
+{
+	rv3049_unregister_driver();
+	rv3029_unregister_driver();
+}
+module_exit(rv30x9_exit)
=20
 MODULE_AUTHOR("Gregory Hermant <gregory.hermant@calao-systems.com>");
 MODULE_AUTHOR("Michael Buesch <m@bues.ch>");
-MODULE_DESCRIPTION("Micro Crystal RV3029 RTC driver");
+MODULE_DESCRIPTION("Micro Crystal RV3029/RV3049 RTC driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:rv3049");
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
