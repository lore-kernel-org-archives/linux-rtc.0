Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36346 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbdK3OAv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 30 Nov 2017 09:00:51 -0500
Received: by mail-wm0-f52.google.com with SMTP id b76so12650779wmg.1
        for <linux-rtc@vger.kernel.org>; Thu, 30 Nov 2017 06:00:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01CB531330@NT-Mail07.beckhoff.com>
References: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com>
 <20171129221114.GV21126@piout.net> <CAOFm3uFb8Jo9detD2CziuYt_DH_ohYD9P=uvqHugKDxpN+xvAQ@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB531330@NT-Mail07.beckhoff.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 30 Nov 2017 15:00:09 +0100
Message-ID: <CAOFm3uHAXKr7KiFeyvYb77jot8M_4rH-cqt2Ze3AbnOiZ_wiwg@mail.gmail.com>
Subject: Re: [PATCH] rtc: add mxc driver for i.MX53
To: =?UTF-8?Q?Patrick_Br=C3=BCnn?= <P.Bruenn@beckhoff.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-dev <linux-kernel-dev@beckhoff.com>,
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
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Nov 30, 2017 at 2:36 PM, Patrick Br=C3=BCnn <P.Bruenn@beckhoff.com>=
 wrote:
>>From: Philippe Ombredanne [mailto:pombredanne@nexb.com]
>>Sent: Donnerstag, 30. November 2017 09:18
>>>
>>>> +/*
>>>> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
>>Reserved.
>>>> + */
>>>> +
>>>> +/*
>>>> + * The code contained herein is licensed under the GNU General Public
>>>> + * License. You may obtain a copy of the GNU General Public License
>>>> + * Version 2 or later at the following locations:
>>>> + *
>>>> + * http://www.opensource.org/licenses/gpl-license.html
>>>> + * http://www.gnu.org/copyleft/gpl.html
>>>> + */
>>
>>Exactly!
>>And while you are it , you could replace the boilerplate license text
>>with the SPDX id.
>>--
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
> To be clear: I don't want to waste anyone's time on this. But as SPDX
> was intended for automation, I think it might be good to try having
> some common pattern here.
> I don't want to start a discussion, so in case there is no guideline I wi=
ll
> just take the /* SPDX */ in firstline version.

Patrick:

There are several threads on the topic explaining why: Linus made it
clear that he wants this, and on the first line:

> +// SPDX-License-Identifier: GPL-2.0


Thomas:
I tend to prefer as Linus pointed the // style throughout when there
is only a license and copyright involved. Here this would mean:

> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2004-2011 Freescale Semiconductor, Inc. All Rights Rese=
rved.

What's you take since you wrote the doc for this? And is there still
some updates needed for this since your last patch set?


Patrick:
Side note a trailing  "All Rights Reserved." in a copyright statement
is never needed, even though customarily cargo culted by everyone,
including me.
Started in 1910, it become fully obsolete in 2000 thanks to Nicaragua
[1] signing the Berne convention.

[1] https://en.wikipedia.org/wiki/All_rights_reserved
--=20
Cordially
Philippe Ombredanne
