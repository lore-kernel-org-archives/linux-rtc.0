Return-Path: <rtc-linux+bncBAABBT7L46VAKGQEWNJOH4I@googlegroups.com>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com. [193.109.254.115])
        by gmr-mx.google.com with ESMTPS id ec7si367882wib.3.2015.05.18.07.23.11
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 07:23:11 -0700 (PDT)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Opensource
 [Steve Twiss]" <stwiss.opensource@diasemi.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE
	<devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala
	<galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL
	<linux-kernel@vger.kernel.org>, LINUXWATCHDOG
	<linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX
	<rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz
	<sameo@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, David Dajun Chen
	<david.chen@diasemi.com>, Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [rtc-linux] [PATCH V2 0/4]  da9062: DA9062 driver submission
Date: Mon, 18 May 2015 14:23:08 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22B8D1@SW-EX-MBX02.diasemi.com>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
 <20150516004634.GH3338@piout.net>
In-Reply-To: <20150516004634.GH3338@piout.net>
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

On 16 May 2015 01:47, Alexandre Belloni wrote

> On 14/05/2015 at 17:43:53 +0100, S Twiss wrote :
> > From: S Twiss <stwiss.opensource@diasemi.com>
> >
> > This patch set adds support for the Dialog DA9062 Power Management IC.
> >
> > In this patch set the following is provided:
> >  - [PATCH V2 1/4]: MFD core support
> >  - [PATCH V2 2/4]: BUCK and LDO regulator driver
> >  - [PATCH V2 3/4]: Watchdog driver
> >  - [PATCH V2 4/4]: Add bindings for all DA9062 components
> 
> This patch should actually be the first one to go in, else checkpatch
> will complain about compatibles not being found.

Hi Alexandre,

Sure thing. These DA9062 patches should be in before the RTC changes to DA9063
get made to support DA9062. I'll ensure I don't submit any RTC updates until then.

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
