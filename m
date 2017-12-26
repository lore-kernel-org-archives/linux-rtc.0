Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdLZIYa (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 26 Dec 2017 03:24:30 -0500
Date: Tue, 26 Dec 2017 16:24:23 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: linux-kernel-dev@beckhoff.com
Cc: Patrick Bruenn <p.bruenn@beckhoff.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
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
        Sascha Hauer <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v4 0/4] rtc: add mxc driver for i.MX53 SRTC
Message-ID: <20171226082422.GG23070@X250>
References: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, Dec 18, 2017 at 12:51:29PM +0100, linux-kernel-dev@beckhoff.com wrote:
> Patrick Bruenn (4):
>   dt-bindings: rtc: add bindings for i.MX53 SRTC
>   ARM: dts: imx53: add srtc node
>   rtc: add mxc driver for i.MX53 SRTC
>   ARM: imx_v6_v7_defconfig: enable RTC_DRV_MXC_V2

Applied 2/4 and 4/4, thanks.
