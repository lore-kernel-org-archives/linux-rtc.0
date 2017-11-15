Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:55125 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932317AbdKOLm0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 15 Nov 2017 06:42:26 -0500
Received: by mail-ot0-f193.google.com with SMTP id w8so19331006otw.11
        for <linux-rtc@vger.kernel.org>; Wed, 15 Nov 2017 03:42:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201711151053.13676.jbe@pengutronix.de>
References: <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
 <20171114105517.74ycmwcjsab7xp2j@piout.net> <201711141343.15309.jbe@pengutronix.de>
 <201711151053.13676.jbe@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 15 Nov 2017 09:42:25 -0200
Message-ID: <CAOMZO5BztTwJcqgG6pF+BVY8wr58wsemw8FVwb=5_vi-16mCgQ@mail.gmail.com>
Subject: Re: DryIce , RTC not working on imx53.
To: Juergen Borleis <jbe@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "Vellemans, Noel" <Noel.Vellemans@visionbms.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        =?UTF-8?Q?Patrick_Br=C3=BCnn?= <P.Bruenn@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Nov 15, 2017 at 7:53 AM, Juergen Borleis <jbe@pengutronix.de> wrote:

> After a quick look into the reference manuals:
>
> Patch 5b72505 ("ARM: dts: imx53: add srtc node") is bad. The i.MX53 provides
> an RTC more close to the i.MX6 instead (e.g. rtc-snvs.c). But unfortunately
> it uses a different register layout than the i.MX6 does. So we can't use
> this driver without i.MX53 specific adaptions.
> But at least 5b72505 should be reverted.

Agreed. Looked in the vendor kernel and this is the rtc driver for mx53:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/rtc/rtc-mxc_v2.c?h=imx_2.6.35_11.09.01

,which is a different one from the dryice one:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/rtc/rtc-imxdi.c?h=imx_2.6.35_11.09.01

I will send a revert for 5b72505 ("ARM: dts: imx53: add srtc node").

Thanks
