Return-Path: <SRS0=ug2M=OB=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65221C43441
	for <linux-rtc@archiver.kernel.org>; Thu, 22 Nov 2018 09:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115D020684
	for <linux-rtc@archiver.kernel.org>; Thu, 22 Nov 2018 09:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="sdzZnTsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115D020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390398AbeKVUKg (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:10:36 -0500
Received: from mail-eopbgr1410092.outbound.protection.outlook.com ([40.107.141.92]:17376
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387669AbeKVUKg (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 22 Nov 2018 15:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNJFjRD7r85f+MNXqqDzF1owMUYjWNwo/wJX79gWsC0=;
 b=sdzZnTsm2+Ip+3TIZZVTmEur/WUZJAaYE0AEXO0pGKGCfwDbZsLPioSJ1gPmgJT8XLYZ4Z4/1ytt7yh/HIcBPYUrw/qxIAirqpuFopbrFnbjlFAHswtf1MzgOcaGKTniqNCvZBHsXL6OtpYFAU+tRcWRt0DHTgfMT6pcZN7IOjQ=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB4294.jpnprd01.prod.outlook.com (20.179.180.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 09:31:52 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%4]) with mapi id 15.20.1339.029; Thu, 22 Nov 2018
 09:31:52 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH  1/4] dt-bindings: rtc: pcf85363: Document pcf85263
 real-time clock
Thread-Topic: [PATCH  1/4] dt-bindings: rtc: pcf85363: Document pcf85263
 real-time clock
Thread-Index: AQHUf/pMdB4pDRo/l0GaSzXPs/F/JaVaA1UAgAABW4CAAYZAkA==
Date:   Thu, 22 Nov 2018 09:31:51 +0000
Message-ID: <OSBPR01MB2103DCC6527012134BC86784B8DB0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1542626108-61344-1-git-send-email-biju.das@bp.renesas.com>
 <1542626108-61344-2-git-send-email-biju.das@bp.renesas.com>
 <20181121100452.f4vyzuol2r6bozza@verge.net.au>
 <20181121100937.7savcuxtlxzjm6ld@verge.net.au>
In-Reply-To: <20181121100937.7savcuxtlxzjm6ld@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB4294;20:F4snFK3J2Uq2B2SJDsxv/O/3VC/p8RQn1XY7F8Tb7sDV95JxBdcUVhZDejMFng5CHbh64zy5jZ2Nh012gkseXLHe9Ss2TpDZd1uym+pj6bFCRVI5hzS1SERjwyoVfWpB4o/vf8BevZF31hXbuiQabbCwaDDZuPjdA2aIDLYh1R8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 1747f6a3-db4f-472c-d277-08d6505d55d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB4294;
x-ms-traffictypediagnostic: OSBPR01MB4294:
x-microsoft-antispam-prvs: <OSBPR01MB429436D9D6516C6ECF4968EFB8DB0@OSBPR01MB4294.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB4294;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB4294;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(13464003)(51914003)(102836004)(53546011)(55016002)(6506007)(76176011)(68736007)(105586002)(7696005)(486006)(106356001)(2900100001)(186003)(26005)(7736002)(66066001)(93886005)(229853002)(305945005)(9686003)(6436002)(74316002)(11346002)(6116002)(2906002)(4326008)(97736004)(6916009)(5660300001)(14454004)(53936002)(33656002)(86362001)(71190400001)(25786009)(6246003)(44832011)(99286004)(71200400001)(316002)(54906003)(478600001)(256004)(476003)(3846002)(8936002)(8676002)(81166006)(81156014)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB4294;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mIJIocTtTOj1inXmJzjYJr3xpPFbw5D5sRCQ23CZumWDRNZRMVNQ1FPm1Sz6skVUPeMAD5YYV/UUPQm/L4mGvBeYPabbYF322m8LR6NLvHFGzYQnnlj6J6cpO9x3RO1h72kvLgCpMfPNg9LE565pq8r75H8qyBoX8E83qY24HwV/dcx2OjhCFNs9gEtgg2dayovrHKD+CIYHyNEnOtO8BThqTSGEfCEXNzyAche2izMMJn3U07kYxQWDFtKn8GBcMcNn29afPZlImx5H66HZiv4LtSdxoFy4tIPPmGnJv0VO2RW+FmNH4szfCPbR8h5HGA4yF63o881wXObyq2regoDQuGR+MUxqDSEEwrrhU5s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1747f6a3-db4f-472c-d277-08d6505d55d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 09:31:51.9376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4294
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello Simon,

Thanks for the feedback.

> -----Original Message-----
> From: Simon Horman <horms@verge.net.au>
> Sent: 21 November 2018 10:10
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>; Alexandre Belloni
> <alexandre.belloni@bootlin.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; linux-rtc@vger.kernel.org;
> devicetree@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
> Subject: Re: [PATCH 1/4] dt-bindings: rtc: pcf85363: Document pcf85263 re=
al-
> time clock
>
> On Wed, Nov 21, 2018 at 11:04:52AM +0100, Simon Horman wrote:
> > On Mon, Nov 19, 2018 at 11:15:05AM +0000, Biju Das wrote:
> > > This patch adds binding for NXP pcf85263 real-time clock. pcf85263
> > > rtc is compatible with pcf85363 rtc except that pcf85363 has 64
> > > bytes additional RAM.
> >
> > How about this:
> >
> > This patch adds binding for the NXP pcf85263 real-time clock.
> >
> > The pcf85263 RTC is compatible with the pcf85363 RTC. The difference
> > between the parts is except that the pcf85363 has 64 bytes more RAM.
>
> The pcf85263 anRTC is compatible with the pcf85363 RTC.
>
> The difference between the pcf85263 and pcf85363 RTS is that the latter h=
as
> 64 bytes more RAM. This renders them incompatible from a DT point of view=
.

Will send V2 with the below changes.

This patch adds binding for the NXP pcf85263 real-time clock.

The pcf85263 RTC is compatible with the pcf85363 RTC. The difference
between the parts is except that the pcf85363 has 64 bytes more RAM.

The pcf85263 RTC is compatible with the pcf85363 RTC.

The difference between the pcf85263 and pcf85363 RTC is that the latter has
64 bytes more RAM. This renders them incompatible from a DT point of view.


Regards,
Biju
> >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > ---
> > >  Documentation/devicetree/bindings/rtc/pcf85363.txt | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/rtc/pcf85363.txt
> > > b/Documentation/devicetree/bindings/rtc/pcf85363.txt
> > > index 76fdabc..94adc1c 100644
> > > --- a/Documentation/devicetree/bindings/rtc/pcf85363.txt
> > > +++ b/Documentation/devicetree/bindings/rtc/pcf85363.txt
> > > @@ -1,8 +1,8 @@
> > > -NXP PCF85363 Real Time Clock
> > > +NXP PCF85263/PCF85363 Real Time Clock
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > >
> > >  Required properties:
> > > -- compatible: Should contain "nxp,pcf85363".
> > > +- compatible: Should contain "nxp,pcf85263" or "nxp,pcf85363".
> > >  - reg: I2C address for chip.
> > >
> > >  Optional properties:
> > > --
> > > 2.7.4
> > >
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
