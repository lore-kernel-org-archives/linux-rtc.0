Return-Path: <SRS0=MiQX=OO=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF9AC04EBF
	for <linux-rtc@archiver.kernel.org>; Wed,  5 Dec 2018 13:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1612081C
	for <linux-rtc@archiver.kernel.org>; Wed,  5 Dec 2018 13:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="YeL6KFb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1612081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeLENmb (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:42:31 -0500
Received: from mail-eopbgr1400093.outbound.protection.outlook.com ([40.107.140.93]:9563
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727094AbeLENmb (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 5 Dec 2018 08:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4looWI4YxPbVyxNWUmlg7KT8/FfZyDnPMKaf4muRhU=;
 b=YeL6KFb7OuafksuA1V3D1Z/wQEhOZQcRF7gIMznIsgMthG1MzXAjiO3IZgAsWs9TrKvEOF339mN7b/34/wpCI6K8Wv+YBhgtbR+ScZAxWjauOAcN0ZI+M2Olk9flgpMPXnJmz0EDcaWaQPeUHUqPi7bgTAGxxXkTsuHpg9w/sP0=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB3319.jpnprd01.prod.outlook.com (20.178.5.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 13:42:26 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%5]) with mapi id 15.20.1404.020; Wed, 5 Dec 2018
 13:42:24 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
Thread-Topic: [PATCH v2 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
Thread-Index: AQHUiAVu7yCQEpKpyEW8KV5jYNpaxKVoKRoAgAAYS4CAAAXKAIAH5lxg
Date:   Wed, 5 Dec 2018 13:42:23 +0000
Message-ID: <OSBPR01MB2103838867CA5A733C9FE9C2B8A80@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1543510486-29532-1-git-send-email-biju.das@bp.renesas.com>
 <1543510486-29532-3-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdXmS6cCZhX_b+oszDjt+t8zgAkCGApweOX-k0Uq05=AEg@mail.gmail.com>
 <20181130123213.GM8952@piout.net>
 <CAMuHMdW6=B5n8CEmqVEaqxtLD9tO3ue7_A1sTBVgi+2SPfVa8g@mail.gmail.com>
In-Reply-To: <CAMuHMdW6=B5n8CEmqVEaqxtLD9tO3ue7_A1sTBVgi+2SPfVa8g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB3319;20:dQP/9KfA27FVpCafVg6NFTWeQnsPdug0Ug+QT0yK+4LCTdbFCt8wTGecHi0YAscoKQgMuyE08A3SrogK+eO5BBwdsXSJ4nv/M+fF4LqigQ1hBWYzcqc102pm8b1ra/ZuibpK9+diXvWwuSv6ooGAMNE+ensCuyYDJkBzCcLW3IM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 1e7e64f7-0689-4892-2454-08d65ab77d58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB3319;
x-ms-traffictypediagnostic: OSBPR01MB3319:
x-microsoft-antispam-prvs: <OSBPR01MB331945DA67A4EBD79BE005A3B8A80@OSBPR01MB3319.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB3319;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB3319;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(396003)(346002)(376002)(51914003)(199004)(189003)(11346002)(53936002)(446003)(68736007)(4326008)(55016002)(6436002)(476003)(486006)(186003)(44832011)(10126004)(7736002)(305945005)(25786009)(6116002)(33656002)(3846002)(26005)(71200400001)(71190400001)(74316002)(478600001)(86362001)(99286004)(102836004)(229853002)(2906002)(5660300001)(53546011)(14454004)(6506007)(106356001)(105586002)(66066001)(76176011)(6306002)(9686003)(8936002)(81166006)(81156014)(14444005)(7696005)(6246003)(93886005)(256004)(97736004)(8676002)(316002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3319;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bhRA3hRWPfPgT5b4z7GTTZc2I1FzILOGNib99FTfIlh67RpaxDpEbAnQ4zmpladlm/Wr4yT5SfmB3dbfrFIxIiIsf9C1w7bskCacN5U9h+r1KKal3vqiXo7egPCW9DzWwBE1xFlaM5+69MNh2bfqPeXeLG8gzpuaWI2iBgNh4PD7BuIq6CljhYatJuTK2ZdRl482tS9Ao6hJpN+Rz2p4zXJEE1bxuyuxBUBktwkdFF+vLYyWJqm2/8gCffgcPbmletvy4cVt7eoB2++kn20mZp+dIyrrrdIz5zvWvwBOTq4AkgCINcFspv2pNqu9VbmQEwBvdbLqL6hUXZej1UVDB3P9qD/ZQFvzxyUCVKckd70=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7e64f7-0689-4892-2454-08d65ab77d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 13:42:23.8740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3319
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

SGkgR2VlcnQgYW5kIEFsZXhhbmRyZSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzRdIHJ0YzogcGNmODUzNjM6IEFkZCBzdXBwb3J0IGZv
ciBOWFAgcGNmODUyNjMgcnRjDQo+DQo+IEhpIEFsZXhhbmRyZSwNCj4NCj4gT24gRnJpLCBOb3Yg
MzAsIDIwMTggYXQgMTozMiBQTSBBbGV4YW5kcmUgQmVsbG9uaQ0KPiA8YWxleGFuZHJlLmJlbGxv
bmlAYm9vdGxpbi5jb20+IHdyb3RlOg0KPiA+IE9uIDMwLzExLzIwMTggMTI6MDU6MTYrMDEwMCwg
R2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBOb3YgMjksIDIwMTggYXQg
NjowMyBQTSBCaWp1IERhcyA8YmlqdS5kYXNAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+
ID4gPiBBZGQgc3VwcG9ydCBmb3IgTlhQIHBjZjg1MjYzIHJlYWwtdGltZSBjbG9jay4gcGNmODUy
NjMgcnRjIGlzDQo+ID4gPiA+IGNvbXBhdGlibGUgd2l0aCBwY2Y4NTM2MyxleGNlcHQgdGhhdCBw
Y2Y4NTM2MyBoYXMgYWRkaXRpb25hbCA2NCBieXRlcw0KPiBvZiBSQU0uDQo+ID4gPiA+DQo+ID4g
PiA+IDEgYnl0ZSBvZiBudm1lbSBpcyBzdXBwb3J0ZWQgYW5kIGV4cG9zZWQgaW4gc3lzZnMgKCMg
aXMgdGhlDQo+ID4gPiA+IGluc3RhbmNlIG51bWJlcixzdGFydGluZyB3aXRoIDApOg0KPiA+ID4g
PiAvc3lzL2J1cy9udm1lbS9kZXZpY2VzL3BjZjg1eDYzLSMvbnZtZW0NCj4gPiA+ID4NCj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzQGJwLnJlbmVzYXMuY29tPg0KPiA+
ID4gPiAtLS0NCj4gPiA+ID4gIFYxLS0+VjIgSW5jb3Jwb3JhdGVkIEFsZXhhbmRyZSBhbmQgR2Vl
cnQncyByZXZpZXcgY29tbWVudC4NCj4gPiA+DQo+ID4gPiBUaGFua3MgZm9yIHRoZSB1cGRhdGUh
DQo+ID4gPg0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3J0Yy9ydGMtcGNmODUzNjMuYw0KPiA+ID4g
PiArKysgYi9kcml2ZXJzL3J0Yy9ydGMtcGNmODUzNjMuYw0KPiA+ID4NCj4gPiA+ID4gQEAgLTMy
MSwxNSArMzQ0LDI1IEBAIHN0YXRpYyBpbnQgcGNmODUzNjNfcHJvYmUoc3RydWN0IGkyY19jbGll
bnQNCj4gKmNsaWVudCwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBz
dHJ1Y3QgaTJjX2RldmljZV9pZCAqaWQpICB7DQo+ID4gPiA+ICAgICAgICAgc3RydWN0IHBjZjg1
MzYzICpwY2Y4NTM2MzsNCj4gPiA+ID4gLSAgICAgICBzdHJ1Y3QgbnZtZW1fY29uZmlnIG52bWVt
X2NmZyA9IHsNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIC5uYW1lID0gInBjZjg1MzYzLSIsDQo+
ID4gPiA+IC0gICAgICAgICAgICAgICAud29yZF9zaXplID0gMSwNCj4gPiA+ID4gLSAgICAgICAg
ICAgICAgIC5zdHJpZGUgPSAxLA0KPiA+ID4gPiAtICAgICAgICAgICAgICAgLnNpemUgPSBOVlJB
TV9TSVpFLA0KPiA+ID4gPiAtICAgICAgICAgICAgICAgLnJlZ19yZWFkID0gcGNmODUzNjNfbnZy
YW1fcmVhZCwNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIC5yZWdfd3JpdGUgPSBwY2Y4NTM2M19u
dnJhbV93cml0ZSwNCj4gPiA+ID4gKyAgICAgICBjb25zdCBzdHJ1Y3QgcmVnbWFwX2NvbmZpZyAq
cmVnbWFwX2NvbmZpZyA9DQo+ICZwY2ZfODUzNjNfcmVnbWFwX2NvbmZpZzsNCj4gPiA+ID4gKyAg
ICAgICBzdHJ1Y3QgbnZtZW1fY29uZmlnIG52bWVtX2NmZ1tdID0gew0KPiA+ID4NCj4gPiA+IHN0
YXRpYz8NCj4gPiA+DQo+ID4gPiBBbHRob3VnaCB0aGUgbnZtZW1fY29uZmlnIGlzIGNvcGllZCwg
YW5kIHRodXMgc3RhdGljIGlzIG5vdCBuZWVkZWQsDQo+ID4gPiBJIGd1ZXNzIHVzaW5nIHN0YXRp
YyB3aWxsIGRlY3JlYXNlIGtlcm5lbCBzaXplLg0KPiA+ID4NCj4gPg0KPiA+IEh1bSwgSSBkb24n
dCB0aGluaywgdGhpcyBpcyBvbiB0aGUgc3RhY2sgYW55d2F5Lg0KPg0KPiBJZiB5b3UgbWFrZSBp
dCBzdGF0aWMsIGl0J3Mgbm8gbG9uZ2VyIGFsbG9jYXRlZCBvbiB0aGUgc3RhY2ssIGFuZCBnY2Mg
aGFzIG5vDQo+IGxvbmdlciB0byBlbWl0IGNvZGUgdG8gaW5pdGlhbGl6ZSBhbGwgbWVtYmVycy4N
Cj4NCg0KSSBoYXZlIHVzZWQgInNpemUiIGNvbW1hbmQgdG8gY2hlY2sgdGhlIHNpemUgb2Ygdm1s
aW51eCB3aXRoIGFuZCB3aXRob3V0IHN0YXRpYy4gUGxlYXNlIGZpbmQgdGhlIHJlc3VsdHMuDQoN
CldpdGhvdXQgc3RhdGljDQo9PT09PT09PT09PQ0KJCBzaXplIHZtbGludXgNCiAgIHRleHQgICBk
YXRhICAgIGJzcyAgICBkZWMgICAgaGV4ZmlsZW5hbWUNCjcxNDczNjAyNjI1OTgyIDI5MjYwODEw
MDY1OTUwIDk5OTgxZXZtbGludXgNCg0KV2l0aCBzdGF0aWMgdmFyaWFibGUNCj09PT09PT09PT09
PT09PT09PQ0KJCBzaXplIHZtbGludXgNCiAgIHRleHQgICBkYXRhICAgIGJzcyAgICBkZWMgICAg
aGV4ZmlsZW5hbWUNCjcxNDcyMDAyNjI2MTEwIDI5MjYwODEwMDY1OTE4IDk5OTdmZXZtbGludXgN
Cg0KU28gb3ZlcmFsbCB3aXRoIHN0YXRpYywgdGhlcmUgaXMgYSByZWR1Y3Rpb24gaW4ga2VybmVs
IHNpemUuIEkgd2lsbCBzZW5kIFYzIHdpdGggZGVjbGFyaW5nIGl0IGFzIHN0YXRpYy4NCg0KUmVn
YXJkcywNCkJpanUNCg0KDQpbaHR0cHM6Ly93d3cyLnJlbmVzYXMuZXUvbWVkaWEvZW1haWwvdW5p
Y2VmLmpwZ10NCg0KVGhpcyBDaHJpc3RtYXMsIGluc3RlYWQgb2Ygc2VuZGluZyBvdXQgY2FyZHMs
IFJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIGhhdmUgZGVjaWRlZCB0byBzdXBwb3J0IFVuaWNl
ZiB3aXRoIGEgZG9uYXRpb24uIEZvciBmdXJ0aGVyIGRldGFpbHMgY2xpY2sgaGVyZTxodHRwczov
L3d3dy51bmljZWYub3JnLz4gdG8gZmluZCBvdXQgYWJvdXQgdGhlIHZhbHVhYmxlIHdvcmsgdGhl
eSBkbywgaGVscGluZyBjaGlsZHJlbiBhbGwgb3ZlciB0aGUgd29ybGQuDQpXZSB3b3VsZCBsaWtl
IHRvIHRha2UgdGhpcyBvcHBvcnR1bml0eSB0byB3aXNoIHlvdSBhIE1lcnJ5IENocmlzdG1hcyBh
bmQgYSBwcm9zcGVyb3VzIE5ldyBZZWFyLg0KDQoNCg0KUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJv
cGUgTHRkLCBEdWtlcyBNZWFkb3csIE1pbGxib2FyZCBSb2FkLCBCb3VybmUgRW5kLCBCdWNraW5n
aGFtc2hpcmUsIFNMOCA1RkgsIFVLLiBSZWdpc3RlcmVkIGluIEVuZ2xhbmQgJiBXYWxlcyB1bmRl
ciBSZWdpc3RlcmVkIE5vLiAwNDU4NjcwOS4NCg==
