Return-Path: <rtc-linux+bncBCAJFDXE4QGBBSFA36VQKGQEFU3VAIQ@googlegroups.com>
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com. [2a00:1450:400c:c05::233])
        by gmr-mx.google.com with ESMTPS id k2si195241wif.0.2015.06.09.22.51.03
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 22:51:03 -0700 (PDT)
Received: by mail-wi0-x233.google.com with SMTP id ut5so36756750wib.1
        for <rtc-linux@googlegroups.com>; Tue, 09 Jun 2015 22:51:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1433845413-13960-2-git-send-email-adrianhuang0701@gmail.com>
References: <1433845413-13960-1-git-send-email-adrianhuang0701@gmail.com>
	<1433845413-13960-2-git-send-email-adrianhuang0701@gmail.com>
Date: Wed, 10 Jun 2015 13:51:03 +0800
Message-ID: <CAHKZfL3ne3m-O0oRyD-Lfjq_BCX5B8JzB7dUuE1yrF0Zp0eaTg@mail.gmail.com>
Subject: [rtc-linux] Re: [RFC PATCH v2 1/2] rtc-cmos: Clear interrupt flag if
 alarm time is
From: Huang Adrian <adrianhuang0701@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Cc: Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>,
	Diego Ercolani <diego.ercolani@gmail.com>, Egbert Eich <eich@suse.com>, Max Asbock <amax@lenovo.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>,
	Adrian Huang <adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

This reworked patch is based on your suggestion. Could you kindly
review it? If it looks good to you, I'll ask Borislav, Diego and
Egbert a favor for testing.

Thanks in advance.

-- Adrian

> ---
>  drivers/rtc/rtc-cmos.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 60 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index a82556a..4e60ac8 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -51,6 +51,7 @@ struct cmos_rtc {
>         struct device           *dev;
>         int                     irq;
>         struct resource         *iomem;
> +       time64_t                alarm_expires;
>
>         void                    (*wake_on)(struct device *);
>         void                    (*wake_off)(struct device *);
> @@ -377,6 +378,8 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>
>         spin_unlock_irq(&rtc_lock);
>
> +       cmos->alarm_expires = rtc_tm_to_time64(&t->time);
> +
>         return 0;
>  }
>
> @@ -588,7 +591,7 @@ static struct bin_attribute nvram = {
>
>  /*----------------------------------------------------------------*/
>
> -static struct cmos_rtc cmos_rtc;
> +static struct cmos_rtc cmos_rtc = { .alarm_expires = 0 };
>
>  static irqreturn_t cmos_interrupt(int irq, void *p)
>  {
> @@ -860,6 +863,52 @@ static void __exit cmos_do_remove(struct device *dev)
>         cmos->dev = NULL;
>  }
>
> +static int cmos_aie_poweroff(struct device *dev)
> +{
> +       struct cmos_rtc *cmos = dev_get_drvdata(dev);
> +       struct rtc_time now;
> +       int err;
> +       time64_t t_now;
> +       unsigned char rtc_control;
> +
> +       if (!cmos->alarm_expires)
> +               return -EINVAL;
> +
> +       spin_lock_irq(&rtc_lock);
> +       rtc_control = CMOS_READ(RTC_CONTROL);
> +       spin_unlock_irq(&rtc_lock);
> +
> +       /* We only care about the situation where AIE is disabled. */
> +       if (rtc_control & RTC_AIE)
> +               return -EBUSY;
> +
> +       err = cmos_read_time(dev, &now);
> +       if (err < 0)
> +               return err;
> +       t_now = rtc_tm_to_time64(&now);
> +
> +       /*
> +        * When enabling "RTC wake-up" in BIOS setup, the machine reboots
> +        * automatically right after shutdown on some buggy boxes.
> +        * This automatic rebooting issue won't happen when the alarm
> +        * time is larger than now+1 seconds.
> +        *
> +        * If the alarm time is equal to now+1 seconds, we need to wait
> +        * for 1 second so that AF is set by CMOS hardware. Therefore, we
> +        * can get a chance to clear AF in cmos_do_shutdown().
> +        *
> +        * If the alarm time is less equal to 'now', the function simply
> +        * returns '0' so that we can get a chance to clear AF in
> +        * cmos_do_shutdown().
> +        */
> +       if (cmos->alarm_expires > (t_now + 1))
> +               return -EBUSY;
> +       else if (cmos->alarm_expires == (t_now + 1))
> +               msleep(1000);
> +
> +       return 0;
> +}
> +
>  #ifdef CONFIG_PM
>
>  static int cmos_suspend(struct device *dev)
> @@ -1094,8 +1143,11 @@ static void cmos_pnp_shutdown(struct pnp_dev *pnp)
>         struct device *dev = &pnp->dev;
>         struct cmos_rtc *cmos = dev_get_drvdata(dev);
>
> -       if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
> -               return;
> +       if (system_state == SYSTEM_POWER_OFF) {
> +               cmos_poweroff(dev);
> +               if (cmos_aie_poweroff(dev) < 0)
> +                       return;
> +       }
>
>         cmos_do_shutdown(cmos->irq);
>  }
> @@ -1200,8 +1252,11 @@ static void cmos_platform_shutdown(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct cmos_rtc *cmos = dev_get_drvdata(dev);
>
> -       if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
> -               return;
> +       if (system_state == SYSTEM_POWER_OFF) {
> +               cmos_poweroff(dev);
> +               if (cmos_aie_poweroff(dev) < 0)
> +                       return;
> +       }
>
>         cmos_do_shutdown(cmos->irq);
>  }
> --
> 1.9.1
>

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
