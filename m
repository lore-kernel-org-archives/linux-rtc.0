Return-Path: <rtc-linux+bncBAABBLEIZWVAKGQEFC7Y7AQ@googlegroups.com>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com. [195.245.231.149])
        by gmr-mx.google.com with ESMTPS id p12si281589wiv.1.2015.05.13.05.31.39
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 05:31:39 -0700 (PDT)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, LINUXKERNEL
	<linux-kernel@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>,
	DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen
	<david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Ian
 Campbell" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG
	<linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, "Support
 Opensource" <Support.Opensource@diasemi.com>, Wim Van Sebroeck
	<wim@iguana.be>
Subject: RE: [rtc-linux] [PATCH V1 3/6] rtc: da9062: DA9062 RTC driver
Date: Wed, 13 May 2015 12:31:36 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22A3F3@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <860a3b6dc7f8dac95c0e36967f24551af8805f7b.1429280614.git.stwiss.opensource@diasemi.com>
 <20150510095838.GF3338@piout.net>
In-Reply-To: <20150510095838.GF3338@piout.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 10 May 2015 10:59 Alexandre Belloni wrote:

> Hi,
> 
> On 17/04/2015 at 15:23:33 +0100, S Twiss wrote :
> > From: S Twiss <stwiss.opensource@diasemi.com>
> >
> > Add RTC driver support for DA9062

[...]

> This is an almost exact copy of drivers/rtc/rtc-da9063.c, apart from the
> retry mechanism in read_time. Can you simply add support for the da9062
> in that driver?


Hi Alexandre,

Something similar is being discussed for the OnKey component of the DA9062.
https://lkml.org/lkml/2015/4/24/304

It is only the OnKey and RTC components that are similar to the DA9063 chip
and I was hoping to keep the 62 RTC separate in this case ... however it should
definitely be possible to re-use the DA9063 RTC driver if this is your requirement.
If this will block my submission of the DA9062 then I will drop the RTC from my
next patch set and try to re-work the existing 63 RTC driver accordingly.

I think this sort of thing has been done before:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/rtc/rtc-pm8xxx.c
 ... at first glance -- it seems to support that sort of thing.

I guess it would be possible to rename the da9063-rtc to something more sensible like
da9xxx-rtc.c if this goes ahead?

Regards,
Steve

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
