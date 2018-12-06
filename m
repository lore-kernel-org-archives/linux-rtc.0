Return-Path: <SRS0=to0F=OP=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07224C64EB1
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 15:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C8020868
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Toq/OO17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C8020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbeLFPY4 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:24:56 -0500
Received: from mail-eopbgr1400127.outbound.protection.outlook.com ([40.107.140.127]:3040
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbeLFPYz (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 6 Dec 2018 10:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uegwJyXI/P8R4IJlSlgbLhwlq+YWV4sq5rN/09gPNs=;
 b=Toq/OO17TgtF18GYBuVE04ilCoDHPzipQilRIfy67yV8xZxCBVru+KQIbgO5sg8ybgFp0+gPWptBlvpQ2uu8GPex786dPXrRc4F0gDg81Op+VCkkXErVqLiEWvjQfBpJYbuWLs1Yrr+fK3aLWV4tCPR8QcDJJCx0YT8jAP8ISaw=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB1911.jpnprd01.prod.outlook.com (52.134.239.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 15:24:48 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%5]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 15:24:48 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: RE: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
Thread-Topic: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
Thread-Index: AQHUjUK6JpQnuqQbm02UjS4gg3wPT6VxdJKAgAA9DyA=
Date:   Thu, 6 Dec 2018 15:24:48 +0000
Message-ID: <OSBPR01MB21039D89E5E8852574A18893B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com>
 <1544086559-47141-3-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdVv262dM8JGWN4w3h2kq4Y4ftRczn8TF-kM_fecF4GXnw@mail.gmail.com>
In-Reply-To: <CAMuHMdVv262dM8JGWN4w3h2kq4Y4ftRczn8TF-kM_fecF4GXnw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1911;20:bg73pzUhSLt6RdO/t4Cm1mH294wr0GHb1BijJw0rxW2bLZcD05UEjIaENYDNwUOgH1twaYqdn/bpCJZJqwRHUAG/h5jI3uisBasLzbbu6B+UQWIyCZZwsBD1+vTtSCs9UKmT9OvDxbDQxK05B9UBcuirdslur7Q0WtbtYt0h7eU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: f21b599d-f53a-4af0-615e-08d65b8ef5bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1911;
x-ms-traffictypediagnostic: OSBPR01MB1911:
x-microsoft-antispam-prvs: <OSBPR01MB1911901ED896C99571AC4383B8A90@OSBPR01MB1911.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB1911;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1911;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(136003)(366004)(396003)(51914003)(189003)(199004)(55016002)(11346002)(6506007)(53546011)(7696005)(81156014)(81166006)(102836004)(44832011)(476003)(8936002)(446003)(26005)(8676002)(186003)(6246003)(33656002)(71200400001)(66066001)(71190400001)(486006)(14444005)(256004)(76176011)(53936002)(5660300001)(7736002)(305945005)(6916009)(229853002)(6436002)(68736007)(478600001)(9686003)(25786009)(3846002)(316002)(54906003)(105586002)(4326008)(14454004)(99286004)(86362001)(6116002)(10126004)(6306002)(2906002)(106356001)(74316002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1911;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M2OK6ns6qjQKQZOtcoAgFAvvzkcVUcHYVsBxQJo6Z8W7lJ7DJh4qrWNk9FoB5hVeUxXJtYM1SeIPW9l8eAbvi1ehsskX+UGqUsOoqHs5oyFq5yvWMZA7jgBEqU4+HtOracR6U9SHmrRk6ITohIr6FsF1CCsKgXa7/v84t70Hf0HY3RV6BUSdf6k7O7nUkulJpxcQF30STzV79mZOInjXCTfG/ItWb8oBrnkk/7JAEMBbQAkCVf/BCwYAhruiwR8ngJDqd1qWR1uQJ1xhzyPT5w/glBFTmoErvxurRKh8E24wPonbXWpJgjqsRGz1UunCEODGgf1SNnfLJ5UqPlK5gQOMrSKkGYJmjNetY2hHCWI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21b599d-f53a-4af0-615e-08d65b8ef5bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 15:24:48.4296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1911
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgZmVlZGJhY2suDQoNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MyAyLzRdIHJ0YzogcGNmODUzNjM6IEFkZCBzdXBwb3J0IGZvciBOWFAgcGNmODUyNjMgcnRj
DQo+DQo+IEhpIEJpanUsDQo+DQo+IENDIG52bWVtIG1haW50YWluZXINCj4NCj4gT24gVGh1LCBE
ZWMgNiwgMjAxOCBhdCAxMDowNCBBTSBCaWp1IERhcyA8YmlqdS5kYXNAYnAucmVuZXNhcy5jb20+
IHdyb3RlOg0KPiA+IEFkZCBzdXBwb3J0IGZvciBOWFAgcGNmODUyNjMgcmVhbC10aW1lIGNsb2Nr
LiBwY2Y4NTI2MyBydGMgaXMNCj4gPiBjb21wYXRpYmxlIHdpdGggcGNmODUzNjMsZXhjZXB0IHRo
YXQgcGNmODUzNjMgaGFzIGFkZGl0aW9uYWwgNjQgYnl0ZXMgb2YNCj4gUkFNLg0KPiA+DQo+ID4g
MSBieXRlIG9mIG52bWVtIGlzIHN1cHBvcnRlZCBhbmQgZXhwb3NlZCBpbiBzeXNmcyAoIyBpcyB0
aGUgaW5zdGFuY2UNCj4gPiBudW1iZXIsc3RhcnRpbmcgd2l0aCAwKTogL3N5cy9idXMvbnZtZW0v
ZGV2aWNlcy9wY2Y4NXg2My0jL252bWVtDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERh
cyA8YmlqdS5kYXNAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gVjEtLT5WMg0KPiA+ICAg
ICAgICAgKiBJbmNvcnBvcmF0ZWQgQWxleGFuZHJlIGFuZCBHZWVydCdzIHJldmlldyBjb21tZW50
Lg0KPiA+IFYyLS0+VjMNCj4gPiAgICAgICAgICogSW5jb3Jwb3JhdGVkIEdlZXJ0J3MgcmV2aWV3
IGNvbW1lbnQuDQo+DQo+IFRoYW5rcyBmb3IgdGhlIHVwZGF0ZSENCj4NCj4gPiAtLS0gYS9kcml2
ZXJzL3J0Yy9ydGMtcGNmODUzNjMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcnRjL3J0Yy1wY2Y4NTM2
My5jDQo+ID4gQEAgLTEyMCw2ICsxMjAsMTEgQEAgc3RydWN0IHBjZjg1MzYzIHsNCj4gPiAgICAg
ICAgIHN0cnVjdCByZWdtYXAgICAgICAgICAgICpyZWdtYXA7DQo+ID4gIH07DQo+ID4NCj4gPiAr
c3RydWN0IHBjZjg1eDYzX2NvbmZpZyB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcmVnbWFwX2NvbmZp
ZyByZWdtYXA7DQo+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgbnVtX252cmFtOw0KPiA+ICt9Ow0K
PiA+ICsNCj4gPiAgc3RhdGljIGludCBwY2Y4NTM2M19ydGNfcmVhZF90aW1lKHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IHJ0Y190aW1lDQo+ID4gKnRtKSAgew0KPiA+ICAgICAgICAgc3RydWN0
IHBjZjg1MzYzICpwY2Y4NTM2MyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOyBAQCAtMzExLDI1DQo+
ID4gKzMxNiw2OCBAQCBzdGF0aWMgaW50IHBjZjg1MzYzX252cmFtX3dyaXRlKHZvaWQgKnByaXYs
IHVuc2lnbmVkIGludA0KPiBvZmZzZXQsIHZvaWQgKnZhbCwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2YWwsIGJ5dGVzKTsgIH0NCj4gPg0KPiA+IC1zdGF0aWMgY29uc3Qg
c3RydWN0IHJlZ21hcF9jb25maWcgcmVnbWFwX2NvbmZpZyA9IHsNCj4gPiAtICAgICAgIC5yZWdf
Yml0cyA9IDgsDQo+ID4gLSAgICAgICAudmFsX2JpdHMgPSA4LA0KPiA+IC0gICAgICAgLm1heF9y
ZWdpc3RlciA9IDB4N2YsDQo+ID4gK3N0YXRpYyBpbnQgcGNmODV4NjNfbnZyYW1fcmVhZCh2b2lk
ICpwcml2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LCB2b2lkICp2YWwsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNpemVfdCBieXRlcykNCj4NCj4gR2l2ZW4gYnl0ZXMgc2hvdWxk
IGJlIDEsIHZhbCBzaG91bGQgYmUgYSBwb2ludGVyIHRvIGEgc2luZ2xlIGJ5dGUuLi4NCj4gV2hh
dCBpZiBieXRlcyA9PSAwPw0KDQpJIGRvdWJ0IHdlIGdldCAiYnl0ZXM9PTAiIGJlY2F1c2Ugb2Yg
dGhlIGNoZWNrcyBpbiAiIGRyaXZlcnMvbnZtZW0vY29yZS5jIg0KRnVuY3Rpb24gIiBiaW5fYXR0
cl9udm1lbV9yZWFkLyBiaW5fYXR0cl9udm1lbV93cml0ZSIuDQoNCg0KPiA+ICt7PiArICAgICAg
IHN0cnVjdCBwY2Y4NTM2MyAqcGNmODUzNjMgPSBwcml2Ow0KPiA+ICsNCj4gPiArICAgICAgIHJl
dHVybiByZWdtYXBfcmVhZChwY2Y4NTM2My0+cmVnbWFwLCBDVFJMX1JBTUJZVEUsIHZhbCk7DQo+
DQo+IEhvd2V2ZXIsIHJlZ21hcF9yZWFkKCkgaGFzIGFuIHVuc2lnbmVkIGludCBvdXRwdXQgcGFy
YW1ldGVyIQ0KPiBTbyBpdCdzIHdyaXRpbmcgdG9vIG1hbnkgYnl0ZXMsIGFuZCBvbmx5IHdyaXRp
bmcgdGhlIGFjdHVhbCBkYXRhIGJ5dGUgdG8gdGhlDQo+IGNvcnJlY3QgYWRkcmVzcyBvbiBsaXR0
bGUtZW5kaWFuIHN5c3RlbXMuDQo+IEhlbmNlIHlvdSBuZWVkIHRvIHVzZSBhbiBpbnRlcm1lZGlh
dGUgdmFyaWFibGUgdG8gY29udmVydCBmcm9tIHVuc2lnbmVkIGludA0KPiB0byBieXRlLg0KDQpP
Sy4gV2lsbCB1c2UgYW4gaW50ZXJtZWRpYXRlIGludGVnZXIgdmFyaWFibGUuDQoNCj4gPiArfQ0K
PiA+ICsNCj4gPiArc3RhdGljIGludCBwY2Y4NXg2M19udnJhbV93cml0ZSh2b2lkICpwcml2LCB1
bnNpZ25lZCBpbnQgb2Zmc2V0LCB2b2lkICp2YWwsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzaXplX3QgYnl0ZXMpIHsNCj4gPiArICAgICAgIHN0cnVjdCBwY2Y4NTM2MyAq
cGNmODUzNjMgPSBwcml2Ow0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiByZWdtYXBfd3JpdGUo
cGNmODUzNjMtPnJlZ21hcCwgQ1RSTF9SQU1CWVRFLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKigodW5zaWduZWQgaW50ICopdmFsKSk7DQo+DQo+IExpa2V3aXNlIGZvciB3
cml0aW5nLg0KPg0KPiA+ICt9DQo+DQo+IEJUVywgd2hpbGUgdGhlIG52bWVtX2RldmljZV97cmVh
ZCx3cml0ZX0oKSBwdWJsaWMgQVBJIGlzIGRvY3VtZW50ZWQsIHRoZQ0KPiBudm1lbV9kZXZpY2Uu
cmVnX3tyZWFkLHdyaXRlfSgpIGRyaXZlciBBUEkgaXNuJ3QuDQo+IEFuZCB0aGUgYmVoYXZpb3Ig
bWlnaHQgYmUgY29uZnVzaW5nLg0KPg0KPiBFLmcuDQo+ICAqIFJldHVybjogbGVuZ3RoIG9mIHN1
Y2Nlc3NmdWwgYnl0ZXMgcmVhZCBvbiBzdWNjZXNzIGFuZCBuZWdhdGl2ZQ0KPiAgKiBlcnJvciBj
b2RlIG9uIGVycm9yLg0KPg0KPiBUaGUgcHVibGljIEFQSSBzZWVtcyB0byBhc3N1bWUgdGhlIGRy
aXZlciBBUEkgcmV0dXJucyB6ZXJvIG9uIHN1Y2Nlc3MsIGFuZA0KPiByZXBsYWNlcyB0aGUgemVy
byBieSB0aGUgbnVtYmVyIG9mIGJ5dGVzIHJlcXVlc3RlZC4NCj4gSWYgdGhlIHJlcXVlc3RlZCBu
dW1iZXIgb2YgYnl0ZXMgaXMgdG9vIGxhcmdlLCBhIHplcm8gc3VjY2VzcyB3b3VsZCBiZQ0KPiBj
b252ZXJ0ZWQgdG8gYSB2YWx1ZSB0aGF0J3MgbGFyZ2VyIHRoYW4gdGhlIGFjdHVhbCBudW1iZXIg
b2YgYnl0ZXMNCj4gdHJhbnNmZXJyZWQhDQo+IEhvd2V2ZXIsIHRoZSBkcml2ZXIgQVBJIGNhbiBy
ZXR1cm4gYSBzbWFsbGVyIChwb3NpdGl2ZSkgbnVtYmVyLCB3aGljaA0KPiBtYXRjaGVzICJzdGFu
ZGFyZCIgcmVhZC93cml0ZSgpIEFQSXMuDQo+DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcGNm
ODV4NjNfY29uZmlnIHBjZl84NTI2M19jb25maWcgPSB7DQo+ID4gKyAgICAgICB7DQo+ID4gKyAg
ICAgICAgICAgICAgIC5yZWdfYml0cyA9IDgsDQo+ID4gKyAgICAgICAgICAgICAgIC52YWxfYml0
cyA9IDgsDQo+ID4gKyAgICAgICAgICAgICAgIC5tYXhfcmVnaXN0ZXIgPSAweDJmLA0KPiA+ICsg
ICAgICAgfSwNCj4gPiArICAgICAgIDENCj4NCj4gVGhlICIxIiBsb29rcyBmdW5ueS4gUGxlYXNl
IHVzZSBDOTkgaW5pdGlhbGl6ZXJzIGZvciBhbGwgc3RydWN0IG1lbWJlcnMuDQoNCk9LIHdpbGwg
Zml4IHRoaXMuDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHBjZjg1
eDYzX2NvbmZpZyBwY2ZfODUzNjNfY29uZmlnID0gew0KPiA+ICsgICAgICAgew0KPiA+ICsgICAg
ICAgICAgICAgICAucmVnX2JpdHMgPSA4LA0KPiA+ICsgICAgICAgICAgICAgICAudmFsX2JpdHMg
PSA4LA0KPiA+ICsgICAgICAgICAgICAgICAubWF4X3JlZ2lzdGVyID0gMHg3ZiwNCj4gPiArICAg
ICAgIH0sDQo+ID4gKyAgICAgICAyDQo+DQo+IExpa2V3aXNlLg0KDQogT0sgd2lsbCBmaXggdGhp
cy4NCg0KUmVnYXJkcywNCkJpanUNCg0KPiBUaGUgcmVzdCBsb29rcyBnb29kIHRvIG1lLCBzbw0K
PiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5i
ZT4NCj4NCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IEdlZXJ0DQo+DQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2Yg
TGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtDQo+IG02OGsub3JnDQo+DQo+IEluIHBl
cnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxm
IGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qg
c2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQoNCg0KW2h0dHBzOi8vd3d3Mi5y
ZW5lc2FzLmV1L21lZGlhL2VtYWlsL3VuaWNlZi5qcGddDQoNClRoaXMgQ2hyaXN0bWFzLCBpbnN0
ZWFkIG9mIHNlbmRpbmcgb3V0IGNhcmRzLCBSZW5lc2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBoYXZl
IGRlY2lkZWQgdG8gc3VwcG9ydCBVbmljZWYgd2l0aCBhIGRvbmF0aW9uLiBGb3IgZnVydGhlciBk
ZXRhaWxzIGNsaWNrIGhlcmU8aHR0cHM6Ly93d3cudW5pY2VmLm9yZy8+IHRvIGZpbmQgb3V0IGFi
b3V0IHRoZSB2YWx1YWJsZSB3b3JrIHRoZXkgZG8sIGhlbHBpbmcgY2hpbGRyZW4gYWxsIG92ZXIg
dGhlIHdvcmxkLg0KV2Ugd291bGQgbGlrZSB0byB0YWtlIHRoaXMgb3Bwb3J0dW5pdHkgdG8gd2lz
aCB5b3UgYSBNZXJyeSBDaHJpc3RtYXMgYW5kIGEgcHJvc3Blcm91cyBOZXcgWWVhci4NCg0KDQoN
ClJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIEx0ZCwgRHVrZXMgTWVhZG93LCBNaWxsYm9hcmQg
Um9hZCwgQm91cm5lIEVuZCwgQnVja2luZ2hhbXNoaXJlLCBTTDggNUZILCBVSy4gUmVnaXN0ZXJl
ZCBpbiBFbmdsYW5kICYgV2FsZXMgdW5kZXIgUmVnaXN0ZXJlZCBOby4gMDQ1ODY3MDkuDQo=
