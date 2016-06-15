Return-Path: <rtc-linux+bncBDKOBWPM5ABRB2G5QO5QKGQEBXYN52Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com. [2607:f8b0:400e:c00::243])
        by gmr-mx.google.com with ESMTPS id un17si1493626pab.0.2016.06.14.23.00.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 23:00:08 -0700 (PDT)
Received: by mail-pf0-x243.google.com with SMTP id t190so988764pfb.2
        for <rtc-linux@googlegroups.com>; Tue, 14 Jun 2016 23:00:08 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [rtc-linux] [PATCH 04/13] RTC: ds1307: Convert ds1307_can_wakeup_device
 into a predicate
Date: Tue, 14 Jun 2016 22:59:30 -0700
Message-Id: <1465970379-14703-5-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
References: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Convert ds1307_can_wakeup_device in ds1307_probe into a predicate in
order to make various chunks of code in that function less connected to
each other.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 54cc527..c482d8b 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1232,6 +1232,21 @@ static void ds1307_clks_register(struct ds1307 *ds1307)
 
 #endif /* CONFIG_COMMON_CLK */
 
+static bool ds1307_can_wakeup_device(const struct ds1307 *ds1307)
+{
+
+/*
+ * For devices with no IRQ directly connected to the SoC, the RTC chip
+ * can be forced as a wakeup source by stating that explicitly in
+ * the device's .dts file using the "wakeup-source" boolean property.
+ * If the "wakeup-source" property is set, don't request an IRQ.
+ * This will guarantee the 'wakealarm' sysfs entry is available on the device,
+ * if supported by the RTC.
+ */
+	return of_property_read_bool(ds1307->client->dev.of_node,
+				     "wakeup-source");
+}
+
 static int ds1307_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -1241,7 +1256,6 @@ static int ds1307_probe(struct i2c_client *client,
 	struct chip_desc	*chip = &chips[id->driver_data];
 	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
 	bool			want_irq = false;
-	bool			ds1307_can_wakeup_device = false;
 	unsigned char		*buf;
 	struct ds1307_platform_data *pdata = dev_get_platdata(&client->dev);
 	irq_handler_t	irq_handler = ds1307_irq;
@@ -1290,20 +1304,6 @@ static int ds1307_probe(struct i2c_client *client,
 		ds1307->write_block_data = ds1307_write_block_data;
 	}
 
-#ifdef CONFIG_OF
-/*
- * For devices with no IRQ directly connected to the SoC, the RTC chip
- * can be forced as a wakeup source by stating that explicitly in
- * the device's .dts file using the "wakeup-source" boolean property.
- * If the "wakeup-source" property is set, don't request an IRQ.
- * This will guarantee the 'wakealarm' sysfs entry is available on the device,
- * if supported by the RTC.
- */
-	if (of_property_read_bool(client->dev.of_node, "wakeup-source")) {
-		ds1307_can_wakeup_device = true;
-	}
-#endif
-
 	switch (ds1307->type) {
 	case ds_1337:
 	case ds_1339:
@@ -1357,7 +1357,7 @@ static int ds1307_probe(struct i2c_client *client,
 		ds1307->regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
 
 		if (chip->alarm && (ds1307->client->irq > 0 ||
-				    ds1307_can_wakeup_device))
+				    ds1307_can_wakeup_device(ds1307)))
 			want_irq = true;
 
 		i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL,
@@ -1567,7 +1567,8 @@ read_rtc:
 		return PTR_ERR(ds1307->rtc);
 	}
 
-	if (ds1307_can_wakeup_device && ds1307->client->irq <= 0) {
+	if (ds1307_can_wakeup_device(ds1307) &&
+	    ds1307->client->irq <= 0) {
 		/* Disable request for an IRQ */
 		want_irq = false;
 		dev_info(&client->dev, "'wakeup-source' is set, request for an IRQ is disabled!\n");
-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
