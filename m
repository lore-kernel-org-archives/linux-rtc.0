Return-Path: <SRS0=MiQX=OO=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7011C04EB9
	for <linux-rtc@archiver.kernel.org>; Wed,  5 Dec 2018 13:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BF12081C
	for <linux-rtc@archiver.kernel.org>; Wed,  5 Dec 2018 13:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="rkKOdlM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BF12081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeLENom (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:44:42 -0500
Received: from mail-eopbgr1410101.outbound.protection.outlook.com ([40.107.141.101]:18144
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727025AbeLENom (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 5 Dec 2018 08:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHPHw1OUv7LfPDoPMkbDnAN7sVACr7bF3ZKEbJHMdUQ=;
 b=rkKOdlM06+p/Wu4q4FbKcYtiyQ1zyTe/KchGTo9Hduu8b7EOvS0ZLtlmobl5ZK8V/dG9jYdS0IpjluYvrQlCFC4f/h92n6kGiO8xhkCOHJYeJkb8NsCtcSg8de7Qfl0tnm1eXIySvgY9dKc7aiDJOA0Zcoa+yW79ijZFjFV+8h4=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB2998.jpnprd01.prod.outlook.com (52.134.254.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 13:44:37 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%5]) with mapi id 15.20.1404.020; Wed, 5 Dec 2018
 13:44:37 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
Thread-Topic: [PATCH v2 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
Thread-Index: AQHUiAVu7yCQEpKpyEW8KV5jYNpaxKVoKRoAgAgG9OA=
Date:   Wed, 5 Dec 2018 13:44:37 +0000
Message-ID: <OSBPR01MB210377306858580604748E92B8A80@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1543510486-29532-1-git-send-email-biju.das@bp.renesas.com>
 <1543510486-29532-3-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdXmS6cCZhX_b+oszDjt+t8zgAkCGApweOX-k0Uq05=AEg@mail.gmail.com>
In-Reply-To: <CAMuHMdXmS6cCZhX_b+oszDjt+t8zgAkCGApweOX-k0Uq05=AEg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2998;20:wTNCOVzB3ijLfTJieVPqVEOhQGnt+S8uQUNUo8GM3VAf7U+Yhq7xsaXO4U/Za6DCSJehtPZI3vxLIjSeowt/75dJILX2IusnI1PeNYjMFbdml70uVrosaoK48eAcsvbOZ02WgtzRC20foDgtRcxwzvhowdbDLFO36qz2shbUpUg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 8af2403e-d3b9-4515-7d58-08d65ab7cc5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2998;
x-ms-traffictypediagnostic: OSBPR01MB2998:
x-microsoft-antispam-prvs: <OSBPR01MB2998ECDC35C3F7065026FF10B8A80@OSBPR01MB2998.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB2998;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2998;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(51914003)(199004)(229853002)(486006)(66066001)(2906002)(33656002)(11346002)(68736007)(3846002)(44832011)(446003)(6116002)(476003)(7696005)(5660300001)(99286004)(76176011)(105586002)(102836004)(6506007)(305945005)(53546011)(106356001)(14454004)(14444005)(74316002)(7736002)(256004)(186003)(97736004)(8936002)(81166006)(81156014)(26005)(8676002)(6436002)(71190400001)(71200400001)(6246003)(86362001)(316002)(478600001)(53936002)(4326008)(6306002)(9686003)(10126004)(25786009)(6916009)(55016002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2998;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lTDtejCMQ93+t6lu7XjJ5V/SP+O/GMP+HjyzrKdTgoBRCMWUUaY6BmZNelkJXzGctjvoYi0yaNVefmjk9wsRUscce6mAdcfPIA+v4+d2mPpaBYm8e7WLlxM0pXdSnLadYqBfnIlBWx4UfIrCVjuKGlwrWQKkw0vDshjhLNiB9bL4h9q+JoQzJfPSZSx+snhD+Y8X2G23V6MKVqDi985adLxlACoN3FTEkg8a157QwaItw4Hz8rk5RrJ4h6F3ByKGyeNYiLVID7d2ss6WDfppZx9XeFXdcIHbP896hcBvjsjcqljL0ITFoiq156vqdKfJo2gB6rCreIZ2N9R+5BK7rKYh4s1RH0yxR8u9VCd3h1E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af2403e-d3b9-4515-7d58-08d65ab7cc5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 13:44:37.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2998
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMi80XSBydGM6IHBjZjg1MzYzOiBBZGQgc3VwcG9ydCBmb3IgTlhQIHBjZjg1MjYz
IHJ0Yw0KPg0KPiBIaSBCaWp1LA0KPg0KPiBPbiBUaHUsIE5vdiAyOSwgMjAxOCBhdCA2OjAzIFBN
IEJpanUgRGFzIDxiaWp1LmRhc0BicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gQWRkIHN1cHBv
cnQgZm9yIE5YUCBwY2Y4NTI2MyByZWFsLXRpbWUgY2xvY2suIHBjZjg1MjYzIHJ0YyBpcw0KPiA+
IGNvbXBhdGlibGUgd2l0aCBwY2Y4NTM2MyxleGNlcHQgdGhhdCBwY2Y4NTM2MyBoYXMgYWRkaXRp
b25hbCA2NCBieXRlcyBvZg0KPiBSQU0uDQo+ID4NCj4gPiAxIGJ5dGUgb2YgbnZtZW0gaXMgc3Vw
cG9ydGVkIGFuZCBleHBvc2VkIGluIHN5c2ZzICgjIGlzIHRoZSBpbnN0YW5jZQ0KPiA+IG51bWJl
cixzdGFydGluZyB3aXRoIDApOiAvc3lzL2J1cy9udm1lbS9kZXZpY2VzL3BjZjg1eDYzLSMvbnZt
ZW0NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhc0BicC5yZW5lc2Fz
LmNvbT4NCj4gPiAtLS0NCj4gPiAgVjEtLT5WMiBJbmNvcnBvcmF0ZWQgQWxleGFuZHJlIGFuZCBH
ZWVydCdzIHJldmlldyBjb21tZW50Lg0KPg0KPiBUaGFua3MgZm9yIHRoZSB1cGRhdGUhDQo+DQo+
ID4gLS0tIGEvZHJpdmVycy9ydGMvcnRjLXBjZjg1MzYzLmMNCj4gPiArKysgYi9kcml2ZXJzL3J0
Yy9ydGMtcGNmODUzNjMuYw0KPg0KPiA+IEBAIC0zMjEsMTUgKzM0NCwyNSBAQCBzdGF0aWMgaW50
IHBjZjg1MzYzX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCAqaWQpICB7DQo+ID4g
ICAgICAgICBzdHJ1Y3QgcGNmODUzNjMgKnBjZjg1MzYzOw0KPiA+IC0gICAgICAgc3RydWN0IG52
bWVtX2NvbmZpZyBudm1lbV9jZmcgPSB7DQo+ID4gLSAgICAgICAgICAgICAgIC5uYW1lID0gInBj
Zjg1MzYzLSIsDQo+ID4gLSAgICAgICAgICAgICAgIC53b3JkX3NpemUgPSAxLA0KPiA+IC0gICAg
ICAgICAgICAgICAuc3RyaWRlID0gMSwNCj4gPiAtICAgICAgICAgICAgICAgLnNpemUgPSBOVlJB
TV9TSVpFLA0KPiA+IC0gICAgICAgICAgICAgICAucmVnX3JlYWQgPSBwY2Y4NTM2M19udnJhbV9y
ZWFkLA0KPiA+IC0gICAgICAgICAgICAgICAucmVnX3dyaXRlID0gcGNmODUzNjNfbnZyYW1fd3Jp
dGUsDQo+ID4gKyAgICAgICBjb25zdCBzdHJ1Y3QgcmVnbWFwX2NvbmZpZyAqcmVnbWFwX2NvbmZp
ZyA9DQo+ICZwY2ZfODUzNjNfcmVnbWFwX2NvbmZpZzsNCj4gPiArICAgICAgIHN0cnVjdCBudm1l
bV9jb25maWcgbnZtZW1fY2ZnW10gPSB7DQo+DQo+IHN0YXRpYz8NCj4NCj4gQWx0aG91Z2ggdGhl
IG52bWVtX2NvbmZpZyBpcyBjb3BpZWQsIGFuZCB0aHVzIHN0YXRpYyBpcyBub3QgbmVlZGVkLCBJ
IGd1ZXNzDQo+IHVzaW5nIHN0YXRpYyB3aWxsIGRlY3JlYXNlIGtlcm5lbCBzaXplLg0KPg0KPiA+
ICsgICAgICAgICAgICAgICB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgLm5hbWUgPSAi
cGNmODV4NjMtIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAud29yZF9zaXplID0gMSwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAuc3RyaWRlID0gMSwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAuc2l6ZSA9IDEsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgLnJl
Z19yZWFkID0gcGNmODV4NjNfbnZyYW1fcmVhZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAucmVnX3dyaXRlID0gcGNmODV4NjNfbnZyYW1fd3JpdGUsDQo+ID4gKyAgICAgICAgICAgICAg
IH0sIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAubmFtZSA9ICJwY2Y4NTM2My0iLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIC53b3JkX3NpemUgPSAxLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIC5zdHJpZGUgPSAxLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IC5zaXplID0gTlZSQU1fU0laRSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAucmVnX3Jl
YWQgPSBwY2Y4NTM2M19udnJhbV9yZWFkLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIC5y
ZWdfd3JpdGUgPSBwY2Y4NTM2M19udnJhbV93cml0ZSwNCj4gPiArICAgICAgICAgICAgICAgfSwN
Cj4gPiAgICAgICAgIH07DQo+ID4gLSAgICAgICBpbnQgcmV0Ow0KPiA+ICsgICAgICAgaW50IHJl
dCwgaSwgbnVtX252bWVtID0gMjsNCj4gPg0KPiA+ICAgICAgICAgaWYgKCFpMmNfY2hlY2tfZnVu
Y3Rpb25hbGl0eShjbGllbnQtPmFkYXB0ZXIsIEkyQ19GVU5DX0kyQykpDQo+ID4gICAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PREVWOw0KPiA+IEBAIC0zMzksNyArMzcyLDEzIEBAIHN0YXRpYyBp
bnQgcGNmODUzNjNfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCj4gPiAgICAgICAg
IGlmICghcGNmODUzNjMpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+
DQo+ID4gLSAgICAgICBwY2Y4NTM2My0+cmVnbWFwID0gZGV2bV9yZWdtYXBfaW5pdF9pMmMoY2xp
ZW50LCAmcmVnbWFwX2NvbmZpZyk7DQo+ID4gKyAgICAgICBpZiAob2ZfZGV2aWNlX2dldF9tYXRj
aF9kYXRhKCZjbGllbnQtPmRldikgPT0NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJnBjZl84NTI2M19yZWdtYXBfY29uZmlnKSB7DQo+ID4gKyAgICAgICAgICAg
ICAgIHJlZ21hcF9jb25maWcgPSAmcGNmXzg1MjYzX3JlZ21hcF9jb25maWc7DQo+ID4gKyAgICAg
ICAgICAgICAgIG51bV9udm1lbSA9IDE7DQo+DQo+IEkgdGhpbmsgaXQncyBjbGVhbmVyIGlmIHlv
dSBzdG9yZSB0aGUgZnVsbCBjb25maWcgKHJlZ21hcF9jb25maWcgKyBudW1fbnZtZW0pDQo+IGlu
IG9mX2RldmljZV9pZC5kYXRhLCBpbnN0ZWFkIG9mIGp1c3QgdGhlIHJlZ21hcF9jb25maWcsIHVz
aW5nDQo+DQo+ICAgICBzdHJ1Y3QgcGNmODV4NjNfY29uZmlnIHsNCj4gICAgICAgICAgICAgc3Ry
dWN0IHJlZ21hcF9jb25maWcgcmVnbWFwOw0KPiAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgbnVt
X252cmFtOw0KPiAgICAgfTsNCj4NCj4gICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNmODV4NjNf
Y29uZmlnIHBjZjg1MjYzX2NvbmZpZyA9IHsgLi4uIH07DQo+ICAgICBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHBjZjg1eDYzX2NvbmZpZyBwY2Y4NTM2M19jb25maWcgPSB7IC4uLiB9Ow0KPg0KPiAgICAg
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgZGV2X2lkc1tdID0gew0KPiAgICAgICAg
ICAgICB7IC5jb21wYXRpYmxlID0gIm54cCxwY2Y4NTI2MyIsIC5kYXRhID0gJnBjZl84NTI2M19j
b25maWcgfSwNCj4gICAgICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJueHAscGNmODUzNjMiLCAu
ZGF0YSA9ICZwY2ZfODUzNjNfY29uZmlnIH0sDQo+ICAgICAgICAgICAgIHsgLyogc2VudGluZWwg
Ki8gfQ0KPiAgICAgfTsNCj4NCj4gVGhlbiB5b3UgY2FuIGp1c3QgZG8NCj4NCj4gICAgICAgICBz
dHJ1Y3QgcGNmODV4NjNfY29uZmlnICpjb25maWcgPSAmcGNmODUzNjNfY29uZmlnOyAvKiBkZWZh
dWx0IGZvciBub24tRFQNCj4gKi8NCj4gICAgICAgICB2b2lkICpkYXRhID0gb2ZfZGV2aWNlX2dl
dF9tYXRjaF9kYXRhKCZjbGllbnQtPmRldik7DQo+ICAgICAgICAgaWYgKGRhdGEpDQo+ICAgICAg
ICAgICAgICAgICBjb25maWcgPSBkYXRhOw0KPg0KPiA+ICsgICAgICAgfQ0KDQpXaWxsIHNlbmQg
VjMgd2l0aCBhYm92ZSBjaGFuZ2VzLg0KDQpSZWdhcmRzLA0KQmlqdQ0KDQoNCltodHRwczovL3d3
dzIucmVuZXNhcy5ldS9tZWRpYS9lbWFpbC91bmljZWYuanBnXQ0KDQpUaGlzIENocmlzdG1hcywg
aW5zdGVhZCBvZiBzZW5kaW5nIG91dCBjYXJkcywgUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUg
aGF2ZSBkZWNpZGVkIHRvIHN1cHBvcnQgVW5pY2VmIHdpdGggYSBkb25hdGlvbi4gRm9yIGZ1cnRo
ZXIgZGV0YWlscyBjbGljayBoZXJlPGh0dHBzOi8vd3d3LnVuaWNlZi5vcmcvPiB0byBmaW5kIG91
dCBhYm91dCB0aGUgdmFsdWFibGUgd29yayB0aGV5IGRvLCBoZWxwaW5nIGNoaWxkcmVuIGFsbCBv
dmVyIHRoZSB3b3JsZC4NCldlIHdvdWxkIGxpa2UgdG8gdGFrZSB0aGlzIG9wcG9ydHVuaXR5IHRv
IHdpc2ggeW91IGEgTWVycnkgQ2hyaXN0bWFzIGFuZCBhIHByb3NwZXJvdXMgTmV3IFllYXIuDQoN
Cg0KDQpSZW5lc2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBMdGQsIER1a2VzIE1lYWRvdywgTWlsbGJv
YXJkIFJvYWQsIEJvdXJuZSBFbmQsIEJ1Y2tpbmdoYW1zaGlyZSwgU0w4IDVGSCwgVUsuIFJlZ2lz
dGVyZWQgaW4gRW5nbGFuZCAmIFdhbGVzIHVuZGVyIFJlZ2lzdGVyZWQgTm8uIDA0NTg2NzA5Lg0K
