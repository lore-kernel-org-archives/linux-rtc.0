Return-Path: <rtc-linux+bncBDS7HNEFSALRBK4KXCWQKGQEZD3HCHI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id hm7si510414wib.0.2015.07.21.01.39.07
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Jul 2015 01:39:07 -0700 (PDT)
Date: Tue, 21 Jul 2015 10:39:05 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	DEVICETREE <devicetree@vger.kernel.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	David Dajun Chen <david.chen@diasemi.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <Support.Opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH RFC V1 2/3] rtc: da9063: Add DA9062 RTC
 capability to DA9063 RTC driver
Message-ID: <20150721083905.GB2853@piout.net>
References: <cover.1436427954.git.stwiss.opensource@diasemi.com>
 <e2de6b382e8e81b40c0eb466f7b19364c13ba5a9.1436427954.git.stwiss.opensource@diasemi.com>
 <20150717234525.GI3487@piout.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B253DC9@SW-EX-MBX02.diasemi.com>
 <20150720215045.GO15539@piout.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B253FD1@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B253FD1@SW-EX-MBX02.diasemi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 21/07/2015 at 08:05:32 +0000, Opensource [Steve Twiss] wrote :
> > > > > +
> > > > > +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> > > > > +	if (!rtc)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	if (strncmp(match->name, "dlg,da9063-rtc", 14) == 0) {
> > > > > +		struct da9063 *chip = dev_get_drvdata(pdev->dev.parent);
> > > > > +
> > > > > +		if (chip->variant_code == PMIC_DA9063_AD)
> > > > > +			rtc->config = &da9063_ad_regs;
> > > > > +	} else
> > > > > +		rtc->config = match->data;
> > > >
> > > > You must not do that.
> > > > You should add a new compatible and change the of_compatible string of
> > > > the mfd_cell in drivers/mfd/da9063-core.c onc you know the variant.
> > >
> > > I can check for a binary comparison against the address of the
> > > static const struct of_device_id da9063_compatible_reg_id_table[] = {}
> > > entry for DA9063.
> > 
> > You also must not compare pointers that way. You can use
> > of_device_is_compatible().
> > 
> > > The DA9063 driver already associates "dlg,da9063-rtc" with both BB and AD
> > > register maps. I think that altering the string at this point would break backwards
> > > compatibility in the device tree for the DA9063.
> > 
> > I'm not fond of the backward compatibility exactly for that kind of
> > issue. The proper way to handle it is to have tow different compatible
> > strings because obviously, the BB and AD variants are not compatible.
> 
> I think I understand what you are saying about modifying the mfd_cell in the
> DA9063 core driver at run-time so that it changes the of_compatible string to [something like]
> "dlg,da9063-ad-rtc". That way the RTC driver can be probed using the correct
> string.
> 
> Ok, I think I see now .. I'll make a patch v2 and send it soon.
> 

This is not needed if you simply change your strncmp with
of_device_is_compatible

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
