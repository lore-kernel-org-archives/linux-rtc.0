Return-Path: <rtc-linux+bncBCL4FNGB7UHBBKESXS5AKGQEHOZOSHA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com. [2a00:1450:400c:c09::244])
        by gmr-mx.google.com with ESMTPS id v69si1499995wmv.0.2016.06.01.09.11.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jun 2016 09:11:20 -0700 (PDT)
Received: by mail-wm0-x244.google.com with SMTP id n184so7635536wmn.1
        for <rtc-linux@googlegroups.com>; Wed, 01 Jun 2016 09:11:20 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH 1/2] rtc-cmos: Clear expired alarm after resume
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
References: <1464795615-7748-1-git-send-email-gabriele.mzt@gmail.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 matthew.garrett@nebula.com
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Message-ID: <337d25d5-f5e2-c2db-e3fa-57a820ef16ac@gmail.com>
Date: Wed, 1 Jun 2016 18:11:17 +0200
MIME-Version: 1.0
In-Reply-To: <1464795615-7748-1-git-send-email-gabriele.mzt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/06/2016 17:40, Gabriele Mazzotta wrote:
> If the system wakes up because of a wake alarm, the internal state
> of the alarm is not updated. As consequence, the state no longer
> reflects the actual state of the hardware and setting a new alarm
> is not possible until the expired alarm is cleared.
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> ---
>  drivers/rtc/rtc-cmos.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index fbe9c72..fd121e3 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -900,11 +900,33 @@ static inline int cmos_poweroff(struct device *dev)
>  
>  #ifdef	CONFIG_PM_SLEEP
>  
> +static void cmos_check_alarm(struct device *dev)
> +{
> +	struct cmos_rtc *cmos = dev_get_drvdata(dev);
> +	struct rtc_wkalrm alarm;
> +	struct rtc_time now;
> +	time64_t t_now;
> +	time64_t t_expires;
> +
> +	cmos_read_time(dev, &now);
> +	rtc_read_alarm(cmos->rtc, &alarm);

Here it should probably check the return value and exit in case of error.

> +	t_now = rtc_tm_to_time64(&now);
> +	t_expires = rtc_tm_to_time64(&alarm.time);
> +
> +	if (t_expires <= t_now && alarm.enabled) {
> +		alarm.enabled = 0;
> +		cmos->suspend_ctrl &= ~RTC_AIE;
> +		rtc_set_alarm(cmos->rtc, &alarm);

Same here.

> +	}
> +}
> +
>  static int cmos_resume(struct device *dev)
>  {
>  	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
>  	unsigned char tmp;
>  
> +	cmos_check_alarm(dev);
> +
>  	if (cmos->enabled_wake) {
>  		if (cmos->wake_off)
>  			cmos->wake_off(dev);
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
