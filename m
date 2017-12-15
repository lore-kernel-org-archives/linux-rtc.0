Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35285 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755268AbdLOLou (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 15 Dec 2017 06:44:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170824103026.18231-1-enric.balletbo@collabora.com>
References: <20170824103026.18231-1-enric.balletbo@collabora.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Fri, 15 Dec 2017 12:44:49 +0100
Message-ID: <CAFqH_52KKH3r+TzgvP3NvPjuFpQJwCZAmj2ZVkcYLdy9qaXLuQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: ds1307: call the platform's logic for handle IRQs.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

2017-08-24 12:30 GMT+02:00 Enric Balletbo i Serra
<enric.balletbo@collabora.com>:
> On some systems the nIRQ pin is often connect to a GPIO, then, if a given
> interrupt line is supposed to wake up the system, the corresponding input
> of that interrupt controller need to be enabled to receive signal from the
> line in question. Before this commit such systems would not wake up
> because are not marked as wakeup IRQs in the IRQ subsystem.
>
> This commit calls enable_irq_wake() on suspend and disables that input to
> prevent the dedicated controller from triggering interrupts unnecessarily
> after wakeup.
>
> After this commit a system composed by a RTC DS1339 chip connected to a
> GPIO line on a AM335x SoC is able to wakeup from suspend-to-RAM, otherwise
> the line is ignored.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/rtc/rtc-ds1307.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 4b43aa6..c4b0f6a 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -1711,11 +1711,36 @@ static int ds1307_probe(struct i2c_client *client,
>         return err;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int ds1307_suspend(struct device *dev)
> +{
> +       struct ds1307 *ds1307 = dev_get_drvdata(dev);
> +
> +       if (device_may_wakeup(dev))
> +               enable_irq_wake(ds1307->irq);
> +
> +       return 0;
> +}
> +
> +static int ds1307_resume(struct device *dev)
> +{
> +       struct ds1307 *ds1307 = dev_get_drvdata(dev);
> +
> +       if (device_may_wakeup(dev))
> +               disable_irq_wake(ds1307->irq);
> +
> +       return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(ds1307_pm_ops, ds1307_suspend, ds1307_resume);
> +
>  static struct i2c_driver ds1307_driver = {
>         .driver = {
>                 .name   = "rtc-ds1307",
>                 .of_match_table = of_match_ptr(ds1307_of_match),
>                 .acpi_match_table = ACPI_PTR(ds1307_acpi_ids),
> +               .pm     = &ds1307_pm_ops,
>         },
>         .probe          = ds1307_probe,
>         .id_table       = ds1307_id,
> --
> 2.9.3
>

A gentle ping, any comments on this?

Thanks,
 Enric
