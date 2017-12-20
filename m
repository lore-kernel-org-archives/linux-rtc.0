Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39633 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755406AbdLTVZN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Dec 2017 16:25:13 -0500
Date: Wed, 20 Dec 2017 22:25:11 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-kernel-dev@beckhoff.com
Cc: Patrick Bruenn <p.bruenn@beckhoff.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Juergen Borleis <jbe@pengutronix.de>,
        Noel Vellemans <Noel.Vellemans@visionbms.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v4 0/4] rtc: add mxc driver for i.MX53 SRTC
Message-ID: <20171220212511.GC15162@piout.net>
References: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 18/12/2017 at 12:51:29 +0100, linux-kernel-dev@beckhoff.com wrote:
> From: Patrick Bruenn <p.bruenn@beckhoff.com>
> 
> Neither rtc-imxdi, rtc-mxc nor rtc-snvs are compatible with i.MX53.
> 
> This is driver enables support for the low power domain SRTC features:
> - 32-bit MSB of non-rollover time counter
> - 32-bit alarm register
> 
> Select the new config option RTC_DRV_MXC_V2 to build this driver
> 
> Based on:
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/rtc/rtc-mxc_v2.c?h=imx_2.6.35_11.09.01
> 
> Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>
> 

Applied 1/4 and 3/4, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
