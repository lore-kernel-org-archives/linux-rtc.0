Return-Path: <SRS0=WBM2=OT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A3BC04EB8
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 12:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1485E20821
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 12:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="boArms6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1485E20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeLJMpR (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:45:17 -0500
Received: from mail-eopbgr1400124.outbound.protection.outlook.com ([40.107.140.124]:33986
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726472AbeLJMpR (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 10 Dec 2018 07:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUF9du+0C7ZoMk7abw+FkRErIA8KlBsJ5HSBBaUtcWs=;
 b=boArms6GCJiuARypi8YO6NDrrTTkINtBSu+jxSLk7XjEjvrxNFsxq9DV5eBmIgHXHpAiiREelNYAut2j7+stHxMmd46gJ/4C5RCRlpob3RoisJCr7zOnNBC5m1EZculObxRWVP/uxK4gAbRUsvubHHqHDI60pEhDD8zMGZFnA+Y=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB2184.jpnprd01.prod.outlook.com (52.134.242.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 12:45:12 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%5]) with mapi id 15.20.1404.021; Mon, 10 Dec 2018
 12:45:12 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 1/5] nvmem: check invalid number of bytes in
 nvmem_device_{read,write}
Thread-Topic: [PATCH v4 1/5] nvmem: check invalid number of bytes in
 nvmem_device_{read,write}
Thread-Index: AQHUjiEXM+YDAsf+QUO3YGAaDLWV+6V37dwA////cmA=
Date:   Mon, 10 Dec 2018 12:45:12 +0000
Message-ID: <OSBPR01MB21034A6FB7EF6E877DA0F151B8A50@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
 <1544182066-31528-2-git-send-email-biju.das@bp.renesas.com>
 <3c09d148-7102-1ee5-770a-009e40de6168@linaro.org>
In-Reply-To: <3c09d148-7102-1ee5-770a-009e40de6168@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2184;20:qxZhanUxjsuqFkLzoTG/vw77jLefJ903nsG1hulkGkLR07xiREZ5E6PNQuuwG2+6QmqNXu10CPRNiuBJMlr32LOexL1bejJ7VUAi1/XQDPIWHt9G62QnLIq5GjT0r0vj33pD0IX04Kf+zWGFWXNAjTwYtFqJCX5ZWY9+yzlDvj4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 8e2d37d3-8e02-4126-0606-08d65e9d537c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2184;
x-ms-traffictypediagnostic: OSBPR01MB2184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-microsoft-antispam-prvs: <OSBPR01MB21842AB94CFAE4B5CDD22E47B8A50@OSBPR01MB2184.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB2184;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2184;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(39860400002)(346002)(376002)(51914003)(189003)(199004)(4326008)(229853002)(10126004)(8676002)(68736007)(486006)(305945005)(102836004)(8936002)(106356001)(14444005)(256004)(33656002)(7696005)(53936002)(14454004)(9686003)(316002)(105586002)(25786009)(6246003)(55016002)(54906003)(110136005)(99286004)(6306002)(81156014)(478600001)(81166006)(5660300001)(97736004)(86362001)(6506007)(71190400001)(11346002)(76176011)(71200400001)(476003)(446003)(6116002)(6436002)(74316002)(186003)(66066001)(7736002)(2906002)(3846002)(26005)(44832011)(53546011)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2184;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: U+YnHIIHl4bbVjq9Tlqf1h9a4p27AjEf6WkErc2TPuOk7dX38um4RDJ5n+okpcX3M4pax4M28nKBsdEm5VYSajGvKQNiyIBik8HWZAPzWRUt4taVbr5HMtPLKqy+konDsxGzdON91W4dt8EUVvXwiHJUlaUiSlwV+uSh9dufUR3tuQ/ScAjR3mCs5z/CtsvwzXJrliJ2dSYY82YLzMT9BYWlckDNF8Pi/MvLiIH71poWgJAzzu3F/QzIXcxGabbsbGSEMgsXfHbKwCWcdz7WvrW+092/j4hqU/xa29tcWQnZUOL47NeOhR0f0o2DlwGQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2d37d3-8e02-4126-0606-08d65e9d537c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 12:45:12.0695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2184
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

SGkgU3Jpbml2YXMsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjQgMS81XSBudm1lbTogY2hlY2sgaW52YWxpZCBudW1iZXIgb2YgYnl0ZXMgaW4N
Cj4gbnZtZW1fZGV2aWNlX3tyZWFkLHdyaXRlfQ0KPg0KPiBUaGFua3MgZm9yIHRoZSBwYXRjaC4N
Cj4NCj4gT24gMDcvMTIvMTggMTE6MjcsIEJpanUgRGFzIHdyb3RlOg0KPiA+IEFkZCBjaGVjayBp
biBudm1lbV9kZXZpY2Vfe3JlYWQsd3JpdGV9KCl0byBlbnN1cmUgdGhhdCBudm1lbSBjb3JlDQo+
ID4gbmV2ZXIgcGFzc2VzIGFuIGludmFsaWQgbnVtYmVyIG9mIGJ5dGVzLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzQGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0K
PiA+IFYzLS0+VjQNCj4gPiAqIE5ldyBwYXRjaC4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbnZt
ZW0vY29yZS5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4NCj4gSXRzIGJl
dHRlciB0byBtb3ZlIGNoZWNrcyBmcm9tDQo+IGJpbl9hdHRyX252bWVtX3JlYWQoKS9iaW5fYXR0
cl9udm1lbV93cml0ZSgpIGludG8gbnZtZW1fcmVnX3JlYWQoKQ0KPiBhbmQgbnZtZW1fcmVnX3dy
aXRlKCksIHNvIGl0cyBlYXN5IHRvIG1haW50YWluLCByYXRoZXIgdGhhbiBhZGRpbmcgdGhlbSB0
bw0KPiBlYWNoIGZ1bmN0aW9uLg0KDQpJbml0aWFsbHkgSSBhbHNvIHRob3VnaHQgdGhlIHNhbWUu
IEJ1dCB0aGVyZSBhcmUgc29tZSBSVEMgZHJpdmVycyB3aGljaCBpcyB1c2luZyBudm1lbV9kZXZp
Y2UNCmludGVyZmFjZSAgaXMgbm90IGRlZmluaW5nICJ3b3JkX3NpemUiICBtZW1iZXIuIFRoYXQg
aXMgdGhlIHJlYXNvbiB3ZSBuZWVkIHRvIGFkZCBpdCBpbiBzZXBhcmF0ZSBmdW5jdGlvbi4NCkNh
biB5b3UgcGxlYXNlIHN1Z2dlc3QgaG93IHRvIGhhbmRsZSB0aGUgYWJvdmUgZHJpdmVycz8NCg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWVtL2NvcmUuYyBiL2RyaXZlcnMvbnZtZW0vY29y
ZS5jIGluZGV4DQo+ID4gZDlmZDExMC4uZGI3ZGUzMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L252bWVtL2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbnZtZW0vY29yZS5jDQo+ID4gQEAgLTE0
MzMsMTAgKzE0MzMsMjEgQEAgaW50IG52bWVtX2RldmljZV9yZWFkKHN0cnVjdCBudm1lbV9kZXZp
Y2UNCj4gKm52bWVtLA0KPiA+ICAgICAgICAgc2l6ZV90IGJ5dGVzLCB2b2lkICpidWYpDQo+ID4g
ICB7DQo+ID4gICBpbnQgcmM7DQo+ID4gK3NpemVfdCBuZXdfYnl0ZXM7DQo+ID4NCj4gPiAgIGlm
ICghbnZtZW0pDQo+ID4gICByZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+ICsvKiBTdG9wIHRoZSB1
c2VyIGZyb20gcmVhZGluZyAqLw0KPiA+ICtpZiAoKG9mZnNldCA+PSBudm1lbS0+c2l6ZSkgfHwg
KGJ5dGVzID09IDApKQ0KPiA+ICtyZXR1cm4gMDsNCj4gPiArDQo+ID4gK2lmICh1bmxpa2VseShj
aGVja19hZGRfb3ZlcmZsb3coYnl0ZXMsIG9mZnNldCwgJm5ld19ieXRlcykpKQ0KPiA+ICtyZXR1
cm4gLUVPVkVSRkxPVzsNCj4gPiArDQo+ID4gK2lmIChuZXdfYnl0ZXMgPiBudm1lbS0+c2l6ZSkN
Cj4gPiArYnl0ZXMgPSBudm1lbS0+c2l6ZSAtIG9mZnNldDsNCj4gPiArDQo+ID4gICByYyA9IG52
bWVtX3JlZ19yZWFkKG52bWVtLCBvZmZzZXQsIGJ1ZiwgYnl0ZXMpOw0KPiA+DQo+ID4gICBpZiAo
cmMpDQo+ID4gQEAgLTE0NjEsMTYgKzE0NzIsMjkgQEAgaW50IG52bWVtX2RldmljZV93cml0ZShz
dHJ1Y3QNCj4gbnZtZW1fZGV2aWNlICpudm1lbSwNCj4gPiAgICAgICAgICBzaXplX3QgYnl0ZXMs
IHZvaWQgKmJ1ZikNCj4gPiAgIHsNCj4gPiAgIGludCByYzsNCj4gPiArc2l6ZV90IG5ld19ieXRl
czsNCj4gPg0KPiA+ICAgaWYgKCFudm1lbSkNCj4gPiAgIHJldHVybiAtRUlOVkFMOw0KPiA+DQo+
ID4gKy8qIFN0b3AgdGhlIHVzZXIgZnJvbSB3cml0aW5nICovDQo+ID4gK2lmIChvZmZzZXQgPj0g
bnZtZW0tPnNpemUpDQo+ID4gK3JldHVybiAtRU5PU1BDOw0KPiA+ICsNCj4gPiAraWYgKGJ5dGVz
ID09IDApDQo+ID4gK3JldHVybiAwOw0KPiA+ICsNCj4gPiAraWYgKHVubGlrZWx5KGNoZWNrX2Fk
ZF9vdmVyZmxvdyhieXRlcywgb2Zmc2V0LCAmbmV3X2J5dGVzKSkpDQo+ID4gK3JldHVybiAtRU9W
RVJGTE9XOw0KPiA+ICsNCj4gPiAraWYgKG5ld19ieXRlcyA+IG52bWVtLT5zaXplKQ0KPiA+ICti
eXRlcyA9IG52bWVtLT5zaXplIC0gb2Zmc2V0Ow0KPiA+ICsNCj4gPiAgIHJjID0gbnZtZW1fcmVn
X3dyaXRlKG52bWVtLCBvZmZzZXQsIGJ1ZiwgYnl0ZXMpOw0KPiA+DQo+ID4gICBpZiAocmMpDQo+
ID4gICByZXR1cm4gcmM7DQo+ID4NCj4gPiAtDQo+DQo+IFVucmVsYXRlZCBjaGFuZ2UhDQoNCkkg
IGZvdW5kIGFuIGV4dHJhIHNwYWNlIGluIHRoaXMgZnVuY3Rpb24uICBJZiBpdCBpcyBhIHByb2Js
ZW0sIEkgd2lsbCBzZW5kIFYyIGZvciB1bmRvaW5nIHRoaXMuDQpQbGVhc2UgbGV0IG1lIGtub3cu
DQoNClJlZ2FyZHMsDQpCaWp1DQoNCg0KW2h0dHBzOi8vd3d3Mi5yZW5lc2FzLmV1L21lZGlhL2Vt
YWlsL3VuaWNlZi5qcGddDQoNClRoaXMgQ2hyaXN0bWFzLCBpbnN0ZWFkIG9mIHNlbmRpbmcgb3V0
IGNhcmRzLCBSZW5lc2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBoYXZlIGRlY2lkZWQgdG8gc3VwcG9y
dCBVbmljZWYgd2l0aCBhIGRvbmF0aW9uLiBGb3IgZnVydGhlciBkZXRhaWxzIGNsaWNrIGhlcmU8
aHR0cHM6Ly93d3cudW5pY2VmLm9yZy8+IHRvIGZpbmQgb3V0IGFib3V0IHRoZSB2YWx1YWJsZSB3
b3JrIHRoZXkgZG8sIGhlbHBpbmcgY2hpbGRyZW4gYWxsIG92ZXIgdGhlIHdvcmxkLg0KV2Ugd291
bGQgbGlrZSB0byB0YWtlIHRoaXMgb3Bwb3J0dW5pdHkgdG8gd2lzaCB5b3UgYSBNZXJyeSBDaHJp
c3RtYXMgYW5kIGEgcHJvc3Blcm91cyBOZXcgWWVhci4NCg0KDQoNClJlbmVzYXMgRWxlY3Ryb25p
Y3MgRXVyb3BlIEx0ZCwgRHVrZXMgTWVhZG93LCBNaWxsYm9hcmQgUm9hZCwgQm91cm5lIEVuZCwg
QnVja2luZ2hhbXNoaXJlLCBTTDggNUZILCBVSy4gUmVnaXN0ZXJlZCBpbiBFbmdsYW5kICYgV2Fs
ZXMgdW5kZXIgUmVnaXN0ZXJlZCBOby4gMDQ1ODY3MDkuDQo=
