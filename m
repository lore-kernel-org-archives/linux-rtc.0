Return-Path: <rtc-linux+bncBDU7VC56WAFBBXHBQ23QKGQEHXP6PWY@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id c140si195230wmh.1.2016.03.10.09.37.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Mar 2016 09:37:31 -0800 (PST)
Date: Thu, 10 Mar 2016 18:34:23 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 1/2] rtc: rv3029: Add update_bits helper for
 eeprom access
Message-ID: <20160310183423.12a02e1f@wiggum>
In-Reply-To: <20160310183346.73aa0f24@wiggum>
References: <20160310183346.73aa0f24@wiggum>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wIGUD1admWT0U2XD/i7K95O"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/wIGUD1admWT0U2XD/i7K95O
Content-Type: text/plain; charset=UTF-8

This simplifies the update of single bits in the eeprom.

Signed-off-by: Michael Buesch <m@bues.ch>
---
 drivers/rtc/rtc-rv3029c2.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index b416ed0..3bbb581 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -308,6 +308,24 @@ static int rv3029_eeprom_write(struct i2c_client *client, u8 reg,
 	return ret;
 }
 
+static int rv3029_eeprom_update_bits(struct i2c_client *client,
+				     u8 reg, u8 mask, u8 set)
+{
+	u8 buf;
+	int ret;
+
+	ret = rv3029_eeprom_read(client, reg, &buf, 1);
+	if (ret < 0)
+		return ret;
+	buf &= ~mask;
+	buf |= set & mask;
+	ret = rv3029_eeprom_write(client, reg, &buf, 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int
 rv3029_i2c_read_time(struct i2c_client *client, struct rtc_time *tm)
 {
@@ -588,23 +606,16 @@ static void rv3029_trickle_config(struct i2c_client *client)
 	const struct rv3029_trickle_tab_elem *elem;
 	int i, err;
 	u32 ohms;
-	u8 eectrl;
+	u8 trickle_set_bits;
 
 	if (!of_node)
 		return;
 
 	/* Configure the trickle charger. */
-	err = rv3029_eeprom_read(client, RV3029_CONTROL_E2P_EECTRL,
-				 &eectrl, 1);
-	if (err < 0) {
-		dev_err(&client->dev,
-			"Failed to read trickle charger config\n");
-		return;
-	}
 	err = of_property_read_u32(of_node, "trickle-resistor-ohms", &ohms);
 	if (err) {
 		/* Disable trickle charger. */
-		eectrl &= ~RV3029_TRICKLE_MASK;
+		trickle_set_bits = 0;
 	} else {
 		/* Enable trickle charger. */
 		for (i = 0; i < ARRAY_SIZE(rv3029_trickle_tab); i++) {
@@ -612,17 +623,17 @@ static void rv3029_trickle_config(struct i2c_client *client)
 			if (elem->r >= ohms)
 				break;
 		}
-		eectrl &= ~RV3029_TRICKLE_MASK;
-		eectrl |= elem->conf;
+		trickle_set_bits = elem->conf;
 		dev_info(&client->dev,
 			 "Trickle charger enabled at %d ohms resistance.\n",
 			 elem->r);
 	}
-	err = rv3029_eeprom_write(client, RV3029_CONTROL_E2P_EECTRL,
-				  &eectrl, 1);
+	err = rv3029_eeprom_update_bits(client, RV3029_CONTROL_E2P_EECTRL,
+					RV3029_TRICKLE_MASK,
+					trickle_set_bits);
 	if (err < 0) {
 		dev_err(&client->dev,
-			"Failed to write trickle charger config\n");
+			"Failed to update trickle charger config\n");
 	}
 }
 
-- 
2.7.0

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

--Sig_/wIGUD1admWT0U2XD/i7K95O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4bAfAAoJEPUyvh2QjYsOkh8P/27RDalOfPrn6DYvnyM20MGR
cxhYTZUj9Ct+7LhOr5KOr2ctdloGvePVh6Pbbu+Ieo556ZU4Zp4ZalpT6HDxHxqd
zaEi0GulTRKs7cUMj7yCP+ADbqh+rXortGyznf4QQYckbpeJ8y4n/b9R/16g0ks8
rNPIuDldc0yIpqZ6w5k5MPaoRAuK0dfIp4ROFBNbL660iWhbRx0RdZV4aX6r2hzT
Pc+z4KxZiqqlNt9teG/SGJVlbEz8TBDuQi5qLz9eQTckRAQLXmR8xbkKYSs/g/A2
yy09MT7V+7/+b0+RqHUSHBjFXYKnccOBM1bGxbxhVW0jNt3buv2/gUYIdKMTcuLH
KvbyVxL7sQemnhYzcoTNkdEBXlZHmWGl5+ayx4W2jV6gLWu9QLuaEoCGZZ7OGwbT
m6V1PEiBMUtt060WkXnZ+68TcHsEdAq5hwwv6P/bBMuT97F1/k1ebfLKT0z9cW+/
5sg1b4UdZ9MZzE31c/6bqDd2s4u1Y5oeVudKDTxMlMPobCcunQVnYhHn8KjN13db
27zDCsQ+1AZi4LsICO4R1d9S5Y+Lrs1z/ayc8oDZIMEBAHVk0wShSiOpusA/ShQG
LeTxjB8cbGPl6x2tmUOV+ytMs9gmo5LA0iQjz7iKhUunvrmLWWDhoQp5VaY25tV6
rmH1q6Lh8IbZXhwub74A
=gtOb
-----END PGP SIGNATURE-----

--Sig_/wIGUD1admWT0U2XD/i7K95O--
