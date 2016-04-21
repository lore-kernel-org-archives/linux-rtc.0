Return-Path: <rtc-linux+bncBAABBZFV4S4AKGQEEN63LWY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 69si140941wmn.1.2016.04.21.11.24.36
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Apr 2016 11:24:36 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 4/6] rtc: rv3029: Removes some checks and warnings
Date: Thu, 21 Apr 2016 20:24:17 +0200
Message-Id: <f4a0b6a1f25057a2d8685dadb0eef5bb0968cf6a.1461250479.git.mylene.josserand@free-electrons.com>
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

Removes some checks from checkpatch such as spaces around arithmetic
operations.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-rv3029c2.c | 66 ++++++++++++++++++++++--------------------=
----
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 470cc1e..a849005 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -130,7 +130,7 @@ static int rv3029_read_regs(struct device *dev, u8 reg,=
 u8 *buf,
 	struct rv3029_data *rv3029 =3D dev_get_drvdata(dev);
=20
 	if ((reg > RV3029_USR1_RAM_PAGE + 7) ||
-		(reg + len > RV3029_USR1_RAM_PAGE + 8))
+	    (reg + len > RV3029_USR1_RAM_PAGE + 8))
 		return -EINVAL;
=20
 	return regmap_bulk_read(rv3029->regmap, reg, buf, len);
@@ -142,7 +142,7 @@ static int rv3029_write_regs(struct device *dev, u8 reg=
, u8 const buf[],
 	struct rv3029_data *rv3029 =3D dev_get_drvdata(dev);
=20
 	if ((reg > RV3029_USR1_RAM_PAGE + 7) ||
-		(reg + len > RV3029_USR1_RAM_PAGE + 8))
+	    (reg + len > RV3029_USR1_RAM_PAGE + 8))
 		return -EINVAL;
=20
 	return regmap_bulk_write(rv3029->regmap, reg, buf, len);
@@ -347,12 +347,12 @@ static int rv3029_read_time(struct device *dev, struc=
t rtc_time *tm)
 		return ret;
 	}
=20
-	tm->tm_sec =3D bcd2bin(regs[RV3029_W_SEC-RV3029_W_SEC]);
-	tm->tm_min =3D bcd2bin(regs[RV3029_W_MINUTES-RV3029_W_SEC]);
+	tm->tm_sec =3D bcd2bin(regs[RV3029_W_SEC - RV3029_W_SEC]);
+	tm->tm_min =3D bcd2bin(regs[RV3029_W_MINUTES - RV3029_W_SEC]);
=20
 	/* HR field has a more complex interpretation */
 	{
-		const u8 _hr =3D regs[RV3029_W_HOURS-RV3029_W_SEC];
+		const u8 _hr =3D regs[RV3029_W_HOURS - RV3029_W_SEC];
=20
 		if (_hr & RV3029_REG_HR_12_24) {
 			/* 12h format */
@@ -363,10 +363,10 @@ static int rv3029_read_time(struct device *dev, struc=
t rtc_time *tm)
 			tm->tm_hour =3D bcd2bin(_hr & 0x3f);
 	}
=20
-	tm->tm_mday =3D bcd2bin(regs[RV3029_W_DATE-RV3029_W_SEC]);
-	tm->tm_mon =3D bcd2bin(regs[RV3029_W_MONTHS-RV3029_W_SEC]) - 1;
-	tm->tm_year =3D bcd2bin(regs[RV3029_W_YEARS-RV3029_W_SEC]) + 100;
-	tm->tm_wday =3D bcd2bin(regs[RV3029_W_DAYS-RV3029_W_SEC]) - 1;
+	tm->tm_mday =3D bcd2bin(regs[RV3029_W_DATE - RV3029_W_SEC]);
+	tm->tm_mon =3D bcd2bin(regs[RV3029_W_MONTHS - RV3029_W_SEC]) - 1;
+	tm->tm_year =3D bcd2bin(regs[RV3029_W_YEARS - RV3029_W_SEC]) + 100;
+	tm->tm_wday =3D bcd2bin(regs[RV3029_W_DAYS - RV3029_W_SEC]) - 1;
=20
 	return 0;
 }
@@ -391,13 +391,13 @@ static int rv3029_read_alarm(struct device *dev, stru=
ct rtc_wkalrm *alarm)
 		return ret;
 	}
=20
-	tm->tm_sec =3D bcd2bin(regs[RV3029_A_SC-RV3029_A_SC] & 0x7f);
-	tm->tm_min =3D bcd2bin(regs[RV3029_A_MN-RV3029_A_SC] & 0x7f);
-	tm->tm_hour =3D bcd2bin(regs[RV3029_A_HR-RV3029_A_SC] & 0x3f);
-	tm->tm_mday =3D bcd2bin(regs[RV3029_A_DT-RV3029_A_SC] & 0x3f);
-	tm->tm_mon =3D bcd2bin(regs[RV3029_A_MO-RV3029_A_SC] & 0x1f) - 1;
-	tm->tm_year =3D bcd2bin(regs[RV3029_A_YR-RV3029_A_SC] & 0x7f) + 100;
-	tm->tm_wday =3D bcd2bin(regs[RV3029_A_DW-RV3029_A_SC] & 0x07) - 1;
+	tm->tm_sec =3D bcd2bin(regs[RV3029_A_SC - RV3029_A_SC] & 0x7f);
+	tm->tm_min =3D bcd2bin(regs[RV3029_A_MN - RV3029_A_SC] & 0x7f);
+	tm->tm_hour =3D bcd2bin(regs[RV3029_A_HR - RV3029_A_SC] & 0x3f);
+	tm->tm_mday =3D bcd2bin(regs[RV3029_A_DT - RV3029_A_SC] & 0x3f);
+	tm->tm_mon =3D bcd2bin(regs[RV3029_A_MO - RV3029_A_SC] & 0x1f) - 1;
+	tm->tm_year =3D bcd2bin(regs[RV3029_A_YR - RV3029_A_SC] & 0x7f) + 100;
+	tm->tm_wday =3D bcd2bin(regs[RV3029_A_DW - RV3029_A_SC] & 0x07) - 1;
=20
 	return 0;
 }
@@ -436,13 +436,13 @@ static int rv3029_set_alarm(struct device *dev, struc=
t rtc_wkalrm *alarm)
 		dev_err(dev, "%s: reading SR failed\n", __func__);
 		return -EIO;
 	}
-	regs[RV3029_A_SC-RV3029_A_SC] =3D bin2bcd(tm->tm_sec & 0x7f);
-	regs[RV3029_A_MN-RV3029_A_SC] =3D bin2bcd(tm->tm_min & 0x7f);
-	regs[RV3029_A_HR-RV3029_A_SC] =3D bin2bcd(tm->tm_hour & 0x3f);
-	regs[RV3029_A_DT-RV3029_A_SC] =3D bin2bcd(tm->tm_mday & 0x3f);
-	regs[RV3029_A_MO-RV3029_A_SC] =3D bin2bcd((tm->tm_mon & 0x1f) - 1);
-	regs[RV3029_A_DW-RV3029_A_SC] =3D bin2bcd((tm->tm_wday & 7) - 1);
-	regs[RV3029_A_YR-RV3029_A_SC] =3D bin2bcd((tm->tm_year & 0x7f) - 100);
+	regs[RV3029_A_SC - RV3029_A_SC] =3D bin2bcd(tm->tm_sec & 0x7f);
+	regs[RV3029_A_MN - RV3029_A_SC] =3D bin2bcd(tm->tm_min & 0x7f);
+	regs[RV3029_A_HR - RV3029_A_SC] =3D bin2bcd(tm->tm_hour & 0x3f);
+	regs[RV3029_A_DT - RV3029_A_SC] =3D bin2bcd(tm->tm_mday & 0x3f);
+	regs[RV3029_A_MO - RV3029_A_SC] =3D bin2bcd((tm->tm_mon & 0x1f) - 1);
+	regs[RV3029_A_DW - RV3029_A_SC] =3D bin2bcd((tm->tm_wday & 7) - 1);
+	regs[RV3029_A_YR - RV3029_A_SC] =3D bin2bcd((tm->tm_year & 0x7f) - 100);
=20
 	ret =3D rv3029_write_regs(dev, RV3029_A_SC, regs,
 				RV3029_ALARM_SECTION_LEN);
@@ -488,13 +488,13 @@ static int rv3029_set_time(struct device *dev, struct=
 rtc_time *tm)
 	if (tm->tm_year < 100)
 		return -EINVAL;
=20
-	regs[RV3029_W_SEC-RV3029_W_SEC] =3D bin2bcd(tm->tm_sec);
-	regs[RV3029_W_MINUTES-RV3029_W_SEC] =3D bin2bcd(tm->tm_min);
-	regs[RV3029_W_HOURS-RV3029_W_SEC] =3D bin2bcd(tm->tm_hour);
-	regs[RV3029_W_DATE-RV3029_W_SEC] =3D bin2bcd(tm->tm_mday);
-	regs[RV3029_W_MONTHS-RV3029_W_SEC] =3D bin2bcd(tm->tm_mon+1);
-	regs[RV3029_W_DAYS-RV3029_W_SEC] =3D bin2bcd((tm->tm_wday & 7)+1);
-	regs[RV3029_W_YEARS-RV3029_W_SEC] =3D bin2bcd(tm->tm_year - 100);
+	regs[RV3029_W_SEC - RV3029_W_SEC] =3D bin2bcd(tm->tm_sec);
+	regs[RV3029_W_MINUTES - RV3029_W_SEC] =3D bin2bcd(tm->tm_min);
+	regs[RV3029_W_HOURS - RV3029_W_SEC] =3D bin2bcd(tm->tm_hour);
+	regs[RV3029_W_DATE - RV3029_W_SEC] =3D bin2bcd(tm->tm_mday);
+	regs[RV3029_W_MONTHS - RV3029_W_SEC] =3D bin2bcd(tm->tm_mon + 1);
+	regs[RV3029_W_DAYS - RV3029_W_SEC] =3D bin2bcd((tm->tm_wday & 7) + 1);
+	regs[RV3029_W_YEARS - RV3029_W_SEC] =3D bin2bcd(tm->tm_year - 100);
=20
 	ret =3D rv3029_write_regs(dev, RV3029_W_SEC, regs,
 				RV3029_WATCH_SECTION_LEN);
@@ -515,6 +515,7 @@ static int rv3029_set_time(struct device *dev, struct r=
tc_time *tm)
=20
 	return 0;
 }
+
 static const struct rv3029_trickle_tab_elem {
 	u32 r;		/* resistance in ohms */
 	u8 conf;	/* trickle config bits */
@@ -603,9 +604,8 @@ static void rv3029_trickle_config(struct device *dev)
 	err =3D rv3029_eeprom_update_bits(dev, RV3029_CONTROL_E2P_EECTRL,
 					RV3029_TRICKLE_MASK,
 					trickle_set_bits);
-	if (err < 0) {
+	if (err < 0)
 		dev_err(dev, "Failed to update trickle charger config\n");
-	}
 }
=20
 #ifdef CONFIG_RTC_DRV_RV3029_HWMON
@@ -829,8 +829,6 @@ static void rv3029_unregister_driver(void)
=20
 static int rv3049_probe(struct spi_device *spi)
 {
-	int res;
-	unsigned int tmp;
 	static const struct regmap_config config =3D {
 		.reg_bits =3D 8,
 		.val_bits =3D 8,
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
