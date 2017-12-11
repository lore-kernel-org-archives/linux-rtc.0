Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:37834 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdLKXIC (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 11 Dec 2017 18:08:02 -0500
MIME-Version: 1.0
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01CB53233C@NT-Mail07.beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-2-linux-kernel-dev@beckhoff.com> <20171206215436.lwttn445wjilh3wo@rob-hp-laptop>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB53233C@NT-Mail07.beckhoff.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 11 Dec 2017 21:08:00 -0200
Message-ID: <CAOMZO5DoiLW3DxLF=agHua9jO-+LgWA3xw6h7kyj_uot47pkjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: rtc: add bindings for i.MX53 SRTC
To: =?UTF-8?Q?Patrick_Br=C3=BCnn?= <P.Bruenn@beckhoff.com>
Cc: Rob Herring <robh@kernel.org>,
        linux-kernel-dev <linux-kernel-dev@beckhoff.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Patrick Bruenn <p.bruenn@beckhoff.compaste>,
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

Hi Patrick,

On Mon, Dec 11, 2017 at 5:08 AM, Patrick Br=C3=BCnn <P.Bruenn@beckhoff.com>=
 wrote:

>>rtc@...
>>
> The rtc for which this series adds support is embedded within a function =
block called
> "Secure Real Time Clock". This driver doesn't utilize all of the hardware=
 features by
> now. But maybe someone else wants to extend the functionalities, later.
> For that possibility I wanted to name the node "srtc". Should I still cha=
nge this?
>
> I believe you have a much better understanding of what should be done her=
e. I don't
> want to argue with you, just thought you might not had that information. =
So if I am
> wrong just tell me and I will change it without further "complaining".

>From the Devicetree Specification document:

"Generic Names Recommendation

The name of a node should be somewhat generic, reflecting the function
of the device and not its precise program-
ming model. If appropriate, the name should be one of the following choices=
:
...
rtc
"

So better use 'rtc' as suggested by Rob.
