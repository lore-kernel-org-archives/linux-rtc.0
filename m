Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34713 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750882AbdKOJxR (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 15 Nov 2017 04:53:17 -0500
From: Juergen Borleis <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: DryIce , RTC not working on imx53.
Date: Wed, 15 Nov 2017 10:53:12 +0100
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "Vellemans, Noel" <Noel.Vellemans@visionbms.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Patrick =?utf-8?q?Br=C3=BCnn?= <P.Bruenn@beckhoff.com>
References: <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com> <20171114105517.74ycmwcjsab7xp2j@piout.net> <201711141343.15309.jbe@pengutronix.de>
In-Reply-To: <201711141343.15309.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201711151053.13676.jbe@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi all,

On Tuesday 14 November 2017 13:43:14 Myself wrote:
> On Tuesday 14 November 2017 11:55:17 Alexandre Belloni wrote:
> > On 14/11/2017 at 08:33:09 -0200, Fabio Estevam wrote:
> > > On Tue, Nov 14, 2017 at 8:26 AM, Alexandre Belloni
> > >
> > > <alexandre.belloni@free-electrons.com> wrote:
> > > >> I have the impression that the dryice driver has never worked in
> > > >> mainlune for mx53.
> > > >
> > > > I doubt that because it seems to have been used by Pengutronix.
> > >
> > > Juergen can confirm, but it seems the dryice driver was only used on
> > > mx25 in mainline.
> >
> > Ok, that would explain it.
>
> Yes. The development was made on an i.MX25. But currently I have an
> i.MX53 on my desk here and could test...

After a quick look into the reference manuals:

Patch 5b72505 ("ARM: dts: imx53: add srtc node") is bad. The i.MX53 provides 
an RTC more close to the i.MX6 instead (e.g. rtc-snvs.c). But unfortunately 
it uses a different register layout than the i.MX6 does. So we can't use 
this driver without i.MX53 specific adaptions.
But at least 5b72505 should be reverted.

jb

-- 
Pengutronix e.K.                             | Juergen Borleis             |
Industrial Linux Solutions                   | http://www.pengutronix.de/  |
