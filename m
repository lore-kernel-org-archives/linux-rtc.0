Return-Path: <SRS0=6w/U=QT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256AFC169C4
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 02:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FB3206BB
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 02:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="Hc8BP56t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfBLCeJ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:34:09 -0500
Received: from mail-eopbgr680127.outbound.protection.outlook.com ([40.107.68.127]:17120
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727265AbfBLCeJ (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 11 Feb 2019 21:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Kso0ZBpnVdRFBQQQ8s/ToPRDohy5SH//bY9XqVsH48=;
 b=Hc8BP56t9+aMbvWcDM3RRZXL/w8CaqgDrK2I22O/SacvHiO2N+NwZoJXR686hNqaZWzPtOTZIRtGJTNdIsxFiPXTpFRTOi7SYrggVs5efTWIYfLKwpzEV3ygK5ykmzm5pczCvybpGnmrnqKie4jo2rB+n5Sz3P2EYwHmtiZrJTE=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3659.namprd06.prod.outlook.com (10.167.236.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 02:34:04 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 02:34:04 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 2/4] rtc: isl1208: Support more chip variations
Thread-Topic: [PATCH v3 2/4] rtc: isl1208: Support more chip variations
Thread-Index: AQHUwntrkP4BjZWqmUSiQ9ihlQNpiA==
Date:   Tue, 12 Feb 2019 02:34:04 +0000
Message-ID: <20190212023225.2710-2-tpiepho@impinj.com>
References: <20190212023225.2710-1-tpiepho@impinj.com>
In-Reply-To: <20190212023225.2710-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32)
 To MWHPR0601MB3708.namprd06.prod.outlook.com (2603:10b6:301:7c::38)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.14.4
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f10d414-f64d-4ecf-1d5e-08d690928dc8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3659;
x-ms-traffictypediagnostic: MWHPR0601MB3659:
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3659;20:I5HRN22oB4oRzEbiU+3IeHTZgSfshaH4t3ObeWRK2EcwwAG2PXvkT2nVATtpnYgv1Q9CbkFgSLd1NLoIRHP6VP2TzOklD+75WNlDbpGR8Brmea31TvIrCK/NZg6qn3g/bQv2/m/YEnvsGs82JAnlqd+/8Z6J5RZPGSneVQPX1pc=
x-microsoft-antispam-prvs: <MWHPR0601MB3659629235C7B1D4291E887BD3650@MWHPR0601MB3659.namprd06.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(396003)(376002)(136003)(366004)(189003)(199004)(316002)(102836004)(66066001)(6486002)(25786009)(86362001)(6116002)(53936002)(1076003)(2351001)(26005)(386003)(6506007)(5640700003)(7736002)(3846002)(305945005)(106356001)(97736004)(50226002)(6512007)(6436002)(105586002)(4326008)(11346002)(446003)(52116002)(14454004)(8676002)(2501003)(2906002)(476003)(2616005)(256004)(6916009)(99286004)(71200400001)(36756003)(54906003)(68736007)(81156014)(478600001)(8936002)(76176011)(14444005)(486006)(186003)(71190400001)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3659;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uTGRV8TirjXYIhHkr0umrMjVJ5o7SGKI6fLpATWL9czG2pL8B+6vvdZ2aU9vzDuTxrAa0MC+OKDw3cJ0tazyEirBkxuGyywfkl/FeCLq32SP++HN23vBWntOUTYl+t+T/7x2WZPZSNHWaGJ2j44xaC/MSatHbiyptoyvb5RKr11d0NpWxNVUUFl3A7kaaqNziAXpK/PyGBUH/Qlb1vQRaLtgRzNr1Aei3nXwoGBJ5RoZu5VszQ/jPGKUqZY2kyPCaUAQLB7fQe/yar48YvYYvFokvD+dbWfgjpSho4VV08LpW7Phzs3eDIAkrxeEvc51SClIlExJGqHLQXzuFis3pGYjZg1ygAtW9m4WvUOudaZm8VBoRA4smg+WIhQdbiTcs2Qqr9RpyrFUMeViRYO1GYHuu3fF8klkk/Hy2W+z/Z8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f10d414-f64d-4ecf-1d5e-08d690928dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 02:34:03.5239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3659
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Add more support in the driver for dealing with differences in is1208
compatible chips.  Put the 1208, 1209, 1218, and 1219 in the list and
encode information about nvram size, tamper, and timestamp features.

This adds support for the isl1209, which has a tamper detect but no
timestamp feature.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/rtc/rtc-isl1208.c | 77 +++++++++++++++++++++++++++++++++----------=
----
 1 file changed, 55 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index d8e0670e12fc..036e5fc148d4 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -13,6 +13,7 @@
 #include <linux/bcd.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/rtc.h>
=20
@@ -73,15 +74,49 @@
 static struct i2c_driver isl1208_driver;
=20
 /* ISL1208 various variants */
-enum {
+enum isl1208_id {
 	TYPE_ISL1208 =3D 0,
+	TYPE_ISL1209,
 	TYPE_ISL1218,
 	TYPE_ISL1219,
+	ISL_LAST_ID
 };
=20
+/* Chip capabilities table */
+static const struct isl1208_config {
+	const char	name[8];
+	unsigned int	nvmem_length;
+	unsigned	has_tamper:1;
+	unsigned	has_timestamp:1;
+} isl1208_configs[] =3D {
+	[TYPE_ISL1208] =3D { "isl1208", 2, false, false },
+	[TYPE_ISL1209] =3D { "isl1209", 2, true,  false },
+	[TYPE_ISL1218] =3D { "isl1218", 8, false, false },
+	[TYPE_ISL1219] =3D { "isl1219", 2, true,  true },
+};
+
+static const struct i2c_device_id isl1208_id[] =3D {
+	{ "isl1208", TYPE_ISL1208 },
+	{ "isl1209", TYPE_ISL1209 },
+	{ "isl1218", TYPE_ISL1218 },
+	{ "isl1219", TYPE_ISL1219 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, isl1208_id);
+
+static const struct of_device_id isl1208_of_match[] =3D {
+	{ .compatible =3D "isil,isl1208", .data =3D &isl1208_configs[TYPE_ISL1208=
] },
+	{ .compatible =3D "isil,isl1209", .data =3D &isl1208_configs[TYPE_ISL1209=
] },
+	{ .compatible =3D "isil,isl1218", .data =3D &isl1208_configs[TYPE_ISL1218=
] },
+	{ .compatible =3D "isil,isl1219", .data =3D &isl1208_configs[TYPE_ISL1219=
] },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, isl1208_of_match);
+
 /* Device state */
 struct isl1208_state {
 	struct rtc_device *rtc;
+	const struct isl1208_config *config;
 };
=20
 /* block read */
@@ -602,11 +637,12 @@ isl1208_rtc_interrupt(int irq, void *data)
 			return err;
 	}
=20
-	if (sr & ISL1208_REG_SR_EVT) {
-		sysfs_notify(&isl1208->rtc->dev.kobj, NULL,
-			     dev_attr_timestamp0.attr.name);
+	if (isl1208->config->has_tamper && (sr & ISL1208_REG_SR_EVT)) {
 		dev_warn(&client->dev, "event detected");
 		handled =3D 1;
+		if (isl1208->config->has_timestamp)
+			sysfs_notify(&isl1208->rtc->dev.kobj, NULL,
+				     dev_attr_timestamp0.attr.name);
 	}
=20
 	return handled ? IRQ_HANDLED : IRQ_NONE;
@@ -743,6 +779,17 @@ isl1208_probe(struct i2c_client *client, const struct =
i2c_device_id *id)
 		return -ENOMEM;
 	i2c_set_clientdata(client, isl1208);
=20
+	/* Determine which chip we have */
+	if (client->dev.of_node) {
+		isl1208->config =3D of_device_get_match_data(&client->dev);
+		if (!isl1208->config)
+			return -ENODEV;
+	} else {
+		if (id->driver_data >=3D ISL_LAST_ID)
+			return -ENODEV;
+		isl1208->config =3D &isl1208_configs[id->driver_data];
+	}
+
 	isl1208->rtc =3D devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(isl1208->rtc))
 		return PTR_ERR(isl1208->rtc);
@@ -759,7 +806,7 @@ isl1208_probe(struct i2c_client *client, const struct i=
2c_device_id *id)
 		dev_warn(&client->dev, "rtc power failure detected, "
 			 "please set clock.\n");
=20
-	if (id->driver_data =3D=3D TYPE_ISL1219) {
+	if (isl1208->config->has_tamper) {
 		struct device_node *np =3D client->dev.of_node;
 		u32 evienb;
=20
@@ -780,10 +827,12 @@ isl1208_probe(struct i2c_client *client, const struct=
 i2c_device_id *id)
 			dev_err(&client->dev, "could not enable tamper detection\n");
 			return rc;
 		}
+		evdet_irq =3D of_irq_get_byname(np, "evdet");
+	}
+	if (isl1208->config->has_timestamp) {
 		rc =3D rtc_add_group(isl1208->rtc, &isl1219_rtc_sysfs_files);
 		if (rc)
 			return rc;
-		evdet_irq =3D of_irq_get_byname(np, "evdet");
 	}
=20
 	rc =3D rtc_add_group(isl1208->rtc, &isl1208_rtc_sysfs_files);
@@ -803,22 +852,6 @@ isl1208_probe(struct i2c_client *client, const struct =
i2c_device_id *id)
 	return rtc_register_device(isl1208->rtc);
 }
=20
-static const struct i2c_device_id isl1208_id[] =3D {
-	{ "isl1208", TYPE_ISL1208 },
-	{ "isl1218", TYPE_ISL1218 },
-	{ "isl1219", TYPE_ISL1219 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, isl1208_id);
-
-static const struct of_device_id isl1208_of_match[] =3D {
-	{ .compatible =3D "isil,isl1208" },
-	{ .compatible =3D "isil,isl1218" },
-	{ .compatible =3D "isil,isl1219" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, isl1208_of_match);
-
 static struct i2c_driver isl1208_driver =3D {
 	.driver =3D {
 		.name =3D "rtc-isl1208",
--=20
2.14.4

