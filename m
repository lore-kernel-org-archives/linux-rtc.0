Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755711AbdLOV63 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 15 Dec 2017 16:58:29 -0500
MIME-Version: 1.0
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01CB53233C@NT-Mail07.beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-2-linux-kernel-dev@beckhoff.com> <20171206215436.lwttn445wjilh3wo@rob-hp-laptop>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB53233C@NT-Mail07.beckhoff.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 15 Dec 2017 15:58:07 -0600
Message-ID: <CAL_JsqL7N8V_=zokbSUm74BdxkMsSCNwU1+dCzcxW=gdUC61eA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: rtc: add bindings for i.MX53 SRTC
To: =?UTF-8?Q?Patrick_Br=C3=BCnn?= <P.Bruenn@beckhoff.com>
Cc: linux-kernel-dev <linux-kernel-dev@beckhoff.com>,
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

On Mon, Dec 11, 2017 at 1:08 AM, Patrick Brünn <P.Bruenn@beckhoff.com> wrote:
>>From: Rob Herring [mailto:robh@kernel.org]
>>Sent: Mittwoch, 6. Dezember 2017 22:55
>>On Tue, Dec 05, 2017 at 03:06:42PM +0100, linux-kernel-dev@beckhoff.com
>>wrote:
>>> From: Patrick Bruenn <p.bruenn@beckhoff.com>
>>>
>>> +++ b/Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt
>>> @@ -0,0 +1,17 @@
>>> +* i.MX53 Real Time Clock controller
>>> +
>>> +Required properties:
>>> +- compatible: should be: "fsl,imx53-rtc"
>>> +- reg: physical base address of the controller and length of memory
>>mapped
>>> +  region.
>>> +- clocks: should contain the phandle for the rtc clock
>>
>>Shouldn't there be more than 1 here. From what I remember, the ipg clock
>>and the 32k clock?
> Yes, you are right. But if I am reading the original  Freescale driver and the
> reference manual correctly, the second clock is always active.
> Section "72.3.1.1 Clocks" from the reference manual [1] reads:
> "SRTC runs on two clock sources, high frequency peripherals clock and low frequency
> timers clock. The high frequency peripheral IP clock is used by the SRTC peripheral bus
> interface, control and status registers. The low frequency 32.768 kHz clock is the
> always-active clock used by the SRTC timers..."
>
> That's why I would only include one clock . Should I change this?

Some chips supported 32.0kHz and 32.768kHz low freq clocks, so you'd
need to be able to query what the frequency is even if you don't need
to enable the clock, but maybe that may be gone in MX53. I don't
remember.

>>> +- interrupts: rtc alarm interrupt
>>> +
>>> +Example:
>>> +
>>> +srtc@53fa4000 {
>>
>>rtc@...
>>
> The rtc for which this series adds support is embedded within a function block called
> "Secure Real Time Clock". This driver doesn't utilize all of the hardware features by
> now. But maybe someone else wants to extend the functionalities, later.
> For that possibility I wanted to name the node "srtc". Should I still change this?
>
> I believe you have a much better understanding of what should be done here. I don't
> want to argue with you, just thought you might not had that information. So if I am
> wrong just tell me and I will change it without further "complaining".

Node names should be generic for the class of h/w they are. So yes, it
should be "rtc".

Rob
