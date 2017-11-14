Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55042 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753458AbdKNKz2 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 14 Nov 2017 05:55:28 -0500
Date: Tue, 14 Nov 2017 11:55:17 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Patrick =?iso-8859-1?Q?Br=FCnn?= <P.Bruenn@beckhoff.com>,
        Juergen Borleis <jbe@pengutronix.de>,
        "Vellemans, Noel" <Noel.Vellemans@visionbms.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: DryIce , RTC not working on imx53.
Message-ID: <20171114105517.74ycmwcjsab7xp2j@piout.net>
References: <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
 <20171109030327.anzo47xayxckn47r@piout.net>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52290E@NT-Mail07.beckhoff.com>
 <20171113161522.2kq7un7gl5vg4qlq@piout.net>
 <CAOMZO5Bi5PcuGiVRZykw9Zp-ysHmHzThhwNai-cqy3HRTUKQAg@mail.gmail.com>
 <CAOMZO5AOAo8OU86CrneFeWuu2ti1sea9843UQ16=7AyU5-B11Q@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52F4BE@NT-Mail07.beckhoff.com>
 <CAOMZO5B_RcXb6X7gUVSJbDpKSHj9eqtDqcYHjEN1n6zhkyCAjQ@mail.gmail.com>
 <20171114102614.g2bxstg5qacvmtk6@piout.net>
 <CAOMZO5CdGAqBkBQ5DdphzNr-tB5r7Sj9jBAhFTFPNezTEjJOMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5CdGAqBkBQ5DdphzNr-tB5r7Sj9jBAhFTFPNezTEjJOMg@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 14/11/2017 at 08:33:09 -0200, Fabio Estevam wrote:
> On Tue, Nov 14, 2017 at 8:26 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> 
> >> I have the impression that the dryice driver has never worked in
> >> mainlune for mx53.
> >>
> >
> > I doubt that because it seems to have been used by Pengutronix.
> 
> Juergen can confirm, but it seems the dryice driver was only used on
> mx25 in mainline.

Ok, that would explain it.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
