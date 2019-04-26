Return-Path: <SRS0=ApoW=S4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C859BC43219
	for <linux-rtc@archiver.kernel.org>; Fri, 26 Apr 2019 19:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CCB2077B
	for <linux-rtc@archiver.kernel.org>; Fri, 26 Apr 2019 19:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tennantco.onmicrosoft.com header.i=@tennantco.onmicrosoft.com header.b="HELXz5Cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfDZToY (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:44:24 -0400
Received: from esa1.tennantco.iphmx.com ([68.232.153.187]:5841 "EHLO
        esa1.tennantco.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDZToY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 26 Apr 2019 15:44:24 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Apr 2019 15:44:23 EDT
IronPort-PHdr: =?us-ascii?q?9a23=3Am6zh1BGeh+B1nqGKLOitmZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76ps24bnLW6fgltlLVR4KTs6sC17OP9f2+EjVbsd6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMRm6twXcu8gZjYd/JKs8yQ?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDM/7WrZiNF/jLhDrRyhuRJx3pLUbo+WOvpwfKzTetIaSn?=
 =?us-ascii?q?ZOUMleTCFBHpizYpETA+cbIepVrY/wrEYOoxukAgmsAfvixjFKiH/x06w1ze?=
 =?us-ascii?q?QgHRnb1wIuH9MOtG7brNP7OKwPVu27wqnJzTHZYPNQwzvz6o/Icx4/rvCMRr?=
 =?us-ascii?q?9wbdTeyU8pFwzfiFWQtZDqPzSP2usRtGib6vNtWOSygGAprAFxpyKgxsYqio?=
 =?us-ascii?q?TRm40V0FHE9Ttnz4YvP9G4TlR0Ydu6H5ZWqiqUNJN2T9s/T210tys20LILtJ?=
 =?us-ascii?q?yhcCUFx5kr3R7SZ+Kff4SV5h/uV/ydLSlkiH9qYr6yiRi//VK+xuHgSsW4yF?=
 =?us-ascii?q?hKoTRGn9XQs30A0h3e5dWbRfZ5+0quxCiA2B7d5+xBP087iLbUJ4Ikz7EqlJ?=
 =?us-ascii?q?ccqlrMEynrk0vslqCWbF8r+u2w5uTiZbXpu4GTOpdvigH7LqQugsu/AfkkMg?=
 =?us-ascii?q?QWX2iU5+C81Lr78EPhXLhEieE6n6bAvJ7HPcoXu7e1AwhO3Yk98Rq/CCqm0M?=
 =?us-ascii?q?gDknkAMVJFfg+Ig5LxO1HUJ/D4EemwjEiwkDdqwPDGOKftApLQLnjflLfher?=
 =?us-ascii?q?F9601GxAUvytBf4opYCrAHIP3tRk/8rMHUAgM2PgCuzOvqCs9x24wRVG6VAq?=
 =?us-ascii?q?KVLrvesVqS6eIuJ+mMapUVuDH4K/U96fDvjXs5lkUbfaWz35UXb365EepmIk?=
 =?us-ascii?q?iCfXrjnNEBEWEQsQo4UOzllFqCXSRPaHa1WqIw/is7B56+DYffWoCth6SM0z?=
 =?us-ascii?q?2/HpJIaWFJEFaMHmryd4qaQfsDczydIstlkjwDU7ihSpQs2gqptA/917pnKu?=
 =?us-ascii?q?vU+isCuZ3/09h14vXZlQsu+jxsE8Sdz2aNQnlukW8SRj42waV/oUl6ylqYza?=
 =?us-ascii?q?h4hPJZGsJJ5/NVTAg1KZ7cw/Z7C9DuQgjBZMuGSE66QtW6BjE8VtYxw94IY0?=
 =?us-ascii?q?ZgFNSulwrD3za2DLIOibyLC4I78rjG03jyOcl90XDG27clj1U8RctPL2Km1e?=
 =?us-ascii?q?ZD8F2ZDorEg0yfm7ynM64R2CrK8marx22JoEVZVkh7VqCPFSQWYkbGpNL1/E?=
 =?us-ascii?q?6ERbKqDbMhMyNLzsmeLqpMLNbuiAMVau3kPYGUQ2Wulnb0TTqZwrqKJsK+V3?=
 =?us-ascii?q?QZ1SObKE8bnhE74XuAMwE4Giym5WnZCWo9RhrUf0rw/Lwm+zuARUguwlTSNR?=
 =?us-ascii?q?cz3qep+hMTmf2XQu8S2bRBoio6tjFoBwjtjcnOBY+GoAxsNOVHbNUx7U0P9F?=
 =?us-ascii?q?qRthc1f/nCZ7tnmkZYdg12u0300BAiJpREmM5sjHQ1wRtaNa+e1lpHazifm5?=
 =?us-ascii?q?v3P+6fJw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2FsBgDlXMNc/zQsL2hmHgEGBwaBZYE+UFqBAwMECygKh?=
 =?us-ascii?q?AWDRwOFMYlYnEcDGDwPAS0ChD4CF4Y/OBMBAwEBAQQBAQEBAgEBAmkcAQuCO?=
 =?us-ascii?q?iJpOTIBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAjg5A?=
 =?us-ascii?q?gEDEhEEDQwBAR0aAQ8CASICJgICAjAVEAIEDgUigwCBagMcAaFMPQJiAguBA?=
 =?us-ascii?q?SmIX3F8M4J5AQEFhQcYgg4JgQsnhnWGLT6BEYgTGCOCUIJXjTWEYJRXAwQCA?=
 =?us-ascii?q?oIIkiInlRyMB5RCAgQCBAUCDgEBBYFmIoFWcIM8gRh3DBeDTIpTQAExgSmSL?=
 =?us-ascii?q?QGBIAEB?=
X-IronPort-AV: E=Sophos;i="5.60,398,1549951200"; 
   d="scan'208";a="14371301"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
  by ob1.tennantco.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Apr 2019 14:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tennantco.onmicrosoft.com; s=selector1-tennantco-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/b22nUuXDB/TAgEsESVRvh0TgdzQ7QvhTHXHSZXXSDA=;
 b=HELXz5CdqpjYA2z7JZomqJoBYsqzlkEXQyLnl+aRWhmYZiq6SPyV5q3PzTULpsoeuYWcR1YlNi9qPp5I/3M/ZN/jusbMTUwvZdzbzZW0v9AEir7NS8Ctg10WGWcNtRd/LqLKo5Wy40peqkSc5l8T3Rj60zzmxDBYSQX3+v5Pi3A=
Received: from CY4PR20MB1381.namprd20.prod.outlook.com (10.173.111.8) by
 CY4PR20MB1397.namprd20.prod.outlook.com (10.171.167.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Fri, 26 Apr 2019 19:37:15 +0000
Received: from CY4PR20MB1381.namprd20.prod.outlook.com
 ([fe80::6dc9:dee3:edc0:a7be]) by CY4PR20MB1381.namprd20.prod.outlook.com
 ([fe80::6dc9:dee3:edc0:a7be%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 19:37:15 +0000
From:   "Howey, Dylan" <Dylan.Howey@tennantco.com>
To:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Howey, Dylan" <Dylan.Howey@tennantco.com>
Subject: [PATCH 2/2] Add alarm support to rtc-pcf2123
Thread-Topic: [PATCH 2/2] Add alarm support to rtc-pcf2123
Thread-Index: AQHU/GdzbqVYFFTW60SqvyHuLFbQ+Q==
Date:   Fri, 26 Apr 2019 19:37:15 +0000
Message-ID: <20190426193648.1599-2-Dylan.Howey@tennantco.com>
References: <20190426193648.1599-1-Dylan.Howey@tennantco.com>
In-Reply-To: <20190426193648.1599-1-Dylan.Howey@tennantco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0011.namprd15.prod.outlook.com
 (2603:10b6:207:17::24) To CY4PR20MB1381.namprd20.prod.outlook.com
 (2603:10b6:903:8d::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dylan.Howey@tennantco.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [198.204.33.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e055c895-9713-4f41-8f27-08d6ca7e95cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR20MB1397;
x-ms-traffictypediagnostic: CY4PR20MB1397:
x-microsoft-antispam-prvs: <CY4PR20MB1397E3F48D9879ACBD5C5290EF3E0@CY4PR20MB1397.namprd20.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(366004)(376002)(189003)(199004)(2351001)(50226002)(53936002)(5660300002)(316002)(107886003)(66946007)(73956011)(8936002)(66556008)(66446008)(66476007)(52116002)(99286004)(64756008)(4326008)(81156014)(305945005)(66066001)(386003)(6506007)(8676002)(102836004)(54906003)(76176011)(81166006)(25786009)(186003)(26005)(7736002)(6512007)(11346002)(1076003)(6916009)(6486002)(36756003)(6116002)(2501003)(97736004)(2616005)(5640700003)(86362001)(68736007)(476003)(256004)(14444005)(478600001)(72206003)(14454004)(6436002)(2906002)(71190400001)(71200400001)(486006)(3846002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR20MB1397;H:CY4PR20MB1381.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: tennantco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xEYt/pYD9x3+pwsb2pVxNcfaRmvJKUPEBs6XIGg2ngJgkRjbWsYRBr7zTkVnTY5PR/rC7LgG4IaQJMJ7U96ae+yKxz1VbTBTA0Kp/pH5RqTCUdx8kmc4h0BxAiWZyk27mbwReT09gc584MgrzHy1o0f5UT1EJ7AN4Akbt7qSb28YrsEPKt6JqchWlBj3snYF4LhMtUoRjuUCn0s99rmnnBHOuOAeLFrBtgGgjQ34zzmt05QN/XBaZT6Man3hkRynFBF2OkuI+S32PKWl2oJsAdtnAEGFTH+Y5L16q3onk5/ZaYOB5WE4hpFd5E7Ys+SlE2Ri088Rkyg9b5saMNtrtUw1/bSxbXB8LKjK749oCJ9Qcd2SrEcdot1OzSvzsfBYNQvKcgB7XKDt6SE+mkJSJb+A/c30iB3MIeKib/G3tyg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: tennantco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e055c895-9713-4f41-8f27-08d6ca7e95cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 19:37:15.0202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 854ee4fb-bf50-420c-8a26-5b96d626ac37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR20MB1397
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

QWxsb3dzIGFsYXJtIHRvIGJlIHNldCB1c2luZyB0aGUgd2FrZWFsYXJtIHN5c2ZzIGludGVyZmFj
ZS4NCg0KU2lnbmVkLW9mZi1ieTogRHlsYW4gSG93ZXkgPER5bGFuLkhvd2V5QHRlbm5hbnRjby5j
b20+DQotLS0NCiBkcml2ZXJzL3J0Yy9ydGMtcGNmMjEyMy5jIHwgMTE1ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDExNSBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3J0Yy9ydGMtcGNmMjEyMy5jIGIvZHJpdmVycy9y
dGMvcnRjLXBjZjIxMjMuYw0KaW5kZXggNGJmY2IxZTY3YzliLi44YzE2YTMxMzk4MGQgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3J0Yy9ydGMtcGNmMjEyMy5jDQorKysgYi9kcml2ZXJzL3J0Yy9ydGMt
cGNmMjEyMy5jDQpAQCAtMzA4LDYgKzMwOCwxMDcgQEAgc3RhdGljIGludCBwY2YyMTIzX3J0Y19z
ZXRfdGltZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBydGNfdGltZSAqdG0pDQogCXJldHVy
biAwOw0KIH0NCiANCitzdGF0aWMgaW50IHBjZjIxMjNfcnRjX3JlYWRfYWxhcm0oc3RydWN0IGRl
dmljZSAqZGV2LCBzdHJ1Y3QgcnRjX3drYWxybSAqYWxtKQ0KK3sNCisJc3RydWN0IHBjZjIxMjNf
cGxhdF9kYXRhICpwZGF0YSA9IGRldl9nZXRfcGxhdGRhdGEoZGV2KTsNCisJdTggcnhidWZbNF07
DQorCWludCByZXQ7DQorCXVuc2lnbmVkIGludCB2YWwgPSAwOw0KKw0KKwlyZXQgPSByZWdtYXBf
YnVsa19yZWFkKHBkYXRhLT5tYXAsIFBDRjIxMjNfUkVHX0FMUk1fTU4sIHJ4YnVmLCA0KTsNCisJ
aWYgKHJldCkNCisJCXJldHVybiByZXQ7DQorDQorCWFsbS0+dGltZS50bV9taW4gPSBiY2QyYmlu
KHJ4YnVmWzBdICYgMHg3Rik7DQorCWFsbS0+dGltZS50bV9ob3VyID0gYmNkMmJpbihyeGJ1Zlsx
XSAmIDB4M0YpOw0KKwlhbG0tPnRpbWUudG1fbWRheSA9IGJjZDJiaW4ocnhidWZbMl0gJiAweDNG
KTsNCisJYWxtLT50aW1lLnRtX3dkYXkgPSBiY2QyYmluKHJ4YnVmWzNdICYgMHgwNyk7DQorDQor
CWRldl9kYmcoZGV2LCAiJXM6IGFsbSBpcyBzZWNzPSVkLCBtaW5zPSVkLCBob3Vycz0lZCBtZGF5
PSVkLCBtb249JWQsIHllYXI9JWQsIHdkYXk9JWRcbiIsDQorCQkJX19mdW5jX18sDQorCQkJYWxt
LT50aW1lLnRtX3NlYywgYWxtLT50aW1lLnRtX21pbiwgYWxtLT50aW1lLnRtX2hvdXIsDQorCQkJ
YWxtLT50aW1lLnRtX21kYXksIGFsbS0+dGltZS50bV9tb24sIGFsbS0+dGltZS50bV95ZWFyLA0K
KwkJCWFsbS0+dGltZS50bV93ZGF5KTsNCisNCisJcmV0ID0gcmVnbWFwX3JlYWQocGRhdGEtPm1h
cCwgUENGMjEyM19SRUdfQ1RSTDIsICZ2YWwpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJldDsN
CisNCisJYWxtLT5lbmFibGVkID0gISEodmFsICYgQ1RSTDJfQUlFKTsNCisNCisJcmV0dXJuIDA7
DQorfQ0KKw0KK3N0YXRpYyBpbnQgcGNmMjEyM19ydGNfc2V0X2FsYXJtKHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0IHJ0Y193a2Fscm0gKmFsbSkNCit7DQorCXN0cnVjdCBwY2YyMTIzX3BsYXRf
ZGF0YSAqcGRhdGEgPSBkZXZfZ2V0X3BsYXRkYXRhKGRldik7DQorCXU4IHR4YnVmWzRdOw0KKwlp
bnQgcmV0Ow0KKwl1bnNpZ25lZCBpbnQgdmFsID0gMDsNCisNCisJZGV2X2RiZyhkZXYsICIlczog
YWxtIGlzIHNlY3M9JWQsIG1pbnM9JWQsIGhvdXJzPSVkLCBtZGF5PSVkLCBtb249JWQsIHllYXI9
JWQsIHdkYXk9JWRcbiIsDQorCQkJX19mdW5jX18sDQorCQkJYWxtLT50aW1lLnRtX3NlYywgYWxt
LT50aW1lLnRtX21pbiwgYWxtLT50aW1lLnRtX2hvdXIsDQorCQkJYWxtLT50aW1lLnRtX21kYXks
IGFsbS0+dGltZS50bV9tb24sIGFsbS0+dGltZS50bV95ZWFyLA0KKwkJCWFsbS0+dGltZS50bV93
ZGF5KTsNCisNCisJLyogRGlzYWJsZSBhbGFybSAqLw0KKwlyZXQgPSByZWdtYXBfcmVhZChwZGF0
YS0+bWFwLCBQQ0YyMTIzX1JFR19DVFJMMiwgJnZhbCk7DQorCWlmIChyZXQpDQorCQlyZXR1cm4g
cmV0Ow0KKw0KKwl2YWwgJj0gfihDVFJMMl9BSUUpOw0KKwlyZXQgPSByZWdtYXBfd3JpdGUocGRh
dGEtPm1hcCwgUENGMjEyM19SRUdfQ1RSTDIsIHZhbCk7DQorDQorCS8qIFNldCBuZXcgYWxhcm0g
Ki8NCisJdHhidWZbMF0gPSBiaW4yYmNkKGFsbS0+dGltZS50bV9taW4gJiAweDdGKTsNCisJdHhi
dWZbMV0gPSBiaW4yYmNkKGFsbS0+dGltZS50bV9ob3VyICYgMHgzRik7DQorCXR4YnVmWzJdID0g
YmluMmJjZChhbG0tPnRpbWUudG1fbWRheSAmIDB4M0YpOw0KKwl0eGJ1ZlszXSA9IGJpbjJiY2Qo
YWxtLT50aW1lLnRtX3dkYXkgJiAweDA3KTsNCisNCisJcmV0ID0gcmVnbWFwX2J1bGtfd3JpdGUo
cGRhdGEtPm1hcCwgUENGMjEyM19SRUdfQUxSTV9NTiwgdHhidWYsIDQpOw0KKwlpZiAocmV0KQ0K
KwkJcmV0dXJuIHJldDsNCisNCisJaWYgKGFsbS0+ZW5hYmxlZCkJew0KKwkJcmV0ID0gcmVnbWFw
X3JlYWQocGRhdGEtPm1hcCwgUENGMjEyM19SRUdfQ1RSTDIsICZ2YWwpOw0KKwkJaWYgKHJldCkN
CisJCQlyZXR1cm4gcmV0Ow0KKw0KKwkJdmFsIHw9IENUUkwyX0FJRTsNCisJCXJldCA9IHJlZ21h
cF93cml0ZShwZGF0YS0+bWFwLCBQQ0YyMTIzX1JFR19DVFJMMiwgdmFsKTsNCisJCWlmIChyZXQp
DQorCQkJcmV0dXJuIHJldDsNCisJfQ0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGljIGly
cXJldHVybl90IHBjZjIxMjNfcnRjX2lycShpbnQgaXJxLCB2b2lkICpkZXYpDQorew0KKwlzdHJ1
Y3QgcGNmMjEyM19wbGF0X2RhdGEgKnBkYXRhID0gZGV2X2dldF9wbGF0ZGF0YShkZXYpOw0KKwlz
dHJ1Y3QgbXV0ZXggKmxvY2sgPSAmcGRhdGEtPnJ0Yy0+b3BzX2xvY2s7DQorCXVuc2lnbmVkIGlu
dCB2YWwgPSAwOw0KKwlpbnQgcmV0ID0gSVJRX05PTkU7DQorDQorCW11dGV4X2xvY2sobG9jayk7
DQorCXJlZ21hcF9yZWFkKHBkYXRhLT5tYXAsIFBDRjIxMjNfUkVHX0NUUkwyLCAmdmFsKTsNCisN
CisJLyogQWxhcm0/ICovDQorCWlmICh2YWwgJiBDVFJMMl9BRikgew0KKwkJcmV0ID0gSVJRX0hB
TkRMRUQ7DQorDQorCQl2YWwgJj0gfihDVFJMMl9BRik7DQorCQlyZWdtYXBfd3JpdGUocGRhdGEt
Pm1hcCwgUENGMjEyM19SRUdfQ1RSTDIsIHZhbCk7DQorDQorCQlydGNfdXBkYXRlX2lycShwZGF0
YS0+cnRjLCAxLCBSVENfSVJRRiB8IFJUQ19BRik7DQorCX0NCisNCisJbXV0ZXhfdW5sb2NrKGxv
Y2spOw0KKw0KKwlyZXR1cm4gcmV0Ow0KK30NCisNCiBzdGF0aWMgaW50IHBjZjIxMjNfcmVzZXQo
c3RydWN0IGRldmljZSAqZGV2KQ0KIHsNCiAJc3RydWN0IHBjZjIxMjNfcGxhdF9kYXRhICpwZGF0
YSA9IGRldl9nZXRfcGxhdGRhdGEoZGV2KTsNCkBAIC0zNDcsNiArNDQ4LDggQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBydGNfY2xhc3Nfb3BzIHBjZjIxMjNfcnRjX29wcyA9IHsNCiAJLnNldF90aW1l
CT0gcGNmMjEyM19ydGNfc2V0X3RpbWUsDQogCS5yZWFkX29mZnNldAk9IHBjZjIxMjNfcmVhZF9v
ZmZzZXQsDQogCS5zZXRfb2Zmc2V0CT0gcGNmMjEyM19zZXRfb2Zmc2V0LA0KKwkucmVhZF9hbGFy
bSA9IHBjZjIxMjNfcnRjX3JlYWRfYWxhcm0sDQorCS5zZXRfYWxhcm0gPSBwY2YyMTIzX3J0Y19z
ZXRfYWxhcm0sDQogDQogfTsNCiANCkBAIC0zOTEsNiArNDk0LDggQEAgc3RhdGljIGludCBwY2Yy
MTIzX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQogCWRldl9pbmZvKCZzcGktPmRldiwg
InNwaWNsayAldSBLSHouXG4iLA0KIAkJCShzcGktPm1heF9zcGVlZF9oeiArIDUwMCkgLyAxMDAw
KTsNCiANCisJZGV2aWNlX2luaXRfd2FrZXVwKCZzcGktPmRldiwgdHJ1ZSk7DQorDQogCS8qIEZp
bmFsaXplIHRoZSBpbml0aWFsaXphdGlvbiAqLw0KIAlydGMgPSBkZXZtX3J0Y19kZXZpY2VfcmVn
aXN0ZXIoJnNwaS0+ZGV2LCBwY2YyMTIzX2RyaXZlci5kcml2ZXIubmFtZSwNCiAJCQkmcGNmMjEy
M19ydGNfb3BzLCBUSElTX01PRFVMRSk7DQpAQCAtNDE4LDYgKzUyMywxNiBAQCBzdGF0aWMgaW50
IHBjZjIxMjNfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCiAJCX0NCiAJfQ0KIA0KKwkv
KiBSZWdpc3RlciBhbGFybSBpcnEgKi8NCisJaWYgKHNwaS0+aXJxID49IDApCXsNCisJCXJldCA9
IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEoJnNwaS0+ZGV2LCBzcGktPmlycSwgTlVMTCwNCisJ
CQkJcGNmMjEyM19ydGNfaXJxLA0KKwkJCQlJUlFGX1RSSUdHRVJfTE9XIHwgSVJRRl9PTkVTSE9U
LA0KKwkJCQlwY2YyMTIzX2RyaXZlci5kcml2ZXIubmFtZSwgJnNwaS0+ZGV2KTsNCisJCWlmIChy
ZXQpDQorCQkJZGV2X2Vycigmc3BpLT5kZXYsICJjb3VsZCBub3QgcmVxdWVzdCBpcnEuXG4iKTsN
CisJfQ0KKw0KIAlyZXR1cm4gMDsNCiANCiBzeXNmc19leGl0Og0KLS0gDQoyLjE3LjENCg0K
