Return-Path: <rtc-linux+bncBAABBOEQVPBAKGQEQZLRCUI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from vba ([213.132.98.41])
        by gmr-mx.google.com with ESMTPS id l66si1909044wml.0.2016.12.09.07.05.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2016 07:05:28 -0800 (PST)
From: Volodymyr Bendiuga <volodymyr.bendiuga@westermo.se>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rtc-linux@googlegroups.com,
        devicetree@vger.kernel.org, volodymyr.bendiuga@gmail.com
Cc: =?UTF-8?q?Mattias=20Walstr=C3=B6m?= <mattias.walstrom@westermo.se>,
        Volodymyr Bendiuga <volodymyr.bendiuga@westermo.se>
Subject: [rtc-linux] [PATCH] rtc: pcf8563: Do not disable clk out by default
Date: Fri,  9 Dec 2016 16:03:49 +0100
Message-Id: <1481295829-21974-1-git-send-email-volodymyr.bendiuga@westermo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Mattias Walstr=C3=B6m <mattias.walstrom@westermo.se>

Commit a39a6405d5f949bc651694028a disables CLKOUT of
the rtc after power-up to improve power consumption.
This is very useful, but some designs do require to
have the rtc on all the time, otherwise devices will
be bricked. Therefore this patch is a compromise that
works for both cases, where the default case is when
CLKOUT is on. If one wants to disable the CLKOUT,
clkout-allow-disable can be added to devicetree's rtc node.

Signed-off-by: Volodymyr Bendiuga <volodymyr.bendiuga@westermo.se>
---
 Documentation/devicetree/bindings/rtc/pcf8563.txt |  1 +
 drivers/rtc/rtc-pcf8563.c                         | 11 +++--------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/pcf8563.txt b/Documentat=
ion/devicetree/bindings/rtc/pcf8563.txt
index 086c998..0b06a36 100644
--- a/Documentation/devicetree/bindings/rtc/pcf8563.txt
+++ b/Documentation/devicetree/bindings/rtc/pcf8563.txt
@@ -7,6 +7,7 @@ see: Documentation/devicetree/bindings/i2c/trivial-admin-gu=
ide/devices.rst
=20
 Optional property:
 - #clock-cells: Should be 0.
+- clkout-allow-disable: Allow the CLKOUT to be disabled if not used.
 - clock-output-names:
   overwrite the default clock name "pcf8563-clkout"
=20
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 1227cea..1489ee9 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -519,18 +519,13 @@ static struct clk *pcf8563_clkout_register_clk(struct=
 pcf8563 *pcf8563)
 	struct device_node *node =3D client->dev.of_node;
 	struct clk *clk;
 	struct clk_init_data init;
-	int ret;
-	unsigned char buf;
-
-	/* disable the clkout output */
-	buf =3D 0;
-	ret =3D pcf8563_write_block_data(client, PCF8563_REG_CLKO, 1, &buf);
-	if (ret < 0)
-		return ERR_PTR(ret);
=20
 	init.name =3D "pcf8563-clkout";
 	init.ops =3D &pcf8563_clkout_ops;
+
+	/* disable the clkout output only if it is allowed in devicetree */
 	init.flags =3D 0;
+	init.flags |=3D !of_property_read_bool(node, "clkout-allow-disable") ? CL=
K_IGNORE_UNUSED : 0;
 	init.parent_names =3D NULL;
 	init.num_parents =3D 0;
 	pcf8563->clkout_hw.init =3D &init;
--=20
2.7.4

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
