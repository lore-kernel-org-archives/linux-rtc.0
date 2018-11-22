Return-Path: <SRS0=ug2M=OB=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A46C43441
	for <linux-rtc@archiver.kernel.org>; Thu, 22 Nov 2018 09:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5795020820
	for <linux-rtc@archiver.kernel.org>; Thu, 22 Nov 2018 09:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="NtKiIUzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5795020820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390542AbeKVUSw (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:18:52 -0500
Received: from mail-eopbgr1410139.outbound.protection.outlook.com ([40.107.141.139]:64419
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387840AbeKVUSw (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 22 Nov 2018 15:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpwGjmq+4zDd2u8g2C+SdANVwipDqLui91JO8z7VGVI=;
 b=NtKiIUzDCjo5OdxWDD5rSnplvp+t9ArOQ67Xo5GopYFEt+HhNXqtM1fDTsUCSMjA1zhR4N7c8OFRKuS5rMe/nGkJ2HKpNIB0RmAWqdW2HQ0Fd8k9KSXX12UbIDp/kS7L5R1Z0wv5NXnNfG6eb/6tO6vuE/HayqKna0/9xo6RVT8=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB3704.jpnprd01.prod.outlook.com (20.178.97.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.44; Thu, 22 Nov 2018 09:40:03 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%4]) with mapi id 15.20.1339.029; Thu, 22 Nov 2018
 09:40:03 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
Thread-Topic: [PATCH 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
Thread-Index: AQHUgYQ81g8fpkLvZkuvYCZVBTmt0KVaCMGAgAF/0FA=
Date:   Thu, 22 Nov 2018 09:40:03 +0000
Message-ID: <OSBPR01MB21034F65FE94BD81EC8C954EB8DB0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1542626108-61344-1-git-send-email-biju.das@bp.renesas.com>
 <1542626108-61344-3-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdVpaB0mJq9LmBoHgBY9MNAXYAKN=h8hCX+iph+D_5pY=Q@mail.gmail.com>
 <20181121103517.GJ8367@piout.net>
In-Reply-To: <20181121103517.GJ8367@piout.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB3704;20:We4b7ThWZGJ1eB3jgY5TPs0ocgsfkWQIQ66XFp4Y/soHPvNK2eC37ohQOpMwYm1kDFM+aIB0BQAoOCeHBVAn8VB+PODxAC8prV5Ixmdo7PFwwjzZEtDyZjfuB8SwdyVq/uH+rQOEf1tq99Corj3GZptS314xwbAYcPgbFOrNUAU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 00440a95-dcab-445e-d4ea-08d6505e7ab9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB3704;
x-ms-traffictypediagnostic: OSBPR01MB3704:
x-microsoft-antispam-prvs: <OSBPR01MB370442E71DCE9879DF7CC4C0B8DB0@OSBPR01MB3704.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(4982022)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB3704;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB3704;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(376002)(396003)(136003)(366004)(13464003)(51914003)(199004)(189003)(74316002)(11346002)(476003)(33656002)(6116002)(3846002)(446003)(305945005)(4326008)(316002)(54906003)(110136005)(44832011)(2906002)(93886005)(14454004)(256004)(486006)(7696005)(76176011)(5660300001)(102836004)(26005)(186003)(6246003)(966005)(53546011)(71190400001)(9686003)(55016002)(71200400001)(6306002)(7736002)(478600001)(99286004)(105586002)(53936002)(106356001)(6506007)(8936002)(2900100001)(86362001)(66066001)(68736007)(229853002)(81166006)(6436002)(8676002)(81156014)(97736004)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3704;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kCad5VqxE8ij+XrXKhdzBTf7Ds4FO20UkqyTOFi9F0nfwjEVDbi1az022Mg+Kg6juLn0E1MiXTmVAcpsoW3sQkgyOwLzfY/zvO91gMwoRx+sz+pDmyxc3heTHEnENNDVcu3oIR7SmYyd69jWgfeuI/GTFVZWU40f2RsFzSJYhVm//1r4f9sIfVh+7zbi/JfFqQ85WvrD4iywApXBlHbCjbTHPdMbSIoUFDyboLc/IYR9fm+sUMXplOzzKpFceSSnO+jSQFakLQDq4VKqB4WyEs44w8oTeV+OgOIuIodytKu5xqmb0j5q4ZvEa+UnKVr4YkPqu3Je6uabvvPTWYezZGMGtdEhFes5I1e5q3YaNsY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00440a95-dcab-445e-d4ea-08d6505e7ab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 09:40:03.3463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3704
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Geert and Alexandre,

Thanks for the feedback.

> -----Original Message-----
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Sent: 21 November 2018 10:35
> To: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Biju Das <biju.das@bp.renesas.com>; Alessandro Zummo
> <a.zummo@towertech.it>; linux-rtc@vger.kernel.org; Simon Horman
> <horms@verge.net.au>; Geert Uytterhoeven <geert+renesas@glider.be>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>; Linux-Renesas <linux-renesas-
> soc@vger.kernel.org>
> Subject: Re: [PATCH 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
>
> On 21/11/2018 11:23:08+0100, Geert Uytterhoeven wrote:
> > Hi Biju,
> >
> > On Mon, Nov 19, 2018 at 12:23 PM Biju Das <biju.das@bp.renesas.com>
> wrote:
> > > Add support for NXP pcf85263 real-time clock. pcf85263 rtc is
> > > compatible with pcf85363,except that pcf85363 has additional 64 bytes=
 of
> RAM.
> > >
> > > 1 byte of nvmem is supported and exposed in sysfs (# is the instance
> > > number,starting with 0): /sys/bus/nvmem/devices/pcf85263-#/nvmem
> > >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/rtc/rtc-pcf85363.c
> > > +++ b/drivers/rtc/rtc-pcf85363.c
> > > @@ -311,7 +311,30 @@ static int pcf85363_nvram_write(void *priv,
> unsigned int offset, void *val,
> > >                                  val, bytes);  }
> > >
> > > -static const struct regmap_config regmap_config =3D {
> > > +static int pcf85263_nvram_read(void *priv, unsigned int offset, void
> *val,
> > > +                              size_t bytes) {
> > > +       struct pcf85363 *pcf85363 =3D priv;
> > > +
> > > +       return regmap_read(pcf85363->regmap, CTRL_RAMBYTE, val); }
> >
> > AFAIU without reading the datasheet, the pcf85363 also has this
> > RAMBYTE register. Would it make sense to expose the contents on both
> parts?

>
> Yes it has. This series allows calling rtc_nvmem_register() multiple time=
s from
> the same driver:
>
> http://patchwork.ozlabs.org/project/rtc-linux/list/?series=3D75212

Will check and send v2,

1) For pcf85363, calling rtc_nvmem_register  twice (1 with 64 bytes and ano=
ther with 1 byte)

2) For pcf85263, calling rtc_nvmem_register   ( with 1 byte)

Regards,
Biju





Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
