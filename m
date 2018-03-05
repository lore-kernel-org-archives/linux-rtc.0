Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:40006 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932418AbeCFPnl (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 6 Mar 2018 10:43:41 -0500
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 59A19204AD
        for <linux-rtc@vger.kernel.org>; Tue,  6 Mar 2018 16:43:36 +0100 (CET)
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: [PATCH v3 1/4] rtc: isl1208: enable interrupt after context
 preparation
Date: Mon, 5 Mar 2018 10:43:53 +0000
Message-ID: <1520246373-19023-2-git-send-email-Denis.Osterland@diehl.com>
References: <1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com>
In-Reply-To: <1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

The interrupt handler got enabled very early. If the interrupt cause is
triggering immediately before the context is fully prepared. This can
lead to undefined behaviour. Therefor we move the interrupt enable code
to the end of the probe function.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
---
 drivers/rtc/rtc-isl1208.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index c8b4953..a13a4ba 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -635,23 +635,6 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (isl1208_i2c_validate_client(client) < 0)
 		return -ENODEV;
 
-	if (client->irq > 0) {
-		rc = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-					       isl1208_rtc_interrupt,
-					       IRQF_SHARED | IRQF_ONESHOT,
-					       isl1208_driver.driver.name,
-					       client);
-		if (!rc) {
-			device_init_wakeup(&client->dev, 1);
-			enable_irq_wake(client->irq);
-		} else {
-			dev_err(&client->dev,
-				"Unable to request irq %d, no alarm support\n",
-				client->irq);
-			client->irq = 0;
-		}
-	}
-
 	rtc = devm_rtc_device_register(&client->dev, isl1208_driver.driver.name,
 				  &isl1208_rtc_ops,
 				  THIS_MODULE);
@@ -674,6 +657,23 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (rc)
 		return rc;
 
+	if (client->irq > 0) {
+		rc = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					       isl1208_rtc_interrupt,
+					       IRQF_SHARED | IRQF_ONESHOT,
+					       isl1208_driver.driver.name,
+					       client);
+		if (!rc) {
+			device_init_wakeup(&client->dev, 1);
+			enable_irq_wake(client->irq);
+		} else {
+			dev_err(&client->dev,
+				"Unable to request irq %d, no alarm support\n",
+				client->irq);
+			client->irq = 0;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.7.4


Diehl AKO Stiftung & Co. KG, Pfannerstraße 75-83, 88239 Wangen im Allgäu
Bereichsvorstand: Dr.-Ing. Michael Siedentop (Sprecher), Josef Fellner (Mitglied)
Sitz der Gesellschaft: Wangen i.A. – Registergericht: Amtsgericht Ulm HRA 620609 – Persönlich haftende Gesellschafterin: Diehl Verwaltungs-Stiftung – Sitz: Nürnberg – Registergericht: Amtsgericht Nürnberg HRA 11756 –
Vorstand: Dr.-Ing. E.h. Thomas Diehl (†) (Vorsitzender), Herr Dipl.-Wirtsch.-Ing. Wolfgang Weggen (stellvertretender Vorsitzender), Dipl.-Kfm. Claus Günther, Dipl.-Kfm. Frank Gutzeit, Dr.-Ing. Heinrich Schunk, Dr.-Ing. Michael Siedentop , Dipl.-Kfm. Dr.-Ing. Martin Sommer, Dipl.-Ing. (FH) Rainer von Borstel, Vorsitzender des Aufsichtsrates: Dr. Klaus Maier
___________________________________________________________________________________________________
Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht. Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.
