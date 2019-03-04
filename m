Return-Path: <SRS0=54M4=RH=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55EDC10F03
	for <linux-rtc@archiver.kernel.org>; Mon,  4 Mar 2019 07:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96400206B8
	for <linux-rtc@archiver.kernel.org>; Mon,  4 Mar 2019 07:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="SXqsbcBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfCDHgf (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:36:35 -0500
Received: from mail-eopbgr1410102.outbound.protection.outlook.com ([40.107.141.102]:56032
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfCDHgf (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 4 Mar 2019 02:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg9/r1NcNfmAtY3fx3NPR8J1wsqEI+Dn0XGaR0bvlao=;
 b=SXqsbcBWexfx9bmhUhqsbGD9qdwV+wiRAsFggg/oYyIWs/MPJBOoZAWWpG2bFgZ+P1il/SltEMIJGmcJd8t4TU5p3xwGLm14q683dWtP8IS2sXbQxpkSs1s7MYdZzN/Ivz9wZZnBauKajW6M6Cpj5ItKUPLzXQUXe6//C+8y1ns=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.242.17) by
 OSBPR01MB4837.jpnprd01.prod.outlook.com (20.179.183.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Mon, 4 Mar 2019 07:36:30 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::d5b0:ac4:6d54:6285]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::d5b0:ac4:6d54:6285%5]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 07:36:30 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 0/5] Add EPSON RX-8571 RTC support
Thread-Topic: [PATCH 0/5] Add EPSON RX-8571 RTC support
Thread-Index: AQHUycpOlymYMXfQkUq5zUGfpbuH96X45FOAgAJBD+A=
Date:   Mon, 4 Mar 2019 07:36:30 +0000
Message-ID: <OSBPR01MB2103083CF63308FD80FD8927B8710@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1550742048-28068-1-git-send-email-biju.das@bp.renesas.com>
 <20190302210733.GC3452@piout.net>
In-Reply-To: <20190302210733.GC3452@piout.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2de07a5-1341-44ac-3c01-08d6a0741e5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB4837;
x-ms-traffictypediagnostic: OSBPR01MB4837:
x-microsoft-exchange-diagnostics: 1;OSBPR01MB4837;20:cTPnfcba7Q99JXEuQIgkIlRpYi0vkXJCm4t6S9JOUoXMAN+bWK9v0CBxZ9+Tw0LqkOCHDL5WO5+Vwy3JXKDoPR8Ut9qEsBKot/trkCciAeQXfdG/UJ/Z+RUSPu/POS0rA6jJxBbLTmr9+0wNltAGlEdukDhK/HfDDEfbj7YJud0=
x-microsoft-antispam-prvs: <OSBPR01MB4837D85F362011E85CE290ACB8710@OSBPR01MB4837.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(39860400002)(366004)(13464003)(199004)(189003)(2906002)(33656002)(66066001)(105586002)(106356001)(97736004)(3846002)(6116002)(8936002)(8676002)(81156014)(81166006)(74316002)(14454004)(7736002)(44832011)(6246003)(54906003)(305945005)(6916009)(478600001)(26005)(229853002)(4326008)(53546011)(102836004)(68736007)(5660300002)(476003)(25786009)(486006)(11346002)(446003)(6436002)(76176011)(9686003)(86362001)(55016002)(186003)(71190400001)(71200400001)(52536013)(7696005)(316002)(53936002)(99286004)(256004)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB4837;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4TNtb2Z7VHwqGm7tcBKH/A34qSg/vxXdD1RXoVYWZ2hUxNb9rpjmObsi/E/8/1U9X+UR+/9+NV+EtOHAkzShTsNCRr5KI+/S/Hd0jn/6TfZ2PJo5RlCuPwxl8YH7paA4QKl1AEP5GHyALn51YAyKokCX81f6AgWNY08ndd/0GZE2rq+GY5FQhBQm7ChWFNmhVOm1jjYUzm1fl0vqPS4fsPDe1cfva6uGAzLZstxyEJhGa7cAzXQdHOS2SJJODDdNoXCLww/HK1qF7ffa/gj2VqV8XHxmPS01Fh83G2vQTvnRotXAZ7KlBciP59wr7EEVSJxXc/Ozly+WG9CbMq3k2igt7Wn2+CGO03AhLWu9OQYId26SPA4dzkf4h+IRgg6HENzoCaU0uUkB1yy625bCWpLEF64OtIMif4e5FQpn6S4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2de07a5-1341-44ac-3c01-08d6a0741e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 07:36:30.3409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4837
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Alexandre,

> -----Original Message-----
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Sent: 02 March 2019 21:08
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; linux-
> rtc@vger.kernel.org; devicetree@vger.kernel.org; Simon Horman
> <horms@verge.net.au>; Geert Uytterhoeven <geert+renesas@glider.be>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
> Subject: Re: [PATCH 0/5] Add EPSON RX-8571 RTC support
>
> On 21/02/2019 09:40:43+0000, Biju Das wrote:
> > This patch set aims to add support for EPSON RX-8571 real-time clock.
> > EPSON RX-8571 rtc is compatible with EPSON RX-8581 rtc except that
> > former has 16 bytes additional RAM.
> >
> > 1 byte of nvmem is supported on both RX-8581 and RX-8571. It is
> > exposed through sysfs along with  support for 16 bytes additional RAM
> > present only on EPSON RX-8571.
> >
> > This patch series is tested against renesas-dev and linux-next.
> >
> > Biju Das (5):
> >   rtc: rx8581: Add rx8571 compatible
> >   rtc: rx8581: Add support for rx8571 RTC
> >   rtc: rx8581: Add support for Epson rx8571 RTC
>
> Applied 1-3. Note that I squashed 2 and 3 as 2 didn't make much sense
> without 3.

Thanks.

Regards,
Biju


Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael Hanna=
wald, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse =
10, 40472 Duesseldorf, Germany,Handelsregister/Commercial Register: Duessel=
dorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr.=
/WEEE reg. no.: DE 14978647
