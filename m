Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33481 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752472AbdK3NmX (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 30 Nov 2017 08:42:23 -0500
Date: Thu, 30 Nov 2017 14:42:10 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Patrick =?iso-8859-1?Q?Br=FCnn?= <P.Bruenn@beckhoff.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-dev <linux-kernel-dev@beckhoff.com>,
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
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] rtc: add mxc driver for i.MX53
Message-ID: <20171130134209.GX21126@piout.net>
References: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com>
 <20171129221114.GV21126@piout.net>
 <CAOFm3uFb8Jo9detD2CziuYt_DH_ohYD9P=uvqHugKDxpN+xvAQ@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB531330@NT-Mail07.beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01CB531330@NT-Mail07.beckhoff.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 30/11/2017 at 13:36:22 +0000, Patrick Brünn wrote:
> >From: Philippe Ombredanne [mailto:pombredanne@nexb.com]
> >Sent: Donnerstag, 30. November 2017 09:18
> >>
> >>> +/*
> >>> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
> >Reserved.
> >>> + */
> >>> +
> >>> +/*
> >>> + * The code contained herein is licensed under the GNU General Public
> >>> + * License. You may obtain a copy of the GNU General Public License
> >>> + * Version 2 or later at the following locations:
> >>> + *
> >>> + * http://www.opensource.org/licenses/gpl-license.html
> >>> + * http://www.gnu.org/copyleft/gpl.html
> >>> + */
> >
> >Exactly!
> >And while you are it , you could replace the boilerplate license text
> >with the SPDX id.
> >--
> 
> How would a perfect header look like?
> Looking at :
> git show b24413180f5600bcb3bb70fbed5cf186b60864bd -- drivers/
> and:
> git grep SPDX -- Documentation/
> 
> it could be:
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
> + */
> or:
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
> + */
> 
> Personally I would prefer:
> +/*
> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> 
> So, is there any guideline?
> 

I'm quoting LWN here:

"For normal C source files, the string will be a comment using the "//"
syntax; header files, instead, use traditional (/* */) comments for
reasons related to tooling."

> To be clear: I don't want to waste anyone's time on this. But as SPDX
> was intended for automation, I think it might be good to try having
> some common pattern here.
> I don't want to start a discussion, so in case there is no guideline I will
> just take the /* SPDX */ in firstline version.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
