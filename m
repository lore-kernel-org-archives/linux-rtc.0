Return-Path: <SRS0=to0F=OP=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7120C04EB9
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 12:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8137920892
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 12:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="I26FZeLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8137920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbeLFMlQ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:41:16 -0500
Received: from mail-eopbgr1400103.outbound.protection.outlook.com ([40.107.140.103]:28960
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727832AbeLFMlP (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 6 Dec 2018 07:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qTF4BPsduY5F1bXgZ7DSFirMeKtXb5IQYp76VNo0+g=;
 b=I26FZeLncoit1ZePhKU498Gqx3CY1E9Px0VzXK1eFiSrrEl7uwueH9qvqmAyZWJtSinTZzfnH8N3F88TCBj+PH1rIrhFDdl8rDt/UZgz3Q25eW+uD3EarjZ8cjnIckShud4oqEPa0wpmpeGq5bo1T8huaSnSLUYCvv9Ssn07ZqM=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB1671.jpnprd01.prod.outlook.com (52.134.226.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 12:40:45 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%5]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 12:40:45 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH v3 4/4] ARM: dts: iwg23s-sbc: Enable RTC
Thread-Topic: [PATCH v3 4/4] ARM: dts: iwg23s-sbc: Enable RTC
Thread-Index: AQHUjUK+MO1auDpxRk6T2F7U8racR6VxeQAAgAApWGA=
Date:   Thu, 6 Dec 2018 12:40:45 +0000
Message-ID: <OSBPR01MB210383AE5748C0E18A370C96B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com>
 <1544086559-47141-5-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdUp2yOiMFFqT5MWhbK=O4fEuTMzH21Wp7HqYBdaruJ1nw@mail.gmail.com>
In-Reply-To: <CAMuHMdUp2yOiMFFqT5MWhbK=O4fEuTMzH21Wp7HqYBdaruJ1nw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1671;20:bt0G2A1BpibhIrAEHRvVQiG1ZXTDtHmr28UJ5wMumrPN4Ud9RLmOmwSEIhUsj9wj92DhmHN4FH3UvFO452+95Qr7UDe4MRfBqMipRegtprf+y3WTHuqrdUhnoC81SKmiI8yEVJr5lmxT/PJjv2DynhV9wVdIQKxw4AsscL7rPns=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: eb1d7120-627f-4d36-893e-08d65b780aaf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1671;
x-ms-traffictypediagnostic: OSBPR01MB1671:
x-microsoft-antispam-prvs: <OSBPR01MB16718DB043D9AF030FB7A504B8A90@OSBPR01MB1671.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB1671;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1671;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(51914003)(25786009)(6436002)(10126004)(486006)(68736007)(5660300001)(86362001)(14454004)(316002)(305945005)(7736002)(26005)(476003)(11346002)(44832011)(446003)(107886003)(7696005)(4326008)(99286004)(39060400002)(8936002)(66066001)(6246003)(81156014)(53936002)(81166006)(71190400001)(7416002)(71200400001)(55016002)(74316002)(229853002)(478600001)(6506007)(76176011)(53546011)(102836004)(97736004)(33656002)(6916009)(54906003)(3846002)(6116002)(9686003)(106356001)(2906002)(8676002)(6306002)(105586002)(256004)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1671;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kvg7y4baFDLeFVpynIgvA+av11VhtyTRNRddNrKfRTkhsmmVuRnoppYpSo0wpUc15foj50rUXId6z/IPFYfnrWz7JLLS4iYw/54rzvEGJLYBk0b9lYpclmXMg6TEyw3XuMIyxWD+gSr/ApvCSbcCUPKGx8mndMfwoa23ML5fLa4KgIzvb7QXEDkY+9y/AD/aKRqCUOnnLNDb5YgJSVKiIHzvGwzlOnbQVDL66HWgoBKu10qicb1gTy/e/Qp2dE/f02YjTbMnx4AboZt7Ovgj6ZonKSIbdguzct/AD+JvJVr3/qj5y1GMbBwm95xpBIdXjmLHU+5uiLmnTTVCOfxkFeBOuCPgJY1+mqEF3vcWtLY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1d7120-627f-4d36-893e-08d65b780aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 12:40:45.1341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1671
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgNC80XSBBUk06IGR0czogaXdnMjNzLXNiYzogRW5hYmxlIFJUQw0KPg0KPiBIaSBC
aWp1LA0KPg0KPiBPbiBUaHUsIERlYyA2LCAyMDE4IGF0IDEwOjA0IEFNIEJpanUgRGFzIDxiaWp1
LmRhc0BicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gRW5hYmxlIE5YUCBwY2Y4NTI2MyByZWFs
IHRpbWUgY2xvY2sgZm9yIHRoZSBpV2F2ZSBTQkMgYmFzZWQgb24gUlovRzFDLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzQGJwLnJlbmVzYXMuY29tPg0KPg0KPiBS
ZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4N
Cj4NCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9yOGE3NzQ3MC1pd2cyM3Mtc2JjLmR0cw0K
PiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3NDcwLWl3ZzIzcy1zYmMuZHRzDQo+ID4g
QEAgLTg0LDEyICs4NCwzMCBAQA0KPiA+ICAgICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDIwMDAw
MDAwPjsNCj4gPiAgfTsNCj4gPg0KPiA+ICsmaTJjMyB7DQo+ID4gKyAgICAgICBwaW5jdHJsLTAg
PSA8JmkyYzNfcGlucz47DQo+ID4gKyAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0K
PiA+ICsNCj4gPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPiArICAgICAgIGNsb2NrLWZy
ZXF1ZW5jeSA9IDw0MDAwMDA+Ow0KPiA+ICsNCj4gPiArICAgICAgIHJ0Y0A1MSB7DQo+ID4gKyAg
ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibnhwLHBjZjg1MjYzIjsNCj4gPiArICAgICAgICAg
ICAgICAgcmVnID0gPDB4NTE+Ow0KPg0KPiBZb3UgbWlnaHQgd2FudCB0byBlbmFibGUgdGhlIG9w
dGlvbmFsIGludGVycnVwdDoNCg0KSSBoYXZlIGVuYWJsZWQgdGhpcyBidXQgdW5mb3J0dW5hdGVs
eSBpdCBpcyBnZW5lcmF0aW5nIDEwMDAwMCBvZiBncGlvIGludGVycnVwdHMgZHVyaW5nIGJvb3Qu
DQoNClRoZSByZWFzb24gaXMsIGJ5IGRlZmF1bHQgdGhpcyBwaW4gaXMgY29uZmlndXJlZCBhcyBm
dW5jdGlvbihQb3dlciBvbiByZXNldC9hdCB1LWJvb3QpLg0KQ3VycmVudGx5IHRoZXJlIGlzIG5v
IGZ1bmN0aW9uIGF2YWlsYWJsZSBpbiBrZXJuZWwgdG8gY29udmVydCBhIHBpbiBmcm9tIGZ1bmN0
aW9uIHRvIGdwaW8gKFNpbWlsYXIgdG8gdGhlIGlzc3VlIEZhYiBpcyBmYWNpbmcgZm9yIGRpc3Bs
YXkgaG90IHBsdWcgaW50ZXJydXB0KQ0KDQpNYXkgYmUgd2UgY2FuIGFkZCBvcHRpb25hbCBpbnRl
cnJ1cHQgYXQgYSBsYXRlciBzdGFnZSwgb25jZSB3ZSBoYXZlIGEgc29sdXRpb24gZm9yIGNvbnZl
cnRpbmcgIHBpbiBmcm9tIGZ1bmN0aW9uIHRvIGdwaW8uDQoNClBsZWFzZSBzaGFyZSB5b3VyIG9w
aW5pb24gb24gdGhpcy4NCg0KUmVnYXJkcywNCkJpanUNCg0KDQoNCg0KDQpbaHR0cHM6Ly93d3cy
LnJlbmVzYXMuZXUvbWVkaWEvZW1haWwvdW5pY2VmLmpwZ10NCg0KVGhpcyBDaHJpc3RtYXMsIGlu
c3RlYWQgb2Ygc2VuZGluZyBvdXQgY2FyZHMsIFJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIGhh
dmUgZGVjaWRlZCB0byBzdXBwb3J0IFVuaWNlZiB3aXRoIGEgZG9uYXRpb24uIEZvciBmdXJ0aGVy
IGRldGFpbHMgY2xpY2sgaGVyZTxodHRwczovL3d3dy51bmljZWYub3JnLz4gdG8gZmluZCBvdXQg
YWJvdXQgdGhlIHZhbHVhYmxlIHdvcmsgdGhleSBkbywgaGVscGluZyBjaGlsZHJlbiBhbGwgb3Zl
ciB0aGUgd29ybGQuDQpXZSB3b3VsZCBsaWtlIHRvIHRha2UgdGhpcyBvcHBvcnR1bml0eSB0byB3
aXNoIHlvdSBhIE1lcnJ5IENocmlzdG1hcyBhbmQgYSBwcm9zcGVyb3VzIE5ldyBZZWFyLg0KDQoN
Cg0KUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUgTHRkLCBEdWtlcyBNZWFkb3csIE1pbGxib2Fy
ZCBSb2FkLCBCb3VybmUgRW5kLCBCdWNraW5naGFtc2hpcmUsIFNMOCA1RkgsIFVLLiBSZWdpc3Rl
cmVkIGluIEVuZ2xhbmQgJiBXYWxlcyB1bmRlciBSZWdpc3RlcmVkIE5vLiAwNDU4NjcwOS4NCg==
