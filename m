Return-Path: <rtc-linux+bncBCZ7NMHQ3YLRBBWX6CXQKGQEI6WYCHA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-x22b.google.com (mail-wi0-x22b.google.com. [2a00:1450:400c:c05::22b])
        by gmr-mx.google.com with ESMTPS id ch7si248469wib.2.2015.09.18.08.19.34
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2015 08:19:34 -0700 (PDT)
Received: by mail-wi0-x22b.google.com with SMTP id fx3so68535046wic.1
        for <rtc-linux@googlegroups.com>; Fri, 18 Sep 2015 08:19:34 -0700 (PDT)
From: Ivan Grimaldi <grimaldi.ivan@gmail.com>
To: a.zummo@towertech.it,
	mpfj@mimc.co.uk,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v2 2/2] Added trickle charger device tree binding
Date: Fri, 18 Sep 2015 17:16:27 +0200
Message-Id: <1442589387-29173-2-git-send-email-grimaldi.ivan@gmail.com>
In-Reply-To: <1442589387-29173-1-git-send-email-grimaldi.ivan@gmail.com>
References: <1442589387-29173-1-git-send-email-grimaldi.ivan@gmail.com>
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

Introduce a device tree binding for specifying the trickle charger
configuration for ds1339.

Signed-off-by: Ivan Grimaldi <grimaldi.ivan@gmail.com>
---
 .../devicetree/bindings/rtc/dallas,ds1390.txt      | 18 +++++++
 drivers/rtc/rtc-ds1390.c                           | 63 ++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1390.txt

diff --git a/Documentation/devicetree/bindings/rtc/dallas,ds1390.txt b/Documentation/devicetree/bindings/rtc/dallas,ds1390.txt
new file mode 100644
index 0000000..8e76f26
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/dallas,ds1390.txt
@@ -0,0 +1,18 @@
+* Dallas DS1390		SPI Serial Real-Time Clock
+
+Required properties:
+- compatible: Should contain "dallas,ds1390".
+- reg: SPI address for chip
+
+Optional properties:
+- trickle-resistor-ohms : Selected resistor for trickle charger
+	Values usable for ds1390 are 250, 2000, 4000
+	Should be given if trickle charger should be enabled
+- trickle-diode-disable : Do not use internal trickle charger diode
+	Should be given if internal trickle charger diode should be disabled
+Example:
+	ds1390: rtc@68 {
+		compatible = "dallas,ds1390";
+		trickle-resistor-ohms = <250>;
+		reg = <0>;
+	};
diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
index a4303b4..9bcf6f9 100644
--- a/drivers/rtc/rtc-ds1390.c
+++ b/drivers/rtc/rtc-ds1390.c
@@ -20,6 +20,7 @@
 #include <linux/spi/spi.h>
 #include <linux/bcd.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #define DS1390_REG_100THS		0x00
 #define DS1390_REG_SECONDS		0x01
@@ -40,11 +41,31 @@
 #define DS1390_REG_STATUS		0x0E
 #define DS1390_REG_TRICKLE		0x0F
 
+#define DS1390_TRICKLE_ENABLE_CHARGER   0xA0
+#define DS1390_TRICKLE_CHARGER_250_OHM  0x01
+#define DS1390_TRICKLE_CHARGER_2K_OHM   0x02
+#define DS1390_TRICKLE_CHARGER_4K_OHM   0x03
+#define DS1390_TRICKLE_CHARGER_NO_DIODE 0x04
+#define DS1390_TRICKLE_CHARGER_DIODE    0x08
+
 struct ds1390 {
 	struct rtc_device *rtc;
 	u8 txrx_buf[9];	/* cmd + 8 registers */
 };
 
+static void ds1390_set_reg(struct device *dev, unsigned char address,
+		unsigned char data)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	unsigned char buf[2];
+
+	/* MSB must be '1' to write */
+	buf[0] = address | 0x80;
+	buf[1] = data;
+
+	spi_write(spi, buf, 2);
+}
+
 static int ds1390_get_reg(struct device *dev, unsigned char address,
 				unsigned char *data)
 {
@@ -67,6 +88,44 @@ static int ds1390_get_reg(struct device *dev, unsigned char address,
 	return 0;
 }
 
+static void ds1390_trickle_of_init(struct spi_device *spi)
+{
+	uint32_t ohms = 0;
+	uint8_t value;
+
+	if (of_property_read_u32(spi->dev.of_node, "trickle-resistor-ohms", &ohms))
+		goto out;
+
+	/* Enable charger */
+	value = DS1390_TRICKLE_ENABLE_CHARGER;
+	if (of_property_read_bool(spi->dev.of_node, "trickle-diode-disable"))
+		value |= DS1390_TRICKLE_CHARGER_NO_DIODE;
+	else
+		value |= DS1390_TRICKLE_CHARGER_DIODE;
+
+	/* Resistor select */
+	switch (ohms) {
+	case 250:
+		value |= DS1390_TRICKLE_CHARGER_250_OHM;
+		break;
+	case 2000:
+		value |= DS1390_TRICKLE_CHARGER_2K_OHM;
+		break;
+	case 4000:
+		value |= DS1390_TRICKLE_CHARGER_4K_OHM;
+		break;
+	default:
+		dev_warn(&spi->dev,
+			 "Unsupported ohm value %02ux in dt\n", ohms);
+		return;
+	}
+
+	ds1390_set_reg(&spi->dev, DS1390_REG_TRICKLE, value);
+
+out:
+	return;
+}
+
 static int ds1390_read_time(struct device *dev, struct rtc_time *dt)
 {
 	struct spi_device *spi = to_spi_device(dev);
@@ -143,6 +202,9 @@ static int ds1390_probe(struct spi_device *spi)
 		return res;
 	}
 
+	if (spi->dev.of_node)
+		ds1390_trickle_of_init(spi);
+
 	chip->rtc = devm_rtc_device_register(&spi->dev, "ds1390",
 					&ds1390_rtc_ops, THIS_MODULE);
 	if (IS_ERR(chip->rtc)) {
@@ -165,5 +227,6 @@ module_spi_driver(ds1390_driver);
 
 MODULE_DESCRIPTION("Dallas/Maxim DS1390/93/94 SPI RTC driver");
 MODULE_AUTHOR("Mark Jackson <mpfj@mimc.co.uk>");
+MODULE_AUTHOR("Ivan Grimaldi <ivan.grimaldi@siaemic.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("spi:rtc-ds1390");
-- 
2.5.2

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
