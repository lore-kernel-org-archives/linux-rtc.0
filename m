Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBP4SWXCQKGQEH7RX3SY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id h62si65879wme.2.2017.02.22.00.18.07
        for <rtc-linux@googlegroups.com>;
        Wed, 22 Feb 2017 00:18:07 -0800 (PST)
Date: Wed, 22 Feb 2017 09:18:05 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCHv2] rtc: cpcap: new rtc driver
Message-ID: <20170222081805.ap2yvarymlr5vvjo@piout.net>
References: <20170220073535.27393-1-sre@kernel.org>
 <20170221061650.12636-1-sre@kernel.org>
 <20170221235212.hik3whcytw6xyevd@piout.net>
 <20170222015634.ugadzezywlrjduyx@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170222015634.ugadzezywlrjduyx@earth>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/02/2017 at 02:56:34 +0100, Sebastian Reichel wrote:
> > Does this mean there is a race condition?
> 
> The logic (incl. comments) in this section are from the vendor
> kernel driver and there is no documentation for CPCAP as far as
> I know. I don't know if the hardware has logic to prevent a race
> condition for the cpcap_tm.tod1 == 255 case.
> 

That's fine, I was just curious :)

> > > +	err = cpcap_get_vendor(dev, rtc->regmap, &rtc->vendor);
> > I think this means it depends on the mfd tree.
> 
> Yes, but cpcap_get_vendor should get into mainline with the
> 4.11 mfd pull request. So if you base your 4.12 for-next tree
> on 4.11-rc1 everything should be fine.
> 

OK, I'll take it for 4.12 then

> > > +	if (err)
> > > +		return err;
> > > +
> > > +	rtc->alarm_irq= platform_get_irq(pdev, 0);
> > > +	err = devm_request_threaded_irq(dev, rtc->alarm_irq, NULL,
> > > +					cpcap_rtc_alarm_irq, IRQ_NONE,
> > > +					"rtc_alarm", rtc);
> > > +	if (err) {
> > > +		dev_err(dev, "Could not request alarm irq: %d\n", err);
> > > +		return err;
> > > +	}
> > > +	disable_irq(rtc->alarm_irq);
> > > +
> > > +	rtc->update_irq= platform_get_irq(pdev, 1);
> > > +	err = devm_request_threaded_irq(dev, rtc->update_irq, NULL,
> > > +					cpcap_rtc_update_irq, IRQ_NONE,
> > > +					"rtc_1hz", rtc);
> 
> > I don't think this IRQ is actually useful. It doesn't really harm but
> > the tests should pass without it.
> 
> Yes. RTC works perfectly fine with just the alarm irq. It also
> works perfectly fine with just the 1 Hz irq (except for wakeup).
> 
> I would like to keep the irq in the driver, so that it's explicitly
> disabled. On Droid 4 mainline kernel is booted via kexec from
> Android (AKA bootloader) and Motorola's Android kernel uses the
> 1 Hz IRQ for some proprietary "secure clock daemon".
> 
> I will add a comment.
> 

OK, my plan was to remove all the RTC_UF users. I'll give it more
thoughts.

> > > +	if (err) {
> > > +		dev_err(dev, "Could not request update irq: %d\n", err);
> > > +		return err;
> > > +	}
> > > +	disable_irq(rtc->update_irq);
> > > +
> > > +	err = device_init_wakeup(dev, 1);
> > 
> > If you use device_init_wakeup, I think it needs to be called before
> > devm_rtc_device_register() to properly work.
> 
> I successfully tested wakeup before sending this. But in case your 
> prefer it to be called before registering the RTC I can move the
> call accordingly.
> 

Then it is fine where it is.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
