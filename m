Return-Path: <SRS0=kYQR=OU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747A5C07E85
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 08:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE46E20811
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 08:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Iy66RNt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE46E20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbeLKIRC (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:17:02 -0500
Received: from mail-eopbgr1410132.outbound.protection.outlook.com ([40.107.141.132]:47360
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbeLKIRC (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 11 Dec 2018 03:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utQQsFEFMsomxj0FIb43nJUlbRnLM61BANBVoa0N+y8=;
 b=Iy66RNt/PHYu2aCDL4DQ2cr5EWm4t2VOggiYVgiloxZy1AcTszNmuiFNM7QGkTGh4tt/Y18+S7irRzkL0mcmnldtTvkV8laXLVRS3Z4BE1uD/xPXeVLigO91Axj39iUFdpNRdIPL3LcPNUNe9nDBxwbJTEDhBYvQbaUUd57WImM=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB3239.jpnprd01.prod.outlook.com (52.134.255.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Tue, 11 Dec 2018 08:16:58 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%5]) with mapi id 15.20.1404.021; Tue, 11 Dec 2018
 08:16:57 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] nvmem: check invalid number of bytes in
 nvmem_{read,write}()
Thread-Topic: [PATCH v2] nvmem: check invalid number of bytes in
 nvmem_{read,write}()
Thread-Index: AQHUkJ41vi60myFo+0uQLP2A0r1LFqV4TKSAgADjUgA=
Date:   Tue, 11 Dec 2018 08:16:57 +0000
Message-ID: <OSBPR01MB2103C137219528C37165A317B8A60@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1544455701-5720-1-git-send-email-biju.das@bp.renesas.com>
 <eb72f5b7-2920-b3b5-8387-d2b6b2d310cd@linaro.org>
In-Reply-To: <eb72f5b7-2920-b3b5-8387-d2b6b2d310cd@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB3239;20:bSx6dmMEeC1Tz6U2rZVHtUqr2jQhzvTdIT8aohPpLXNtMBYd5Y8u+xZtCedZ1FB52GLCNhByis7UJj4PsKwtWkhpYvJ93UTGHl885qhzULWiMAzkerwnb24z1TYTIW/pgtGx7lDcpD7TwRS6kISkDguPbbdrDYwV5hONKUPMA/Q=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 00b7caa7-f759-4b89-060c-08d65f4104e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB3239;
x-ms-traffictypediagnostic: OSBPR01MB3239:
x-microsoft-antispam-prvs: <OSBPR01MB32393296C288ED28A2DBEB03B8A60@OSBPR01MB3239.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB3239;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB3239;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(136003)(376002)(39860400002)(51914003)(189003)(199004)(5660300001)(68736007)(9686003)(316002)(106356001)(305945005)(74316002)(99286004)(6246003)(7736002)(4326008)(6306002)(76176011)(478600001)(53936002)(81156014)(54906003)(102836004)(14454004)(10126004)(2906002)(6506007)(7696005)(186003)(53546011)(26005)(55016002)(8936002)(446003)(3846002)(97736004)(6116002)(6436002)(11346002)(256004)(229853002)(81166006)(25786009)(33656002)(44832011)(86362001)(486006)(8676002)(476003)(105586002)(66066001)(71200400001)(71190400001)(6916009)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3239;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BsO2w1MZSPEHmTUx1rfYwTeuo9hUtlla4Tq+p0OMAxEAmjttIRYOHZnZX8nE1I9lHHJxhLpZGUDUvfkOqQql6Ec4Nl2d90nXdCna3jc1RhyGi6KQUS/2fI2aAaQfKl0kt74i8Nt0hapgzfJWM6hgymqfx0DM2ZLeuQTG9A3eQlYXPK0g/eOLk+U2tVRyPEKNZDEVcu3IjG9D/S1tEmfQ9dtKJtETqtLSqxrAzAxV8qIcn2YIB6OoZgS+LKd/X6th+DCrGdzMoH0CieEjSrNdjnE8ld5o7AA4hXuMScBvXkcnn+Bv2xIorCkB8ZjATfvq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b7caa7-f759-4b89-060c-08d65f4104e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 08:16:57.6855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3239
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

SGkgU3JpbmksDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjJdIG52bWVtOiBjaGVjayBpbnZhbGlkIG51bWJlciBvZiBieXRlcyBpbg0KPiBudm1l
bV97cmVhZCx3cml0ZX0oKQ0KPg0KPg0KPg0KPiBPbiAxMC8xMi8xOCAxNToyOCwgQmlqdSBEYXMg
d3JvdGU6DQo+ID4gKy8qIFN0b3AgdGhlIHVzZXIgZnJvbSB3cml0aW5nICovDQo+ID4gK2lmIChv
ZmZzZXQgPj0gbnZtZW0tPnNpemUpDQo+ID4gK3JldHVybiAtRU5PU1BDOw0KPiA+ICsNCj4gVGhp
cyBzaG91bGQgYmUgInJldHVybiAtRUZCSUciIHRvIG1ha2UgdXRpbGl0aWVzIGxpa2UgZGQgb3Ig
c2ggaGFwcHkuDQo+DQo+IExvb2sgYXQgMzhiMDc3NGMwNTk4YyAoIm52bWVtOiBjb3JlOiByZXR1
cm4gRUZCSUcgb24gb3V0LW9mLXJhbmdlDQo+IHdyaXRlIikgZm9yIG1vcmUgaW5mby4NCg0KcmV0
dXJuIC1FTk9TUEMgYWxzbyBtYWtlIGRkIG9yIHNoIGhhcHB5LiBQbGVhc2UgbGV0IG1lIGtub3cg
d2hpY2ggaXMgYXBwcm9wcmlhdGUgYnkgdGhlIGJlbG93IHJlc3VsdHMuIEJhc2VkIG9uIHlvdXIg
ZmVlZGJhY2ssIElmIG5lZWRlZCwgSSBjYW4gc2VuZCBhIHBhdGNoIHdpdGggInJldHVybiAtRUZC
SUciDQoNCldpdGggLUVOT1NQQw0KLS0tLS0tLS0tLS0tDQpkZCBpZj0xLmJpbiBvZj0vc3lzL2J1
cy9udm1lbS9kZXZpY2VzL3BjZjg1eDYzLTAvbnZtZW0gYnM9MSBjb3VudD0yDQpkZDogd3JpdGlu
ZyAnL3N5cy9idXMvbnZtZW0vZGV2aWNlcy9wY2Y4NXg2My0wL252bWVtJzogTm8gc3BhY2UgbGVm
dCBvbiBkZXZpY2UNCjIrMCByZWNvcmRzIGluDQoxKzAgcmVjb3JkcyBvdXQNCg0KZWNobyAiMTIz
NCIgPiAvc3lzL2J1cy9udm1lbS9kZXZpY2VzL3BjZjg1eDYzLTAvbnZtZW0NCi1zaDogZWNobzog
d3JpdGUgZXJyb3I6IE5vIHNwYWNlIGxlZnQgb24gZGV2aWNlDQoNCndpdGggLUVGQklHDQotLS0t
LS0tLS0tLS0NCmRkIGlmPTEuYmluIG9mPS9zeXMvYnVzL252bWVtL2RldmljZXMvcGNmODV4NjMt
MC9udm1lbSBicz0xIGNvdW50DQpkZDogd3JpdGluZyAnL3N5cy9idXMvbnZtZW0vZGV2aWNlcy9w
Y2Y4NXg2My0wL252bWVtJzogRmlsZSB0b28gbGFyZ2UNCjIrMCByZWNvcmRzIGluDQoxKzAgcmVj
b3JkcyBvdXQNCg0KZWNobyAiMTIzNCIgPiAvc3lzL2J1cy9udm1lbS9kZXZpY2VzL3BjZjg1eDYz
LTAvbnZtZW0NCi1zaDogZWNobzogd3JpdGUgZXJyb3I6IEZpbGUgdG9vIGxhcmdlDQoNClJlZ2Fy
ZHMsDQpCaWp1DQoNCg0KDQoNCltodHRwczovL3d3dzIucmVuZXNhcy5ldS9tZWRpYS9lbWFpbC91
bmljZWYuanBnXQ0KDQpUaGlzIENocmlzdG1hcywgaW5zdGVhZCBvZiBzZW5kaW5nIG91dCBjYXJk
cywgUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUgaGF2ZSBkZWNpZGVkIHRvIHN1cHBvcnQgVW5p
Y2VmIHdpdGggYSBkb25hdGlvbi4gRm9yIGZ1cnRoZXIgZGV0YWlscyBjbGljayBoZXJlPGh0dHBz
Oi8vd3d3LnVuaWNlZi5vcmcvPiB0byBmaW5kIG91dCBhYm91dCB0aGUgdmFsdWFibGUgd29yayB0
aGV5IGRvLCBoZWxwaW5nIGNoaWxkcmVuIGFsbCBvdmVyIHRoZSB3b3JsZC4NCldlIHdvdWxkIGxp
a2UgdG8gdGFrZSB0aGlzIG9wcG9ydHVuaXR5IHRvIHdpc2ggeW91IGEgTWVycnkgQ2hyaXN0bWFz
IGFuZCBhIHByb3NwZXJvdXMgTmV3IFllYXIuDQoNCg0KDQpSZW5lc2FzIEVsZWN0cm9uaWNzIEV1
cm9wZSBMdGQsIER1a2VzIE1lYWRvdywgTWlsbGJvYXJkIFJvYWQsIEJvdXJuZSBFbmQsIEJ1Y2tp
bmdoYW1zaGlyZSwgU0w4IDVGSCwgVUsuIFJlZ2lzdGVyZWQgaW4gRW5nbGFuZCAmIFdhbGVzIHVu
ZGVyIFJlZ2lzdGVyZWQgTm8uIDA0NTg2NzA5Lg0K
