Return-Path: <rtc-linux+bncBAABBANP5GUQKGQE54BCGRQ@googlegroups.com>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com. [195.245.230.162])
        by gmr-mx.google.com with ESMTPS id ec7si130283wib.3.2015.04.24.07.47.29
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 Apr 2015 07:47:29 -0700 (PDT)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>, LINUXKERNEL
	<linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, "Samuel
 Ortiz" <sameo@linux.intel.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE
	<devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG
	<linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll
	<pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring
	<robh+dt@kernel.org>, "Opensource [Steve Twiss]"
	<stwiss.opensource@diasemi.com>, Support Opensource
	<Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
Subject: [rtc-linux] RE: [PATCH V1 1/6] mfd: da9062: DA9062 MFD core driver
Date: Fri, 24 Apr 2015 14:47:27 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B2175F5@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <b3bb4bc09cd94b0b13c713d98dd64576722123c1.1429280614.git.stwiss.opensource@diasemi.com>
In-Reply-To: <b3bb4bc09cd94b0b13c713d98dd64576722123c1.1429280614.git.stwiss.opensource@diasemi.com>
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

On 17 April 2015 15:24 Steve Twiss wrote.

> Subject: [PATCH V1 1/6] mfd: da9062: DA9062 MFD core driver
> From: S Twiss <stwiss.opensource@diasemi.com>
> 
> Add MFD core driver support for DA9062
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> 
> This patch applies against linux-next and v4.0
> 
>  drivers/mfd/Kconfig                  |   12 +
>  drivers/mfd/Makefile                 |    3 +-
>  drivers/mfd/da9062-core.c            |  611 +++++++++++++++++++
>  include/linux/mfd/da9062/core.h      |   61 ++
>  include/linux/mfd/da9062/registers.h | 1108

Hi,

Due to changes in the regulator driver, I am going to alter this with 
moving the static irqreturn_t da9062_vdd_warn_event(int irq, void *data)
function from the regulators and into the core.

The VDD_WARN applies to the system voltage and is not specific to regulators.
So it would make more sense for this to exist in the core driver instead

I'll resend this in PATCH V2 soon

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
