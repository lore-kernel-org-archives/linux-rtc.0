Return-Path: <rtc-linux+bncBAABBFXUQ2XAKGQEGXCFN6I@googlegroups.com>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com. [193.109.254.118])
        by gmr-mx.google.com with ESMTPS id v8si193388wiw.1.2015.08.05.00.24.05
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2015 00:24:05 -0700 (PDT)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE
	<devicetree@vger.kernel.org>, LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>, RTCLINUX
	<rtc-linux@googlegroups.com>, David Dajun Chen <david.chen@diasemi.com>,
	"Ian Campbell" <ijc+devicetree@hellion.org.uk>, Kumar Gala
	<galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland
	<mark.rutland@arm.com>, "Pawel Moll" <pawel.moll@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support
 Opensource <Support.Opensource@diasemi.com>
Subject: [rtc-linux] RE: [PATCH V3 3/3] rtc: da9063: Add DA9062 RTC capability
 to DA9063 RTC driver
Date: Wed, 5 Aug 2015 07:24:03 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B2606F8@SW-EX-MBX02.diasemi.com>
References: <cover.1437474547.git.stwiss.opensource@diasemi.com>
 <b79c0b5d1b96bd06ab81a2459c493e68ec6b1971.1437474547.git.stwiss.opensource@diasemi.com>
 <20150805015519.GZ3486@piout.net>
In-Reply-To: <20150805015519.GZ3486@piout.net>
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

On 05 August 2015 02:55 Alexandre Belloni wrote:

> Subject: Re: [PATCH V3 3/3] rtc: da9063: Add DA9062 RTC capability to DA9063 RTC driver
> 
> On 21/07/2015 at 11:29:07 +0100, S Twiss wrote :
> > From: S Twiss <stwiss.opensource@diasemi.com>
> >
> > Add DA9062 RTC support into the existing DA9063 RTC driver component by
> > using generic access tables for common register and bit mask definitions.
> >
> > The following change will add generic register and bit mask support to the
> > DA9063 RTC. The changes are slightly complicated by requiring support for
> > three register sets: DA9063-AD, DA9063-BB and DA9062-AA.
> >
> > The following alterations have been made to the DA9063 RTC:
> >
> > - Addition of a da9063_compatible_rtc_regmap structure to hold all generic
> >   registers and bitmasks for this type of RTC component.
> > - A re-write of struct da9063 to use pointers for regmap and compatible
> >   registers/masks definitions
> > - Addition of a of_device_id table for DA9063 and DA9062 defaults
> > - Refactoring functions to use struct da9063_compatible_rtc accesses to
> >   generic registers/masks instead of using defines from registers.h
> > - Re-work of da9063_rtc_probe() to use of_match_node() and dev_get_regmap()
> >   to provide initialisation of generic registers and masks and access to
> >   regmap
> >
> > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> >
> Applied, thanks.

Thank you.

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
