Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from enterprise03.smtp.diehl.com ([193.201.238.214]:34098 "EHLO
        enterprise03.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751194AbeGJJyC (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 10 Jul 2018 05:54:02 -0400
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: [PATCH v4 4/5] rtc: isl1208: set ev-evienb bit from device tree
Date: Tue, 10 Jul 2018 09:44:15 +0000
Message-ID: <20180710090710.9066-5-Denis.Osterland@diehl.com>
References: <20180710090710.9066-1-Denis.Osterland@diehl.com>
In-Reply-To: <20180710090710.9066-1-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Denis Osterland <Denis.Osterland@diehl.com>

Add support to disable event in pull-up.

Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
---
 drivers/rtc/rtc-isl1208.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index bbe08c1ab9f3..2f18ee3c615a 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -44,6 +44,7 @@
 #define ISL1208_REG_INT_IM     (1<<7)   /* interrupt/alarm mode */
 #define ISL1219_REG_EV  0x09
 #define ISL1219_REG_EV_EVEN    (1<<4)   /* event detection enable */
+#define ISL1219_REG_EV_EVIENB  (1<<7)   /* event in pull-up disable */
 #define ISL1208_REG_ATR 0x0a
 #define ISL1208_REG_DTR 0x0b
 
@@ -777,7 +778,10 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			 "please set clock.\n");
 
 	if (id->driver_data == TYPE_ISL1219) {
+		struct device_node *np = client->dev.of_node;
 		rc = ISL1219_REG_EV_EVEN;
+		if (of_get_property(np, "isil,ev-evienb", NULL))
+			rc |= ISL1219_REG_EV_EVIENB;
 		rc = i2c_smbus_write_byte_data(client, ISL1219_REG_EV, rc);
 		if (rc < 0) {
 			dev_err(&client->dev, "could not enable tamper detection\n");
@@ -786,7 +790,7 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		rc = rtc_add_group(rtc, &isl1219_rtc_sysfs_files);
 		if (rc)
 			return rc;
-		evdet_irq = of_irq_get_byname(client->dev.of_node, "evdet");
+		evdet_irq = of_irq_get_byname(np, "evdet");
 	}
 
 	rc = sysfs_create_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
-- 
2.18.0



Diehl Connectivity Solutions GmbH
Geschäftsführung: Horst Leonberger
Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
Nürnberg: HRB 32315
___________________________________________________________________________________________________

Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited. 
