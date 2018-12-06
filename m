Return-Path: <SRS0=to0F=OP=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFD9C64EB1
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 15:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA3F214C1
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 15:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="wsGI2Cz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA3F214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbeLFPuF (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:50:05 -0500
Received: from mail-eopbgr1400113.outbound.protection.outlook.com ([40.107.140.113]:1846
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbeLFPuE (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 6 Dec 2018 10:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEolkFCSe5OhRnTRJXf96qQYzYg/mUxazwYrKJi82lY=;
 b=wsGI2Cz+4uKP6OUsnxOAy8L7Gpg4M4t4wqTadG1c7FGRT5fRgIHp1p2DflwvitNbaW5P7tCwpaVcnR906NoUulE4joDUd46tLe86uyqnejpuNEloue6IPIShUF7xxZWTkkKEiSyxF63zKNNpmx0sWTZX3VMVZqgcL1uDiKzqMGw=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB1560.jpnprd01.prod.outlook.com (52.134.225.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 15:49:57 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%5]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 15:49:57 +0000
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
Thread-Index: AQHUjUK6JpQnuqQbm02UjS4gg3wPT6VxdJKAgAA9DyCAACb3gIAAAhnw
Date:   Thu, 6 Dec 2018 15:49:57 +0000
Message-ID: <OSBPR01MB2103A13E75634AD81CFD1628B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com>
 <1544086559-47141-3-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdVv262dM8JGWN4w3h2kq4Y4ftRczn8TF-kM_fecF4GXnw@mail.gmail.com>
 <OSBPR01MB21039D89E5E8852574A18893B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAMuHMdWRz-iutKD54vtmJxnLsb3vtm1juYDw-k1+RFCNUVsjkg@mail.gmail.com>
In-Reply-To: <CAMuHMdWRz-iutKD54vtmJxnLsb3vtm1juYDw-k1+RFCNUVsjkg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1560;20:1oNtTF8XNFTEgCcVzQv1AN7WEhDaG4MhGoiouMGSxH8Hj4M5xGANxLB0SlNFvuyFUQNC9/SPy+cFNTavXSufQxrBuGy13EHI2ByGJWNlcDM60myadxPgC5dWx60qXBkbKUREWv4kHi/N0x1L+R7zuoKEsFdrbFbZoW0jnWrtjX0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 404c2cf7-4933-44ea-8b78-08d65b927907
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1560;
x-ms-traffictypediagnostic: OSBPR01MB1560:
x-microsoft-antispam-prvs: <OSBPR01MB1560FDC20A63E4282A0D8DA2B8A90@OSBPR01MB1560.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB1560;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1560;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(51914003)(199004)(189003)(6116002)(305945005)(7736002)(74316002)(105586002)(11346002)(446003)(6916009)(478600001)(476003)(44832011)(486006)(86362001)(229853002)(5660300001)(4326008)(6436002)(3846002)(71200400001)(10126004)(6246003)(71190400001)(25786009)(66066001)(14454004)(68736007)(55016002)(54906003)(8936002)(186003)(81166006)(81156014)(9686003)(256004)(6306002)(93886005)(316002)(53936002)(8676002)(102836004)(33656002)(6506007)(53546011)(99286004)(106356001)(7696005)(97736004)(2906002)(76176011)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1560;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 08vuTuNlc8QD8jqmFrMst0bkRkeLoKNgqZ+PRd1y6VzNjCal/1+mg7MHLREsoAbGZn2ddHbzrqvZeMXd8wMoMjXk436K6844jkOc1MNlxHilTGM2jIfcCOGHj8G2sdLYTjxXjl0nAB/FtruIgRR6bqG3x/PMXYx0fn2fNcgaavRlBk23lhhbEhRDsJFqtirl7bikqE+lmD4TyaDYC6ngEqiz6VCgttA03j7Gg0mM2QqZFVGXKhqTjpM2X5vLMNG0sz5IgmDQKSgIQqXLA4Wqid79ShMkLKqVMqZ4OcE9qN2xZozXkeYhVvL9NnObpTmp2i981u0dQayxXPwbZ25VeZdkm80Wxco09WdgpiSOJHA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404c2cf7-4933-44ea-8b78-08d65b927907
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 15:49:57.1502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1560
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgMi80XSBydGM6IHBjZjg1MzYzOiBBZGQgc3VwcG9ydCBmb3IgTlhQIHBjZjg1MjYz
IHJ0Yw0KPg0KPiBIaSBCaWp1LA0KPg0KPiBPbiBUaHUsIERlYyA2LCAyMDE4IGF0IDQ6MjQgUE0g
QmlqdSBEYXMgPGJpanUuZGFzQGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjMgMi80XSBydGM6IHBjZjg1MzYzOiBBZGQgc3VwcG9ydCBmb3IgTlhQDQo+
ID4gPiBwY2Y4NTI2MyBydGMgQ0MgbnZtZW0gbWFpbnRhaW5lcg0KPiA+ID4NCj4gPiA+IE9uIFRo
dSwgRGVjIDYsIDIwMTggYXQgMTA6MDQgQU0gQmlqdSBEYXMgPGJpanUuZGFzQGJwLnJlbmVzYXMu
Y29tPg0KPiB3cm90ZToNCj4gPiA+ID4gQWRkIHN1cHBvcnQgZm9yIE5YUCBwY2Y4NTI2MyByZWFs
LXRpbWUgY2xvY2suIHBjZjg1MjYzIHJ0YyBpcw0KPiA+ID4gPiBjb21wYXRpYmxlIHdpdGggcGNm
ODUzNjMsZXhjZXB0IHRoYXQgcGNmODUzNjMgaGFzIGFkZGl0aW9uYWwgNjQNCj4gPiA+ID4gYnl0
ZXMgb2YNCj4gPiA+IFJBTS4NCj4NCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9ydGMvcnRjLXBjZjg1
MzYzLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9ydGMvcnRjLXBjZjg1MzYzLmMNCj4gPiA+ID4g
QEAgLTEyMCw2ICsxMjAsMTEgQEAgc3RydWN0IHBjZjg1MzYzIHsNCj4gPiA+ID4gICAgICAgICBz
dHJ1Y3QgcmVnbWFwICAgICAgICAgICAqcmVnbWFwOw0KPiA+ID4gPiAgfTsNCj4gPiA+ID4NCj4g
PiA+ID4gK3N0cnVjdCBwY2Y4NXg2M19jb25maWcgew0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBy
ZWdtYXBfY29uZmlnIHJlZ21hcDsNCj4gPiA+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgbnVtX252
cmFtOw0KPiA+ID4gPiArfTsNCj4gPiA+ID4gKw0KPiA+ID4gPiAgc3RhdGljIGludCBwY2Y4NTM2
M19ydGNfcmVhZF90aW1lKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0DQo+ID4gPiA+IHJ0Y190
aW1lDQo+ID4gPiA+ICp0bSkgIHsNCj4gPiA+ID4gICAgICAgICBzdHJ1Y3QgcGNmODUzNjMgKnBj
Zjg1MzYzID0gZGV2X2dldF9kcnZkYXRhKGRldik7IEBADQo+ID4gPiA+IC0zMTEsMjUNCj4gPiA+
ID4gKzMxNiw2OCBAQCBzdGF0aWMgaW50IHBjZjg1MzYzX252cmFtX3dyaXRlKHZvaWQgKnByaXYs
IHVuc2lnbmVkDQo+ID4gPiA+ICtpbnQNCj4gPiA+IG9mZnNldCwgdm9pZCAqdmFsLA0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YWwsIGJ5dGVzKTsgIH0NCj4gPiA+
ID4NCj4gPiA+ID4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnbWFwX2NvbmZpZyByZWdtYXBfY29u
ZmlnID0gew0KPiA+ID4gPiAtICAgICAgIC5yZWdfYml0cyA9IDgsDQo+ID4gPiA+IC0gICAgICAg
LnZhbF9iaXRzID0gOCwNCj4gPiA+ID4gLSAgICAgICAubWF4X3JlZ2lzdGVyID0gMHg3ZiwNCj4g
PiA+ID4gK3N0YXRpYyBpbnQgcGNmODV4NjNfbnZyYW1fcmVhZCh2b2lkICpwcml2LCB1bnNpZ25l
ZCBpbnQgb2Zmc2V0LCB2b2lkDQo+ICp2YWwsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzaXplX3QgYnl0ZXMpDQo+ID4gPg0KPiA+ID4gR2l2ZW4gYnl0ZXMgc2hvdWxk
IGJlIDEsIHZhbCBzaG91bGQgYmUgYSBwb2ludGVyIHRvIGEgc2luZ2xlIGJ5dGUuLi4NCj4gPiA+
IFdoYXQgaWYgYnl0ZXMgPT0gMD8NCj4gPg0KPiA+IEkgZG91YnQgd2UgZ2V0ICJieXRlcz09MCIg
YmVjYXVzZSBvZiB0aGUgY2hlY2tzIGluICINCj4gZHJpdmVycy9udm1lbS9jb3JlLmMiDQo+ID4g
RnVuY3Rpb24gIiBiaW5fYXR0cl9udm1lbV9yZWFkLyBiaW5fYXR0cl9udm1lbV93cml0ZSIuDQo+
DQo+IERlcGVuZHMuIFRoZXJlIGFyZSBvdGhlciBmdW5jdGlvbnMgY2FsbGluZyBudm1lbV9yZWdf
e3JlYWQsd3JpdGV9KCksIGUuZy4NCj4gbnZtZW1fZGV2aWNlX3tyZWFkLHdyaXRlfSgpLg0KDQpP
Sy4gSW4gdGhhdCBjYXNlLCBJIHdpbGwgcmV0dXJuICgtRUlOVkFMKSAgZm9yICJieXRlcyAhPTEi
DQoNCj4gPg0KPiA+ID4gPiArez4gKyAgICAgICBzdHJ1Y3QgcGNmODUzNjMgKnBjZjg1MzYzID0g
cHJpdjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHJldHVybiByZWdtYXBfcmVhZChwY2Y4
NTM2My0+cmVnbWFwLCBDVFJMX1JBTUJZVEUsIHZhbCk7DQo+ID4gPg0KPiA+ID4gSG93ZXZlciwg
cmVnbWFwX3JlYWQoKSBoYXMgYW4gdW5zaWduZWQgaW50IG91dHB1dCBwYXJhbWV0ZXIhDQo+ID4g
PiBTbyBpdCdzIHdyaXRpbmcgdG9vIG1hbnkgYnl0ZXMsIGFuZCBvbmx5IHdyaXRpbmcgdGhlIGFj
dHVhbCBkYXRhDQo+ID4gPiBieXRlIHRvIHRoZSBjb3JyZWN0IGFkZHJlc3Mgb24gbGl0dGxlLWVu
ZGlhbiBzeXN0ZW1zLg0KPiA+ID4gSGVuY2UgeW91IG5lZWQgdG8gdXNlIGFuIGludGVybWVkaWF0
ZSB2YXJpYWJsZSB0byBjb252ZXJ0IGZyb20NCj4gPiA+IHVuc2lnbmVkIGludCB0byBieXRlLg0K
PiA+DQo+ID4gT0suIFdpbGwgdXNlIGFuIGludGVybWVkaWF0ZSBpbnRlZ2VyIHZhcmlhYmxlLg0K
PiA+DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBpbnQgcGNmODV4NjNf
bnZyYW1fd3JpdGUodm9pZCAqcHJpdiwgdW5zaWduZWQgaW50IG9mZnNldCwgdm9pZA0KPiAqdmFs
LA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBieXRlcykg
ew0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBwY2Y4NTM2MyAqcGNmODUzNjMgPSBwcml2Ow0KPiA+
ID4gPiArDQo+ID4gPiA+ICsgICAgICAgcmV0dXJuIHJlZ21hcF93cml0ZShwY2Y4NTM2My0+cmVn
bWFwLCBDVFJMX1JBTUJZVEUsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKigodW5zaWduZWQgaW50ICopdmFsKSk7DQo+ID4gPg0KPiA+ID4gTGlrZXdpc2UgZm9yIHdy
aXRpbmcuDQo+ID4gPg0KPiA+ID4gPiArfQ0KPiA+ID4NCj4gPiA+IEJUVywgd2hpbGUgdGhlIG52
bWVtX2RldmljZV97cmVhZCx3cml0ZX0oKSBwdWJsaWMgQVBJIGlzIGRvY3VtZW50ZWQsDQo+ID4g
PiB0aGUNCj4gPiA+IG52bWVtX2RldmljZS5yZWdfe3JlYWQsd3JpdGV9KCkgZHJpdmVyIEFQSSBp
c24ndC4NCj4gPiA+IEFuZCB0aGUgYmVoYXZpb3IgbWlnaHQgYmUgY29uZnVzaW5nLg0KPiA+ID4N
Cj4gPiA+IEUuZy4NCj4gPiA+ICAqIFJldHVybjogbGVuZ3RoIG9mIHN1Y2Nlc3NmdWwgYnl0ZXMg
cmVhZCBvbiBzdWNjZXNzIGFuZCBuZWdhdGl2ZQ0KPiA+ID4gICogZXJyb3IgY29kZSBvbiBlcnJv
ci4NCj4gPiA+DQo+ID4gPiBUaGUgcHVibGljIEFQSSBzZWVtcyB0byBhc3N1bWUgdGhlIGRyaXZl
ciBBUEkgcmV0dXJucyB6ZXJvIG9uDQo+ID4gPiBzdWNjZXNzLCBhbmQgcmVwbGFjZXMgdGhlIHpl
cm8gYnkgdGhlIG51bWJlciBvZiBieXRlcyByZXF1ZXN0ZWQuDQo+ID4gPiBJZiB0aGUgcmVxdWVz
dGVkIG51bWJlciBvZiBieXRlcyBpcyB0b28gbGFyZ2UsIGEgemVybyBzdWNjZXNzIHdvdWxkDQo+
ID4gPiBiZSBjb252ZXJ0ZWQgdG8gYSB2YWx1ZSB0aGF0J3MgbGFyZ2VyIHRoYW4gdGhlIGFjdHVh
bCBudW1iZXIgb2YNCj4gPiA+IGJ5dGVzIHRyYW5zZmVycmVkIQ0KPiA+ID4gSG93ZXZlciwgdGhl
IGRyaXZlciBBUEkgY2FuIHJldHVybiBhIHNtYWxsZXIgKHBvc2l0aXZlKSBudW1iZXIsDQo+ID4g
PiB3aGljaCBtYXRjaGVzICJzdGFuZGFyZCIgcmVhZC93cml0ZSgpIEFQSXMuDQoNClJlZ2FyZHMs
DQpCaWp1DQoNCg0KW2h0dHBzOi8vd3d3Mi5yZW5lc2FzLmV1L21lZGlhL2VtYWlsL3VuaWNlZi5q
cGddDQoNClRoaXMgQ2hyaXN0bWFzLCBpbnN0ZWFkIG9mIHNlbmRpbmcgb3V0IGNhcmRzLCBSZW5l
c2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBoYXZlIGRlY2lkZWQgdG8gc3VwcG9ydCBVbmljZWYgd2l0
aCBhIGRvbmF0aW9uLiBGb3IgZnVydGhlciBkZXRhaWxzIGNsaWNrIGhlcmU8aHR0cHM6Ly93d3cu
dW5pY2VmLm9yZy8+IHRvIGZpbmQgb3V0IGFib3V0IHRoZSB2YWx1YWJsZSB3b3JrIHRoZXkgZG8s
IGhlbHBpbmcgY2hpbGRyZW4gYWxsIG92ZXIgdGhlIHdvcmxkLg0KV2Ugd291bGQgbGlrZSB0byB0
YWtlIHRoaXMgb3Bwb3J0dW5pdHkgdG8gd2lzaCB5b3UgYSBNZXJyeSBDaHJpc3RtYXMgYW5kIGEg
cHJvc3Blcm91cyBOZXcgWWVhci4NCg0KDQoNClJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIEx0
ZCwgRHVrZXMgTWVhZG93LCBNaWxsYm9hcmQgUm9hZCwgQm91cm5lIEVuZCwgQnVja2luZ2hhbXNo
aXJlLCBTTDggNUZILCBVSy4gUmVnaXN0ZXJlZCBpbiBFbmdsYW5kICYgV2FsZXMgdW5kZXIgUmVn
aXN0ZXJlZCBOby4gMDQ1ODY3MDkuDQo=
