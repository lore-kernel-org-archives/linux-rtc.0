Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41659 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbdIYMHx (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 25 Sep 2017 08:07:53 -0400
Date: Mon, 25 Sep 2017 14:07:42 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: "winton.liu" <18502523564@163.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1374: wdt:support suspend/resume for watchdog
Message-ID: <20170925120742.ja54wu2orgai6fsr@piout.net>
References: <1506340724-18108-1-git-send-email-18502523564@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506340724-18108-1-git-send-email-18502523564@163.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 25/09/2017 at 19:58:44 +0800, winton.liu wrote:
> When enable CONFIG_RTC_DRV_DS1374_WDT use as watchdog,
> in suspend mode, watchdog is still working but no daemon
> patting the watchdog. The system will reboot if timeout.
> So disable watchdog in suspend  and recover it in resume.
> 

That is definitively not what we want. Many people will want to still
have the watchdog running when the platform is suspended. Your options
are to either disable the watchdog before going to suspend or wake up
the platform just in time to ping the watchdog.

> Signed-off-by: winton.liu <18502523564@163.com>
> ---
>  drivers/rtc/rtc-ds1374.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
> index 38a2e9e..e990773 100644
> --- a/drivers/rtc/rtc-ds1374.c
> +++ b/drivers/rtc/rtc-ds1374.c
> @@ -690,6 +690,10 @@ static int ds1374_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  
> +#ifdef CONFIG_RTC_DRV_DS1374_WDT
> +	ds1374_wdt_disable();
> +#endif
> +
>  	if (client->irq > 0 && device_may_wakeup(&client->dev))
>  		enable_irq_wake(client->irq);
>  	return 0;
> @@ -699,6 +703,10 @@ static int ds1374_resume(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  
> +#ifdef CONFIG_RTC_DRV_DS1374_WDT
> +	ds1374_wdt_settimeout(131072);
> +#endif
> +
>  	if (client->irq > 0 && device_may_wakeup(&client->dev))
>  		disable_irq_wake(client->irq);
>  	return 0;
> -- 
> 1.9.1
> 
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
