Return-Path: <SRS0=fWeB=QI=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB46C282DA
	for <linux-rtc@archiver.kernel.org>; Fri,  1 Feb 2019 19:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945AD21872
	for <linux-rtc@archiver.kernel.org>; Fri,  1 Feb 2019 19:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="PK62cZRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfBATmv (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:42:51 -0500
Received: from mail-eopbgr750125.outbound.protection.outlook.com ([40.107.75.125]:51290
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729332AbfBATmv (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 1 Feb 2019 14:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wbcSSmyGM4zGmzGahk7eZpry+L7MP4ORS8T8Me+NcM=;
 b=PK62cZRK4NwcbGJwtiZrAxYkXt/9fdLaICeVNj5VEidvhk3vgwOEz8AWpSzqpulzFJPNJA1M6M4RkhzNrspQt0YSNl6VVyFEfK0uKM/oVogCa8/hfkctJh3QbgY66wqnEV5Tbv3hHHmZCtUtUxfS6fY0Y7jLzPXuqstUq4i8LGU=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3707.namprd06.prod.outlook.com (10.167.236.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Fri, 1 Feb 2019 19:42:12 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 19:42:12 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: isl1208: Support more chip variations
Thread-Topic: [PATCH 2/3] rtc: isl1208: Support more chip variations
Thread-Index: AQHUumY6Zh3btsQK1Ee52DDoz6OY/A==
Date:   Fri, 1 Feb 2019 19:42:12 +0000
Message-ID: <20190201194147.25885-2-tpiepho@impinj.com>
References: <20190201194147.25885-1-tpiepho@impinj.com>
In-Reply-To: <20190201194147.25885-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:40::42) To MWHPR0601MB3708.namprd06.prod.outlook.com
 (2603:10b6:301:7c::38)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.14.4
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3707;6:isM/Z4IUimEea4CIXv5bAlyGvuQxe8dn4sKjuw3qIMnkkiCDb3IqlnsjRZdjf+X5T/xHUO27AG3Wpo/mj2y/rtl5j1ofwMudYGuceNcQSDmoxECtwugrm/GkCvI23SIUGA/kQhRobh+J4VdO1d+XW0j3StwdrcCI9H1Tuij1x6dKV93azBs88mlNHEUkimBTe0a9ajnyN8LjjQp1Zm8TJROg6fELkjzCdHTE9CgoH/erty0O0LXyVX6efew8AabMkmIASmfbeJtr7aK9KPbtby5IySG+vwj0NfBheeKPhf1HjblD4fuRD0i/HaJ2ZnBRR6s7zVsAaWgbf/K1Nn+1rOMQcUbLzM0l9UKomhcXd3Qj9Xan+if9tH66Q0maWBY9l5z/lbqx/jVvzykoQT3ojxdLh3zrCLehJtwOugUYNGcmRR9m8nzX71eWHP6qsUP/TdlR1VZlxZJGh/y2xHD0Pw==;5:/NPMTDJn3/Rs5L/5syanASK2/WM9mrwl0pDpS87qH3FtJlVwM1rASuT8mbXk8pm9Cv0KzhIdOWYkEesoTDPgByjP8O6AusLZRKdIrT9vFBv3k0/KUhPDd+lrEQ4uCxoqLpUIVU6hBLchQcBkNy5eFb20LVnVhB3cJCxOR5jvfasxzZ1PB46Y5lxro2Y2vVAvWdUBAl8zapKZYmPw1zLtNQ==;7:68rWP2d1sm/qEyhKPC7vqUFcvSoct8P48khUpTH2yPS5tObvea+hoESEwe9TOX8G/7ngPoFSJ+HJfQKCgCQqbmyzkYYm4X2ilWw01DdNUnrKVKKz2ua9a3hxq6TQONdiLYPsoLPrl4vrZG/Tr8uFTw==
x-ms-office365-filtering-correlation-id: 22235c20-e7dc-40de-5602-08d6887d5c6a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3707;
x-ms-traffictypediagnostic: MWHPR0601MB3707:
x-microsoft-antispam-prvs: <MWHPR0601MB37078A9C35336070E63CCCE6D3920@MWHPR0601MB3707.namprd06.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(346002)(396003)(366004)(136003)(199004)(189003)(106356001)(54906003)(105586002)(316002)(97736004)(99286004)(52116002)(76176011)(2906002)(478600001)(6512007)(5640700003)(14454004)(6486002)(6916009)(6436002)(53936002)(8936002)(36756003)(3846002)(6116002)(50226002)(2351001)(68736007)(2501003)(102836004)(386003)(6506007)(86362001)(26005)(25786009)(1076003)(81166006)(305945005)(14444005)(11346002)(256004)(66066001)(8676002)(2616005)(7736002)(446003)(476003)(71190400001)(186003)(71200400001)(4326008)(486006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3707;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t2cOqI+63oek1ttyBwmKB3l0pygy7dxS1NNdz4yqoQK7N+LhoJe8yAQu3Hq8UAMplvOS0A165Xadre+R1mbOJcE6avqxxK8nQwSVZzj2CaD648533POC/QwwXKIg0X9pr961pfNqiFgrsAo83mhDIhOOSB4LOWabepTKA+IZyNQPyGWNk5C1fLTbX2bzlQ3CIjcE+i7CCoItv+8w4aN9St3igkrybb0sdLeeErjU/62G1wswCjFPh/X9SSehPzle7NS1UUZ9FRLtBQ8csRNvlzArGVJcdZpCEqBUlBpdBWq5rwmBJwohvL/khUoOsd1uhAC7+XTJEY+e7XnWTEMWBbNPV2vOXd7b8IScyj2q2U6uCIqmmskO4X+aF9qaeHrsDmm6VzfOYcaDINx84c95+NM6laIbAKQKn9P3lza92kA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22235c20-e7dc-40de-5602-08d6887d5c6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 19:42:11.9634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3707
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
 drivers/rtc/rtc-isl1208.c | 78 ++++++++++++++++++++++++++++++++++---------=
----
 1 file changed, 56 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index d8e0670e12fc..77912ee58011 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -73,15 +73,49 @@
 static struct i2c_driver isl1208_driver;
=20
 /* ISL1208 various variants */
-enum {
+enum isl1208_id {
 	TYPE_ISL1208 =3D 0,
 	TYPE_ISL1218,
 	TYPE_ISL1219,
+	TYPE_ISL1209,
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
@@ -602,11 +636,12 @@ isl1208_rtc_interrupt(int irq, void *data)
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
@@ -743,6 +778,19 @@ isl1208_probe(struct i2c_client *client, const struct =
i2c_device_id *id)
 		return -ENOMEM;
 	i2c_set_clientdata(client, isl1208);
=20
+	/* Determine which chip we have */
+	if (client->dev.of_node) {
+		const struct of_device_id *match =3D
+			of_match_node(isl1208_of_match, client->dev.of_node);
+		if (!match)
+			return -EINVAL;
+		isl1208->config =3D match->data;
+	} else {
+		if (id->driver_data >=3D ISL_LAST_ID)
+			return -EINVAL;
+		isl1208->config =3D &isl1208_configs[id->driver_data];
+	}
+
 	isl1208->rtc =3D devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(isl1208->rtc))
 		return PTR_ERR(isl1208->rtc);
@@ -759,7 +807,7 @@ isl1208_probe(struct i2c_client *client, const struct i=
2c_device_id *id)
 		dev_warn(&client->dev, "rtc power failure detected, "
 			 "please set clock.\n");
=20
-	if (id->driver_data =3D=3D TYPE_ISL1219) {
+	if (isl1208->config->has_tamper) {
 		struct device_node *np =3D client->dev.of_node;
 		u32 evienb;
=20
@@ -780,10 +828,12 @@ isl1208_probe(struct i2c_client *client, const struct=
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
@@ -803,22 +853,6 @@ isl1208_probe(struct i2c_client *client, const struct =
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

