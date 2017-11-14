Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53175 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754145AbdKNMnU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 14 Nov 2017 07:43:20 -0500
From: Juergen Borleis <jbe@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: DryIce , RTC not working on imx53.
Date: Tue, 14 Nov 2017 13:43:14 +0100
Cc: Fabio Estevam <festevam@gmail.com>,
        Patrick =?utf-8?q?Br=C3=BCnn?= <P.Bruenn@beckhoff.com>,
        "Vellemans, Noel" <Noel.Vellemans@visionbms.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
References: <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com> <CAOMZO5CdGAqBkBQ5DdphzNr-tB5r7Sj9jBAhFTFPNezTEjJOMg@mail.gmail.com> <20171114105517.74ycmwcjsab7xp2j@piout.net>
In-Reply-To: <20171114105517.74ycmwcjsab7xp2j@piout.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201711141343.15309.jbe@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On Tuesday 14 November 2017 11:55:17 Alexandre Belloni wrote:
> On 14/11/2017 at 08:33:09 -0200, Fabio Estevam wrote:
> > On Tue, Nov 14, 2017 at 8:26 AM, Alexandre Belloni
> >
> > <alexandre.belloni@free-electrons.com> wrote:
> > >> I have the impression that the dryice driver has never worked in
> > >> mainlune for mx53.
> > >
> > > I doubt that because it seems to have been used by Pengutronix.
> >
> > Juergen can confirm, but it seems the dryice driver was only used on
> > mx25 in mainline.
>
> Ok, that would explain it.

Yes. The development was made on an i.MX25. But currently I have an i.MX53 
on my desk here and could test...

jb

-- 
Pengutronix e.K.                             | Juergen Borleis             |
Industrial Linux Solutions                   | http://www.pengutronix.de/  |
