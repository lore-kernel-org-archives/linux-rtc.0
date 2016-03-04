Return-Path: <rtc-linux+bncBDU7VC56WAFBBDFY463AKGQE2W64HGA@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id c140si17783wmh.1.2016.03.04.11.03.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 11:03:40 -0800 (PST)
Date: Fri, 4 Mar 2016 19:56:54 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 6/6] rtc-rv3029: Add device tree property for
 trickle charger
Message-ID: <20160304195654.578b8f6c@wiggum>
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
 boundary="Sig_/LF5hyk+VpZutbNj+4ko3_cs"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/LF5hyk+VpZutbNj+4ko3_cs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The trickle charger resistor can be enabled via device tree
property trickle-resistor-ohms.

Signed-off-by: Michael Buesch <m@bues.ch>
---
 drivers/rtc/rtc-rv3029c2.c | 106 +++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index fb85e0d..8a4e55a 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -10,9 +10,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * NOTE: Currently this driver only supports the bare minimum for read
- * and write the RTC and alarms. The extra features provided by this chip
- * (trickle charger, eeprom, T=C2=B0 compensation) are unavailable.
  */
=20
 #include <linux/module.h>
@@ -527,6 +524,107 @@ static int rv3029_rtc_set_time(struct device *dev, st=
ruct rtc_time *tm)
 	return rv3029_i2c_set_time(to_i2c_client(dev), tm);
 }
=20
+static const struct rv3029_trickle_tab_elem {
+	u32 r;		/* resistance in ohms */
+	u8 conf;	/* trickle config bits */
+} rv3029_trickle_tab[] =3D {
+	{
+		.r	=3D 1076,
+		.conf	=3D RV3029_TRICKLE_1K | RV3029_TRICKLE_5K |
+			  RV3029_TRICKLE_20K | RV3029_TRICKLE_80K,
+	}, {
+		.r	=3D 1091,
+		.conf	=3D RV3029_TRICKLE_1K | RV3029_TRICKLE_5K |
+			  RV3029_TRICKLE_20K,
+	}, {
+		.r	=3D 1137,
+		.conf	=3D RV3029_TRICKLE_1K | RV3029_TRICKLE_5K |
+			  RV3029_TRICKLE_80K,
+	}, {
+		.r	=3D 1154,
+		.conf	=3D RV3029_TRICKLE_1K | RV3029_TRICKLE_5K,
+	}, {
+		.r	=3D 1371,
+		.conf	=3D RV3029_TRICKLE_1K | RV3029_TRICKLE_20K |
+			  RV3029_TRICKLE_80K,
+	}, {
+		.r	=3D 1395,
+		.conf	=3D RV3029_TRICKLE_1K | RV3029_TRICKLE_20K,
+	}, {
+		.r	=3D 1472,
+		.conf	=3D RV3029_TRICKLE_1K | RV3029_TRICKLE_80K,
+	}, {
+		.r	=3D 1500,
+		.conf	=3D RV3029_TRICKLE_1K,
+	}, {
+		.r	=3D 3810,
+		.conf	=3D RV3029_TRICKLE_5K | RV3029_TRICKLE_20K |
+			  RV3029_TRICKLE_80K,
+	}, {
+		.r	=3D 4000,
+		.conf	=3D RV3029_TRICKLE_5K | RV3029_TRICKLE_20K,
+	}, {
+		.r	=3D 4706,
+		.conf	=3D RV3029_TRICKLE_5K | RV3029_TRICKLE_80K,
+	}, {
+		.r	=3D 5000,
+		.conf	=3D RV3029_TRICKLE_5K,
+	}, {
+		.r	=3D 16000,
+		.conf	=3D RV3029_TRICKLE_20K | RV3029_TRICKLE_80K,
+	}, {
+		.r	=3D 20000,
+		.conf	=3D RV3029_TRICKLE_20K,
+	}, {
+		.r	=3D 80000,
+		.conf	=3D RV3029_TRICKLE_80K,
+	},
+};
+
+static void rv3029_trickle_config(struct i2c_client *client)
+{
+	struct device_node *of_node =3D client->dev.of_node;
+	const struct rv3029_trickle_tab_elem *elem;
+	int i, err;
+	u32 ohms;
+	u8 eectrl;
+
+	if (!of_node)
+		return;
+
+	/* Configure the trickle charger. */
+	err =3D rv3029_eeprom_read(client, RV3029_CONTROL_E2P_EECTRL,
+				 &eectrl, 1);
+	if (err < 0) {
+		dev_err(&client->dev,
+			"Failed to read trickle charger config\n");
+		return;
+	}
+	err =3D of_property_read_u32(of_node, "trickle-resistor-ohms", &ohms);
+	if (err) {
+		/* Disable trickle charger. */
+		eectrl &=3D ~RV3029_TRICKLE_MASK;
+	} else {
+		/* Enable trickle charger. */
+		for (i =3D 0; i < ARRAY_SIZE(rv3029_trickle_tab); i++) {
+			elem =3D &rv3029_trickle_tab[i];
+			if (elem->r >=3D ohms)
+				break;
+		}
+		eectrl &=3D ~RV3029_TRICKLE_MASK;
+		eectrl |=3D elem->conf;
+		dev_info(&client->dev,
+			 "Trickle charger enabled at %d ohms resistance.\n",
+			 elem->r);
+	}
+	err =3D rv3029_eeprom_write(client, RV3029_CONTROL_E2P_EECTRL,
+				  &eectrl, 1);
+	if (err < 0) {
+		dev_err(&client->dev,
+			"Failed to write trickle charger config\n");
+	}
+}
+
 static const struct rtc_class_ops rv3029_rtc_ops =3D {
 	.read_time	=3D rv3029_rtc_read_time,
 	.set_time	=3D rv3029_rtc_set_time,
@@ -557,6 +655,8 @@ static int rv3029_probe(struct i2c_client *client,
 		return rc;
 	}
=20
+	rv3029_trickle_config(client);
+
 	rtc =3D devm_rtc_device_register(&client->dev, client->name,
 				       &rv3029_rtc_ops, THIS_MODULE);
=20
--=20
2.7.0

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--Sig_/LF5hyk+VpZutbNj+4ko3_cs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2dp2AAoJEPUyvh2QjYsOdqsP/1QBGqqdhOQgYMQ0sKp0s99Z
55wXVjWxakAAlh3dlqd04tQ5YpPNiN4I7/RgNTT1EWI2ihFWvcwwwS/WLICycAZx
LvIYrO6azDQIBeLSmdqEEo0CStU7+sbPYwFiNchrZlaBowBKFElgM0Eb7iSaJp61
21M6E1xN9TqUlD20LT8i+Gf5NNAAAUkt00z0w4LB1/Tsj0uJ4DiVyDxl4wjvyLyY
Pa09QtmTMH40GV6bkY23ppfA079CKWsjQWWT862dtOZV/P4eB+zF6SSSdQEFyKj2
FVSOjbjZE5ArGiqnpVE2jWKbiBDWcptIydANPlwnKDrxHYyHCYlybUd8HFA1Ea2+
4snqfjOKZolOKhS7z8o+BKBCgX5h+i8T6Hz37EHWeOvaIBp4fPpAAwN3HQA7xi0W
4ya8uxTP35c1cZ58I6ghdw8EdQxLU05fLpTRzSXiAv8r2AOfrxeJLY9KSbopcu/o
7HIj8IkaiWwQGpTn10Pi9WBngo47JvIbMM9PCs9ku6aO5Ox39/XXuBaMLdcu1Wxv
UNb7JZldhEm+del/3vG5KeKXe+5BJJsnVekCTqnaqr9jtCfy0fokvwsZ1Z2DehR8
AjTVMfLjaPbemfqMCjYgufiJAJ2PqQ8Kvly1mC5Ds8ZGmCLXlBwiYADK5HVl9IeG
UKh2bTbn4iMElxuTIAYt
=vBDU
-----END PGP SIGNATURE-----

--Sig_/LF5hyk+VpZutbNj+4ko3_cs--
