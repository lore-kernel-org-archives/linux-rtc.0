Return-Path: <rtc-linux+bncBAABBMOWVCVAKGQEOJQSKEQ@googlegroups.com>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com. [195.245.231.147])
        by gmr-mx.google.com with ESMTPS id m3si89653wia.1.2015.05.06.07.54.41
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 06 May 2015 07:54:41 -0700 (PDT)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>, LINUXKERNEL
	<linux-kernel@vger.kernel.org>, LINUXWATCHDOG
	<linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>
CC: Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE
	<devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX
	<rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz
	<sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>
Subject: [rtc-linux] RE: [PATCH V1 5/6] watchdog: da9062: DA9062 watchdog driver
Date: Wed, 6 May 2015 14:54:37 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B21924A@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <2afd9f55c71553186e99bfe386312f0c7d7501ed.1429280614.git.stwiss.opensource@diasemi.com>
 <55327DDA.4080003@roeck-us.net>
In-Reply-To: <55327DDA.4080003@roeck-us.net>
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

On 18 April 2015 16:53 Guenter Roeck wrote:

Hi Guenter,

Thanks for your comments.

> On 04/17/2015 07:23 AM, S Twiss wrote:
> > From: S Twiss <stwiss.opensource@diasemi.com>
> >
> > Add watchdog driver support for DA9062
> >
> > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> >
> Hi Steve,
> 
> Key question here is if the da9062 is really so much different to the da9062
> that you can not use the same driver.

The DA9062 watchdog driver does have some similarities with the DA9063 watchdog 
base functionality -- however the watchdog component in the DA9062 chip has more
features yet to be added in software. I do intend to add these other features ...
however, if "not adding them here" is a problem I can drop the DA9062 watchdog
driver from this patch-set until I have time to write in the newer changes.

> I am especially concerned about the added da9062_reset_watchdog_timer(),
> given the delay it introduces.

After giving this some thought, I am going to remove this 300ms delay from the
reset_watchdog_timer() function for my next submission attempt.  However
I am adding a 300ms delay into the stop() and update_timeout_register() functions
instead.

The DA9062 watchdog ping (register CONTROL_F) is "windowed" for protection
against spurious writes -- i.e. the ping function cannot be called within a 250ms
time limit or the PMIC will reset. This windowing protection also extends to altering
the timeout scale in the CONTROL_D register -- in which case if the timeout
register is altered and the ping() function is called within the 250ms limit, the
PMIC will reset. The delay is there to stop that from happening.

I realised my previous patch was over-sanitised: by putting the time delay into the
ping() function I was protecting CONTROL_D in stop() and  update_timeout_register(),
but I was being too over-protective of the ping() function. Therefore if there was an 
"incorrect trigger signal", the watchdog would not be allowed to fail because the
driver would have filtered out the errors.

> > +static int da9062_reset_watchdog_timer(struct da9062 *hw)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_update_bits(hw->regmap,
> > +			   DA9062AA_CONTROL_F,
> > +			   DA9062AA_WATCHDOG_MASK,
> > +			   DA9062AA_WATCHDOG_MASK);
> > +
> > +	mdelay(300);
> 
> Really ? That seems to be excessive, especially given how often
> this function is called (for each ping!).
> 

Please see above.

> > +
> > +	return ret;
> > +}
> > +
> > +static int da9062_wdt_update_timeout_register(struct da9062 *chip,
> > +					      unsigned int regval)
> > +{
> > +	int ret;
> > +
> > +	ret = da9062_reset_watchdog_timer(chip);
> > +	if (ret)
> > +		dev_err(chip->dev, "Failed to ping the watchdog (err =
> %d)\n",
> > +			ret);
> > +
> And no impact, so this doesn't really matter ?
> 

I really want to send an error so the user can be notified their ping()
has failed. As it stands, allowing thing to fail is not the best error path.

> > +	return regmap_update_bits(chip->regmap,
> > +				  DA9062AA_CONTROL_D,
> > +				  DA9062AA_TWDSCALE_MASK,
> > +				  regval);
> > +}
> > +

[...]

> > +static int da9062_wdt_stop(struct watchdog_device *wdd)
> > +{
> > +	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
> > +	int ret;
> > +
> > +	ret = da9062_reset_watchdog_timer(wdt->hw);
> > +	if (ret)
> > +		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err =
> %d)\n",
> > +			ret);
> > +
> ping or reset ? And no impact, ie you just ignore the error ?
> 

Same again -- I will add an error path to this

[...]

> > +	wdt->wdtdev.info = &da9062_watchdog_info;
> > +	wdt->wdtdev.ops = &da9062_watchdog_ops;
> > +	wdt->wdtdev.min_timeout = DA9062_WDT_MIN_TIMEOUT;
> > +	wdt->wdtdev.max_timeout = DA9062_WDT_MAX_TIMEOUT;
> > +	wdt->wdtdev.timeout = DA9062_WDG_DEFAULT_TIMEOUT;
> > +	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
> > +
> > +	watchdog_set_drvdata(&wdt->wdtdev, wdt);
> > +	dev_set_drvdata(&pdev->dev, wdt);
> > +
> > +	irq = platform_get_irq_byname(pdev, "WDG_WARN");
> > +	if (irq < 0)
> > +		dev_err(wdt->hw->dev, "Failed to get IRQ.\n");
> 
> But you still request the negative irq.
> 
> > +
> > +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > +			   da9062_wdt_wdg_warn_irq_handler,
> > +			    IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> IRQF_SHARED,
> > +			   "WDG_WARN", wdt);
> > +	if (ret) {
> > +		dev_err(wdt->hw->dev,
> > +			"Failed to request watchdog device IRQ.\n");
> 
> Either this is an error, or it isn't. If it is, I would expect the driver
> to abort loading. If not, please don't use dev_err.
> 

I will put error paths in here also.

> > +	}
> > +
> > +	ret = watchdog_register_device(&wdt->wdtdev);
> > +	if (ret < 0)
> > +		dev_err(wdt->hw->dev,
> > +			"watchdog registration incomplete (%d)\n", ret);
> 
> incomplete ?
> 

Will fix this with an error path

> > +	else
> > +		dev_info(wdt->hw->dev, "installed DA9062 watchdog\n");
> 
> Please rop this message.
> 

Will do this.

> > +
> > +	da9062_wdt_ping(&wdt->wdtdev);
> > +	if (ret < 0)
> > +		dev_err(wdt->hw->dev,
> > +			"failed to ping the watchdog (%d)\n", ret);
> > +
> That ping is asking for an explanation. Does it imply that the watchdog is
> known to be running
> and can not be stopped ?
> 
> Also, the ping function already creates an error message. Please be less noisy
> with
> your messages.
> 
> > +	return ret;
> 
> If the above ping fails, this will return an error without unregistering
> the watchdog device.
> 

I will refactor this piece.

[...]

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
