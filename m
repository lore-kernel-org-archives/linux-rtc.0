Return-Path: <SRS0=fWeB=QI=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFFCC282D8
	for <linux-rtc@archiver.kernel.org>; Fri,  1 Feb 2019 19:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E850321872
	for <linux-rtc@archiver.kernel.org>; Fri,  1 Feb 2019 19:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="Dp0Sle0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfBATmR (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:42:17 -0500
Received: from mail-eopbgr750130.outbound.protection.outlook.com ([40.107.75.130]:11975
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729303AbfBATmR (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 1 Feb 2019 14:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwBvJjnltjGIVWegudlra7v+2HbcJt3Tff8TwDJyZ8I=;
 b=Dp0Sle0NV0Ki90yG5lwaGZpZWXN+SwWH2MPFEx/9cMhJzkbwi4kPaq0VT3dvcwptF/vj71sv5mU5j9ukpj8jvrCkrk7vH16/r+ZuzSEbUL1dZJwr/WXrRVGud0fcfKLHrdqt9M9FcEvjKv6A4IxMFZ3PX4qPxC/Yj2EEUpDZQrY=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3739.namprd06.prod.outlook.com (10.167.236.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Fri, 1 Feb 2019 19:42:13 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 19:42:13 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] rtc: isl1208: Add new style nvmem support to driver
Thread-Topic: [PATCH 3/3] rtc: isl1208: Add new style nvmem support to driver
Thread-Index: AQHUumY63hvEyc+wwkCE/GjGCtKCLg==
Date:   Fri, 1 Feb 2019 19:42:13 +0000
Message-ID: <20190201194147.25885-3-tpiepho@impinj.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3739;6:lFiQb9BGnbxfyUi+l1ZvGc9mvY5s8oJy4aGNx0Z4j3JLk8eGDL/GLQiVKdaeXiyCBwVBobW1XK1PVOkNBLyC2ZBQcqFSt9Xzos/TMwBsX4XIE6dKkcVvg9I+a1qv6XlHuNDtWwrCxSKniQ8CnbMTwELen+JUkajEqlYdqiv4QtXuHL6gFHQvh6iDeSpSHr2AFqirZ3/FR/Gp/P1tdANxnCrm7kOhKBPDTTVWQy0RMvytiaUUFNYgrHH4cVH8PKEgJYKWQsS67Mq7H8xsuhP8PvCxG1flYjGGOisHqS1cgtV6myYZzu++GY0nduzGF+8t0V7ufp0POIILYs+uD4Ix6nxgU4IuELLlaq1W80meKBmSKMNEKY8gcG27utOe0CnZqE52/kcTD+83zSdN5bYCuMJmMUJyiLsQI5pnhcoxgtJpJ1eCR7aDrRLfmXYRPprjjLnHBqv/rYAS1dAnarHLYw==;5:mkrNfDRRmRyuK0CADCV8a0/Ue/Pov17P3gGe+kYqto5UylUOtldV/NRjKQPD+9ZE4FobnoQsDMenX1i0upHhiKDPXxgCKKgdNpY9HW4lEZdaCbdSWIfKTK5mL9OCGe24x8UcRfHDk4vc0K6m892c+oVZjY1AqNqfQaZLw6Y6/BxNfMXU8i+aRExeqJvnczCuKF0/eu4Qw6jZiLyUUbXuIw==;7:N7UuceG2xJk8bVAhPS9+0fCDqxt8PDPGdL0nvXinAE98nmKtfP6NXNq0EJmijbKyzJmDhoMRbghdtpYzwFuu+kk2Vl4wImfXY09IE2llNqoJn4ZMhRIaRDGDV9UU02vp9WXyD/UT81DSQZ8yzpTLTg==
x-ms-office365-filtering-correlation-id: e4cb005a-0083-4a75-1b90-08d6887d5cc6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3739;
x-ms-traffictypediagnostic: MWHPR0601MB3739:
x-microsoft-antispam-prvs: <MWHPR0601MB3739D4BA73C8D970F0501E29D3920@MWHPR0601MB3739.namprd06.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(366004)(376002)(136003)(396003)(346002)(189003)(199004)(2501003)(99286004)(14454004)(54906003)(76176011)(52116002)(256004)(14444005)(66066001)(1076003)(97736004)(7736002)(3846002)(305945005)(6116002)(2616005)(476003)(11346002)(446003)(486006)(50226002)(8936002)(2351001)(53936002)(71200400001)(4326008)(6486002)(81166006)(25786009)(6916009)(2906002)(6512007)(86362001)(5640700003)(8676002)(36756003)(316002)(68736007)(6436002)(102836004)(478600001)(186003)(81156014)(105586002)(26005)(106356001)(386003)(6506007)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3739;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0JnMriWof+zrEzOnzR2pFkNGmtuW6UqtFPQ5eNfjwBcZBZASlU0ko9weOmw2yqoPo8SQj3HmJ5JpP7CFCrZkK176IKpxlrKORpIx5YbQ37QJG0U1qmv18CXiH/gsNqLLhGfV86TQU+e8mxXnm17Kv/Y1Qn3uEP5T3S6HMQIRTH+it8OxZk6VbMK92QWihVaipDhLluipO+YRsHNX8v0e6UQrZbrTeHsINJMY22hYsjrQQpRrGvA6rLybCebX3lQ+X5Y27Ufy8ileoIb5N3iRMx+f+13ud4odv10f02TU8t6YWb2Ak8aLedA8wbQ4Jy0dkaPoNIm1tL4G3uq1UDzsj3BwNSiyvN/fUmwDn+dyWMjXVTu/ZdTTvtxvizu38+RvxLaNC6ibxtyF10eOCDkXrSjgzmzIPlZ+xndFQ+ZXuI4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cb005a-0083-4a75-1b90-08d6887d5cc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 19:42:12.5678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3739
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Add support for the RTC's NVRAM using the standard nvmem support that is
part of the Linux RTC framework.

This driver already has a sysfs attribute that provides access to the
RTC's NVRAM as a single 16-bit value.  Some chips have more than two
bytes of NVRAM, so this will not work for them.  It's also non-standard.

This sysfs attribute is left in for backward compatibility, but will only
be able to read the first two bytes of NVRAM.  The nvmem interface will
allow access to all NVRAM, e.g. eight bytes on the isl1218.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/rtc/rtc-isl1208.c | 46 +++++++++++++++++++++++++++++++++++++++++++=
+++
 1 file changed, 46 insertions(+)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 77912ee58011..1be1156aef23 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -114,6 +114,7 @@ MODULE_DEVICE_TABLE(of, isl1208_of_match);
=20
 /* Device state */
 struct isl1208_state {
+	struct nvmem_config nvmem_config;
 	struct rtc_device *rtc;
 	const struct isl1208_config *config;
 };
@@ -741,6 +742,46 @@ static const struct attribute_group isl1219_rtc_sysfs_=
files =3D {
 	.attrs	=3D isl1219_rtc_attrs,
 };
=20
+static int isl1208_nvmem_read(void *priv, unsigned int off, void *buf,
+			      size_t count)
+{
+	struct isl1208_state *isl1208 =3D priv;
+	struct i2c_client *client =3D to_i2c_client(isl1208->rtc->dev.parent);
+	int ret;
+
+	/* nvmem sanitizes offset/count for us, but count=3D=3D0 is possible */
+	if (!count)
+		return count;
+	ret =3D isl1208_i2c_read_regs(client, ISL1208_REG_USR1 + off, buf,
+				    count);
+	return ret =3D=3D 0 ? count : ret;
+}
+
+static int isl1208_nvmem_write(void *priv, unsigned int off, void *buf,
+			       size_t count)
+{
+	struct isl1208_state *isl1208 =3D priv;
+	struct i2c_client *client =3D to_i2c_client(isl1208->rtc->dev.parent);
+	int ret;
+
+	/* nvmem sanitizes off/count for us, but count=3D=3D0 is possible */
+	if (!count)
+		return count;
+	ret =3D isl1208_i2c_set_regs(client, ISL1208_REG_USR1 + off, buf,
+				   count);
+
+	return ret =3D=3D 0 ? count : ret;
+}
+
+static const struct nvmem_config isl1208_nvmem_config =3D {
+	.name =3D "isl1208_nvram",
+	.word_size =3D 1,
+	.stride =3D 1,
+	/* .size from chip specific config */
+	.reg_read =3D isl1208_nvmem_read,
+	.reg_write =3D isl1208_nvmem_write,
+};
+
 static int isl1208_setup_irq(struct i2c_client *client, int irq)
 {
 	int rc =3D devm_request_threaded_irq(&client->dev, irq, NULL,
@@ -797,6 +838,11 @@ isl1208_probe(struct i2c_client *client, const struct =
i2c_device_id *id)
=20
 	isl1208->rtc->ops =3D &isl1208_rtc_ops;
=20
+	/* Setup nvmem configuration in driver state struct */
+	isl1208->nvmem_config =3D isl1208_nvmem_config;
+	isl1208->nvmem_config.size =3D isl1208->config->nvmem_length;
+	isl1208->nvmem_config.priv =3D isl1208;
+
 	rc =3D isl1208_i2c_get_sr(client);
 	if (rc < 0) {
 		dev_err(&client->dev, "reading status failed\n");
--=20
2.14.4

