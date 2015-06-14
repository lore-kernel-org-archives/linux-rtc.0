Return-Path: <rtc-linux+bncBDS7HNEFSALRBPEE7CVQKGQE4QWGTNQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si407247wib.2.2015.06.14.15.37.48
        for <rtc-linux@googlegroups.com>;
        Sun, 14 Jun 2015 15:37:48 -0700 (PDT)
Date: Mon, 15 Jun 2015 00:37:47 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>,
	Diego Ercolani <diego.ercolani@gmail.com>,
	Egbert Eich <eich@suse.com>, Max Asbock <amax@lenovo.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [rtc-linux] Re: [RFC PATCH v2 1/2] rtc-cmos: Clear interrupt flag if
 alarm time is
Message-ID: <20150614223747.GB17679@piout.net>
References: <1433845413-13960-1-git-send-email-adrianhuang0701@gmail.com>
 <1433845413-13960-2-git-send-email-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1433845413-13960-2-git-send-email-adrianhuang0701@gmail.com>
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

On 09/06/2015 at 18:23:32 +0800, Adrian Huang wrote :
> @@ -588,7 +591,7 @@ static struct bin_attribute nvram = {
>  
>  /*----------------------------------------------------------------*/
>  
> -static struct cmos_rtc	cmos_rtc;
> +static struct cmos_rtc	cmos_rtc = { .alarm_expires = 0 };
>  

That is probably unnecessary as the whole struct is already zeroed at
initialization.

>  static irqreturn_t cmos_interrupt(int irq, void *p)
>  {
> @@ -860,6 +863,52 @@ static void __exit cmos_do_remove(struct device *dev)
>  	cmos->dev = NULL;
>  }
>  
> +static int cmos_aie_poweroff(struct device *dev)
> +{
> +	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
> +	struct rtc_time now;
> +	int err;
> +	time64_t t_now;
> +	unsigned char rtc_control;
> +
> +	if (!cmos->alarm_expires)
> +		return -EINVAL;
> +
> +	spin_lock_irq(&rtc_lock);
> +	rtc_control = CMOS_READ(RTC_CONTROL);
> +	spin_unlock_irq(&rtc_lock);
> +
> +	/* We only care about the situation where AIE is disabled. */
> +	if (rtc_control & RTC_AIE)
> +		return -EBUSY;
> +
> +	err = cmos_read_time(dev, &now);
> +	if (err < 0)
> +		return err;
> +	t_now = rtc_tm_to_time64(&now);
> +
> +	/*
> +	 * When enabling "RTC wake-up" in BIOS setup, the machine reboots
> +	 * automatically right after shutdown on some buggy boxes.
> +	 * This automatic rebooting issue won't happen when the alarm
> +	 * time is larger than now+1 seconds.
> +	 *
> +	 * If the alarm time is equal to now+1 seconds, we need to wait
> +	 * for 1 second so that AF is set by CMOS hardware. Therefore, we
> +	 * can get a chance to clear AF in cmos_do_shutdown().
> +	 *
> +	 * If the alarm time is less equal to 'now', the function simply
> +	 * returns '0' so that we can get a chance to clear AF in
> +	 * cmos_do_shutdown().
> +	 */
> +	if (cmos->alarm_expires > (t_now + 1))
> +		return -EBUSY;
> +	else if (cmos->alarm_expires == (t_now + 1))
> +		msleep(1000);

I'm not too happy about that one second wait. Isn't the idea of
updating the alarm to a value in the past to cancel it working?

> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM
>  
>  static int cmos_suspend(struct device *dev)
> @@ -1094,8 +1143,11 @@ static void cmos_pnp_shutdown(struct pnp_dev *pnp)
>  	struct device *dev = &pnp->dev;
>  	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
>  
> -	if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
> -		return;
> +	if (system_state == SYSTEM_POWER_OFF) {
> +		cmos_poweroff(dev);

You should test the return value of cmos_poweroff() at some point as the
return is depending on it in the original code.

However, I'm not sure why one would want to not execute
cmos_do_shutdown() only when CONFIG_PM is not defined.

> +		if (cmos_aie_poweroff(dev) < 0)
> +			return;
> +	}
>  
>  	cmos_do_shutdown(cmos->irq);
>  }
> @@ -1200,8 +1252,11 @@ static void cmos_platform_shutdown(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
>  
> -	if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
> -		return;
> +	if (system_state == SYSTEM_POWER_OFF) {
> +		cmos_poweroff(dev);

Same comment here.

> +		if (cmos_aie_poweroff(dev) < 0)
> +			return;
> +	}
>  
>  	cmos_do_shutdown(cmos->irq);
>  }

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
