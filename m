Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46531 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752549AbdHVXJX (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 22 Aug 2017 19:09:23 -0400
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id B2C7120A51
        for <linux-rtc@vger.kernel.org>; Wed, 23 Aug 2017 01:09:19 +0200 (CEST)
From: Eric Cooper <ecc@cmu.edu>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        rtc-linux@googlegroups.com
Cc: Eric Cooper <ecc@cmu.edu>
Subject: [PATCH] rtc: m41t80: enable wakealarm when "wakeup-source" is specified
Date: Sat, 29 Jul 2017 20:10:54 -0400
Message-Id: <20170730001054.20118-1-ecc@cmu.edu>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>
Message-ID: <20170730001054.d0O9OQHBG_ZgQKtxJR6VGJk5Qi_PEMnGq6L1ZY8-COM@z>

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
