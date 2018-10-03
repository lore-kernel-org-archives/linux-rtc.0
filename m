Return-Path: <SRS0=Sf1+=MP=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C67C64EBC
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Oct 2018 09:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7981F20835
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Oct 2018 09:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bbvSoftwareServices.onmicrosoft.com header.i=@bbvSoftwareServices.onmicrosoft.com header.b="oqNNXoD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7981F20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bbv.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeJCPs5 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:48:57 -0400
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:7168
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727188AbeJCPs5 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 3 Oct 2018 11:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRKFzqYy7x6ncp6VLNOFJeP5xmEaGhoUKZKtlkQ7gCY=;
 b=oqNNXoD/vgZurliPHzs/tVkqcts5NXqBoxTNMhRoFixGCm6AVrdMmCc5Gflubk62NlXP0WvpHXDJ6IQn5wiF76o+DlXVxfDMzM4iCPY464rIY8h5GYBiG/47Fd5ZYYVBGpGqr9uX4pYkACHRcNizhWTl4O3buNX9Git5YJNRcY8=
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com (52.135.135.148) by
 DB7PR03MB3562.eurprd03.prod.outlook.com (52.134.98.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Wed, 3 Oct 2018 09:01:24 +0000
Received: from DB7PR03MB3834.eurprd03.prod.outlook.com
 ([fe80::15cf:1dc2:d333:eaeb]) by DB7PR03MB3834.eurprd03.prod.outlook.com
 ([fe80::15cf:1dc2:d333:eaeb%3]) with mapi id 15.20.1185.026; Wed, 3 Oct 2018
 09:01:24 +0000
From:   =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lukas.stockmann@siemens.com" <lukas.stockmann@siemens.com>,
        "pascal.bach@siemens.com" <pascal.bach@siemens.com>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add capacitor selection for
 pcf85063
Thread-Topic: [PATCH 1/2] dt-bindings: rtc: add capacitor selection for
 pcf85063
Thread-Index: AQHUU/kV4EyUL5nDhEiJ1526TVfJvqT/WVQAgAOyMYCACjvYAA==
Date:   Wed, 3 Oct 2018 09:01:24 +0000
Message-ID: <ed0744bf64335a3d220353f04394f1cb357b2b4e.camel@bbv.ch>
References: <20180924112340.2685-1-urs.fassler@bbv.ch>
         <20180924121802.GC13455@piout.net> <20180926204435.GB8654@ravnborg.org>
In-Reply-To: <20180926204435.GB8654@ravnborg.org>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0102CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::23) To DB7PR03MB3834.eurprd03.prod.outlook.com
 (2603:10a6:5:30::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=urs.fassler@bbv.ch; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [85.1.96.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR03MB3562;6:BLtCQI3Df1DiBFqCEtXGgc6idXUgnP7SnO8tSpZKg9pynBsG8IvUMMX3yxnahYLkDEPN8Ol3ejInf/vVuTeh2lsECFx9TDort2I1qyjRi4NRliLdyla/Pkgl9CAQnAB4CpgTL5fZg5uhflZejC7umUwOE2Ilv0lSCA7FG6SGl+tsc9bfG1UN9qxXEZIzafLHqGEMtWf/brMVnItPFV/Gk5kgtCBg3MT0l+xmBDa73DyciQSlhqhN3NpCqy/EcDy78zoufAIziTTqRWi8GTHgUTWi3qwr0L08+jqL2w8lnhBwK9O/Yr2MXIRv0vbpJGDZzaT7c5gmtl6wod6E2PWdN6O22o6GwO+OVZw1Vrk4kDgP+FsHe6JPte41ZlPtmZAT0/42D7LvSqVlRmpLAOhlwMMZU/41cNZNe821gbzzSSNVIKrVcyhi5EA9D4yBbuvyNhoqGK73nKP1CoZ2zHn8Qg==;5:HGMlmqHlPiHd0PuS/2fDa62F9oREB+11i54j4FsQaJqYM2lbF4NHveGvCuS5NinIyI8lSGNiOD8M57P6OHcxUGqgNcJfxGNTCA/x0FEJFFZmfkrwcJ+rNVBUDxJl4aeqFZRlIQFJO536C/7+HL2V/ctAtU/CLMM6wnDnynqVIto=;7:c7fIFKMSRbic4OgeUnnh/Cfa6fdC2EFlzXeMoC/v0MtD4+xEzklzQwSYAJaxoqqbe0AtcD4wBruEi8hFW2Sq6qhEOfVX4stpDlud2bnMrwYsEFPgHdzv+Mb/m3DYZIY+LDgdYe7Jz2QWMdAOeiQwaQa9z/PrbFwzWCr4+7nO7fo+e6/wKxz59i9323bCzx7vAExxNVF9XFzPZa4Ki/7m/T8LBxPM1wnAfUzXqf+iVBDp7vVmUfTyT66bGCg5PQc5
x-ms-office365-filtering-correlation-id: be88e825-73a3-4610-1c93-08d6290ecb56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR03MB3562;
x-ms-traffictypediagnostic: DB7PR03MB3562:
x-microsoft-antispam-prvs: <DB7PR03MB3562F356824A0A1E95DD74FB8FE90@DB7PR03MB3562.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231355)(944501410)(4982022)(52105095)(10201501046)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DB7PR03MB3562;BCL:0;PCL:0;RULEID:;SRVR:DB7PR03MB3562;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39840400004)(376002)(346002)(136003)(189003)(199004)(386003)(229853002)(11346002)(2616005)(446003)(476003)(6116002)(3846002)(85202003)(106356001)(105586002)(486006)(2906002)(36756003)(5250100002)(2900100001)(118296001)(6512007)(966005)(7736002)(305945005)(26005)(6486002)(186003)(256004)(102836004)(53936002)(5660300001)(6436002)(6306002)(14454004)(85182001)(478600001)(8936002)(99286004)(52116002)(4326008)(74482002)(71190400001)(6506007)(316002)(71200400001)(81156014)(81166006)(86362001)(6246003)(66066001)(68736007)(25786009)(76176011)(97736004)(8676002)(54906003)(33896004)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR03MB3562;H:DB7PR03MB3834.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bbv.ch does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: k7BgUS++ahMAE5ny9AS6BvBwD35ypDLbDmHMHCvGkYsECcRNvGCD8CHXxtj34kX3lp9ityROK5sGrJfzRqdT51qCWZF7x0zFJfxUA/XOl3Y2mwn3iWG8sIkaxFUXfx6ptWZCUlmhs8seW1lJPIRnguEENaAQ8cMtaHMP76LLbrwaVQQPmfu2gRfzpzSSNu8P+INNyXvRf80oEwikf8WJyPiL2/HJQE0i1dfRBnQsrfIsWiO4pxTdeilw1zbWt9uVZ9WmAwqapNx+/zhbNb7DPm5xlSN0KxXWoFqdj8hXs5CkCqJM1p9sGzvr0+oeiYJ/4LQz51we1T1l+tUdgDJGi7nr688YWnyqRb2x68h5Fbw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5BB59DB71418748AF81EE25B552452F@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: be88e825-73a3-4610-1c93-08d6290ecb56
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 09:01:24.0275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3562
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

SGkgU2FtLA0KSSByZXZpZXdlZCB5b3VyIHBhdGNoLiBJIHdvdWxkIGFsc28gcmVjb21tZW5kIHRv
IHJlbW92ZSB0aGUgIm54cCwiDQpwcmVmaXggZm9yIHRoZSBkZXZpY2UgdHJlZSBwcm9wZXJ0eS4g
T3RoZXJ3aXNlIHdlIGFyZSBiZSBoYXBweSB0byB1c2UNCm91ciBwYXRjaCBzaW5jZSBpdCBmdWxm
aWxscyBvdXIgbmVlZHMgYW5kIGlzIG1vcmUgZ2VuZXJhbCB0aGFuIG91cg0KdmVyc2lvbi4NCg0K
VXJzDQoNCg0KT24gV2VkLCAyMDE4LTA5LTI2IGF0IDIyOjQ0ICswMjAwLCBTYW0gUmF2bmJvcmcg
d3JvdGU6DQo+IEhpIFVycy4NCj4gDQo+IE9uIE1vbiwgU2VwIDI0LCAyMDE4IGF0IDAyOjE4OjAy
UE0gKzAyMDAsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiA+IEhlbGxvIFVycywNCj4gPiAN
Cj4gPiBZb3UgcHJvYmFibHkgd2FudCB0byBzeW5jaHJvbml6ZSB3aXRoIFNhbSBhbmQgaGlzIHNl
cmllczoNCj4gPiBodHRwOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9ydGMtbGludXgv
bGlzdC8/c2VyaWVzPTY0NjY0JnN0YXRlPSoNCj4gDQo+IFdlIHdpbGwgbGlrZWx5IGFkZCBhIG5l
dyBwcm9wZXJ0eSB0aGF0IGNhbiBiZSB1c2VkDQo+IGluIGdlbmVyYWwuIFNlZSBhYm92ZSBtYWls
IHNlcmllcyAocmVjZW50IG1haWxzKS4NCj4gDQo+IEkgd2lsbCBjb3B5IHlvdSBvbiBteSBuZXh0
IHN1Ym1pc3Npb24gKGluIGEgd2VlayBvciBzbykuDQo+IA0KPiAJU2FtDQoNCg==
