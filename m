Return-Path: <rtc-linux+bncBDU7VC56WAFBBPMD5C3AKGQELBMWIMA@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id 71si167586wmp.0.2016.03.04.13.44.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 13:44:29 -0800 (PST)
Date: Fri, 4 Mar 2016 22:40:55 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH v3 5/6] rtc-rv3029: Add functions for EEPROM access
Message-ID: <20160304224055.37423933@wiggum>
In-Reply-To: <20160304195632.5c620851@wiggum>
References: <20160301213322.661fe771@wiggum>
	<20160301213655.GG23985@piout.net>
	<20160301225401.3f0aeabb@wiggum>
	<20160301230745.GJ23985@piout.net>
	<20160302072627.14e53e94@wiggum>
	<20160302120045.GO23985@piout.net>
	<20160304195337.51439645@wiggum>
	<20160304195632.5c620851@wiggum>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qMCqVtm1y4_ACiSmm=VWeYh"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/qMCqVtm1y4_ACiSmm=VWeYh
Content-Type: text/plain; charset=UTF-8

This adds functions for access to the EEPROM memory on the rv3029.

Signed-off-by: Michael Buesch <m@bues.ch>
---
 drivers/rtc/rtc-rv3029c2.c | 125 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index a58188e..e59b8a5 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -19,6 +19,9 @@
 #include <linux/i2c.h>
 #include <linux/bcd.h>
 #include <linux/rtc.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+
 
 /* Register map */
 /* control section */
@@ -186,6 +189,128 @@ rv3029_i2c_set_sr(struct i2c_client *client, u8 val)
 	return 0;
 }
 
+static int rv3029_eeprom_busywait(struct i2c_client *client)
+{
+	int i, ret;
+	u8 sr;
+
+	for (i = 100; i > 0; i--) {
+		ret = rv3029_i2c_get_sr(client, &sr);
+		if (ret < 0)
+			break;
+		if (!(sr & RV3029_STATUS_EEBUSY))
+			break;
+		usleep_range(1000, 10000);
+	}
+	if (i <= 0) {
+		dev_err(&client->dev, "EEPROM busy wait timeout.\n");
+		return -ETIMEDOUT;
+	}
+
+	return ret;
+}
+
+static int rv3029_eeprom_exit(struct i2c_client *client)
+{
+	/* Re-enable eeprom refresh */
+	return rv3029_i2c_update_bits(client, RV3029_ONOFF_CTRL,
+				      RV3029_ONOFF_CTRL_EERE,
+				      RV3029_ONOFF_CTRL_EERE);
+}
+
+static int rv3029_eeprom_enter(struct i2c_client *client)
+{
+	int ret;
+	u8 sr;
+
+	/* Check whether we are in the allowed voltage range. */
+	ret = rv3029_i2c_get_sr(client, &sr);
+	if (ret < 0)
+		return ret;
+	if (sr & (RV3029_STATUS_VLOW1 | RV3029_STATUS_VLOW2)) {
+		/* We clear the bits and retry once just in case
+		 * we had a brown out in early startup.
+		 */
+		sr &= ~RV3029_STATUS_VLOW1;
+		sr &= ~RV3029_STATUS_VLOW2;
+		ret = rv3029_i2c_set_sr(client, sr);
+		if (ret < 0)
+			return ret;
+		usleep_range(1000, 10000);
+		ret = rv3029_i2c_get_sr(client, &sr);
+		if (ret < 0)
+			return ret;
+		if (sr & (RV3029_STATUS_VLOW1 | RV3029_STATUS_VLOW2)) {
+			dev_err(&client->dev,
+				"Supply voltage is too low to safely access the EEPROM.\n");
+			return -ENODEV;
+		}
+	}
+
+	/* Disable eeprom refresh. */
+	ret = rv3029_i2c_update_bits(client, RV3029_ONOFF_CTRL,
+				     RV3029_ONOFF_CTRL_EERE, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Wait for any previous eeprom accesses to finish. */
+	ret = rv3029_eeprom_busywait(client);
+	if (ret < 0)
+		rv3029_eeprom_exit(client);
+
+	return ret;
+}
+
+static int rv3029_eeprom_read(struct i2c_client *client, u8 reg,
+			      u8 buf[], size_t len)
+{
+	int ret, err;
+
+	err = rv3029_eeprom_enter(client);
+	if (err < 0)
+		return err;
+
+	ret = rv3029_i2c_read_regs(client, reg, buf, len);
+
+	err = rv3029_eeprom_exit(client);
+	if (err < 0)
+		return err;
+
+	return ret;
+}
+
+static int rv3029_eeprom_write(struct i2c_client *client, u8 reg,
+			       u8 const buf[], size_t len)
+{
+	int ret, err;
+	size_t i;
+	u8 tmp;
+
+	err = rv3029_eeprom_enter(client);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < len; i++, reg++) {
+		ret = rv3029_i2c_read_regs(client, reg, &tmp, 1);
+		if (ret < 0)
+			break;
+		if (tmp != buf[i]) {
+			ret = rv3029_i2c_write_regs(client, reg, &buf[i], 1);
+			if (ret < 0)
+				break;
+		}
+		ret = rv3029_eeprom_busywait(client);
+		if (ret < 0)
+			break;
+	}
+
+	err = rv3029_eeprom_exit(client);
+	if (err < 0)
+		return err;
+
+	return ret;
+}
+
 static int
 rv3029_i2c_read_time(struct i2c_client *client, struct rtc_time *tm)
 {
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

--Sig_/qMCqVtm1y4_ACiSmm=VWeYh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2gDnAAoJEPUyvh2QjYsOazAQAMFYZNA/BNbWzmfblluwn9DV
YafVjcEBoYU4ynI37W4Rq4dTWgNKqRYHjwsIo4kyjixspMkvY5Sh4GrDeyA9Wfmf
sDgehbg6oy+dRdpA381u0MlzrXUvVJGKMuP5KQyWjnI7V3aqx9PNOV1d8pih0skc
U2YI2bPB4ScG0xzfNVjvcIYzRpBBM+BwsVmP80lKs25OswELleq4rL5mQuNVYNat
G3MYzh8fO9hW9F1G+SmlO52UaH3BVlbmFLh4NAgXsFVT/Rr8wMYgesff+yvU0Q+u
FsJi2ocYCi/g7s7PbKcy2WF7MB8A9fLe2Ut9fz39uZ5hKGfS/SVjyx3OwZZOMLok
RBy/+634+fDdczR/njWG9XX3C2egq8bacTxZCyTR2v6OjgPGo3uFNHnxxcFmsvn3
dizu9xztBATkL4+svd9iPKbacI0cfvVkZig8hLPGXVYYtjvtisq3QpO1IikDWstz
g5xfaeG1kRRQuD6HxbcudHWEizFpf2ldfaPPujsrzi8QriYUXH0EqmcoznZq8R1q
MX57Na86C8CN1m2yk0YihD0gRqZN6IWo1F8udnEMXZQZo3LX3SJxQ27JrXFOpgaV
1JyZ8+M6TgUJoV1gurK0FCXprqsXPtLAWTg7j7htfW6TGjakoOH/hTHbIoGanJAx
6kGfn2GLHql3ar10Dvkm
=fXav
-----END PGP SIGNATURE-----

--Sig_/qMCqVtm1y4_ACiSmm=VWeYh--
