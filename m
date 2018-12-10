Return-Path: <SRS0=WBM2=OT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5276C65BB3
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 15:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782212081F
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 15:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Xr1E1LPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782212081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeLJPfr (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:35:47 -0500
Received: from mail-eopbgr1410137.outbound.protection.outlook.com ([40.107.141.137]:26391
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726607AbeLJPfr (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 10 Dec 2018 10:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n7h+omy3anzUeb09/Jk7OpZ1kPaBQPayssYX7yhwe4=;
 b=Xr1E1LPiUe2jSdDxGsuzf8vhxNs+XHWntxOg6sA3St09qzTPfav1rPsIxZzUZ5tQcYKq+CmfBefjNXRxUVXIMREjLKjDwYWE7qYA00xvW0UD2VOFE7lpXn/YdlPTWff1mfOLXQmOwa9y4NvH7uq2Uj60ww05/Y59I939kFV49V4=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB1925.jpnprd01.prod.outlook.com (52.134.239.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.18; Mon, 10 Dec 2018 15:35:39 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%5]) with mapi id 15.20.1404.021; Mon, 10 Dec 2018
 15:35:39 +0000
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
Thread-Index: AQHUjiEXM+YDAsf+QUO3YGAaDLWV+6V37dwA////cmCAAAXCAIAAK5gg
Date:   Mon, 10 Dec 2018 15:35:38 +0000
Message-ID: <OSBPR01MB2103060BAFB268FDB1C9FF1EB8A50@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
 <1544182066-31528-2-git-send-email-biju.das@bp.renesas.com>
 <3c09d148-7102-1ee5-770a-009e40de6168@linaro.org>
 <OSBPR01MB21034A6FB7EF6E877DA0F151B8A50@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <e6643627-e6f3-5dad-9c3f-6babb8e0ce56@linaro.org>
In-Reply-To: <e6643627-e6f3-5dad-9c3f-6babb8e0ce56@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1925;20:b4N02eeFRW3WSGGajbdBLrYvzw44sjf46gM3gQE2oHM2Ve9Uid8i0bQ0JBxV6mVIJ2kStabWj4dMunlUMZ73N/XcdSUJbT1D28+yphibovyHMWvZJWFiu1grjCn2UPdOGL30OPKjWd7BJU4KhVtuwpKdP2RfMEmiONzVUfJleYc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 6268dd8f-5132-4bdb-7fee-08d65eb52325
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1925;
x-ms-traffictypediagnostic: OSBPR01MB1925:
x-microsoft-antispam-prvs: <OSBPR01MB1925489E2604E4A1A34C2E4DB8A50@OSBPR01MB1925.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB1925;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1925;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(52314003)(51914003)(6436002)(305945005)(74316002)(7736002)(2906002)(81156014)(81166006)(93886005)(54906003)(316002)(33656002)(229853002)(110136005)(6116002)(71200400001)(97736004)(71190400001)(8936002)(3846002)(8676002)(66066001)(68736007)(25786009)(105586002)(478600001)(5660300001)(4326008)(14454004)(10126004)(6506007)(53546011)(102836004)(26005)(7696005)(99286004)(106356001)(76176011)(186003)(55016002)(6306002)(9686003)(86362001)(256004)(6246003)(476003)(11346002)(446003)(44832011)(53936002)(486006)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1925;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tmpDbqfstMR6NL9T0mT8wt5F7Tvkz2Tjfj0NZxSxzn0+c1Bpq8H2xE4q274EfYNym/CP91NH/R09ccqhVPEidn0N7f+CCKMWM6hEc/ZPa483W7ISeg1TLhNU9+I4WXkMcU5x7s79Sj++vXZlPorC7mJoB6wS62KznTTiVw+2iAoon+SQh00NYFuf7IBRRYzViQ7a/vqDFyaIqNq/zcCCADc+lnm8ynhFuD/iOJhGWIX6Ye4U0rX9gUQjgS1uSN3DH5VeA2U+AP0glLLc/FS4JjjsBddkqtQBQGJRfmC04FXArLwDNjR9vlVpHLWuQ7bl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6268dd8f-5132-4bdb-7fee-08d65eb52325
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 15:35:38.9244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1925
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

SGkgU3Jpbml2YXMsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjQgMS81XSBudm1lbTogY2hlY2sgaW52YWxpZCBudW1iZXIgb2YgYnl0ZXMgaW4N
Cj4gbnZtZW1fZGV2aWNlX3tyZWFkLHdyaXRlfQ0KPg0KPg0KPg0KPiBPbiAxMC8xMi8xOCAxMjo0
NSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4+IEl0cyBiZXR0ZXIgdG8gbW92ZSBjaGVja3MgZnJvbQ0K
PiA+PiBiaW5fYXR0cl9udm1lbV9yZWFkKCkvYmluX2F0dHJfbnZtZW1fd3JpdGUoKSBpbnRvDQo+
IG52bWVtX3JlZ19yZWFkKCkNCj4gPj4gYW5kIG52bWVtX3JlZ193cml0ZSgpLCBzbyBpdHMgZWFz
eSB0byBtYWludGFpbiwgcmF0aGVyIHRoYW4gYWRkaW5nDQo+ID4+IHRoZW0gdG8gZWFjaCBmdW5j
dGlvbi4NCj4gPiBJbml0aWFsbHkgSSBhbHNvIHRob3VnaHQgdGhlIHNhbWUuIEJ1dCB0aGVyZSBh
cmUgc29tZSBSVEMgZHJpdmVycw0KPiA+IHdoaWNoIGlzIHVzaW5nIG52bWVtX2RldmljZSBpbnRl
cmZhY2UgIGlzIG5vdCBkZWZpbmluZyAid29yZF9zaXplIg0KPiBtZW1iZXIuIFRoYXQgaXMgdGhl
IHJlYXNvbiB3ZSBuZWVkIHRvIGFkZCBpdCBpbiBzZXBhcmF0ZSBmdW5jdGlvbi4NCj4gPiBDYW4g
eW91IHBsZWFzZSBzdWdnZXN0IGhvdyB0byBoYW5kbGUgdGhlIGFib3ZlIGRyaXZlcnM/DQo+DQo+
IFdvcmQgc2l6ZSBpcyBvcHRpb25hbCBhbnl3YXksIGluIHRoZSBjYXNlIHdoZXJlIHdvcmRfc2l6
ZSBpcyBub3Qgc3BlY2lmaWVkLA0KPiBpdHMgY29uc2lkZXJlZCBhcyBvbmUgYnl0ZSB3b3JkX3Np
emUuDQoNCldpbGwgc2VuZCBWMiBmb3IgdGhpcy4NCg0KUmVnYXJkcywNCkJpanUNCg0KDQpbaHR0
cHM6Ly93d3cyLnJlbmVzYXMuZXUvbWVkaWEvZW1haWwvdW5pY2VmLmpwZ10NCg0KVGhpcyBDaHJp
c3RtYXMsIGluc3RlYWQgb2Ygc2VuZGluZyBvdXQgY2FyZHMsIFJlbmVzYXMgRWxlY3Ryb25pY3Mg
RXVyb3BlIGhhdmUgZGVjaWRlZCB0byBzdXBwb3J0IFVuaWNlZiB3aXRoIGEgZG9uYXRpb24uIEZv
ciBmdXJ0aGVyIGRldGFpbHMgY2xpY2sgaGVyZTxodHRwczovL3d3dy51bmljZWYub3JnLz4gdG8g
ZmluZCBvdXQgYWJvdXQgdGhlIHZhbHVhYmxlIHdvcmsgdGhleSBkbywgaGVscGluZyBjaGlsZHJl
biBhbGwgb3ZlciB0aGUgd29ybGQuDQpXZSB3b3VsZCBsaWtlIHRvIHRha2UgdGhpcyBvcHBvcnR1
bml0eSB0byB3aXNoIHlvdSBhIE1lcnJ5IENocmlzdG1hcyBhbmQgYSBwcm9zcGVyb3VzIE5ldyBZ
ZWFyLg0KDQoNCg0KUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUgTHRkLCBEdWtlcyBNZWFkb3cs
IE1pbGxib2FyZCBSb2FkLCBCb3VybmUgRW5kLCBCdWNraW5naGFtc2hpcmUsIFNMOCA1RkgsIFVL
LiBSZWdpc3RlcmVkIGluIEVuZ2xhbmQgJiBXYWxlcyB1bmRlciBSZWdpc3RlcmVkIE5vLiAwNDU4
NjcwOS4NCg==
