Return-Path: <rtc-linux+bncBCQ2RG5RUQPBBEV4SW6AKGQE4DFU7WA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qk0-x229.google.com (mail-qk0-x229.google.com. [2607:f8b0:400d:c09::229])
        by gmr-mx.google.com with ESMTPS id t206si394560ywb.3.2016.07.12.14.16.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2016 14:16:01 -0700 (PDT)
Received: by mail-qk0-x229.google.com with SMTP id s63so26358244qkb.2
        for <rtc-linux@googlegroups.com>; Tue, 12 Jul 2016 14:16:01 -0700 (PDT)
From: Chris DeBruin <cdeb5783@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	Chris DeBruin <cdeb5783@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: pcf85063: Add support for the PCF85063A device
Date: Tue, 12 Jul 2016 17:15:46 -0400
Message-Id: <1468358146-18717-1-git-send-email-cdeb5783@gmail.com>
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

The current rtc-pcf85063 driver only supports the PCF85063TP device.
Using the existing driver on a PCF85063A will result in the time being
set correctly into the RTC, but the RTC is held in the stopped state.
Therefore, the time will no longer advance and no error is indicated.

The PCF85063A device has a bigger memory map than the PCF85063TP.
The existing driver make use of an address rollover condition,
but the rollover point is different in the two devices.

Signed-off-by: Chris DeBruin <cdeb5783@gmail.com>
---
 drivers/rtc/rtc-pcf85063.c | 48 +++++++++++++++++++++++++++++++++++++-----=
----
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index e8ddbb359..95b2b97 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -16,6 +16,17 @@
 #include <linux/rtc.h>
 #include <linux/module.h>
=20
+/*
+ * Information for this driver was pulled from the following datasheets.
+ *
+ *  http://www.nxp.com/documents/data_sheet/PCF85063A.pdf
+ *  http://www.nxp.com/documents/data_sheet/PCF85063TP.pdf
+ *
+ *  PCF85063A -- Rev. 6 =E2=80=94 18 November 2015
+ *  PCF85063TP -- Rev. 4 =E2=80=94 6 May 2015
+*/
+
+
 #define PCF85063_REG_CTRL1		0x00 /* status */
 #define PCF85063_REG_CTRL1_STOP		BIT(5)
 #define PCF85063_REG_CTRL2		0x01
@@ -55,6 +66,22 @@ static int pcf85063_stop_clock(struct i2c_client *client=
, u8 *ctrl1)
 	return 0;
 }
=20
+static int pcf85063_start_clock(struct i2c_client *client, u8 ctrl1)
+{
+	s32 ret;
+
+	/* start the clock */
+	ctrl1 &=3D PCF85063_REG_CTRL1_STOP;
+
+	ret =3D i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, ctrl1);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failing to start the clock\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /*
  * In the routines that deal directly with the pcf85063 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr =3D calendar year-epoch.
@@ -99,13 +126,14 @@ static int pcf85063_get_datetime(struct i2c_client *cl=
ient, struct rtc_time *tm)
 static int pcf85063_set_datetime(struct i2c_client *client, struct rtc_tim=
e *tm)
 {
 	int rc;
-	u8 regs[8];
+	u8 regs[7];
+	u8 ctrl1;
=20
 	/*
 	 * to accurately set the time, reset the divider chain and keep it in
 	 * reset state until all time/date registers are written
 	 */
-	rc =3D pcf85063_stop_clock(client, &regs[7]);
+	rc =3D pcf85063_stop_clock(client, &ctrl1);
 	if (rc !=3D 0)
 		return rc;
=20
@@ -127,13 +155,6 @@ static int pcf85063_set_datetime(struct i2c_client *cl=
ient, struct rtc_time *tm)
 	/* year and century */
 	regs[6] =3D bin2bcd(tm->tm_year % 100);
=20
-	/*
-	 * after all time/date registers are written, let the 'address auto
-	 * increment' feature wrap around and write register CTRL1 to re-enable
-	 * the clock divider chain again
-	 */
-	regs[7] &=3D ~PCF85063_REG_CTRL1_STOP;
-
 	/* write all registers at once */
 	rc =3D i2c_smbus_write_i2c_block_data(client, PCF85063_REG_SC,
 					    sizeof(regs), regs);
@@ -142,6 +163,15 @@ static int pcf85063_set_datetime(struct i2c_client *cl=
ient, struct rtc_time *tm)
 		return rc;
 	}
=20
+    /*
+     * Write the control register as a seperate action since the size of
+     * the register space is different between the PCF85063TP and
+     * PCF85063A devices.  The rollover point can not be used.
+     */
+	rc =3D pcf85063_start_clock(client, ctrl1);
+	if (rc !=3D 0)
+		return rc;
+
 	return 0;
 }
=20
--=20
1.9.1

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
