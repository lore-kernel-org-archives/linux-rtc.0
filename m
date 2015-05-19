Return-Path: <rtc-linux+bncBAABBBU45SVAKGQEUQQYWTY@googlegroups.com>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com. [195.245.231.141])
        by gmr-mx.google.com with ESMTPS id m3si549848wia.1.2015.05.19.03.18.46
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 03:18:46 -0700 (PDT)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Guenter Roeck
	<linux@roeck-us.net>
CC: LINUXKERNEL <linux-kernel@vger.kernel.org>, LINUXWATCHDOG
	<linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE
	<devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX
	<rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz
	<sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [rtc-linux] RE: [PATCH V2 3/4] watchdog: da9062: DA9062 watchdog driver
Date: Tue, 19 May 2015 10:16:46 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22B994@SW-EX-MBX02.diasemi.com>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
 <6a51f163b99edfad9165ad29609abb072dbaa2b7.1431621833.git.stwiss.opensource@diasemi.com>
 <55555639.8090505@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B63A@SW-EX-MBX02.diasemi.com>
 <5555ED4F.5070003@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B6E2@SW-EX-MBX02.diasemi.com>
 <20150515202005.GA23133@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B8C8@SW-EX-MBX02.diasemi.com>
 <20150518152737.GA14403@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B8FE@SW-EX-MBX02.diasemi.com>
 <20150518173927.GV3338@piout.net>
In-Reply-To: <20150518173927.GV3338@piout.net>
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

On 18 May 2015 18:39 Alexandre Belloni wrote:

> Sure, what I understand is that the base functionality is the same and
> even the registers are compatible. Are you sure the new features can't
> be added to the da9063 and called conditionally? Plenty of drivers are
> doing that.

Hi Alexandre/Guenter,

I didn't say it couldn't be added to DA9063. Of course it's all possible, but I think
it would become unmaintainable in future without separate drivers. There is some
extra freeze functionality and a watchdog warn interrupt: both do not exist in the
DA9063.

What I did say **one month ago** was the DA9062 watchdog driver does have some
similarities with the DA9063 watchdog (https://lkml.org/lkml/2015/5/6/505).

But I would prefer two drivers for watchdog in this case. When compared to the RTC and
OnKey the watchdog is very different on the hardware side. Despite the appearance of
some similarity, the watchdog is not a functional clone like the RTC and OnKey components.

I would not like a combined watchdog driver because I think that the extra functions
that the DA9062 contains would bloat out the DA9063 watchdog, and would make it difficult
to test and to maintain for the future..

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
