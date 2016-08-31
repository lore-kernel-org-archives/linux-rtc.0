Return-Path: <rtc-linux+bncBCL4FNGB7UHBBIGWTW7AKGQELLA4Y6Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com. [2a00:1450:400c:c09::243])
        by gmr-mx.google.com with ESMTPS id u3si250018wmf.1.2016.08.31.16.41.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 16:41:20 -0700 (PDT)
Received: by mail-wm0-x243.google.com with SMTP id d196so5952950wmd.1
        for <rtc-linux@googlegroups.com>; Wed, 31 Aug 2016 16:41:20 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc-cmos: Reject unsupported alarm values
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
References: <20160831225929.20336-1-gabriele.mzt@gmail.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Message-ID: <51495377-fcf7-df2c-bac4-ef32334158a3@gmail.com>
Date: Thu, 1 Sep 2016 01:41:18 +0200
MIME-Version: 1.0
In-Reply-To: <20160831225929.20336-1-gabriele.mzt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/09/2016 00:59, Gabriele Mazzotta wrote:
> Return an error if the user tries to set an alarm that isn't
> supported by the hardware.
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> ---
>  drivers/rtc/rtc-cmos.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index 4cdb335..b3f9298 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -336,6 +336,26 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>  	if (!is_valid_irq(cmos->irq))
>  		return -EIO;
>  
> +	if (!cmos->mon_alrm || !cmos->day_alrm) {
> +		struct rtc_time now;
> +		time64_t t_now;
> +		time64_t t_alrm;
> +
> +		cmos_read_time(dev, &now);
> +		t_now = rtc_tm_to_time64(&now);
> +		t_alrm = rtc_tm_to_time64(&t->time);
> +		if (!cmos->day_alrm && (t_alrm - t_now) > (24 * 60 * 60)) {
> +			dev_err(dev,
> +				"Alarms can be up to one day in the future\n");
> +			return -EINVAL;
> +		}
> +		if (!cmos->mon_alrm && (t_alrm - t_now) > (31 * 24 * 60 * 60)) {

I actually realized this is wrong. It's possible for this to let some
invalid dates go through. The driver writes a date in the registers,
so if mon_alrm is missing, I need to do something better than
adding 31 days. Sorry, I was thinking about time deltas rather
than well defined dates.

> +			dev_err(dev,
> +				"Alarms can be up to 31 days in the future\n");
> +			return -EINVAL;
> +		}
> +	}
> +
>  	mon = t->time.tm_mon + 1;
>  	mday = t->time.tm_mday;
>  	hrs = t->time.tm_hour;
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
