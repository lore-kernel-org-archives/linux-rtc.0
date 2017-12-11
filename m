Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from internet2.beckhoff.com ([194.25.186.210]:53272 "EHLO
        Internet2.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdLKHIe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 11 Dec 2017 02:08:34 -0500
From: =?iso-8859-1?Q?Patrick_Br=FCnn?= <P.Bruenn@beckhoff.com>
To: Rob Herring <robh@kernel.org>,
        linux-kernel-dev <linux-kernel-dev@beckhoff.com>
CC: Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Patrick Bruenn <p.bruenn@beckhoff.comPaste>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Fabio Estevam" <fabio.estevam@nxp.com>,
        Juergen Borleis <jbe@pengutronix.de>,
        "Noel Vellemans" <Noel.Vellemans@visionbms.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        =?iso-8859-1?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Subject: RE: [PATCH v2 1/5] dt-bindings: rtc: add bindings for i.MX53 SRTC
Date: Mon, 11 Dec 2017 07:08:30 +0000
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E01CB53233C@NT-Mail07.beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-2-linux-kernel-dev@beckhoff.com>
 <20171206215436.lwttn445wjilh3wo@rob-hp-laptop>
In-Reply-To: <20171206215436.lwttn445wjilh3wo@rob-hp-laptop>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

>From: Rob Herring [mailto:robh@kernel.org]
>Sent: Mittwoch, 6. Dezember 2017 22:55
>On Tue, Dec 05, 2017 at 03:06:42PM +0100, linux-kernel-dev@beckhoff.com
>wrote:
>> From: Patrick Bruenn <p.bruenn@beckhoff.com>
>>
>> +++ b/Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt
>> @@ -0,0 +1,17 @@
>> +* i.MX53 Real Time Clock controller
>> +
>> +Required properties:
>> +- compatible: should be: "fsl,imx53-rtc"
>> +- reg: physical base address of the controller and length of memory
>mapped
>> +  region.
>> +- clocks: should contain the phandle for the rtc clock
>
>Shouldn't there be more than 1 here. From what I remember, the ipg clock
>and the 32k clock?
Yes, you are right. But if I am reading the original  Freescale driver and the
reference manual correctly, the second clock is always active.
Section "72.3.1.1 Clocks" from the reference manual [1] reads:
"SRTC runs on two clock sources, high frequency peripherals clock and low frequency
timers clock. The high frequency peripheral IP clock is used by the SRTC peripheral bus
interface, control and status registers. The low frequency 32.768 kHz clock is the
always-active clock used by the SRTC timers..."

That's why I would only include one clock . Should I change this?

>
>> +- interrupts: rtc alarm interrupt
>> +
>> +Example:
>> +
>> +srtc@53fa4000 {
>
>rtc@...
>
The rtc for which this series adds support is embedded within a function block called
"Secure Real Time Clock". This driver doesn't utilize all of the hardware features by
now. But maybe someone else wants to extend the functionalities, later.
For that possibility I wanted to name the node "srtc". Should I still change this?

I believe you have a much better understanding of what should be done here. I don't
want to argue with you, just thought you might not had that information. So if I am
wrong just tell me and I will change it without further "complaining".

Thank you for taking the time,
Patrick

[1] https://cache.freescale.com/files/32bit/doc/ref_manual/iMX53RM.pdf

---
Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Beckhoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075
