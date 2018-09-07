Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35714 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIHAS3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 7 Sep 2018 20:18:29 -0400
From: Sam Ravnborg <sam@ravnborg.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v1 4/5] rtc: pcf8523: external capacitor configuration
Date: Fri,  7 Sep 2018 21:35:07 +0200
Message-Id: <20180907193508.24974-5-sam@ravnborg.org>
In-Reply-To: <20180822183555.GA24084@ravnborg.org>
References: <20180822183555.GA24084@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Søren Andersen <san@skov.dk>

Add support for specifying the quartz load in the DT node.
The pcf8523 may use either a 7 pF or an 12.5 pF xtal.
If the rtc has the wrong configuration the time will
drift several hours/week.

If nothing is specified in DT then the factory default of 7 pF is used.
This is a change compared to before where the driver assumed 12.5 pF.

Note: all kernel dts trees are updated with the new property.

Signed-off-by: Søren Andersen <san@skov.dk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf8523.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index 453615f8ac9a..3c19b4d21a2d 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -85,7 +85,7 @@ static int pcf8523_write(struct i2c_client *client, u8 reg, u8 value)
 	return 0;
 }
 
-static int pcf8523_select_capacitance(struct i2c_client *client, bool high)
+static int pcf8523_select_capacitance(struct i2c_client *client)
 {
 	u8 value;
 	int err;
@@ -94,7 +94,7 @@ static int pcf8523_select_capacitance(struct i2c_client *client, bool high)
 	if (err < 0)
 		return err;
 
-	if (!high)
+	if (!device_property_present(&client->dev, "nxp,quartz_load_12.5pf"))
 		value &= ~REG_CONTROL1_CAP_SEL;
 	else
 		value |= REG_CONTROL1_CAP_SEL;
@@ -331,7 +331,7 @@ static int pcf8523_probe(struct i2c_client *client,
 	if (!pcf)
 		return -ENOMEM;
 
-	err = pcf8523_select_capacitance(client, true);
+	err = pcf8523_select_capacitance(client);
 	if (err < 0)
 		return err;
 
-- 
2.12.0
