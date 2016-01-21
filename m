Return-Path: <rtc-linux+bncBAABBDNCQS2QKGQEDFHOUDI@googlegroups.com>
MIME-Version: 1.0
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de. [2a01:238:20a:202:5300::7])
        by gmr-mx.google.com with ESMTPS id f18si104277wme.1.2016.01.21.09.10.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2016 09:10:37 -0800 (PST)
From: Michael Lange <linuxstuff@milaw.biz>
To: rtc-linux@googlegroups.com
Cc: Michael Lange <linuxstuff@milaw.biz>
Subject: [rtc-linux] [PATCH] rtc: ds1307.c: add support for the DT property 'wakeup-source'
Date: Thu, 21 Jan 2016 18:10:16 +0100
Message-Id: <1453396216-8367-1-git-send-email-linuxstuff@milaw.biz>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

For RTC chips with no IRQ directly connected to the SoC, the RTC chip
can be forced as a wakeup source by stating that explicitly in
the device's .dts file using the "wakeup-source" boolean property.
This will guarantee the 'wakealarm' sysfs entry is available on the
device, if supported by the RTC.

With these changes to the driver rtc-ds1307 and the necessary entries
in the .dts file, I get an working ds1337 RTC on the Witty Pi extension
board by UUGear for the Raspberry Pi.

An example for the entry in the .dts file:

	rtc: ds1337@68 {
		compatible = "dallas,ds1337";
		reg = <0x68>;
		wakeup-source;

If the "wakeup-source" property is set, do not request an IRQ.
Set also UIE mode to unsupported, to get a working 'hwclock' binary.

Signed-off-by: Michael Lange <linuxstuff@milaw.biz>
---
 drivers/rtc/rtc-ds1307.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index aa705bb..7500b5c 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -860,6 +860,7 @@ static int ds1307_probe(struct i2c_client *client,
 	struct chip_desc	*chip = &chips[id->driver_data];
 	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
 	bool			want_irq = false;
+	bool			ds1307_can_wakeup_device = false;
 	unsigned char		*buf;
 	struct ds1307_platform_data *pdata = dev_get_platdata(&client->dev);
 	irq_handler_t	irq_handler = ds1307_irq;
@@ -907,6 +908,20 @@ static int ds1307_probe(struct i2c_client *client,
 		ds1307->write_block_data = ds1307_write_block_data;
 	}
 
+#ifdef CONFIG_OF
+/*
+ * For devices with no IRQ directly connected to the SoC, the RTC chip
+ * can be forced as a wakeup source by stating that explicitly in
+ * the device's .dts file using the "wakeup-source" boolean property.
+ * If the "wakeup-source" property is set, don't request an IRQ.
+ * This will guarantee the 'wakealarm' sysfs entry is available on the device,
+ * if supported by the RTC.
+ */
+	if (of_property_read_bool(client->dev.of_node, "wakeup-source")) {
+		ds1307_can_wakeup_device = true;
+	}
+#endif
+
 	switch (ds1307->type) {
 	case ds_1337:
 	case ds_1339:
@@ -925,11 +940,13 @@ static int ds1307_probe(struct i2c_client *client,
 			ds1307->regs[0] &= ~DS1337_BIT_nEOSC;
 
 		/*
-		 * Using IRQ?  Disable the square wave and both alarms.
+		 * Using IRQ or defined as wakeup-source?
+		 * Disable the square wave and both alarms.
 		 * For some variants, be sure alarms can trigger when we're
 		 * running on Vbackup (BBSQI/BBSQW)
 		 */
-		if (ds1307->client->irq > 0 && chip->alarm) {
+		if (chip->alarm && (ds1307->client->irq > 0 ||
+						ds1307_can_wakeup_device)) {
 			ds1307->regs[0] |= DS1337_BIT_INTCN
 					| bbsqi_bitpos[ds1307->type];
 			ds1307->regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
@@ -1144,6 +1161,14 @@ read_rtc:
 		return PTR_ERR(ds1307->rtc);
 	}
 
+	if (ds1307_can_wakeup_device) {
+		/* Disable request for an IRQ */
+		want_irq = false;
+		dev_info(&client->dev, "'wakeup-source' is set, request for an IRQ is disabled!\n");
+		/* We cannot support UIE mode if we do not have an IRQ line */
+		ds1307->rtc->uie_unsupported = 1;
+	}
+
 	if (want_irq) {
 		err = devm_request_threaded_irq(&client->dev,
 						client->irq, NULL, irq_handler,
-- 
2.4.10

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
