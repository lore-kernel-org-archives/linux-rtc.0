Return-Path: <SRS0=6w/U=QT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38D1C169C4
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 02:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D9F206BB
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 02:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="HY6G9Bge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfBLCeO (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:34:14 -0500
Received: from mail-eopbgr680127.outbound.protection.outlook.com ([40.107.68.127]:17120
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727549AbfBLCeN (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 11 Feb 2019 21:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWDeJjAcyrjUmJYwe/VtZ7kon14mhqTpBqy/rvhHanQ=;
 b=HY6G9BgeFjGMsW+aiOHWMrzS1hBp4Zu7nj7loNy3CJr0wcI5EB86PboW1rVC0Yp1mbxNkABtmuyZaSm/lZHZvzE9i4NB7m/EVB5evddhA5U6Z+Dh9xPEETT4FBG7h3UmA++dyneFipAoK5/kMcTZEc974bqBiwWNp7mz2ya5VIQ=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3659.namprd06.prod.outlook.com (10.167.236.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 02:34:05 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 02:34:05 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 3/4] rtc: isl1208: Add new style nvmem support to driver
Thread-Topic: [PATCH v3 3/4] rtc: isl1208: Add new style nvmem support to
 driver
Thread-Index: AQHUwntst0ucCLwYTE2N6SGR2Pg1kQ==
Date:   Tue, 12 Feb 2019 02:34:05 +0000
Message-ID: <20190212023225.2710-3-tpiepho@impinj.com>
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
x-ms-office365-filtering-correlation-id: 2cd8b201-6969-4879-98e9-08d690928e54
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3659;
x-ms-traffictypediagnostic: MWHPR0601MB3659:
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3659;20:vhXnqdDeK6VkBZxOPI6NfylYrb02H7HBfTIGxKyVxCTSghIB/bO3CChXLBd+zGYbH4dHWdi5PEliRvzi3rO3EHQF6Ff7trra+PeIptwQ1KwV6GLzz1kur8YCRBU3+9qJkbCWvxtsUYaNuCgem3xm5Vh6iiuiGitPinYN2IY3qJk=
x-microsoft-antispam-prvs: <MWHPR0601MB365910F9C840D54DDAAC1B7ED3650@MWHPR0601MB3659.namprd06.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(396003)(376002)(136003)(366004)(189003)(199004)(316002)(102836004)(66066001)(6486002)(25786009)(86362001)(6116002)(53936002)(1076003)(2351001)(26005)(386003)(6506007)(5640700003)(7736002)(3846002)(305945005)(106356001)(97736004)(50226002)(6512007)(6436002)(105586002)(4326008)(11346002)(446003)(52116002)(14454004)(8676002)(2501003)(2906002)(476003)(2616005)(256004)(6916009)(99286004)(71200400001)(36756003)(54906003)(68736007)(81156014)(478600001)(8936002)(76176011)(14444005)(486006)(186003)(71190400001)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3659;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hd3zszrEDBDiVUoijX9u6HqK29CGUHuRvxSEaqeHmrCxZx4RpRoTZcf5/263c38OJqS7+iH5ONg3pHF5OwszGure+ix89+n+0uAkhdqlI9QVX1OQEbT0Iy7DmpjpBcK8F/Wm2SsC2b7J7efxDyOl63cWu0fFu6Q0KwH5anmV2byQf335oB2+9IN5Q7l8bLaANiaG7B8roWvQPXiQ9AzW/L/6raQmyNcbP3fxGPnQLahYonkIMhsaeIcoazLG67TSJw4Y4yBTzAQ6hg67BhVM2II0kTK0taN2AZ/+BQlv96AQxfTEzr9LijGhvb9KmuOWc+GGZy//lYXLaK/a3pfXEraw8IQQLdLidObx3mJgXCexjiqco4zYfg7V1+I3FG4FZL727CYiH0MLpFJLYxSTq2wxUrquxRX6yKMU7yXtnT0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd8b201-6969-4879-98e9-08d690928e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 02:34:04.4425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3659
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
 drivers/rtc/rtc-isl1208.c | 50 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 036e5fc148d4..471e395b20db 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -115,6 +115,7 @@ MODULE_DEVICE_TABLE(of, isl1208_of_match);
=20
 /* Device state */
 struct isl1208_state {
+	struct nvmem_config nvmem_config;
 	struct rtc_device *rtc;
 	const struct isl1208_config *config;
 };
@@ -742,6 +743,46 @@ static const struct attribute_group isl1219_rtc_sysfs_=
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
@@ -796,6 +837,11 @@ isl1208_probe(struct i2c_client *client, const struct =
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
@@ -849,6 +895,10 @@ isl1208_probe(struct i2c_client *client, const struct =
i2c_device_id *id)
 	if (rc)
 		return rc;
=20
+	rc =3D rtc_nvmem_register(isl1208->rtc, &isl1208->nvmem_config);
+	if (rc)
+		return rc;
+
 	return rtc_register_device(isl1208->rtc);
 }
=20
--=20
2.14.4

