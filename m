Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f170.google.com ([74.125.82.170]:33932 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756790AbdLVSgW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 22 Dec 2017 13:36:22 -0500
MIME-Version: 1.0
In-Reply-To: <20171218115133.16371-3-linux-kernel-dev@beckhoff.com>
References: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com> <20171218115133.16371-3-linux-kernel-dev@beckhoff.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 22 Dec 2017 16:36:21 -0200
Message-ID: <CAOMZO5BUeeRVeOq8k=ykNC1KqoFGLZp-Rf=6_npSGgYd_KwxyA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] ARM: dts: imx53: add srtc node
To: linux-kernel-dev <linux-kernel-dev@beckhoff.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Patrick Bruenn <p.bruenn@beckhoff.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Noel Vellemans <Noel.Vellemans@visionbms.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, Dec 18, 2017 at 9:51 AM,  <linux-kernel-dev@beckhoff.com> wrote:
> From: Patrick Bruenn <p.bruenn@beckhoff.com>
>
> rtc-mxc_v2 driver will add support for the i.MX53 SRTC
>
> Note: we keep the 'srtc' label to avoid duplicate with imx53-m53.dtsi
>
> Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
