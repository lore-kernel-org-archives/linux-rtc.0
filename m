Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46994 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbdLKL2q (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 11 Dec 2017 06:28:46 -0500
Received: by mail-wm0-f68.google.com with SMTP id r78so13796562wme.5
        for <linux-rtc@vger.kernel.org>; Mon, 11 Dec 2017 03:28:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171211105657.20251-4-linux-kernel-dev@beckhoff.com>
References: <20171211105657.20251-1-linux-kernel-dev@beckhoff.com> <20171211105657.20251-4-linux-kernel-dev@beckhoff.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 11 Dec 2017 12:28:04 +0100
Message-ID: <CAOFm3uHkZoRqdbv1O0kGD6Jomexj3a3pAhUrMYJyphSu0gLdhQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] rtc: add mxc driver for i.MX53 SRTC
To: linux-kernel-dev <linux-kernel-dev@beckhoff.com>
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
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, Dec 11, 2017 at 11:56 AM,  <linux-kernel-dev@beckhoff.com> wrote:
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
[...]
> v2:
[...]
> - add SPDX-License-Identifier and cleanup copyright notice

Thank you for using the SPDX ids in this patch series.

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

-- 
Cordially
Philippe Ombredanne
