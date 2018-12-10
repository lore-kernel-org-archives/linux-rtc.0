Return-Path: <SRS0=WBM2=OT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AB5C04EB8
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 12:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A82820821
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 12:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ms7vr//v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A82820821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeLJMfo (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:35:44 -0500
Received: from mail-eopbgr1410105.outbound.protection.outlook.com ([40.107.141.105]:6211
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbeLJMfo (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 10 Dec 2018 07:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeSNIWFFjMVhT6PdLmr0hzdV7K5BfVhB4t0RiS4fRaI=;
 b=ms7vr//vXkkTTjXF7q9FRnO6tbVCLjSTVKLujgNkozmMRjReBBvFZ6//SWEVmqfHZGkD86sqCzQOGdVn+KAoiOXhQiLJAILsXWCWdnC9rSljbZ3hiemRnLHSBs/RnEXc++P73jw8ldPWXDYxvlaQhN1souf0ZNb59dbSlHEXlqU=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB2629.jpnprd01.prod.outlook.com (52.134.253.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Mon, 10 Dec 2018 12:35:36 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%5]) with mapi id 15.20.1404.021; Mon, 10 Dec 2018
 12:35:36 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH v4 4/5] ARM: shmobile: Enable NXP pcf85363 rtc in
 shmobile_defconfig
Thread-Topic: [PATCH v4 4/5] ARM: shmobile: Enable NXP pcf85363 rtc in
 shmobile_defconfig
Thread-Index: AQHUjiEceNbHI28mSkSctVPlDE/z0aV351AAgAAAbBA=
Date:   Mon, 10 Dec 2018 12:35:35 +0000
Message-ID: <OSBPR01MB2103861EF91EE6456EB3E03BB8A50@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
 <1544182066-31528-5-git-send-email-biju.das@bp.renesas.com>
 <20181210121340.iuwyq5myk4woezpg@verge.net.au>
In-Reply-To: <20181210121340.iuwyq5myk4woezpg@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2629;20:N0tDKftHqmawgNhflZLCbRGGQLRj7f5vUQQe6IZQ7Ahk2PtkI6CbbBHSJVj4rkKI8McN1MqliKvhUKkbK1AUFnpAbqXPNkVPCVLrRgT1ny0QHjduJEgyv/cFweOdsTFPduJ1X6kmT+d3/FYA4yOcjYvtI8nJyCX8bFVmtIdFNXQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: cea98c81-792d-4f72-cb3a-08d65e9bfc2d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2629;
x-ms-traffictypediagnostic: OSBPR01MB2629:
x-microsoft-antispam-prvs: <OSBPR01MB262932B0E12C39A90437BBB9B8A50@OSBPR01MB2629.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB2629;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2629;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(51914003)(7696005)(229853002)(6506007)(71200400001)(99286004)(26005)(71190400001)(6116002)(8936002)(3846002)(68736007)(6246003)(39060400002)(107886003)(11346002)(6436002)(6916009)(25786009)(446003)(186003)(478600001)(44832011)(76176011)(256004)(102836004)(476003)(486006)(97736004)(5660300001)(86362001)(9686003)(81156014)(74316002)(7736002)(66066001)(33656002)(55016002)(6306002)(81166006)(14454004)(8676002)(2906002)(54906003)(10126004)(4326008)(316002)(53936002)(105586002)(305945005)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2629;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vO4JdWxedVR73Tz2CXVzcmoX6Xipn4lhp6g5ls0/5Kml1ryiFuWaTdmHgp9jtZnQBXU95M73UpA6B8v78cotvHDdEFglL3YcQ7xbEXYBjJ7lOTwV9Ts8HvLIvY2w2naCOUgk6WLn+uBHMNKlQNfMrra3yhhB9B8SGP0sfMnyoKHEnlTEJzK69/OVqy6d0l4/xLHVcdfhsr7qKDY/uh6iVL/5/mdKuba6Vu/aG/hXr0+nJT4l3clKsceTHEO6r66gO669ZIbfh9iCmCT41u80v1gDLIheeiGKuB65stWlbeNuV0S7yFyKccxmnCZb4Jwr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea98c81-792d-4f72-cb3a-08d65e9bfc2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 12:35:35.8091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2629
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Simon,

Thanks for the feedback.

> Subject: Re: [PATCH v4 4/5] ARM: shmobile: Enable NXP pcf85363 rtc in
> shmobile_defconfig
>
> On Fri, Dec 07, 2018 at 11:27:45AM +0000, Biju Das wrote:
> > The iWave RZ/G1C SBC supports RTC (NXP pcf85263). To increase hardware
> > support enable the driver in the shmobile_defconfig multiplatform
> > configuration.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks, applied for v4.22.
>
> Is a similar change for multi_v7_defconfig also appropriate?

Will send a separate patch for adding it to the "multi_v7_defconfig"

CONFIG_RTC_DRV_PCF85363=3Dm

Regards,
Biju


[https://www2.renesas.eu/media/email/unicef.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe ha=
ve decided to support Unicef with a donation. For further details click her=
e<https://www.unicef.org/> to find out about the valuable work they do, hel=
ping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a =
prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
