Return-Path: <rtc-linux+bncBDU7VC56WAFBBC5Y463AKGQEBHXKLGA@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id m72si8489wma.3.2016.03.04.11.03.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 11:03:39 -0800 (PST)
Date: Fri, 4 Mar 2016 19:56:11 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 4/6] rtc-rv3029: Add i2c register update-bits helper
Message-ID: <20160304195611.48d5177b@wiggum>
In-Reply-To: <20160304195337.51439645@wiggum>
References: <20160301213322.661fe771@wiggum>
	<20160301213655.GG23985@piout.net>
	<20160301225401.3f0aeabb@wiggum>
	<20160301230745.GJ23985@piout.net>
	<20160302072627.14e53e94@wiggum>
	<20160302120045.GO23985@piout.net>
	<20160304195337.51439645@wiggum>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UmNahiIwkikWD7lGh6+/sEj"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/UmNahiIwkikWD7lGh6+/sEj
Content-Type: text/plain; charset=UTF-8

This simplifies mask/set operations on device I2C registers.

Signed-off-by: Michael Buesch <m@bues.ch>
---
 drivers/rtc/rtc-rv3029c2.c | 54 ++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 29cc871..769f73a 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -2,6 +2,7 @@
  * Micro Crystal RV-3029 rtc class driver
  *
  * Author: Gregory Hermant <gregory.hermant@calao-systems.com>
+ *         Michael Buesch <m@bues.ch>
  *
  * based on previously existing rtc class drivers
  *
@@ -143,6 +144,24 @@ rv3029_i2c_write_regs(struct i2c_client *client, u8 reg, u8 const buf[],
 }
 
 static int
+rv3029_i2c_update_bits(struct i2c_client *client, u8 reg, u8 mask, u8 set)
+{
+	u8 buf;
+	int ret;
+
+	ret = rv3029_i2c_read_regs(client, reg, &buf, 1);
+	if (ret < 0)
+		return ret;
+	buf &= mask;
+	buf |= set;
+	ret = rv3029_i2c_write_regs(client, reg, &buf, 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int
 rv3029_i2c_get_sr(struct i2c_client *client, u8 *buf)
 {
 	int ret = rv3029_i2c_read_regs(client, RV3029_STATUS, buf, 1);
@@ -260,22 +279,13 @@ static int rv3029_rtc_i2c_alarm_set_irq(struct i2c_client *client,
 					int enable)
 {
 	int ret;
-	u8 buf[1];
-
-	/* enable AIE irq */
-	ret = rv3029_i2c_read_regs(client, RV3029_IRQ_CTRL, buf, 1);
-	if (ret < 0) {
-		dev_err(&client->dev, "can't read INT reg\n");
-		return ret;
-	}
-	if (enable)
-		buf[0] |= RV3029_IRQ_CTRL_AIE;
-	else
-		buf[0] &= ~RV3029_IRQ_CTRL_AIE;
 
-	ret = rv3029_i2c_write_regs(client, RV3029_IRQ_CTRL, buf, 1);
+	/* enable/disable AIE irq */
+	ret = rv3029_i2c_update_bits(client, RV3029_IRQ_CTRL,
+				     (u8)~RV3029_IRQ_CTRL_AIE,
+				     (enable ? RV3029_IRQ_CTRL_AIE : 0));
 	if (ret < 0) {
-		dev_err(&client->dev, "can't set INT reg\n");
+		dev_err(&client->dev, "can't update INT reg\n");
 		return ret;
 	}
 
@@ -316,20 +326,11 @@ static int rv3029_rtc_i2c_set_alarm(struct i2c_client *client,
 		return ret;
 
 	if (alarm->enabled) {
-		u8 buf[1];
-
 		/* clear AF flag */
-		ret = rv3029_i2c_read_regs(client, RV3029_IRQ_FLAGS,
-					   buf, 1);
-		if (ret < 0) {
-			dev_err(&client->dev, "can't read alarm flag\n");
-			return ret;
-		}
-		buf[0] &= ~RV3029_IRQ_FLAGS_AF;
-		ret = rv3029_i2c_write_regs(client, RV3029_IRQ_FLAGS,
-					    buf, 1);
+		ret = rv3029_i2c_update_bits(client, RV3029_IRQ_FLAGS,
+					     (u8)~RV3029_IRQ_FLAGS_AF, 0);
 		if (ret < 0) {
-			dev_err(&client->dev, "can't set alarm flag\n");
+			dev_err(&client->dev, "can't clear alarm flag\n");
 			return ret;
 		}
 		/* enable AIE irq */
@@ -454,5 +455,6 @@ static struct i2c_driver rv3029_driver = {
 module_i2c_driver(rv3029_driver);
 
 MODULE_AUTHOR("Gregory Hermant <gregory.hermant@calao-systems.com>");
+MODULE_AUTHOR("Michael Buesch <m@bues.ch>");
 MODULE_DESCRIPTION("Micro Crystal RV3029 RTC driver");
 MODULE_LICENSE("GPL");
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

--Sig_/UmNahiIwkikWD7lGh6+/sEj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2dpLAAoJEPUyvh2QjYsOp7AP/2e65jEVr+S+d35w8JwuwIJ5
mB8Oue0Wo87UkX+oofwgNUfKV10+w8/M41nXcwReeWxg+J7dEIsJk24S/AgsWUEU
jssLt5ueFYA0G/L6CIlTBWjvIFoQ8DzKYVuQ8ASjGdmSHT+KGwjTb0eErsWFV+pJ
HOswStcE/FC+fJWnfHiUTJLJUDNZqs3UXX4jzmx/qXXyaRaUTq/IWXlA/OUaUyFS
pRi59SgwmctyvoM9xQx5WkqFgFUx7PwNeH/bCx9i+rxhRoZpPVWOMwarQaPCm92h
hmFIxOjPoUH2wRKPw6b23NkZAF+5Cw+o3+4JkZNO5c8/Cf6UdjBhyrec8PlwVhlw
cj/9yoPb1sa8ZDfBbQ54M91mY+1qW8loaOr1D3+RrMfrrtZ6y1+1KLJvlyo7k0vf
hv06CxgPW65YfoPFB3ixwUV7gmzyDREMuxXJJfVR5rP5A5vJrvNEK2+UtUtr+9w4
bvFBGt/3o/kwpU2LvFKLIHcr64+pYS+zgD4Vg9LyVGXZm16rSHGHBmUwtvBZyObY
gElIjhZJbo5IXuLlMJvnszZAqKhp/SCBdM3D+hO2KtVXGjYfaNf7MXDNVFvt2CBt
sYXQ4ZPTabnr+Se0bikGPrTQ4xyNJbxOC+CMGKgC5TjYx6DfDHg3AFapEEa3tGTk
+otL5M+WRr3ROm2CLgl0
=XHcR
-----END PGP SIGNATURE-----

--Sig_/UmNahiIwkikWD7lGh6+/sEj--
