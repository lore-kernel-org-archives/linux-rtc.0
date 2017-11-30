Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:48246 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdK3L4H (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 30 Nov 2017 06:56:07 -0500
Date: Thu, 30 Nov 2017 11:53:16 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel-dev@beckhoff.com, Mark Rutland <mark.rutland@arm.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Patrick Bruenn <p.bruenn@beckhoff.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Noel Vellemans <Noel.Vellemans@visionbms.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:REAL TIME CLOCK \(RTC\) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH] rtc: add mxc driver for i.MX53
Message-ID: <20171130115316.1dcd86d8@karo-electronics.de>
In-Reply-To: <20171130095047.4sl7rfa5cc6rtmig@pengutronix.de>
References: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com>
        <20171130095047.4sl7rfa5cc6rtmig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On Thu, 30 Nov 2017 10:50:47 +0100 Sascha Hauer wrote:
> On Tue, Nov 28, 2017 at 08:39:27AM +0100, linux-kernel-dev@beckhoff.com wrote:
[...]
> > +/*! MXC RTC Power management control */
> > +static int mxc_rtc_probe(struct platform_device *pdev)
> > +{
> > +	struct timespec tv;
> > +	struct resource *res;
> > +	struct rtc_drv_data *pdata = NULL;
> 
> No need to initialize.
> 
> > +	void __iomem *ioaddr;
> > +	int ret = 0;
>
Same here.


Lothar Waßmann
