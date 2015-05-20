Return-Path: <rtc-linux+bncBCV3TM5A74DRBONR6KVAKGQEDV7UZCY@googlegroups.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com. [209.85.220.53])
        by gmr-mx.google.com with ESMTPS id x3si1925738pdh.2.2015.05.20.07.22.49
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 07:22:49 -0700 (PDT)
Received: by pacwv17 with SMTP id wv17so68864007pac.2
        for <rtc-linux@googlegroups.com>; Wed, 20 May 2015 07:22:49 -0700 (PDT)
Date: Wed, 20 May 2015 22:22:07 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Zhi Li <lznuaa@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
	"Frank.Li@freescale.com" <Frank.Li@freescale.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, a.zummo@towertech.it,
	p.zabel@pengutronix.de, alexandre.belloni@free-electrons.com,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	rtc-linux@googlegroups.com, linux-pm@vger.kernel.org,
	linux-input@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [rtc-linux] Re: [PATCH v2 0/7] Change snvs rtc and poweroff to use
 syscon add pwrkey driver
Message-ID: <20150520142205.GA24844@dragon>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
 <20150520015851.GB1071@dragon>
 <CAHrpEqS5gAsu6=ut-mPwZiipqKJb=VicRooCPFhEf324kuhnDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAHrpEqS5gAsu6=ut-mPwZiipqKJb=VicRooCPFhEf324kuhnDQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, May 19, 2015 at 09:44:46PM -0500, Zhi Li wrote:
> On Tue, May 19, 2015 at 8:58 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Wed, May 20, 2015 at 01:04:35AM +0800, Frank.Li@freescale.com wrote:
> >> From: Frank Li <Frank.Li@freescale.com>
> >>
> >> Change from v1 to v2
> >>  - Change simple-bus to simple-mfd
> >>  - RTC remove lock.
> >>  - RTC remove comments "These register offsets are relative to LP (Low Power) range"
> >>  - power off, remove extra space
> >>
> >> SNVS is MPF module.
> >> include rtc, power off, ON/OFF power key
> >>
> >>   arm: imx: power-off: change to syscon to access register
> >>   rtc: arm: imx: snvs: change use syscon to access register
> >> Above two patch change existed power-off and rtc use syscon
> >>
> >>   Document: dt: fsl: snvs: change support syscon
> >>   arm: dts: imx: update snvs to use syscon access register
> >> Update dt file and document
> >>
> >>   input: keyboard: imx: add snvs power key driver
> >>   document: devicetree: input: imx: i.mx snvs power device tree bindings
> >>   arm: dts: imx6sx: enable snvs power key
> >> Added on/off key driver
> >>
> >> Frank Li (6):
> >>   arm: imx: power-off: change to syscon to access register
> >>   rtc: arm: imx: snvs: change use syscon to access register
> >>   Document: dt: fsl: snvs: change support syscon
> >>   arm: dts: imx: update snvs to use syscon access register
> >>   document: devicetree: input: imx: i.mx snvs power device tree bindings
> >>   arm: dts: imx6sx: enable snvs power key
> >
> > So, the series will break existing DTBs for RTC and poweroff, right?
> > If this is unavoidable, should we at least have some warning messages
> > telling users about his breakage?
> 
> How to do that?
> Just added it commit message or need runtime warning?

runtime, so that users can know why their installed DTBs break with the
new kernel.

Shawn

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
