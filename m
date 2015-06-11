Return-Path: <rtc-linux+bncBAABBMEN4WVQKGQEWFS4SUQ@googlegroups.com>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com. [195.245.230.166])
        by gmr-mx.google.com with ESMTPS id p9si393885wiz.3.2015.06.11.01.28.32
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2015 01:28:32 -0700 (PDT)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: 'Lee Jones' <lee.jones@linaro.org>
CC: LINUXKERNEL <linux-kernel@vger.kernel.org>, Samuel Ortiz
	<sameo@linux.intel.com>, Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE
	<devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG
	<linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll
	<pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring
	<robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [rtc-linux] RE: [PATCH V3 1/4] mfd: da9062: DA9062 MFD core driver
Date: Thu, 11 Jun 2015 08:27:57 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22F4C4@SW-EX-MBX02.diasemi.com>
References: <cover.1432041031.git.stwiss.opensource@diasemi.com>
 <ecf72b79429e6758111a908fd1ded29c0b96da15.1432041031.git.stwiss.opensource@diasemi.com>
 <20150526161024.GQ11677@x1>
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

On 28 May 2015 13:53, Steve Twiss wrote:

> To: 'Lee Jones'
> Subject: RE: [PATCH V3 1/4] mfd: da9062: DA9062 MFD core driver
> 
> Hi Lee,
> 
> I will refactor a lot of the driver and implement your changes as requested.

Hi Lee,

I realise this is a busy kernel time for you, as ever, so this is just to see if I am
missing anything with the reply I sent about the requested alterations a couple
of weeks ago. 

It relates to the addition of support for the Dialog DA9062 Power Management IC
 - https://lkml.org/lkml/2015/5/28/358

The main changes requested (for the core MFD) can be found in here:
 - https://lkml.org/lkml/2015/5/28/359

I believe that the only two major differences with your previous comments were 
those relating to the interrupt handler da9062_vdd_warn_event() -- which 
has been erased,  and the header file -- which I would prefer the to remain
[mostly] untouched if possible.

The reasons for these two differences are described below:

> > > +	/* VDD WARN event support */
> > > +	irq_vdd_warn = regmap_irq_get_virq(chip->regmap_irq,
> > > +					   DA9062_IRQ_VDD_WARN);
> > > +	if (irq_vdd_warn < 0) {
> > > +		dev_err(chip->dev, "Failed to get IRQ.\n");
> > > +		return irq_vdd_warn;
> > > +	}
> > > +	chip->irq_vdd_warn = irq_vdd_warn;
> > > +
> > > +	ret = devm_request_threaded_irq(chip->dev, irq_vdd_warn,
> > > +					NULL, da9062_vdd_warn_event,
> > > +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > > +					"VDD_WARN", chip);
> > > +	if (ret) {
> > > +		dev_warn(chip->dev,
> > > +			 "Failed to request VDD_WARN IRQ.\n");
> > > +		chip->irq_vdd_warn = -ENXIO;
> > > +	}
> >
> > This looks like a lot of code, which doesn't really do anything.  What
> > is a VDD warning indicator anyway?
> >
> 
> I will remove this.
> 
> The IRQ handler da9062_vdd_warn_event() -- see earlier above -- does
> not currently do anything apart from handle the IRQ that was requested
> here. It prints a statement to say the main PMIC voltage supply dropped
> below a defined trigger point, but doesn't actually do anything to mitigate
> this problem.
> 
> Previously this VDD_WARN was in the regulator driver, however it should
> be made available even if the regulator driver is not installed -- so I added it
> to the core instead.
> 
> In a previous driver submission I had a similar problem, a warning IRQ was
> just printing to the console to say there was an error -- the handler and
> IRQ code was put in by me so it could be used if the driver was taken and
> integrated into a fully working system.
> 
> I was asked to remove it in the other driver -- and I have done the same
> here for now. I can always add it back later.
> 

And

> > > diff --git a/include/linux/mfd/da9062/registers.h
> > b/include/linux/mfd/da9062/registers.h
> > > new file mode 100644
> > > index 0000000..d07c2bc
> > > --- /dev/null
> > > +++ b/include/linux/mfd/da9062/registers.h
> 
> [...]
> 
> > > +/*
> > > + * Registers
> > > + */
> >
> > Really? ;)
> >
> > > +#define DA9062AA_PAGE_CON		0x000
> > > +#define DA9062AA_STATUS_A		0x001
> > > +#define DA9062AA_STATUS_B		0x002
> 
> [...]
> 
> > > +
> > > +/*
> > > + * Bit fields
> > > + */
> > > +
> > > +/* DA9062AA_PAGE_CON = 0x000 */
> > > +#define DA9062AA_PAGE_SHIFT		0
> > > +#define DA9062AA_PAGE_MASK		(0x3f << 0)
> > > +#define DA9062AA_WRITE_MODE_SHIFT	6
> > > +#define DA9062AA_WRITE_MODE_MASK	(0x01 << 6)
> >
> > For 1 << X, you should use BIT(X).
> >
> 
> For the two comments above "Registers" and "Bit fields" and the (1<<x)
> definitions ...
> 
> The whole of this file is automatically generated by our hardware designers
> I would prefer it if the register definitions and bit fields are not altered using
> the #define BIT(nr) (1UL<<(nr)) macro and the comments removed because
> we have scripts that can be used to check this file automatically.
> 
> Also if the register map is ever updated, then it will be easier for me to diff
> the new delivered register and bit field definitions with the old one.
> 
> My preference would be not to change this header file.
> 
> [...]
 
If these last two things are a problem can you please let me know.

regards,
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
