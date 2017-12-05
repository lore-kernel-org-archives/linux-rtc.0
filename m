Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39718 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752858AbdLEOML (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 5 Dec 2017 09:12:11 -0500
MIME-Version: 1.0
In-Reply-To: <20171205140646.30367-4-linux-kernel-dev@beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com> <20171205140646.30367-4-linux-kernel-dev@beckhoff.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Dec 2017 12:12:10 -0200
Message-ID: <CAOMZO5DkHM4L17eHQVANhtrkQkP8ayvVtXD9aVu==5CnauJqeA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rtc: mxc_v2: add driver for i.MX53 SRTC
To: linux-kernel-dev@beckhoff.com
Cc: Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Patrick Bruenn <p.bruenn@beckhoff.com>,
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
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, Dec 5, 2017 at 12:06 PM,  <linux-kernel-dev@beckhoff.com> wrote:
> From: Patrick Bruenn <p.bruenn@beckhoff.com>
>
> Add RTC_DRV_MXC_V2 config option
>
> Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>

You should add the Kconfig as part of the patch that introduces the driver.
