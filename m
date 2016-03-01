Return-Path: <rtc-linux+bncBDU7VC56WAFBB3XZ263AKGQEQZW3PVA@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id s141si79113wmd.1.2016.03.01.12.34.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 12:34:53 -0800 (PST)
Date: Tue, 1 Mar 2016 21:33:22 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Gregory Hermant <gregory.hermant@calao-systems.com>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH] rtc-rv3029c2: Add trickle charger
Message-ID: <20160301213322.661fe771@wiggum>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7_1Q.RcL9XaouPtLt/yu6A/"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/7_1Q.RcL9XaouPtLt/yu6A/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This adds a device tree property to enable the tricke charger at
some to be configured resistance.
If the property is left out, the trickle charger is disabled.

The kconfig name is also changed to include the chip number as
there are other MicroCrystal RTCs.

Also a "rv3029" device ID was added, because the C2 suffix does
not appear in latest chip versions and datasheet versions.

Signed-off-by: Michael Buesch <m@bues.ch>
---
 drivers/rtc/Kconfig        |   2 +-
 drivers/rtc/rtc-rv3029c2.c | 335 ++++++++++++++++++++++++++++++++++++++++-=
----
 2 files changed, 299 insertions(+), 38 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 376322f..c37f535 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -595,7 +595,7 @@ config RTC_DRV_EM3027
 	  will be called rtc-em3027.
=20
 config RTC_DRV_RV3029C2
-	tristate "Micro Crystal RTC"
+	tristate "Micro Crystal RV3029(C2)"
 	help
 	  If you say yes here you get support for the Micro Crystal
 	  RV3029-C2 RTC chips.
diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index e9ac5a4..036e205 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -2,30 +2,46 @@
  * Micro Crystal RV-3029C2 rtc class driver
  *
  * Author: Gregory Hermant <gregory.hermant@calao-systems.com>
+ *         Michael Buesch <m@bues.ch>
  *
  * based on previously existing rtc class drivers
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
- * NOTE: Currently this driver only supports the bare minimum for read
- * and write the RTC and alarms. The extra features provided by this chip
- * (trickle charger, eeprom, T=C2=B0 compensation) are unavailable.
  */
=20
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/bcd.h>
 #include <linux/rtc.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+
=20
 /* Register map */
 /* control section */
 #define RV3029C2_ONOFF_CTRL		0x00
+#define RV3029C2_ONOFF_CTRL_WE		(1 << 0)
+#define RV3029C2_ONOFF_CTRL_TE		(1 << 1)
+#define RV3029C2_ONOFF_CTRL_TAR		(1 << 2)
+#define RV3029C2_ONOFF_CTRL_EERE	(1 << 3)
+#define RV3029C2_ONOFF_CTRL_SRON	(1 << 4)
+#define RV3029C2_ONOFF_CTRL_TD0		(1 << 5)
+#define RV3029C2_ONOFF_CTRL_TD1		(1 << 6)
+#define RV3029C2_ONOFF_CTRL_CLKINT	(1 << 7)
 #define RV3029C2_IRQ_CTRL		0x01
 #define RV3029C2_IRQ_CTRL_AIE		(1 << 0)
+#define RV3029C2_IRQ_CTRL_TIE		(1 << 1)
+#define RV3029C2_IRQ_CTRL_V1IE		(1 << 2)
+#define RV3029C2_IRQ_CTRL_V2IE		(1 << 3)
+#define RV3029C2_IRQ_CTRL_SRIE		(1 << 4)
 #define RV3029C2_IRQ_FLAGS		0x02
 #define RV3029C2_IRQ_FLAGS_AF		(1 << 0)
+#define RV3029C2_IRQ_FLAGS_TF		(1 << 1)
+#define RV3029C2_IRQ_FLAGS_V1IF		(1 << 2)
+#define RV3029C2_IRQ_FLAGS_V2IF		(1 << 3)
+#define RV3029C2_IRQ_FLAGS_SRF		(1 << 4)
 #define RV3029C2_STATUS			0x03
 #define RV3029C2_STATUS_VLOW1		(1 << 2)
 #define RV3029C2_STATUS_VLOW2		(1 << 3)
@@ -33,6 +49,7 @@
 #define RV3029C2_STATUS_PON		(1 << 5)
 #define RV3029C2_STATUS_EEBUSY		(1 << 7)
 #define RV3029C2_RST_CTRL		0x04
+#define RV3029C2_RST_CTRL_SYSR		(1 << 4)
 #define RV3029C2_CONTROL_SECTION_LEN	0x05
=20
 /* watch section */
@@ -67,16 +84,26 @@
 /* eeprom data section */
 #define RV3029C2_E2P_EEDATA1		0x28
 #define RV3029C2_E2P_EEDATA2		0x29
+#define RV3029C2_E2PDATA_SECTION_LEN	0x02
=20
 /* eeprom control section */
 #define RV3029C2_CONTROL_E2P_EECTRL	0x30
-#define RV3029C2_TRICKLE_1K		(1<<0)  /*  1K resistance */
-#define RV3029C2_TRICKLE_5K		(1<<1)  /*  5K resistance */
-#define RV3029C2_TRICKLE_20K		(1<<2)  /* 20K resistance */
-#define RV3029C2_TRICKLE_80K		(1<<3)  /* 80K resistance */
-#define RV3029C2_CONTROL_E2P_XTALOFFSET	0x31
-#define RV3029C2_CONTROL_E2P_QCOEF	0x32
-#define RV3029C2_CONTROL_E2P_TURNOVER	0x33
+#define RV3029C2_EECTRL_THP		(1 << 0) /* temp scan interval */
+#define RV3029C2_EECTRL_THE		(1 << 1) /* thermometer enable */
+#define RV3029C2_EECTRL_FD0		(1 << 2) /* CLKOUT */
+#define RV3029C2_EECTRL_FD1		(1 << 3) /* CLKOUT */
+#define RV3029C2_TRICKLE_1K		(1 << 4) /* 1.5K resistance */
+#define RV3029C2_TRICKLE_5K		(1 << 5) /* 5K   resistance */
+#define RV3029C2_TRICKLE_20K		(1 << 6) /* 20K  resistance */
+#define RV3029C2_TRICKLE_80K		(1 << 7) /* 80K  resistance */
+#define RV3029C2_TRICKLE_MASK		(RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_5K =
|\
+					 RV3029C2_TRICKLE_20K | RV3029C2_TRICKLE_80K)
+#define RV3029C2_TRICKLE_SHIFT		4
+#define RV3029C2_CONTROL_E2P_XOFFS	0x31 /* XTAL offset */
+#define RV3029C2_CONTROL_E2P_XOFFS_SIGN	(1 << 7) /* Sign: 1->pos, 0->neg *=
/
+#define RV3029C2_CONTROL_E2P_QCOEF	0x32 /* XTAL temp drift coef */
+#define RV3029C2_CONTROL_E2P_TURNOVER	0x33 /* XTAL turnover temp (in *C) *=
/
+#define RV3029C2_CONTROL_E2P_TOV_MASK	0x3F /* XTAL turnover temp mask */
=20
 /* user ram section */
 #define RV3029C2_USR1_RAM_PAGE		0x38
@@ -84,6 +111,7 @@
 #define RV3029C2_USR2_RAM_PAGE		0x3C
 #define RV3029C2_USR2_SECTION_LEN	0x04
=20
+
 static int
 rv3029c2_i2c_read_regs(struct i2c_client *client, u8 reg, u8 *buf,
 	unsigned len)
@@ -114,6 +142,24 @@ rv3029c2_i2c_write_regs(struct i2c_client *client, u8 =
reg, u8 const buf[],
 }
=20
 static int
+rv3029c2_i2c_maskset_reg(struct i2c_client *client, u8 reg, u8 mask, u8 se=
t)
+{
+	u8 buf[1];
+	int ret;
+
+	ret =3D rv3029c2_i2c_read_regs(client, reg, buf, 1);
+	if (ret < 0)
+		return ret;
+	buf[0] &=3D mask;
+	buf[0] |=3D set;
+	ret =3D rv3029c2_i2c_write_regs(client, reg, buf, 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int
 rv3029c2_i2c_get_sr(struct i2c_client *client, u8 *buf)
 {
 	int ret =3D rv3029c2_i2c_read_regs(client, RV3029C2_STATUS, buf, 1);
@@ -138,6 +184,128 @@ rv3029c2_i2c_set_sr(struct i2c_client *client, u8 val=
)
 	return 0;
 }
=20
+static int rv3029c2_eeprom_busywait(struct i2c_client *client)
+{
+	int i, ret;
+	u8 sr;
+
+	for (i =3D 100; i > 0; i--) {
+		ret =3D rv3029c2_i2c_get_sr(client, &sr);
+		if (ret < 0)
+			break;
+		if (!(sr & RV3029C2_STATUS_EEBUSY))
+			break;
+		usleep_range(1000, 10000);
+	}
+	if (i <=3D 0) {
+		dev_err(&client->dev, "EEPROM busy wait timeout.\n");
+		return -ETIMEDOUT;
+	}
+
+	return ret;
+}
+
+static int rv3029c2_eeprom_exit(struct i2c_client *client)
+{
+	/* Re-enable eeprom refresh */
+	return rv3029c2_i2c_maskset_reg(client, RV3029C2_ONOFF_CTRL,
+					0xFF, RV3029C2_ONOFF_CTRL_EERE);
+}
+
+static int rv3029c2_eeprom_enter(struct i2c_client *client)
+{
+	int i, ret;
+	u8 sr;
+
+	/* Check whether we are in the allowed voltage range. */
+	for (i =3D 100; i > 0; i--) {
+		ret =3D rv3029c2_i2c_get_sr(client, &sr);
+		if (ret < 0)
+			return ret;
+		if (!(sr & (RV3029C2_STATUS_VLOW1 | RV3029C2_STATUS_VLOW2)))
+			break;
+
+		sr &=3D ~RV3029C2_STATUS_VLOW1;
+		sr &=3D ~RV3029C2_STATUS_VLOW2;
+		ret =3D rv3029c2_i2c_set_sr(client, sr);
+		if (ret < 0)
+			return ret;
+		usleep_range(1000, 10000);
+	}
+	if (i <=3D 0) {
+		dev_err(&client->dev, "EEPROM voltage wait timeout.\n");
+		return -ETIMEDOUT;
+	}
+
+	/* Disable eeprom refresh. */
+	ret =3D rv3029c2_i2c_maskset_reg(client, RV3029C2_ONOFF_CTRL,
+				       (u8)~RV3029C2_ONOFF_CTRL_EERE, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Wait for previous eeprom accesses to finish. */
+	ret =3D rv3029c2_eeprom_busywait(client);
+	if (ret < 0)
+		rv3029c2_eeprom_exit(client);
+
+	return ret;
+}
+
+static int rv3029c2_eeprom_read(struct i2c_client *client, u8 reg,
+				u8 buf[], size_t len)
+{
+	int ret, err;
+	size_t i;
+
+	ret =3D rv3029c2_eeprom_enter(client);
+	if (ret < 0)
+		return ret;
+
+	for (i =3D 0; i < len; i++) {
+		ret =3D rv3029c2_i2c_read_regs(client, reg, &buf[i], 1);
+		if (ret < 0)
+			break;
+	}
+
+	err =3D rv3029c2_eeprom_exit(client);
+	if (err < 0)
+		return err;
+
+	return ret;
+}
+
+static int rv3029c2_eeprom_write(struct i2c_client *client, u8 reg,
+				 u8 const buf[], size_t len)
+{
+	int ret, err;
+	size_t i;
+	u8 tmp;
+
+	ret =3D rv3029c2_eeprom_enter(client);
+	if (ret < 0)
+		return ret;
+
+	for (i =3D 0; i < len; i++) {
+		ret =3D rv3029c2_i2c_read_regs(client, reg, &tmp, 1);
+		if (ret < 0)
+			break;
+		if (tmp !=3D buf[i]) {
+			ret =3D rv3029c2_i2c_write_regs(client, reg, &buf[i], 1);
+			if (ret < 0)
+				break;
+		}
+		ret =3D rv3029c2_eeprom_busywait(client);
+		if (ret < 0)
+			break;
+	}
+
+	err =3D rv3029c2_eeprom_exit(client);
+	if (err < 0)
+		return err;
+
+	return ret;
+}
+
 static int
 rv3029c2_i2c_read_time(struct i2c_client *client, struct rtc_time *tm)
 {
@@ -230,22 +398,13 @@ static int rv3029c2_rtc_i2c_alarm_set_irq(struct i2c_=
client *client,
 					int enable)
 {
 	int ret;
-	u8 buf[1];
-
-	/* enable AIE irq */
-	ret =3D rv3029c2_i2c_read_regs(client, RV3029C2_IRQ_CTRL,	buf, 1);
-	if (ret < 0) {
-		dev_err(&client->dev, "can't read INT reg\n");
-		return ret;
-	}
-	if (enable)
-		buf[0] |=3D RV3029C2_IRQ_CTRL_AIE;
-	else
-		buf[0] &=3D ~RV3029C2_IRQ_CTRL_AIE;
=20
-	ret =3D rv3029c2_i2c_write_regs(client, RV3029C2_IRQ_CTRL, buf, 1);
+	/* enable/disable AIE irq */
+	ret =3D rv3029c2_i2c_maskset_reg(client, RV3029C2_IRQ_CTRL,
+				       (u8)~RV3029C2_IRQ_CTRL_AIE,
+				       (enable ? RV3029C2_IRQ_CTRL_AIE : 0));
 	if (ret < 0) {
-		dev_err(&client->dev, "can't set INT reg\n");
+		dev_err(&client->dev, "can't update INT reg\n");
 		return ret;
 	}
=20
@@ -286,20 +445,11 @@ static int rv3029c2_rtc_i2c_set_alarm(struct i2c_clie=
nt *client,
 		return ret;
=20
 	if (alarm->enabled) {
-		u8 buf[1];
-
 		/* clear AF flag */
-		ret =3D rv3029c2_i2c_read_regs(client, RV3029C2_IRQ_FLAGS,
-						buf, 1);
-		if (ret < 0) {
-			dev_err(&client->dev, "can't read alarm flag\n");
-			return ret;
-		}
-		buf[0] &=3D ~RV3029C2_IRQ_FLAGS_AF;
-		ret =3D rv3029c2_i2c_write_regs(client, RV3029C2_IRQ_FLAGS,
-						buf, 1);
+		ret =3D rv3029c2_i2c_maskset_reg(client, RV3029C2_IRQ_FLAGS,
+					       (u8)~RV3029C2_IRQ_FLAGS_AF, 0);
 		if (ret < 0) {
-			dev_err(&client->dev, "can't set alarm flag\n");
+			dev_err(&client->dev, "can't clear alarm flag\n");
 			return ret;
 		}
 		/* enable AIE irq */
@@ -372,6 +522,109 @@ static int rv3029c2_rtc_set_time(struct device *dev, =
struct rtc_time *tm)
 	return rv3029c2_i2c_set_time(to_i2c_client(dev), tm);
 }
=20
+static const struct rv3029c2_trickle_tab_elem {
+	u32 r;		/* resistance in ohms */
+	u8 conf;	/* trickle config bits */
+} rv3029c2_trickle_tab[] =3D {
+	{
+		.r	=3D 1076,
+		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_5K |
+			  RV3029C2_TRICKLE_20K | RV3029C2_TRICKLE_80K,
+	}, {
+		.r	=3D 1091,
+		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_5K |
+			  RV3029C2_TRICKLE_20K,
+	}, {
+		.r	=3D 1137,
+		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_5K |
+			  RV3029C2_TRICKLE_80K,
+	}, {
+		.r	=3D 1154,
+		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_5K,
+	}, {
+		.r	=3D 1371,
+		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_20K |
+			  RV3029C2_TRICKLE_80K,
+	}, {
+		.r	=3D 1395,
+		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_20K,
+	}, {
+		.r	=3D 1472,
+		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_80K,
+	}, {
+		.r	=3D 1500,
+		.conf	=3D RV3029C2_TRICKLE_1K,
+	}, {
+		.r	=3D 3810,
+		.conf	=3D RV3029C2_TRICKLE_5K | RV3029C2_TRICKLE_20K |
+			  RV3029C2_TRICKLE_80K,
+	}, {
+		.r	=3D 4000,
+		.conf	=3D RV3029C2_TRICKLE_5K | RV3029C2_TRICKLE_20K,
+	}, {
+		.r	=3D 4706,
+		.conf	=3D RV3029C2_TRICKLE_5K | RV3029C2_TRICKLE_80K,
+	}, {
+		.r	=3D 5000,
+		.conf	=3D RV3029C2_TRICKLE_5K,
+	}, {
+		.r	=3D 16000,
+		.conf	=3D RV3029C2_TRICKLE_20K | RV3029C2_TRICKLE_80K,
+	}, {
+		.r	=3D 20000,
+		.conf	=3D RV3029C2_TRICKLE_20K,
+	}, {
+		.r	=3D 80000,
+		.conf	=3D RV3029C2_TRICKLE_80K,
+	},
+};
+
+static int rv3029c2_of_init(struct i2c_client *client)
+{
+	struct device_node *of_node =3D client->dev.of_node;
+	const struct rv3029c2_trickle_tab_elem *elem;
+	int i, err;
+	u32 ohms;
+	u8 eectrl;
+
+	if (!of_node)
+		return 0;
+
+	/* Configure the trickle charger. */
+	err =3D rv3029c2_eeprom_read(client, RV3029C2_CONTROL_E2P_EECTRL,
+				   &eectrl, 1);
+	if (err < 0) {
+		dev_err(&client->dev, "Failed to read trickle "
+			"charger config\n");
+		return err;
+	}
+	err =3D of_property_read_u32(of_node, "trickle-resistor-ohms", &ohms);
+	if (err) {
+		/* Disable trickle charger. */
+		eectrl &=3D ~RV3029C2_TRICKLE_MASK;
+	} else {
+		/* Enable trickle charger. */
+		for (i =3D 0; i < ARRAY_SIZE(rv3029c2_trickle_tab); i++) {
+			elem =3D &rv3029c2_trickle_tab[i];
+			if (elem->r >=3D ohms)
+				break;
+		}
+		eectrl &=3D ~RV3029C2_TRICKLE_MASK;
+		eectrl |=3D elem->conf;
+		dev_info(&client->dev, "Trickle charger enabled at %d ohms "
+			 "resistance.\n", elem->r);
+	}
+	err =3D rv3029c2_eeprom_write(client, RV3029C2_CONTROL_E2P_EECTRL,
+				    &eectrl, 1);
+	if (err < 0) {
+		dev_err(&client->dev, "Failed to write trickle "
+			"charger config\n");
+		return err;
+	}
+
+	return 0;
+}
+
 static const struct rtc_class_ops rv3029c2_rtc_ops =3D {
 	.read_time	=3D rv3029c2_rtc_read_time,
 	.set_time	=3D rv3029c2_rtc_set_time,
@@ -381,6 +634,7 @@ static const struct rtc_class_ops rv3029c2_rtc_ops =3D =
{
=20
 static struct i2c_device_id rv3029c2_id[] =3D {
 	{ "rv3029c2", 0 },
+	{ "rv3029", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rv3029c2_id);
@@ -401,6 +655,12 @@ static int rv3029c2_probe(struct i2c_client *client,
 		return rc;
 	}
=20
+	rc =3D rv3029c2_of_init(client);
+	if (rc < 0) {
+		dev_err(&client->dev, "OF init failed.\n");
+		return rc;
+	}
+
 	rtc =3D devm_rtc_device_register(&client->dev, client->name,
 					&rv3029c2_rtc_ops, THIS_MODULE);
=20
@@ -423,5 +683,6 @@ static struct i2c_driver rv3029c2_driver =3D {
 module_i2c_driver(rv3029c2_driver);
=20
 MODULE_AUTHOR("Gregory Hermant <gregory.hermant@calao-systems.com>");
+MODULE_AUTHOR("Michael Buesch <m@bues.ch>");
 MODULE_DESCRIPTION("Micro Crystal RV3029C2 RTC driver");
 MODULE_LICENSE("GPL");
--=20
2.7.0

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

--Sig_/7_1Q.RcL9XaouPtLt/yu6A/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1fySAAoJEPUyvh2QjYsO+awP/38pJn1qJwpZ2iEKnmN07Pj7
Y6NOVTCZx4YONMOL5O/weAQmwhOce9B62cnKaCW8gXbT8hOMi5rqZeqeVMaN5JGY
APyBAEjb7es80MGBlmLidDtTOaz05c0YwT9g0BBIg+FuzRrmwHy4r8xBoQ+Jl1Ms
y+pmBZHn9MraR10pKAWf8oxEQXUq0pB8Q+qVERRBAWOnppnJ2+2zR+eHbJrFLW1V
VE74yoxu78Tg0wNF8Szd9MVPMyQJhc0ava3/GlcZKQG2aJKGFEaPJHlovbhBvN/l
U+IeA2pRoHgXWV+asWXXia9WQK3l1DcSfK7tqKLlgE4KqOi1Tc8bUTl+gDmlSDM9
hB9UXgyNMulKW5qCW4bvlUOAQwR6On/43CRsJG49t5F5t3i37f3mEgfFt09urtcT
JELUvY+ez6MYNgRLv47Ms4T2JKaokU6qMCJtxhgDWsS7sangz4Aqm6CObbwKny6f
b6TP67Jcgb/liG49ii35JoTKddavmOIqvvi6kGRSTBbAVETnbYRAySFpOJ5MS/r7
yqU73Y/z0P5UG+HYWQKBh8MQv6VX117Z/VUYQ/X7r1VKFFrhEVtQGpEedyaAGkBC
PYJTTJK+9coT2XDC4sWWUuZ5iUnXDLhs/anU6hUZ8/jLDnam+V8vIbnMOKTxYoGY
svnDcVldtFnxCM2phPV/
=Xwlo
-----END PGP SIGNATURE-----

--Sig_/7_1Q.RcL9XaouPtLt/yu6A/--
