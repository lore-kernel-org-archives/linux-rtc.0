Return-Path: <rtc-linux+bncBDS7HNEFSALRBRMXZ62QKGQE3EJJAJA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e130si767366wme.2.2016.02.04.14.08.05
        for <rtc-linux@googlegroups.com>;
        Thu, 04 Feb 2016 14:08:05 -0800 (PST)
Date: Thu, 4 Feb 2016 23:07:54 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 1/3] rtc: Add functions to set and read rtc offset
Message-ID: <20160204220754.GB4782@piout.net>
References: <20160202104111.GU20165@piout.net>
 <1454519804-13770-1-git-send-email-stillcompiling@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1454519804-13770-1-git-send-email-stillcompiling@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 03/02/2016 at 09:16:42 -0800, Joshua Clayton wrote :
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 5836751..c064eb9 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -939,4 +939,61 @@ void rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer)
>  	mutex_unlock(&rtc->ops_lock);
>  }
>  
> +/**
> + * rtc_read_offset - Read the amount of rtc offset in parts per billion
> + * @ rtc: rtc device to be used
> + * @ offset: the offset in parts per billion
> + *
> + * see below for details.
> + *
> + * Kernel interface to read rtc clock offset
> + * Returns 0 on success, or a negative number on error.
> + * If the rtc offset is not setable (or not implemented), return 0 and put
> + * 0 in the offset value;
> + */
> +int rtc_read_offset(struct rtc_device *rtc, long *offset)
> +{
> +	int ret = 0;
> +
> +	if (!rtc->ops)
> +		return -ENODEV;
> +
> +	if (!rtc->ops->set_offset) {
> +		*offset = 0;
> +		return 0;
> +	}
> +

I should have been clearer but this is not necessary anymore since the
sysfs interface will not always be present but you
should probably test rtc->ops->read_offset instead.

> +	mutex_lock(&rtc->ops_lock);
> +	ret = rtc->ops->read_offset(rtc->dev.parent, offset);
> +	mutex_unlock(&rtc->ops_lock);
> +	return ret;
> +}
>  
> +/**
> + * rtc_set_offset - Adjusts the duration of the average second
> + * @ rtc: rtc device to be used
> + * @ offset: the offset in parts per billion
> + *
> + * Some rtc's allow an adjustment to the average duration of a second
> + * to compensate for differences in the actual clock rate due to temperature,
> + * the crystal, capacitor, etc.
> + *
> + * Kernel interface to adjust an rtc clock offset.
> + * Return 0 on success, or a negative number on error.
> + * If the rtc offset is not setable (or not implemented), return -EINVAL
> + */
> +int rtc_set_offset(struct rtc_device *rtc, long offset)
> +{
> +	int ret = 0;
> +
> +	if (!rtc->ops)
> +		return -ENODEV;
> +
> +	if (!rtc->ops->set_offset)
> +		return -EINVAL;
> +
> +	mutex_lock(&rtc->ops_lock);
> +	ret = rtc->ops->set_offset(rtc->dev.parent, offset);
> +	mutex_unlock(&rtc->ops_lock);
> +	return ret;
> +}
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index 3359f04..b693ada 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -89,6 +89,8 @@ struct rtc_class_ops {
>  	int (*set_mmss)(struct device *, unsigned long secs);
>  	int (*read_callback)(struct device *, int data);
>  	int (*alarm_irq_enable)(struct device *, unsigned int enabled);
> +	int (*read_offset)(struct device *, long *offset);
> +	int (*set_offset)(struct device *, long offset);
>  };
>  
>  #define RTC_DEVICE_NAME_SIZE 20
> @@ -208,6 +210,8 @@ void rtc_timer_init(struct rtc_timer *timer, void (*f)(void *p), void *data);
>  int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
>  		    ktime_t expires, ktime_t period);
>  void rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer);
> +int rtc_read_offset(struct rtc_device *rtc, long *offset);
> +int rtc_set_offset(struct rtc_device *rtc, long offset);
>  void rtc_timer_do_work(struct work_struct *work);
>  
>  static inline bool is_leap_year(unsigned int year)
> -- 
> 2.5.0
> 

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
