Return-Path: <rtc-linux+bncBDKOBWPM5ABRBWGWUO5QKGQETQLV2YI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com. [2607:f8b0:400e:c00::243])
        by gmr-mx.google.com with ESMTPS id 62si7279324pfx.1.2016.06.21.00.23.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 00:23:04 -0700 (PDT)
Received: by mail-pf0-x243.google.com with SMTP id i123so755736pfg.3
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 00:23:04 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	cphealy@gmail.com
Subject: [rtc-linux] [PATCH v2 06/17] RTC: ds1307: Convert want_irq into a predicate
Date: Tue, 21 Jun 2016 00:22:39 -0700
Message-Id: <1466493770-11895-5-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Convert want_irq variable into a predicate in order to detangle various
independent chunks of ds1307_probe().

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 98e1f81..ccfaba4 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1247,6 +1247,30 @@ static bool ds1307_can_wakeup_device(const struct ds1307 *ds1307)
 				     "wakeup-source");
 }
 
+static bool ds1307_want_irq(const struct ds1307 *ds1307,
+			    const struct chip_desc *chip)
+{
+
+
+	if (chip->alarm) {
+		switch (ds1307->type) {
+		case ds_1337:
+		case ds_1339:
+		case ds_3231:
+		case ds_1341:
+			return (ds1307->client->irq > 0 ||
+				ds1307_can_wakeup_device(ds1307));
+
+		case mcp794xx:
+			return (ds1307->client->irq > 0);
+		default:
+			break;
+		}
+	}
+
+	return false;
+}
+
 static int ds1307_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -1255,7 +1279,6 @@ static int ds1307_probe(struct i2c_client *client,
 	int			tmp;
 	struct chip_desc	*chip = &chips[id->driver_data];
 	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
-	bool			want_irq = false;
 	unsigned char		*buf;
 	struct ds1307_platform_data *pdata = dev_get_platdata(&client->dev);
 	irq_handler_t	irq_handler = ds1307_irq;
@@ -1356,10 +1379,6 @@ static int ds1307_probe(struct i2c_client *client,
 			| bbsqi_bitpos[ds1307->type];
 		ds1307->regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
 
-		if (chip->alarm && (ds1307->client->irq > 0 ||
-				    ds1307_can_wakeup_device(ds1307)))
-			want_irq = true;
-
 		i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL,
 							ds1307->regs[0]);
 
@@ -1441,10 +1460,7 @@ static int ds1307_probe(struct i2c_client *client,
 		break;
 	case mcp794xx:
 		rtc_ops = &mcp794xx_rtc_ops;
-		if (ds1307->client->irq > 0 && chip->alarm) {
-			irq_handler = mcp794xx_irq;
-			want_irq = true;
-		}
+		irq_handler = mcp794xx_irq;
 		break;
 	default:
 		break;
@@ -1557,7 +1573,7 @@ read_rtc:
 				bin2bcd(tmp));
 	}
 
-	if (want_irq) {
+	if (ds1307_want_irq(ds1307, chip)) {
 		device_set_wakeup_capable(&client->dev, true);
 		set_bit(HAS_ALARM, &ds1307->flags);
 	}
@@ -1570,13 +1586,11 @@ read_rtc:
 	if (ds1307_can_wakeup_device(ds1307) &&
 	    ds1307->client->irq <= 0) {
 		/* Disable request for an IRQ */
-		want_irq = false;
-		dev_info(&client->dev, "'wakeup-source' is set, request for an IRQ is disabled!\n");
+		dev_info(&client->dev,
+			 "'wakeup-source' is set, request for an IRQ is disabled!\n");
 		/* We cannot support UIE mode if we do not have an IRQ line */
 		ds1307->rtc->uie_unsupported = 1;
-	}
-
-	if (want_irq) {
+	} else if (ds1307_want_irq(ds1307, chip)) {
 		err = devm_request_threaded_irq(&client->dev,
 						client->irq, NULL, irq_handler,
 						IRQF_SHARED | IRQF_ONESHOT,
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
