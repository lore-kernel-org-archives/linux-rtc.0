Return-Path: <SRS0=6w/U=QT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0164BC169C4
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 01:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93E621855
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 01:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="C8t9pF3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfBLBay (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:30:54 -0500
Received: from mail-eopbgr780093.outbound.protection.outlook.com ([40.107.78.93]:16696
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726300AbfBLBay (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 11 Feb 2019 20:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+AjgrrRGunchGkRCTt0kf8WjsB+l0FBBSQcFdtbJ7o=;
 b=C8t9pF3+gS4tYv8DcfgWIn9fWLgPCdoEzRSCEEYaEdyb/YymGnCC5DmhpDAZWL8n2M+UtXeatZFb1X02R417qKgftGbwR9vjSch9qeCUbIwBp6gMXlRWj5CFfkJNrJoeY6o88xOjKbIyzHfCyRmoeqj8nzQ+qPlkTacCnffhTLk=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 12 Feb 2019 01:30:50 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 01:30:50 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>
Subject: Re: [PATCH 2/3] rtc: isl1208: Support more chip variations
Thread-Topic: [PATCH 2/3] rtc: isl1208: Support more chip variations
Thread-Index: AQHUumY6Zh3btsQK1Ee52DDoz6OY/KXZleiAgAHadoA=
Date:   Tue, 12 Feb 2019 01:30:50 +0000
Message-ID: <1549935049.3075.118.camel@impinj.com>
References: <20190201194147.25885-1-tpiepho@impinj.com>
         <20190201194147.25885-2-tpiepho@impinj.com>
         <20190210211239.GH23062@piout.net>
In-Reply-To: <20190210211239.GH23062@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b189ae9-6c43-4379-4e52-08d69089b8f4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3708;
x-ms-traffictypediagnostic: MWHPR0601MB3708:
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3708;20:Gs22rHy7qaBw/HOOVf3G2YZLQh+b9XEcRSxa3vTjbG1VvfjievYVePUTsrJW2RrWjYLA2OR3cSwWAE38xWwaCvaDZ2cQRRM5wItkZJzs0l1iAf0650IuYxgfkPjC1h3yqjEdhnbcyx6W4aThMm2fSfPWjZ4VmfOUIod8Gb8K/wE=
x-microsoft-antispam-prvs: <MWHPR0601MB370836FA989B45AA9293040DD3650@MWHPR0601MB3708.namprd06.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(346002)(136003)(366004)(376002)(199004)(189003)(2351001)(6436002)(81156014)(8936002)(14454004)(103116003)(81166006)(229853002)(68736007)(2906002)(2501003)(6512007)(8676002)(25786009)(105586002)(106356001)(316002)(256004)(71190400001)(71200400001)(6486002)(97736004)(5640700003)(478600001)(102836004)(305945005)(186003)(66066001)(7736002)(26005)(86362001)(76176011)(6506007)(6916009)(6246003)(53936002)(99286004)(4326008)(2616005)(6116002)(486006)(476003)(11346002)(446003)(3846002)(36756003)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3708;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w5K6c/w0rJhz03d8p/e+gwXHwiVBbOCtHZTQpRgkfOfvFzXZCjx+9kTqFlZoYRC9keUm5bX0dPJU6Xbhdcvl3yKTAcN9sB0dIWJwHY58r8HZQQqpYOiAr3R/xKyOBE+4SsMZOebNwB2ngv+ElVryQdPd3yeg8/9m9zlDRI9Q+mrnYhOTL4rrcQKJXYJe/w6PNFbNGEFAggvZ0O2wdn2V83GjzvvJd9qe8OR4I/NPUTRCVWkINP30VDtfNjirmTnhBqMMtx0T3QBVaOoEX6f7NlfrIDb5pfhzZb2CG4f5QXoVHLEjpjFbhcZO3oIFs9HM7giqJ02jorQm1wY4JlW6aZ06iYpohjHuL1BAcu4LMKQuNTVzVLD0rhJ64yW8kyyubn899dZj7yT5Tf9ckVrkrkE8gtXnwLjt+OgQ0T89wAU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D164BC33FC64EC439AF329192FF1E270@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b189ae9-6c43-4379-4e52-08d69089b8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 01:30:50.6110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3708
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

T24gU3VuLCAyMDE5LTAyLTEwIGF0IDIyOjEyICswMTAwLCBBbGV4YW5kcmUgQmVsbG9uaSB3cm90
ZToNCj4gK307DQo+ID4gK01PRFVMRV9ERVZJQ0VfVEFCTEUoaTJjLCBpc2wxMjA4X2lkKTsNCj4g
PiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlzbDEyMDhfb2ZfbWF0
Y2hbXSA9IHsNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAiaXNpbCxpc2wxMjA4IiwgLmRhdGEgPSAm
aXNsMTIwOF9jb25maWdzW1RZUEVfSVNMMTIwOF0gfSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAi
aXNpbCxpc2wxMjA5IiwgLmRhdGEgPSAmaXNsMTIwOF9jb25maWdzW1RZUEVfSVNMMTIwOV0gfSwN
Cj4gDQo+IFRoaXMgY29tcGF0aWJsZSBuZWVkcyB0byBiZSBkb2N1bWVudGVkLg0KDQpJIHNlZSBp
c2lsLGlzbDEyMTkgZXNjYXBlZCBkb2N1bWVudGF0aW9uIHdoZW4gaXQgd2FzIGFkZGVkIHRvby4g
IEknbGwNCmFkZCBib3RoIHRvIHJ0Yy50eHQuDQoNCj4gPiAgDQo+ID4gIAlyZXR1cm4gaGFuZGxl
ZCA/IElSUV9IQU5ETEVEIDogSVJRX05PTkU7DQo+ID4gQEAgLTc0Myw2ICs3NzgsMTkgQEAgaXNs
MTIwOF9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LCBjb25zdCBzdHJ1Y3QgaTJjX2Rl
dmljZV9pZCAqaWQpDQo+ID4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4gIAlpMmNfc2V0X2NsaWVu
dGRhdGEoY2xpZW50LCBpc2wxMjA4KTsNCj4gPiAgDQo+ID4gKwkvKiBEZXRlcm1pbmUgd2hpY2gg
Y2hpcCB3ZSBoYXZlICovDQo+ID4gKwlpZiAoY2xpZW50LT5kZXYub2Zfbm9kZSkgew0KPiA+ICsJ
CWNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm1hdGNoID0NCj4gPiArCQkJb2ZfbWF0Y2hfbm9k
ZShpc2wxMjA4X29mX21hdGNoLCBjbGllbnQtPmRldi5vZl9ub2RlKTsNCj4gPiArCQlpZiAoIW1h
dGNoKQ0KPiANCj4gVGhpcyB3aWxsIG5ldmVyIGhhcHBlbiwgZWxzZSB0aGUgZHJpdmVyIHdvdWxk
IG5vdCBiZSBwcm9iZWQuDQoNCklmIHRoZXJlIHdhcyBhIGRyaXZlcl9vdmVycmlkZSBhYmlsaXR5
IHdpdGggaTJjLCBsaWtlIFBDSSBhbmQgU1BJLCB0aGVuDQppdCB3b3VsZCBiZSBwb3NzaWJsZS4N
Cg0KPiANCj4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwkJaXNsMTIwOC0+Y29uZmlnID0g
bWF0Y2gtPmRhdGE7DQo+IA0KPiBNYXliZSB5b3Ugc2hvdWxkIHVzZSBvZl9kZXZpY2VfZ2V0X21h
dGNoX2RhdGEgYW55d2F5Lg0KDQpZZXMsIG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgpIHdvdWxk
IGJlIGJldHRlci4gIE5vdCBzdXJlIHdoeSBJIGRpZG4ndA0KZmluZCB0aGF0Lg0KDQpJbnRlcmVz
dGluZ2x5LCBJIHNlZSBjb3VsZCBoYXZlIGp1c3QgZGVwZW5kZWQgb24gaWQtPmRyaXZlcl9kYXRh
IGJlaW5nDQpzZXQgZXZlbiBpbiB0aGUgT0YgY2FzZSwgYXMgdGhlIGkyYy1jb3JlIGNvZGUgYWx3
YXlzIHNldHMgaXQuICBCdXQgaXQNCmxvb2sgdG8gYmUgZGVwcmVjYXRlZCBhbmQgaTJjIGNsaWVu
dHMgc2hvdWxkIHByb3ZpZGUgYSBwcm9iZV9uZXcgbWV0aG9kDQp0aGF0IGRvZXMgbm90IHByb3Zp
ZGUgYW4gaTJjX2RldmljZV9pZC4gIEknbSBub3Qgc3VyZSBpZiB0aGF0J3MNCmVudGlyZWx5IGJl
dHRlciwgYXMgZXZlcnkgaTJjIGNsaWVudCB0aGF0IGNhcmVzIHdpbGwgbmVlZCB0byByZS0NCmlt
cGxlbWVudCB0aGUgY29kZSB0byBsb29rIHVwIGJ5IGRldmljZSBuYW1lIGFuZC9vciBPRiBub2Rl
IGFuZC9vcg0KQUNQSS4NCg0KPiANCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJaWYgKGlkLT5kcml2
ZXJfZGF0YSA+PSBJU0xfTEFTVF9JRCkNCj4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiBU
aGlzIHNob3VsZCBiZSAtRU5PREVWLg0KDQpUaGVyZSdzIHF1aXRlIGEgZmV3IGRyaXZlcnMgdGhh
dCByZXR1cm4gRUlOVkFMIHdoZW4gdGhlIGRyaXZlcl9kYXRhDQphcHBlYXJzIHRvIGJlIGluY29y
cmVjdC4gIEJ1dCBzb21lIGFsc28gcmV0dXJuIEVOT0RFVi4NCg==
