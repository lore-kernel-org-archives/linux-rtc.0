Return-Path: <rtc-linux+bncBDDMDOGHWALRBKOI6TFQKGQEWHTN7JY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com. [2607:f8b0:400d:c0d::244])
        by gmr-mx.google.com with ESMTPS id o189si985905ywc.15.2017.07.29.17.11.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jul 2017 17:11:21 -0700 (PDT)
Received: by mail-qt0-x244.google.com with SMTP id c15so10315541qta.3
        for <rtc-linux@googlegroups.com>; Sat, 29 Jul 2017 17:11:20 -0700 (PDT)
Received: from cooper-siegel.org (pool-71-112-158-16.pitbpa.fios.verizon.net. [71.112.158.16])
        by smtp.gmail.com with ESMTPSA id e192sm892777qka.48.2017.07.29.17.11.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Jul 2017 17:11:19 -0700 (PDT)
Sender: Eric Cooper <eric.c.cooper@gmail.com>
From: Eric Cooper <ecc@cmu.edu>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Eric Cooper <ecc@cmu.edu>
Subject: [rtc-linux] [PATCH] rtc: m41t80: enable wakealarm when
 "wakeup-source" is specified
Date: Sat, 29 Jul 2017 20:10:54 -0400
Message-Id: <20170730001054.20118-1-ecc@cmu.edu>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Don't require an IRQ if the wakeup-source device-tree property is present.

Signed-off-by: Eric Cooper <ecc@cmu.edu>
---
 drivers/rtc/rtc-m41t80.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 58698d21c2c3..85ecb7043dc5 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -774,6 +774,7 @@ static int m41t80_probe(struct i2c_client *client,
 	struct rtc_device *rtc = NULL;
 	struct rtc_time tm;
 	struct m41t80_data *m41t80_data = NULL;
+	bool wakeup_source = false;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK |
 				     I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -789,6 +790,10 @@ static int m41t80_probe(struct i2c_client *client,
 	m41t80_data->features = id->driver_data;
 	i2c_set_clientdata(client, m41t80_data);
 
+#ifdef CONFIG_OF
+	wakeup_source = of_property_read_bool(client->dev.of_node,
+						"wakeup-source");
+#endif
 	if (client->irq > 0) {
 		rc = devm_request_threaded_irq(&client->dev, client->irq,
 					       NULL, m41t80_handle_irq,
@@ -797,14 +802,16 @@ static int m41t80_probe(struct i2c_client *client,
 		if (rc) {
 			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
 			client->irq = 0;
-		} else {
-			m41t80_rtc_ops.read_alarm = m41t80_read_alarm;
-			m41t80_rtc_ops.set_alarm = m41t80_set_alarm;
-			m41t80_rtc_ops.alarm_irq_enable = m41t80_alarm_irq_enable;
-			/* Enable the wakealarm */
-			device_init_wakeup(&client->dev, true);
+			wakeup_source = false;
 		}
 	}
+	if (client->irq > 0 || wakeup_source) {
+		m41t80_rtc_ops.read_alarm = m41t80_read_alarm;
+		m41t80_rtc_ops.set_alarm = m41t80_set_alarm;
+		m41t80_rtc_ops.alarm_irq_enable = m41t80_alarm_irq_enable;
+		/* Enable the wakealarm */
+		device_init_wakeup(&client->dev, true);
+	}
 
 	rtc = devm_rtc_device_register(&client->dev, client->name,
 				       &m41t80_rtc_ops, THIS_MODULE);
@@ -812,6 +819,10 @@ static int m41t80_probe(struct i2c_client *client,
 		return PTR_ERR(rtc);
 
 	m41t80_data->rtc = rtc;
+	if (client->irq <= 0) {
+		/* We cannot support UIE mode if we do not have an IRQ line */
+		rtc->uie_unsupported = 1;
+	}
 
 	/* Make sure HT (Halt Update) bit is cleared */
 	rc = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_HOUR);
-- 
2.13.2

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
