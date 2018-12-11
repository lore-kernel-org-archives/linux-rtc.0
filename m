Return-Path: <SRS0=kYQR=OU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2645C5CFFE
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA802082F
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="nlF7jJQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA802082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeLKKzA (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:55:00 -0500
Received: from mail-eopbgr1410113.outbound.protection.outlook.com ([40.107.141.113]:10140
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726469AbeLKKy7 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 11 Dec 2018 05:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thIv1SX/JuhZHMqfBMPEemfms60OwrtkDGRfWZrccwg=;
 b=nlF7jJQf5VyJWZNCj2aWiv9J/B2AhUgEqUfiZm5n2zS1KdWO0+dOVpkYe2a9lUjh3Q9DTxPE1uIwD9BeAK6VosdhsmgYz9jdWdM0nTwh+YphVc4pWyXkVYRCt2rToNECeGc4RNEctLMU60769HFSjTGdo7Q+m+eHtlZBl6pPFIs=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB2997.jpnprd01.prod.outlook.com (52.134.254.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 10:54:54 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%5]) with mapi id 15.20.1404.021; Tue, 11 Dec 2018
 10:54:54 +0000
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
Subject: RE: [PATCH v3] nvmem: check invalid number of bytes in
 nvmem_{read,write}()
Thread-Topic: [PATCH v3] nvmem: check invalid number of bytes in
 nvmem_{read,write}()
Thread-Index: AQHUkTSAXvw/4DICLE+5wbI8dxDUI6V5TPOAgAAIsxA=
Date:   Tue, 11 Dec 2018 10:54:54 +0000
Message-ID: <OSBPR01MB210338DE328981500C6992F8B8A60@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1544520254-4210-1-git-send-email-biju.das@bp.renesas.com>
 <9f1a2851-58ca-2971-69d5-c1322b20130c@linaro.org>
In-Reply-To: <9f1a2851-58ca-2971-69d5-c1322b20130c@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2997;20:5tHvUq+piRQkUmXQ3oFdtvHlRLb7Wu/hS0Ye6+Ik7fVQPDJVoN97EGi94c6Y5T7QEWf6BW+C/2pKBjFGK8LEYnWbaAayjkKgkGl9XfAwzDuHGCtL+Cq3VVvPjYIRCQXK49q/jXGw4+kN3GvAVGQkwCzpv3OUg0UwnMRM1n0xx2w=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: b232702a-836b-41bc-54d8-08d65f57153c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2997;
x-ms-traffictypediagnostic: OSBPR01MB2997:
x-microsoft-antispam-prvs: <OSBPR01MB2997D38A9AD7753BF7C9E362B8A60@OSBPR01MB2997.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB2997;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2997;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39860400002)(51914003)(189003)(199004)(55016002)(7736002)(53546011)(44832011)(25786009)(4326008)(3846002)(10126004)(74316002)(76176011)(5660300001)(6116002)(9686003)(6306002)(305945005)(53936002)(6246003)(66066001)(102836004)(86362001)(7696005)(478600001)(81166006)(54906003)(71200400001)(71190400001)(6506007)(81156014)(2906002)(11346002)(8676002)(446003)(99286004)(476003)(14454004)(97736004)(486006)(8936002)(68736007)(106356001)(6916009)(6436002)(105586002)(26005)(316002)(33656002)(256004)(186003)(229853002)(14444005)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2997;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1KQ3yX4FlM14X0WFvDvVwYOK0fLI/XzEhtlP7m5di8nFBZzFNksE4Q4XbZOXIpAB8Ky7CbdiJEBjoUe6A1F/N6mBjDeF3GuMBNlLtnlASSLG5XUpdCAzmFJVcsIEOROLXUstT26zRP1ayUzwCXi5ADpr6C45+lkLRxXSnGm6XlwdPJ8JHVoqIUC2kkuuwj9aGt2FHEm6EeytsIwFUkkvXtoX7E6bWUh9KJKJeCztdWW+WcfW6++BQYPraYD5XzATqCS9Fo/igMrFefTGp3Y8kvy+8/ReHLfSyRygifrcvoOvvgLrsXKpvfp7bbQoDD6a
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b232702a-836b-41bc-54d8-08d65f57153c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 10:54:54.0581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2997
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

SGVsbG8gU3JpbmksDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjNdIG52bWVtOiBjaGVjayBpbnZhbGlkIG51bWJlciBvZiBieXRlcyBpbg0KPiBu
dm1lbV97cmVhZCx3cml0ZX0oKQ0KPg0KPg0KPg0KPiBBZnRlciBhcHBseWluZyB0aGlzIHBhdGNo
IEkgZ2V0IGJlbG93IGVycm9ycyB3aXRoIFc9MSBDPTENCj4NCj4gT24gMTEvMTIvMTggMDk6MjQs
IEJpanUgRGFzIHdyb3RlOg0KPiA+ICtpZiAodW5saWtlbHkoY2hlY2tfYWRkX292ZXJmbG93KGJ5
dGVzLCBvZmZzZXQsICZuZXdfYnl0ZXMpKSkNCj4gPiArcmV0dXJuIC1FT1ZFUkZMT1c7DQo+ID4g
ICBkcml2ZXJzL252bWVtL2NvcmUuYzo4MjoxMzogZXJyb3I6IGluY29tcGF0aWJsZSB0eXBlcyBp
biBjb21wYXJpc29uDQo+IGV4cHJlc3Npb24gKGRpZmZlcmVudCB0eXBlIHNpemVzKQ0KPiBkcml2
ZXJzL252bWVtL2NvcmUuYzo4MjoxMzogZXJyb3I6IGluY29tcGF0aWJsZSB0eXBlcyBpbiBjb21w
YXJpc29uDQo+IGV4cHJlc3Npb24gKGRpZmZlcmVudCB0eXBlIHNpemVzKQ0KPiBkcml2ZXJzL252
bWVtL2NvcmUuYzoxMTM6MTM6IGVycm9yOiBpbmNvbXBhdGlibGUgdHlwZXMgaW4gY29tcGFyaXNv
bg0KPiBleHByZXNzaW9uIChkaWZmZXJlbnQgdHlwZSBzaXplcykNCj4gZHJpdmVycy9udm1lbS9j
b3JlLmM6MTEzOjEzOiBlcnJvcjogaW5jb21wYXRpYmxlIHR5cGVzIGluIGNvbXBhcmlzb24NCj4g
ZXhwcmVzc2lvbiAoZGlmZmVyZW50IHR5cGUgc2l6ZXMpDQoNCkkgd2FzIHRyeWluZyB3aXRoIGFy
bTMyIHRvb2xjaGFpbiBhbmQgY29tcGlsZXIgaGFwcHkuIE5vdyB0cmllZCB3aXRoIEFybTY0IHRv
b2xjaGFpbiwgaXQgcHJvdmlkZXMgYSB3YXJuaW5nIGFuZCB0aGUgYmVsb3cgdHlwZWNhc3QgZml4
ZWQgdGhlIGlzc3VlLg0KaWYgKHVubGlrZWx5KGNoZWNrX2FkZF9vdmVyZmxvdyhieXRlcywgKHNp
emVfdClvZmZzZXQsICZuZXdfYnl0ZXMpKSkNCg0KRG9lcyB0eXBlY2FzdGluZyB0byAoc2l6ZV90
KSAgZml4ZWQgdGhlIGlzc3VlIGluIHlvdXIgZW52aXJvbm1lbnQ/IFBsZWFzZSBsZXQgIG1lIGtu
b3cuDQoNCnJlZ2FyZHMsDQpCaWp1DQoNCg0KDQoNCltodHRwczovL3d3dzIucmVuZXNhcy5ldS9t
ZWRpYS9lbWFpbC91bmljZWYuanBnXQ0KDQpUaGlzIENocmlzdG1hcywgaW5zdGVhZCBvZiBzZW5k
aW5nIG91dCBjYXJkcywgUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUgaGF2ZSBkZWNpZGVkIHRv
IHN1cHBvcnQgVW5pY2VmIHdpdGggYSBkb25hdGlvbi4gRm9yIGZ1cnRoZXIgZGV0YWlscyBjbGlj
ayBoZXJlPGh0dHBzOi8vd3d3LnVuaWNlZi5vcmcvPiB0byBmaW5kIG91dCBhYm91dCB0aGUgdmFs
dWFibGUgd29yayB0aGV5IGRvLCBoZWxwaW5nIGNoaWxkcmVuIGFsbCBvdmVyIHRoZSB3b3JsZC4N
CldlIHdvdWxkIGxpa2UgdG8gdGFrZSB0aGlzIG9wcG9ydHVuaXR5IHRvIHdpc2ggeW91IGEgTWVy
cnkgQ2hyaXN0bWFzIGFuZCBhIHByb3NwZXJvdXMgTmV3IFllYXIuDQoNCg0KDQpSZW5lc2FzIEVs
ZWN0cm9uaWNzIEV1cm9wZSBMdGQsIER1a2VzIE1lYWRvdywgTWlsbGJvYXJkIFJvYWQsIEJvdXJu
ZSBFbmQsIEJ1Y2tpbmdoYW1zaGlyZSwgU0w4IDVGSCwgVUsuIFJlZ2lzdGVyZWQgaW4gRW5nbGFu
ZCAmIFdhbGVzIHVuZGVyIFJlZ2lzdGVyZWQgTm8uIDA0NTg2NzA5Lg0K
