Return-Path: <SRS0=fWeB=QI=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C9C282D8
	for <linux-rtc@archiver.kernel.org>; Fri,  1 Feb 2019 19:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22C221872
	for <linux-rtc@archiver.kernel.org>; Fri,  1 Feb 2019 19:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="RJO3HmAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfBATmu (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:42:50 -0500
Received: from mail-eopbgr800138.outbound.protection.outlook.com ([40.107.80.138]:61696
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727222AbfBATmu (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 1 Feb 2019 14:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCaVxUSzpXxTL0Uo1f08DMU4HmbOEsCvW0edwBIhk4A=;
 b=RJO3HmAZ29/mEPQ3/UaHGsd5is3KIxNWszLgWUFZmRYtMgWlWo1lgVrV/PLUCP4nxMEOrQoQpCR4UIA5O6CslI2HbASEQ5ENcoNer8dgS2xO/2xQWxviWa/Iu2cvBcwGI/4siAP0IaovhhuOO7iv6yCMSF6JuFRjAIb3q61oqks=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3707.namprd06.prod.outlook.com (10.167.236.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Fri, 1 Feb 2019 19:42:07 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 19:42:07 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc: isl1208: Introduce driver state struct
Thread-Topic: [PATCH 1/3] rtc: isl1208: Introduce driver state struct
Thread-Index: AQHUumY3prNd6qjoPU6rB0FiNSCnEg==
Date:   Fri, 1 Feb 2019 19:42:07 +0000
Message-ID: <20190201194147.25885-1-tpiepho@impinj.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3707;6:ValIJP5iVK/1HwDAnuwDHm5UeGaHV56ysNzq/XfevJWHMGISIgYsY3Su+Y1rwNeRhOSkhrUgtLdt7V7GcIuCWJibc5QTBya2Zn4eNWvL0Wr/SJZmahQYlTMVFVYOnsfCC0N6claSVmHKbVJDuTukFCfE2eQZvsggDLYqzomI2kywboAIo0o+Ortnf/bMup5Fyp6erAdXlUCVKt0He3TYSWWL0OaYqZ9jRWlFN5EKcrBldRvZOyUsSdFUuO+2gtYQROurb8vRjlQpjRzWiiJo0AvAC765jMIRJwv9OZ1U/u+6nMtntHKMztMcZ37dIzQ2KJUorQAvFCWM0hmZOvWqce8BfdywekcKhKvI+56rfOWh3YZMGJtb1K4kBAVJZeb3peYC1TdTc5DvRltskheA4CQbZMCwcszd3NOWppfzur3yJEp2XlAJiCcyf51JaT4BWOdpH+0pqE+Kc9HQiJHqrg==;5:KEH/OFvHUhNQds/M7gNbrWGuUOZXxnm4QpkRdITKhW7prLJgBFEcDy/XpIH7HJAqbjKOlCeGkzWN/ahZMzPKv4n8S4GvQtn/ZSndL0t49dwMQR1M9oGHmnHf8rqOovJR+SJYGsub5g1v1dnok7u0pvQXueZ/kc+IHzOwaQA3aeoXJ0FhkKOeMAoWc/duNfUMTqwgRYdxCILjti+nVxKfUw==;7:vSBzITlXGJ8bPScUHcm1nGS5iMRYWnu/C0fGmcFODTVSP4noSqn2TVrJHY87oW77CMFxuTPx5CHyxX459G5fKnA+UnVI0a7uN12TRbIl26xlgQ8079YcA/sci6IkZmMkD/Prrb4vbw8b5OLE9WqLxw==
x-ms-office365-filtering-correlation-id: b0066773-6fd6-48e2-62a1-08d6887d593b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3707;
x-ms-traffictypediagnostic: MWHPR0601MB3707:
x-microsoft-antispam-prvs: <MWHPR0601MB3707FE707C53A7E5A3B1A3E0D3920@MWHPR0601MB3707.namprd06.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(346002)(396003)(366004)(136003)(199004)(189003)(106356001)(54906003)(105586002)(316002)(97736004)(99286004)(52116002)(2906002)(478600001)(6512007)(5640700003)(14454004)(6486002)(6916009)(6436002)(53936002)(8936002)(36756003)(3846002)(6116002)(50226002)(2351001)(68736007)(2501003)(102836004)(386003)(6506007)(86362001)(26005)(25786009)(1076003)(81166006)(305945005)(14444005)(256004)(66066001)(8676002)(2616005)(7736002)(476003)(71190400001)(186003)(71200400001)(4326008)(486006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3707;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vw52x80nETNTOHPUIb492vT6vLVs8v+vuIoC6iQqx6IS4jRXSHpSC99n1N5Jqv1wz25q0jKJCxQW6iHrGZL+MS2mQWdnUAx1hyN3zCtMm+ILOnrflHz7ibZs4B0VgIHc+h6sXWJyAt+7o8xyEztdg0Nl4nHQH3ldePWVz1fTxk8MtqXrznWWxSpngV3gb739ZBFc/ZqbxHJGhU4zCdQUNMQiGWUGihxQAgVUE8FTwETChToPm+WYQwrnhQcZRkbrMC6OXpxlKpWhk15gGpzSK4eqAJJ9sHRJMv/pTvZuiWinVItRuF9znTICKR4HvUn9k11ZAOQJCKtxfhkohrDP6m3Nk5Khg2n0/nC3OIiJhnow+K54unMIm2foHTHAfgs0+ndr+uiXp+ykssshD2NWT/UGExmokNst0ZTpZ1xA/O8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0066773-6fd6-48e2-62a1-08d6887d593b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 19:42:06.6235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3707
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

This driver has no state of its own, depending entirely on what is in
the generic rtc device.

Intoduce a state struct.  For now it only contains a pointer to the rtc
device struct, but future patches will add more data.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/rtc/rtc-isl1208.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 263af3d8cd9f..d8e0670e12fc 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -79,6 +79,11 @@ enum {
 	TYPE_ISL1219,
 };
=20
+/* Device state */
+struct isl1208_state {
+	struct rtc_device *rtc;
+};
+
 /* block read */
 static int
 isl1208_i2c_read_regs(struct i2c_client *client, u8 reg, u8 buf[],
@@ -557,7 +562,7 @@ isl1208_rtc_interrupt(int irq, void *data)
 {
 	unsigned long timeout =3D jiffies + msecs_to_jiffies(1000);
 	struct i2c_client *client =3D data;
-	struct rtc_device *rtc =3D i2c_get_clientdata(client);
+	struct isl1208_state *isl1208 =3D i2c_get_clientdata(client);
 	int handled =3D 0, sr, err;
=20
 	/*
@@ -580,7 +585,7 @@ isl1208_rtc_interrupt(int irq, void *data)
 	if (sr & ISL1208_REG_SR_ALM) {
 		dev_dbg(&client->dev, "alarm!\n");
=20
-		rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
+		rtc_update_irq(isl1208->rtc, 1, RTC_IRQF | RTC_AF);
=20
 		/* Clear the alarm */
 		sr &=3D ~ISL1208_REG_SR_ALM;
@@ -598,7 +603,7 @@ isl1208_rtc_interrupt(int irq, void *data)
 	}
=20
 	if (sr & ISL1208_REG_SR_EVT) {
-		sysfs_notify(&rtc->dev.kobj, NULL,
+		sysfs_notify(&isl1208->rtc->dev.kobj, NULL,
 			     dev_attr_timestamp0.attr.name);
 		dev_warn(&client->dev, "event detected");
 		handled =3D 1;
@@ -723,7 +728,7 @@ static int
 isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	int rc =3D 0;
-	struct rtc_device *rtc;
+	struct isl1208_state *isl1208;
 	int evdet_irq =3D -1;
=20
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
@@ -732,13 +737,17 @@ isl1208_probe(struct i2c_client *client, const struct=
 i2c_device_id *id)
 	if (isl1208_i2c_validate_client(client) < 0)
 		return -ENODEV;
=20
-	rtc =3D devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
+	/* Allocate driver state, point i2c client data to it */
+	isl1208 =3D devm_kzalloc(&client->dev, sizeof(*isl1208), GFP_KERNEL);
+	if (!isl1208)
+		return -ENOMEM;
+	i2c_set_clientdata(client, isl1208);
=20
-	rtc->ops =3D &isl1208_rtc_ops;
+	isl1208->rtc =3D devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(isl1208->rtc))
+		return PTR_ERR(isl1208->rtc);
=20
-	i2c_set_clientdata(client, rtc);
+	isl1208->rtc->ops =3D &isl1208_rtc_ops;
=20
 	rc =3D isl1208_i2c_get_sr(client);
 	if (rc < 0) {
@@ -771,13 +780,13 @@ isl1208_probe(struct i2c_client *client, const struct=
 i2c_device_id *id)
 			dev_err(&client->dev, "could not enable tamper detection\n");
 			return rc;
 		}
-		rc =3D rtc_add_group(rtc, &isl1219_rtc_sysfs_files);
+		rc =3D rtc_add_group(isl1208->rtc, &isl1219_rtc_sysfs_files);
 		if (rc)
 			return rc;
 		evdet_irq =3D of_irq_get_byname(np, "evdet");
 	}
=20
-	rc =3D rtc_add_group(rtc, &isl1208_rtc_sysfs_files);
+	rc =3D rtc_add_group(isl1208->rtc, &isl1208_rtc_sysfs_files);
 	if (rc)
 		return rc;
=20
@@ -791,7 +800,7 @@ isl1208_probe(struct i2c_client *client, const struct i=
2c_device_id *id)
 	if (rc)
 		return rc;
=20
-	return rtc_register_device(rtc);
+	return rtc_register_device(isl1208->rtc);
 }
=20
 static const struct i2c_device_id isl1208_id[] =3D {
--=20
2.14.4

