Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42741 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753034AbdKMQPe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 13 Nov 2017 11:15:34 -0500
Date: Mon, 13 Nov 2017 17:15:22 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Patrick =?iso-8859-1?Q?Br=FCnn?= <P.Bruenn@beckhoff.com>
Cc: "Vellemans, Noel" <Noel.Vellemans@visionBMS.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: DryIce , RTC not working on imx53.
Message-ID: <20171113161522.2kq7un7gl5vg4qlq@piout.net>
References: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
 <20171109030327.anzo47xayxckn47r@piout.net>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52290E@NT-Mail07.beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01CB52290E@NT-Mail07.beckhoff.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

+Cc Fabio

On 09/11/2017 at 09:59:02 +0000, Patrick Brünn wrote:
> 
> >From: Alexandre Belloni [mailto:alexandre.belloni@free-electrons.com]
> >Sent: Donnerstag, 9. November 2017 04:03
> >
> >hwclock times out because the alarm is not working properly. Can you
> >check whether rtctest is working?
> >
> You mean "tools/testing/selftests/timers/rtctest", right?
> 
> I just run it and it's stuck at "Counting 5 update (1/sec) interrupts from reading /dev/rtc0:"
> 

So alarms or interrupts definitively don't work.

> Kernel log shows a new message for each try I restart rtctest.
> [ 1032.349562] imxdi_rtc 53fa4000.srtc: Write-wait timeout val = 0x5a042418 reg = 0x00000008"
> 

That would explain it because failing to write DCAMR means that the
alarm is not set to the proper value.

But that doesn't explain all the spurious interrupts you are seeing.

Fabio, is there any recent change in the platform code that would make
reading/writing the rtc register fail?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
