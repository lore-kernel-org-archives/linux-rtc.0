Return-Path: <SRS0=UPVA=PK=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D3EC43387
	for <linux-rtc@archiver.kernel.org>; Wed,  2 Jan 2019 16:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45BD2080A
	for <linux-rtc@archiver.kernel.org>; Wed,  2 Jan 2019 16:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="cFjP0wYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfABQAW (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:00:22 -0500
Received: from mail-eopbgr750130.outbound.protection.outlook.com ([40.107.75.130]:37862
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729511AbfABQAW (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 2 Jan 2019 11:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDaS/jhXg+DIkNSWk5tWFHj0+G0swQYql37IUcxBeo4=;
 b=cFjP0wYmLDHs8jRUAilkYQYJICu3Khahnpm9814NQnFI6ktOUcq/UkSX0Oc3ygu+/sWU7+90iAYBVIG24eUzbFN0rNlPviofNSh5N7XTtS8EqeWtP9sIcMwUDz09MdHrtWIDYSnxeM7cyTHbHYTbzckVJ4Cm3HMmavrIhK+JiU8=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3691.namprd06.prod.outlook.com (10.167.236.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 2 Jan 2019 16:00:18 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c067:6414:a064:fa37]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c067:6414:a064:fa37%4]) with mapi id 15.20.1495.005; Wed, 2 Jan 2019
 16:00:18 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: isl1208: fix negative digital trim reporting
Thread-Topic: [PATCH] rtc: isl1208: fix negative digital trim reporting
Thread-Index: AQHUorRBvCX+iJ4XiUmYdz0zMrm/KA==
Date:   Wed, 2 Jan 2019 16:00:17 +0000
Message-ID: <20190102160002.23670-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::18) To MWHPR0601MB3708.namprd06.prod.outlook.com
 (2603:10b6:301:7c::38)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3691;6:EIsshCfcAvnd3dk6QU7KdaDMN3RXRwqr+Yu3YJkmExPtSIV2QhBVhh/17Q1mruBHi76uQ/aimwp4N1aQPP5f503M4stlaAVbJ69YdKUOofHzCW5ydXUcs+mS0dWIJW+PHberZioZ5kRS8Rs3fJ7lzIU5goMnpwpVf6tbkYcKdbx3vNAfGzn2zNp6HmN/3fbjvHGxrj0Ocnh6jFxT4ioxPLW1ayp+kHAFjL7lbg4+/Utgi7dYF2PbKixKv9H7VmxP7gpV+KOg3LGvgvWH8mqjEKaIKO3p+8nDvcndfkh7p1K49l794blUyoyZuDN18ruEkBtBzmVnpvwkN4xt1ZKtRRWOq4aTPQ0ioXouKBqnP2vy+3gNgPA2gu4o1IGFC/s90nqY/cHaiGH6SaThIKGLYsI3z+IWUBY54ABH4ibxaYwIZE4Ip4AvaBeTPP3UIY8LBQ9iaE5pLhQLnsPC/qCwVQ==;5:veHPurgdP0P1yZRbqnlWxRtp4mscp3B5XAfObN2qkTb7iZsSVrdVNViIw0VDI5SmXGDZQ5BuaadkTlk/MmFoHD7CNzmi4gvL8mlIEK2DGN7hql7jsZ4FzZ8dZovB/TVTjR2Ku7xxNT/hm57OTF+1xIZarkxSNgq8/6e5BSe641qw/xE7xWPsXGZ4LyCnZGbkcp+lHe+/dlk67qvnhLV42A==;7:TLkdMp5dSVXlr3hq4KRkZyd/CFt28bEEvhXCQTRFkEflSJKyl41npAao3NrjTmNRFEfSccdVQrfCgjy2sAKPxdZtY6vIS+F+b58scCvTah6B9pwRUoOSq3+1xFUilV/P6I9uzYstTIc8sQ3z70SjsA==
x-ms-office365-filtering-correlation-id: fe7021f8-fa69-4ecc-0c7d-08d670cb63b6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3691;
x-ms-traffictypediagnostic: MWHPR0601MB3691:
x-microsoft-antispam-prvs: <MWHPR0601MB3691390E1F09040AAC1BF21BD38C0@MWHPR0601MB3691.namprd06.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3691;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3691;
x-forefront-prvs: 0905A6B2C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39840400004)(376002)(366004)(189003)(199004)(4326008)(52116002)(8676002)(53936002)(81156014)(81166006)(2616005)(478600001)(486006)(102836004)(476003)(36756003)(2501003)(54906003)(386003)(6506007)(186003)(97736004)(5660300001)(68736007)(26005)(5640700003)(316002)(25786009)(6436002)(2351001)(6486002)(1076003)(3846002)(6512007)(8936002)(6116002)(99286004)(6916009)(2906002)(106356001)(305945005)(256004)(86362001)(7736002)(66066001)(14454004)(71190400001)(71200400001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3691;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /tFIl2k1e4TdaG2Lq5J8OPeV4AS53f8cfwdhKRP3B9IlnSwaDoN44/q2Q0Pk7bCFd777mc7VZOTdSYTsxNvWKce2yaD+1ABpSdc5Unkfq/BcgFIJL33fFfiFPFqNffzLf3rdBHpKTlT9saGzqNRG0Sk2ywBDjh6K6qNJBZigI1KzRx7AmeyAOK+EBJgMdzPDRw8AVNraIZh1BXWHYUm38baqQU2mU5XNa/0QGRnx0PENNgYFTYh8hZgjpRPm1Y81uubH3C8DOEURadKeyYTxdxxdu8d13Z8wlG6q2l5JWGkFA+Sro5N8lUAOTnQzWOKu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7021f8-fa69-4ecc-0c7d-08d670cb63b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 16:00:17.8207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3691
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

isl1208_i2c_get_dtr() was returning the dtr value directly, but could
also return a negative error code.  Negative trimming values, e.g. -20,
would get interpreted as an error code, e.g. -ENOTDIR.

This patch offsets the dtr value by 100 so it's positive and won't alias
an error code.

Also fix check that considered a return value of -1 to be success.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/rtc/rtc-isl1208.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 53e965888ead..320dd15331f4 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -200,6 +200,7 @@ isl1208_i2c_get_atr(struct i2c_client *client)
 	return atr;
 }
=20
+/* returns adjustment value + 100 */
 static int
 isl1208_i2c_get_dtr(struct i2c_client *client)
 {
@@ -210,7 +211,7 @@ isl1208_i2c_get_dtr(struct i2c_client *client)
 	/* dtr encodes adjustments of {-60,-40,-20,0,20,40,60} ppm */
 	dtr =3D ((dtr & 0x3) * 20) * (dtr & (1 << 2) ? -1 : 1);
=20
-	return dtr;
+	return dtr + 100;
 }
=20
 static int
@@ -287,8 +288,8 @@ isl1208_rtc_proc(struct device *dev, struct seq_file *s=
eq)
 		   (sr & ISL1208_REG_SR_RTCF) ? "bad" : "okay");
=20
 	dtr =3D isl1208_i2c_get_dtr(client);
-	if (dtr >=3D 0 - 1)
-		seq_printf(seq, "digital_trim\t: %d ppm\n", dtr);
+	if (dtr >=3D 0)
+		seq_printf(seq, "digital_trim\t: %d ppm\n", dtr - 100);
=20
 	atr =3D isl1208_i2c_get_atr(client);
 	if (atr >=3D 0)
@@ -677,7 +678,7 @@ isl1208_sysfs_show_dtrim(struct device *dev,
 	if (dtr < 0)
 		return dtr;
=20
-	return sprintf(buf, "%d ppm\n", dtr);
+	return sprintf(buf, "%d ppm\n", dtr - 100);
 }
=20
 static DEVICE_ATTR(dtrim, S_IRUGO, isl1208_sysfs_show_dtrim, NULL);
--=20
2.14.4

