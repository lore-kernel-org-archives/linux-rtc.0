Return-Path: <SRS0=fZ1A=QM=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD60C282CB
	for <linux-rtc@archiver.kernel.org>; Tue,  5 Feb 2019 17:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5942081B
	for <linux-rtc@archiver.kernel.org>; Tue,  5 Feb 2019 17:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="pLs2kCUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfBERmb (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:42:31 -0500
Received: from mail-eopbgr800091.outbound.protection.outlook.com ([40.107.80.91]:12256
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbfBERmb (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 5 Feb 2019 12:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h76c0DmBwrkp7romsuIdcUix/os8fxowkY8U46NmxBI=;
 b=pLs2kCUYXeL2fTzqdfFFmK3Tv4z7ZqrPyvUS8vlHU0i8QASjxOYai2LLe6gng56p9i7YcApvzgLxoQrIPcT708EucCEyafD+ytalvJYOgfYRelUoPBTQjLjgE4uGR+JDpQgJe/ul7jVt2+G1sYs8541lCFous2Va1GpicR7nlHY=
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com (52.132.101.36) by
 CY4PR0601MB3697.namprd06.prod.outlook.com (52.132.101.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 17:41:49 +0000
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::680a:27a3:4516:979c]) by CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::680a:27a3:4516:979c%5]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 17:41:49 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2] rtc: isl1208: Add new style nvmem support to driver
Thread-Topic: [PATCH v2] rtc: isl1208: Add new style nvmem support to driver
Thread-Index: AQHUvXoSc2gMK4brREeC0pysUPdidw==
Date:   Tue, 5 Feb 2019 17:41:49 +0000
Message-ID: <20190205174139.1383-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::20) To CY4PR0601MB3697.namprd06.prod.outlook.com
 (2603:10b6:910:91::36)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.14.4
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR0601MB3697;6:2iZgETca1gqOt+mjimtCyFWB03BgK0Je0SzrypBbdqTlqYxWbHUaGHqJf+lnt/YhHTkaRZ7hbWZinbQyJaZj/auReKRrAoFNcVaFjhcjlSIx1OKTb3HD6bw4mhWFPpYUEFGpkdJqp/sueIznnZ9ubkmy21xvmih/N5pYWB1whJC4euAA6WqTCdwVZdONg2twnj0bwmbZT7ucxlEC7Al2b2TCV1+2R39dk0CFtLXPdBcu/c1xesRGO9EUCBFuWWb/Bj+ls5JkCeSyE9ba7NE58K2PbDQ5cP1Kz6uoRkBxb86mq+Rj3NucqVU0D+LT0947gsrEXItLOPOf8iXX0aq1e1TRqwLeLDvgQrCzSxRbFshnBdn+vBA4Tr5GteK7swls0HgBWciLzUN91gjboZ/dGkznrKa2RDbEpsaNePUs8f4FpZ6snXd4DQhHPFpcKhZ+8ekOS+oHz6L1wz7ZCw+4qg==;5:sXgQspWv/kbP1NuCAMowSY0HcAt/IEvnzrP48/yV+AZAPInJTZZ00iW7I4YzIzuf3vn+OtokZROQJcM2P7vijqzbQ9cwxaDpSCSv9Sswv2TJ8RDo5C1dZ5K4UVzPIIW4RwHMN1P/Nxzxp0DlZjr4x+KUkSdceI3uFXNo2DtigQnZuMt22bFxbmeu+NRnwODr0yBQEuwqye2DoEINDUXw3Q==;7:SYVUCFIJOMlCbH8x9AjW0Vhottq7C1+QcPhMFH0XaMXUBh/8ZY3Pk+1Pq095XfssvvkZJ0ubgGj22TOhLk4HY04C/3OaYl3rI0jnvVCA68Vd+3zcz8gp3A3XX0tvumaLwIt+Dc30DD87ZhEJPHdDEA==
x-ms-office365-filtering-correlation-id: 1bf9eeef-64c9-4108-2b63-08d68b9134a9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:CY4PR0601MB3697;
x-ms-traffictypediagnostic: CY4PR0601MB3697:
x-microsoft-antispam-prvs: <CY4PR0601MB36971F08850CCCF1060B164AD36E0@CY4PR0601MB3697.namprd06.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39850400004)(189003)(199004)(2616005)(476003)(486006)(5640700003)(68736007)(97736004)(6512007)(52116002)(6436002)(2906002)(71190400001)(71200400001)(66066001)(6486002)(478600001)(54906003)(36756003)(1076003)(26005)(14454004)(102836004)(186003)(25786009)(86362001)(2501003)(53936002)(386003)(6506007)(8936002)(4326008)(316002)(2351001)(99286004)(14444005)(256004)(50226002)(305945005)(3846002)(6116002)(8676002)(105586002)(81166006)(106356001)(81156014)(7736002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0601MB3697;H:CY4PR0601MB3697.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E4YjBkH9fAWbkE+AVUmDJ0bC0EcWOYjKE4mamMucZQ20czLV7/BXinkc4F0Bbu0uwi8UNSC4V/Av0XQEuThJT7OSjPTuQcz1xgXJ55ljCwVY2CMhm+Zh4sl5hMJkiYJGJ3RebT/Xb72457t52P3oOD5zmTdXKPi28T56s4zOQfzZ2Htg64BPeUYlcEMHFGuVyiXaYu/VtA/2NTzzjtT1VJ1FoZgisjASidLKSabhNEudy3DL5eVgoHsUOcjSD18aGrtwRu+7p1tmy5DiV7fDr6G5ZuwGYBJ0S/o3V1U+qgobCcZlqF4MjV3bkAiljula8ULXytc8pC6VFGyJZa8dOd1ygIHttHNMgi+SgAyXJYtnlUrIHCAtcH4EuyN91ABWbqSs+QpKY0Jb5h6dVqoh9L5WB+zHrDbVeBnznQXg3dE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf9eeef-64c9-4108-2b63-08d68b9134a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 17:41:48.6542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0601MB3697
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

Changes from v1:
  Add call to register nvmem that got dropped while rebasing.

 drivers/rtc/rtc-isl1208.c | 50 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 77912ee58011..92c48349e359 100644
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
@@ -850,6 +896,10 @@ isl1208_probe(struct i2c_client *client, const struct =
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

