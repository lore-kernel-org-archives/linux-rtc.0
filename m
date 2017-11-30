Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37920 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdK3ISx (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 30 Nov 2017 03:18:53 -0500
Received: by mail-wm0-f49.google.com with SMTP id 64so10639744wme.3
        for <linux-rtc@vger.kernel.org>; Thu, 30 Nov 2017 00:18:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171129221114.GV21126@piout.net>
References: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com> <20171129221114.GV21126@piout.net>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 30 Nov 2017 09:18:11 +0100
Message-ID: <CAOFm3uFb8Jo9detD2CziuYt_DH_ohYD9P=uvqHugKDxpN+xvAQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: add mxc driver for i.MX53
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel-dev@beckhoff.com,
        Alessandro Zummo <a.zummo@towertech.it>,
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
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Nov 29, 2017 at 11:11 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 28/11/2017 at 08:39:27 +0100, linux-kernel-dev@beckhoff.com wrote:
>> From: Patrick Bruenn <p.bruenn@beckhoff.com>
[]
>> diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
>> new file mode 100644
>> index 000000000000..5049b521b38e
>> --- /dev/null
>> +++ b/drivers/rtc/rtc-mxc_v2.c
>> @@ -0,0 +1,531 @@
>
> I think SPDX identifier will soon be required on new files, please add
> one.
>
>> +/*
>> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights Reserved.
>> + */
>> +
>> +/*
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */

Exactly!
And while you are it , you could replace the boilerplate license text
with the SPDX id.
-- 
Cordially
Philippe Ombredanne
