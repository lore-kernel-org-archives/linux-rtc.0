Return-Path: <SRS0=ySH3=OQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FE6C07E85
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 10:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34592083D
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 10:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="UZVXfXAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34592083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLGKQt (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:16:49 -0500
Received: from mail-eopbgr1410122.outbound.protection.outlook.com ([40.107.141.122]:53551
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbeLGKQt (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 7 Dec 2018 05:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+nNHhTtcG98WCl034AnsANspqKnKMaToWWCr8ZYE0c=;
 b=UZVXfXAfKA6YwD2vwEj/rUHCvoX/M9CAwIECjI50S0b3HW1Xq7vD1bnaEb46O8li3NzM/+CcbPQYqfss4mJgE63y9rNtWc/G7NFk69mNNghTWDmDwsR1WFihDZhYTmuILQK+K3+N+vuVOSmRlpsp9IJgikLbegq46EK8vIaAc7k=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB3495.jpnprd01.prod.outlook.com (20.178.96.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Fri, 7 Dec 2018 10:16:41 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%5]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 10:16:41 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: RE: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
Thread-Topic: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
Thread-Index: AQHUjUK6JpQnuqQbm02UjS4gg3wPT6VxdJKAgAA9DyCAACb3gIAAAhnwgAASzgCAAQtNMIAAD+YAgAAGniA=
Date:   Fri, 7 Dec 2018 10:16:41 +0000
Message-ID: <OSBPR01MB21030916075015094519D0F2B8AA0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com>
 <1544086559-47141-3-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdVv262dM8JGWN4w3h2kq4Y4ftRczn8TF-kM_fecF4GXnw@mail.gmail.com>
 <OSBPR01MB21039D89E5E8852574A18893B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAMuHMdWRz-iutKD54vtmJxnLsb3vtm1juYDw-k1+RFCNUVsjkg@mail.gmail.com>
 <OSBPR01MB2103A13E75634AD81CFD1628B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20181206165202.GC8952@piout.net>
 <OSBPR01MB2103D626F5A58D86D726E721B8AA0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAMuHMdUXPPEqKiXC6reGkEUUAMUEK5Ku+zbDv0BS7KMVUYQGhQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUXPPEqKiXC6reGkEUUAMUEK5Ku+zbDv0BS7KMVUYQGhQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB3495;20:Wl7zm8GhkU1/nYixGN06Ft/58PdtwokW0pMMr+O1GnSWr+yj4JSGtUF7jNzVGJE/d1JP+9vEkx2w8o8Kh7IwiMgRq94AsGtjwshhEgTdispfmlqjfwwZqZFTtfgOA4JqX8BbBhsr1fPekpKd8oZoC1cRbT/DR0+j0UZbmL+KGO8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 206a1e60-665f-41e4-ab02-08d65c2d14cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB3495;
x-ms-traffictypediagnostic: OSBPR01MB3495:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-microsoft-antispam-prvs: <OSBPR01MB34958B7889C7D949CB76C9F4B8AA0@OSBPR01MB3495.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB3495;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB3495;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(366004)(396003)(346002)(51914003)(189003)(199004)(102836004)(76176011)(44832011)(53936002)(99286004)(81166006)(446003)(11346002)(81156014)(6306002)(9686003)(486006)(8936002)(33656002)(93886005)(476003)(55016002)(54906003)(106356001)(74316002)(7696005)(316002)(53546011)(6506007)(6436002)(26005)(6246003)(105586002)(229853002)(5660300001)(97736004)(186003)(68736007)(66066001)(305945005)(25786009)(6916009)(478600001)(14454004)(8676002)(7736002)(10126004)(4326008)(71200400001)(256004)(71190400001)(6116002)(3846002)(2906002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3495;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HzKWaeouBp2KbpwJPJ/Ua2pBqS8/qhT2+TAG7sg+y1MrLJGwbn7WUPNomi36E1gx+hIRRjNTtZuwOruGi7Uo8IupqANklqbHqBdWX3mz31vT7Df3TkcPwWnRSCeYlArc63gYhgMYbZ02M4hmxfc2LAreQBsGEuK9LYRro474GUb2iyxsdoXXMlKtX2BKDMiSDbUIYU4pVNALvkijOwnabnW+uAbVSW0i648Y7I9wBpq0J1GlOznv433ehWq0602eKzuP5AzdDJsDcElsw1HpoRPWvywF8XTlFpoCIAo0AwARZ0qJKdYCSbOdC1J9azRxNy/N/tJOwckoHM6GQo6sM5Wo4o9DHVB8M/bm0IV1gcg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206a1e60-665f-41e4-ab02-08d65c2d14cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 10:16:41.0838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3495
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgMi80XSBydGM6IHBjZjg1MzYzOiBBZGQgc3VwcG9ydCBmb3IgTlhQIHBjZjg1MjYz
IHJ0Yw0KPg0KPiBIaSBCaWp1LA0KPg0KPiBPbiBGcmksIERlYyA3LCAyMDE4IGF0IDEwOjM0IEFN
IEJpanUgRGFzIDxiaWp1LmRhc0BicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzIDIvNF0gcnRjOiBwY2Y4NTM2MzogQWRkIHN1cHBvcnQgZm9yIE5YUA0K
PiA+ID4gcGNmODUyNjMgcnRjDQo+ID4gPg0KPiA+ID4gT24gMDYvMTIvMjAxOCAxNTo0OTo1Nysw
MDAwLCBCaWp1IERhcyB3cm90ZToNCj4NCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYz
IDIvNF0gcnRjOiBwY2Y4NTM2MzogQWRkIHN1cHBvcnQgZm9yIE5YUA0KPiA+ID4gPiA+IHBjZjg1
MjYzIHJ0Yw0KPg0KPiA+ID4gPiA+IE9uIFRodSwgRGVjIDYsIDIwMTggYXQgNDoyNCBQTSBCaWp1
IERhcw0KPiA+ID4gPiA+IDxiaWp1LmRhc0BicC5yZW5lc2FzLmNvbT4NCj4gPiA+IHdyb3RlOg0K
PiA+ID4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvNF0gcnRjOiBwY2Y4NTM2Mzog
QWRkIHN1cHBvcnQgZm9yDQo+ID4gPiA+ID4gPiA+IE5YUA0KPiA+ID4gPiA+ID4gPiBwY2Y4NTI2
MyBydGMgQ0MgbnZtZW0gbWFpbnRhaW5lciBHaXZlbiBieXRlcyBzaG91bGQgYmUgMSwNCj4gPiA+
ID4gPiA+ID4gdmFsIHNob3VsZCBiZSBhIHBvaW50ZXIgdG8gYSBzaW5nbGUgYnl0ZS4uLg0KPiA+
ID4gPiA+ID4gPiBXaGF0IGlmIGJ5dGVzID09IDA/DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
SSBkb3VidCB3ZSBnZXQgImJ5dGVzPT0wIiBiZWNhdXNlIG9mIHRoZSBjaGVja3MgaW4gIg0KPiA+
ID4gPiA+IGRyaXZlcnMvbnZtZW0vY29yZS5jIg0KPiA+ID4gPiA+ID4gRnVuY3Rpb24gIiBiaW5f
YXR0cl9udm1lbV9yZWFkLyBiaW5fYXR0cl9udm1lbV93cml0ZSIuDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBEZXBlbmRzLiBUaGVyZSBhcmUgb3RoZXIgZnVuY3Rpb25zIGNhbGxpbmcNCj4gPiA+ID4g
PiBudm1lbV9yZWdfe3JlYWQsd3JpdGV9KCksDQo+ID4gPiBlLmcuDQo+ID4gPiA+ID4gbnZtZW1f
ZGV2aWNlX3tyZWFkLHdyaXRlfSgpLg0KPiA+ID4gPg0KPiA+ID4gPiBPSy4gSW4gdGhhdCBjYXNl
LCBJIHdpbGwgcmV0dXJuICgtRUlOVkFMKSAgZm9yICJieXRlcyAhPTEiDQo+ID4gPg0KPiA+ID4g
SSB0aGluayBpdCBpcyBwcm9iYWJseSBiZXR0ZXIgdG8gZW5zdXJlIHRoZSBudm1lbSBjb3JlIG5l
dmVyIHBhc3Nlcw0KPiA+ID4gYW4gaW52YWxpZCBudW1iZXIgb2YgYnl0ZXMuIEFsbCB0aGUgdGhl
ciBSVEMgZHJpdmVycyBtYWtlIHRoYXQNCj4gYXNzdW1wdGlvbi4NCj4gPg0KPiA+IEluIHRoYXQg
Y2FzZSwgSSB3aWxsIGRvIGZvbGxvd2luZyBjaGVja3MgaW4NCj4gPiBudm1lbV9kZXZpY2Vfe3Jl
YWQsd3JpdGV9KCkgYmVmb3JlIGNhbGxpbmcgbnZtZW1fcmVnX3tyZWFkLHdyaXRlfSgpLA0KPiA+
DQo+ID4gbnZtZW1fZGV2aWNlX3JlYWQNCj4gPg0KPiA+IC8qIFN0b3AgdGhlIHVzZXIgZnJvbSBy
ZWFkaW5nICovDQo+ID4gaWYgKG9mZnNldCAgPj0gbnZtZW0tPnNpemUpDQo+ID4gcmV0dXJuIDA7
DQo+ID4NCj4gPiBpZiAoYnl0ZXMgPT0gMCkNCj4gPiByZXR1cm4gLUVJTlZBTDsNCj4NCj4gV2h5
IG5vdCAwPw0KDQpPay4gV2lsbCBtZXJnZSB3aXRoIGFib3ZlIGNoZWNrLg0KDQppZiAoKG9mZnNl
dCAgPj0gbnZtZW0tPnNpemUpICAmJiAoYnl0ZXMgPT0gMCkpDQogICAgICAgIHJldHVybiAwOw0K
DQo+ID4NCj4gPiBpZiAob2Zmc2V0ICsgYnl0ZXMgPiBudm1lbS0+c2l6ZSkNCj4NCj4gVGhpcyBt
aWdodCBvdmVyZmxvdywgcGxlYXNlIHVzZSBjaGVja19hZGRfb3ZlcmZsb3coKS4NCg0KV2lsbCB1
c2UgY2hlY2tfYWRkX292ZXJmbG93KCkgYW5kIHRoZW4gdGhlICByZXN1bHQgaXMgY29tcGFyZWQg
d2l0aCBudm1lbS0+c2l6ZSwgaWYgdGhlIGNoZWNrIG9wZXJhdGlvbiBpcyBzdWNjZXNzZnVsLg0K
DQo+ID4gYnl0ZXMgPSBudm1lbS0+c2l6ZSAtIG9mZnNldDsNCj4gPg0KPiA+IG52bWVtX2Rldmlj
ZV93cml0ZQ0KPiA+DQo+ID4gLyogU3RvcCB0aGUgdXNlciBmcm9tIHdyaXRpbmcgKi8NCj4gPiBp
ZiAob2Zmc2V0ICA+PSBudm1lbS0+c2l6ZSkNCj4gPiByZXR1cm4gLUVGQklHOw0KPg0KPiBFTk9T
UEM/DQoNCk9LLCBXaWxsIGNoYW5nZSBpdCB0byBFTk9TUEMuDQoNCj4gKyBzYW1lIGNvbW1lbnRz
IGFzIGZvciByZWFkLg0KPg0KPiBPaCwgYW5kIG9mZnNldCBpcyB1bnNpZ25lZCBpbnQgaW5zdGVh
ZCBvZiBsb2ZmX3QuDQo+IE5vYm9keSdzIGVudmlzaW9uaW5nIG52bWVtIGRldmljZXMgbGFyZ2Vy
IHRoYW4gNCBHaUI/DQoNClJlZ2FyZHMsDQpCaWp1DQoNCg0KW2h0dHBzOi8vd3d3Mi5yZW5lc2Fz
LmV1L21lZGlhL2VtYWlsL3VuaWNlZi5qcGddDQoNClRoaXMgQ2hyaXN0bWFzLCBpbnN0ZWFkIG9m
IHNlbmRpbmcgb3V0IGNhcmRzLCBSZW5lc2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBoYXZlIGRlY2lk
ZWQgdG8gc3VwcG9ydCBVbmljZWYgd2l0aCBhIGRvbmF0aW9uLiBGb3IgZnVydGhlciBkZXRhaWxz
IGNsaWNrIGhlcmU8aHR0cHM6Ly93d3cudW5pY2VmLm9yZy8+IHRvIGZpbmQgb3V0IGFib3V0IHRo
ZSB2YWx1YWJsZSB3b3JrIHRoZXkgZG8sIGhlbHBpbmcgY2hpbGRyZW4gYWxsIG92ZXIgdGhlIHdv
cmxkLg0KV2Ugd291bGQgbGlrZSB0byB0YWtlIHRoaXMgb3Bwb3J0dW5pdHkgdG8gd2lzaCB5b3Ug
YSBNZXJyeSBDaHJpc3RtYXMgYW5kIGEgcHJvc3Blcm91cyBOZXcgWWVhci4NCg0KDQoNClJlbmVz
YXMgRWxlY3Ryb25pY3MgRXVyb3BlIEx0ZCwgRHVrZXMgTWVhZG93LCBNaWxsYm9hcmQgUm9hZCwg
Qm91cm5lIEVuZCwgQnVja2luZ2hhbXNoaXJlLCBTTDggNUZILCBVSy4gUmVnaXN0ZXJlZCBpbiBF
bmdsYW5kICYgV2FsZXMgdW5kZXIgUmVnaXN0ZXJlZCBOby4gMDQ1ODY3MDkuDQo=
