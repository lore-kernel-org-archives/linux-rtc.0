Return-Path: <SRS0=ySH3=OQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968A2C64EB1
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 09:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BA520838
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 09:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BA520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLGJeT (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:34:19 -0500
Received: from mail-eopbgr1410133.outbound.protection.outlook.com ([40.107.141.133]:26550
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbeLGJeS (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 7 Dec 2018 04:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkQJSdf/j0TkUJkgoJH9v+Sj/hYnr6im6PREu8TR2Os=;
 b=W2XUsbI2Fa1EcIPxNUYM87utP2TGz5jUnWXm0XBx1Nm9DP86yI4mALdxtjqM2Uc0VmkGQUSGX+2msBIRZ8FQ+cWrHzHeL2BSw9mSln4EprYSmiG0fEDpfLvypbKJK7cJms4jeNUqaY6t2lpGgycYlH4rvPiyMJJzgXkHpgMyHXw=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB4789.jpnprd01.prod.outlook.com (20.179.182.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 7 Dec 2018 09:34:11 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%5]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 09:34:11 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
Thread-Index: AQHUjUK6JpQnuqQbm02UjS4gg3wPT6VxdJKAgAA9DyCAACb3gIAAAhnwgAASzgCAAQtNMA==
Date:   Fri, 7 Dec 2018 09:34:11 +0000
Message-ID: <OSBPR01MB2103D626F5A58D86D726E721B8AA0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com>
 <1544086559-47141-3-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdVv262dM8JGWN4w3h2kq4Y4ftRczn8TF-kM_fecF4GXnw@mail.gmail.com>
 <OSBPR01MB21039D89E5E8852574A18893B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAMuHMdWRz-iutKD54vtmJxnLsb3vtm1juYDw-k1+RFCNUVsjkg@mail.gmail.com>
 <OSBPR01MB2103A13E75634AD81CFD1628B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20181206165202.GC8952@piout.net>
In-Reply-To: <20181206165202.GC8952@piout.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB4789;20:/fFGh6rB7bcMR7buX49FqNTTzUoE/qS2fALn91DDiAzGIa5dI1leOR6Ozp27EZHAVsGg5RVxlkL2xVcWIQuJAVgnqrRlxXRJiaHJedgZ8j8j+T4U/zLa9sFNLdMgmJt5rTnx4VnhoyHQRu2RGVGnvHF32nDJx6ncjTbCpXAs8as=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 1da3a6c2-22bc-482b-b670-08d65c272504
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB4789;
x-ms-traffictypediagnostic: OSBPR01MB4789:
x-microsoft-antispam-prvs: <OSBPR01MB4789ED06B68E797F32CB0856B8AA0@OSBPR01MB4789.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB4789;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB4789;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(396003)(366004)(189003)(199004)(51914003)(14454004)(71190400001)(25786009)(2906002)(11346002)(6436002)(256004)(6246003)(68736007)(106356001)(33656002)(105586002)(97736004)(86362001)(446003)(71200400001)(53936002)(9686003)(7736002)(6116002)(55016002)(476003)(305945005)(76176011)(3846002)(186003)(4326008)(66066001)(7696005)(10126004)(6916009)(229853002)(8676002)(53546011)(486006)(93886005)(44832011)(102836004)(316002)(54906003)(8936002)(6506007)(478600001)(81156014)(99286004)(81166006)(74316002)(5660300001)(6306002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB4789;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q9qGHv9kJB2JK355UYcCLpbYu3hMCqPMm2i2KMGy3a7ZSc5GTiq4wFkRP7pNX8z0puIsWjzjNTs2f+/g2RC79V/VHHpumSjtOxixnkb3+Qm+7sn89AX7Bu/hMLVw4QyAmjEBAwS4JAfqYU4d8sOMjYqaBhgRjyKiwOUCwRidHeFK37eXF1bITWNxjhIvS9vfVBcmPprTEP4idUt1pPqtM2Fq8O1xGGRXsCowMzpsIbOfCdAvTHlaGl98joJH+l1KxmhWE5uXgl/Dp3FLb6EYw3g4FMT8k/MxU4bnBy1pFF+bWIp390zv7/8013c0RO2zQE+MGUaD3A5X0uREM4kRnNQ8UTHWTyvbAlYxttO9kLg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da3a6c2-22bc-482b-b670-08d65c272504
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 09:34:11.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4789
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Alexandre,

Thanks for the feedback.

> Subject: Re: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP pcf85263 r=
tc
>
> On 06/12/2018 15:49:57+0000, Biju Das wrote:
> > Hi Geert,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP
> > > pcf85263 rtc
> > >
> > > Hi Biju,
> > >
> > > On Thu, Dec 6, 2018 at 4:24 PM Biju Das <biju.das@bp.renesas.com>
> wrote:
> > > > > Subject: Re: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP
> > > > > pcf85263 rtc CC nvmem maintainer
> > > > >
> > > > > On Thu, Dec 6, 2018 at 10:04 AM Biju Das
> > > > > <biju.das@bp.renesas.com>
> > > wrote:
> > > > > > Add support for NXP pcf85263 real-time clock. pcf85263 rtc is
> > > > > > compatible with pcf85363,except that pcf85363 has additional
> > > > > > 64 bytes of
> > > > > RAM.
> > >
> > > > > > --- a/drivers/rtc/rtc-pcf85363.c
> > > > > > +++ b/drivers/rtc/rtc-pcf85363.c
> > > > > > @@ -120,6 +120,11 @@ struct pcf85363 {
> > > > > >         struct regmap           *regmap;
> > > > > >  };
> > > > > >
> > > > > > +struct pcf85x63_config {
> > > > > > +       struct regmap_config regmap;
> > > > > > +       unsigned int num_nvram; };
> > > > > > +
> > > > > >  static int pcf85363_rtc_read_time(struct device *dev, struct
> > > > > > rtc_time
> > > > > > *tm)  {
> > > > > >         struct pcf85363 *pcf85363 =3D dev_get_drvdata(dev); @@
> > > > > > -311,25
> > > > > > +316,68 @@ static int pcf85363_nvram_write(void *priv,
> > > > > > +unsigned int
> > > > > offset, void *val,
> > > > > >                                  val, bytes);  }
> > > > > >
> > > > > > -static const struct regmap_config regmap_config =3D {
> > > > > > -       .reg_bits =3D 8,
> > > > > > -       .val_bits =3D 8,
> > > > > > -       .max_register =3D 0x7f,
> > > > > > +static int pcf85x63_nvram_read(void *priv, unsigned int
> > > > > > +offset, void
> > > *val,
> > > > > > +                              size_t bytes)
> > > > >
> > > > > Given bytes should be 1, val should be a pointer to a single byte=
...
> > > > > What if bytes =3D=3D 0?
> > > >
> > > > I doubt we get "bytes=3D=3D0" because of the checks in "
> > > drivers/nvmem/core.c"
> > > > Function " bin_attr_nvmem_read/ bin_attr_nvmem_write".
> > >
> > > Depends. There are other functions calling nvmem_reg_{read,write}(),
> e.g.
> > > nvmem_device_{read,write}().
> >
> > OK. In that case, I will return (-EINVAL)  for "bytes !=3D1"
> >
>
> I think it is probably better to ensure the nvmem core never passes an in=
valid
> number of bytes. All the ther RTC drivers make that assumption.

In that case, I will do following checks in nvmem_device_{read,write}() bef=
ore calling nvmem_reg_{read,write}(),

nvmem_device_read

/* Stop the user from reading */
if (offset  >=3D nvmem->size)
return 0;

if (bytes =3D=3D 0)
return -EINVAL;

if (offset + bytes > nvmem->size)
bytes =3D nvmem->size - offset;

nvmem_device_write

/* Stop the user from writing */
if (offset  >=3D nvmem->size)
return -EFBIG;

if (bytes =3D=3D 0)
return -EINVAL;

if (offset + bytes > nvmem->size)
bytes =3D nvmem->size - offset;

regards,
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
