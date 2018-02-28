Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from enterprise01.smtp.diehl.com ([193.201.238.219]:35782 "EHLO
        enterprise01.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752592AbeB1Mzt (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 28 Feb 2018 07:55:49 -0500
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: [PATCH v2 2/4] rtc: isl1208: switch to rtc_register_device
Date: Wed, 28 Feb 2018 12:45:47 +0000
Message-ID: <1519821214-22379-3-git-send-email-Denis.Osterland@diehl.com>
References: <1519821214-22379-1-git-send-email-Denis.Osterland@diehl.com>
In-Reply-To: <1519821214-22379-1-git-send-email-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Denis Osterland <Denis.Osterland@diehl.com>

Fix possible race condition.
It is not allowed to return with an error code after RTC is registered.

Suggested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/rtc/rtc-isl1208.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index a13a4ba..908fb4d 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -635,12 +635,12 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (isl1208_i2c_validate_client(client) < 0)
 		return -ENODEV;
 
-	rtc = devm_rtc_device_register(&client->dev, isl1208_driver.driver.name,
-				  &isl1208_rtc_ops,
-				  THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	rtc->ops = &isl1208_rtc_ops;
+
 	i2c_set_clientdata(client, rtc);
 
 	rc = isl1208_i2c_get_sr(client);
@@ -674,7 +674,7 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		}
 	}
 
-	return 0;
+	return rtc_register_device(isl1208->rtc);
 }
 
 static int
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
