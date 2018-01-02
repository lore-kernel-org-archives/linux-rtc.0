Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:35255 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbeABJuq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Jan 2018 04:50:46 -0500
Date: Tue, 2 Jan 2018 10:50:44 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: a.zummo@towertech.it, corbet@lwn.net, arnd@arndb.de,
        broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] rtc: Add one offset seconds to expand RTC range
Message-ID: <20180102095044.GA2226@piout.net>
References: <9ab56bdcaeb52241e22b738d6babe7b01728f64c.1514869621.git.baolin.wang@linaro.org>
 <ffbbc85faa0ecb4e2343fcbc95ed4bfd8e8f6993.1514869622.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ffbbc85faa0ecb4e2343fcbc95ed4bfd8e8f6993.1514869622.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 02/01/2018 at 13:10:07 +0800, Baolin Wang wrote:
> From our investigation for all RTC drivers, 1 driver will be expired before
> year 2017, 7 drivers will be expired before year 2038, 23 drivers will be
> expired before year 2069, 72 drivers will be expired before 2100 and 104
> drivers will be expired before 2106. Especially for these early expired
> drivers, we need to expand the RTC range to make the RTC can still work
> after the expired year.
> 
> So we can expand the RTC range by adding one offset to the time when reading
> from hardware, and subtracting it when writing back. For example, if you have
> an RTC that can do 100 years, and currently is configured to be based in
> Jan 1 1970, so it can represents times from 1970 to 2069. Then if you change
> the start year from 1970 to 2000, which means it can represents times from
> 2000 to 2099. By adding or subtracting the offset produced by moving the wrap
> point, all times between 1970 and 1999 from RTC hardware could get interpreted
> as times from 2070 to 2099, but the interpretation of dates between 2000 and
> 2069 would not change.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/rtc/class.c     |   53 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/rtc/interface.c |   53 +++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/rtc.h     |    2 ++
>  3 files changed, 106 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
> index 31fc0f1..8e59cf0 100644
> --- a/drivers/rtc/class.c
> +++ b/drivers/rtc/class.c
> @@ -211,6 +211,55 @@ static int rtc_device_get_id(struct device *dev)
>  	return id;
>  }
>  
> +static void rtc_device_get_offset(struct rtc_device *rtc)
> +{
> +	u32 start_year;
> +	int ret;
> +
> +	rtc->offset_secs = 0;
> +	rtc->start_secs = rtc->min_hw_secs;
> +
> +	/*
> +	 * If RTC driver did not implement the range of RTC hardware device,
> +	 * then we can not expand the RTC range by adding or subtracting one
> +	 * offset.
> +	 */
> +	if (!rtc->max_hw_secs)
> +		return;
> +
> +	ret = device_property_read_u32(rtc->dev.parent, "start-year",
> +				       &start_year);
> +	if (ret)
> +		return;
> +

I think we need to have a way for drivers to set the start_secs value
because then we can fix all the drivers using a variation of
if (tm->tm_year < 70)
	tm->tm_year += 100;

The main issue is that they will want to set start_secs to 0 so we can't
use start_secs != 0 to know whether it has already been set. Maybe we
can rely on offset_secs being set.


> +	/*
> +	 * Record the start time values in seconds, which are used to valid if
> +	 * the setting time values are in the new expanded range.
> +	 */
> +	rtc->start_secs = max_t(time64_t, mktime64(start_year, 1, 1, 0, 0, 0),
> +				rtc->min_hw_secs);
> +
> +	/*
> +	 * If the start_secs is larger than the maximum seconds (max_hw_secs)
> +	 * support by RTC hardware, which means the minimum seconds
> +	 * (min_hw_secs) of RTC hardware will be mapped to start_secs by adding
> +	 * one offset, so the offset seconds calculation formula should be:
> +	 * rtc->offset_secs = rtc->start_secs - rtc->min_hw_secs;
> +	 *
> +	 * If the start_secs is less than max_hw_secs, then there is one region
> +	 * is overlapped between the original RTC hardware range and the new
> +	 * expanded range, and this overlapped region do not need to be mapped
> +	 * into the new expanded range due to it is valid for RTC device. So
> +	 * the minimum seconds of RTC hardware (min_hw_secs) should be mapped to
> +	 * max_hw_secs + 1, then the offset seconds formula should be:
> +	 * rtc->offset_secs = rtc->max_hw_secs - rtc->min_hw_secs + 1;
> +	 */
> +	if (rtc->start_secs > rtc->max_hw_secs)
> +		rtc->offset_secs = rtc->start_secs - rtc->min_hw_secs;
> +	else
> +		rtc->offset_secs = rtc->max_hw_secs - rtc->min_hw_secs + 1;

And so we have the case where start_secs < rtc->min_hw_secs. Those are
the RTC failing in 2069. Wee need to handle those drivers generically
here.

> +}
> +
>  /**
>   * rtc_device_register - register w/ RTC class
>   * @dev: the device to register
> @@ -253,6 +302,8 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
>  		goto exit_ida;
>  	}
>  
> +	rtc_device_get_offset(rtc);
> +
>  	/* Check to see if there is an ALARM already set in hw */
>  	err = __rtc_read_alarm(rtc, &alrm);
>  
> @@ -449,6 +500,8 @@ int __rtc_register_device(struct module *owner, struct rtc_device *rtc)
>  		return err;
>  	}
>  
> +	rtc_device_get_offset(rtc);
> +
>  	/* Check to see if there is an ALARM already set in hw */
>  	err = __rtc_read_alarm(rtc, &alrm);
>  	if (!err && !rtc_valid_tm(&alrm.time))
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index c8090e3..eb96a90 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -20,6 +20,46 @@
>  static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer);
>  static void rtc_timer_remove(struct rtc_device *rtc, struct rtc_timer *timer);
>  
> +static void rtc_add_offset(struct rtc_device *rtc, struct rtc_time *tm)
> +{
> +	time64_t secs;
> +
> +	if (!rtc->offset_secs)
> +		return;
> +
> +	secs = rtc_tm_to_time64(tm);
> +	/*
> +	 * Since the reading time values from RTC device are always less than
> +	 * rtc->max_hw_secs, then if the reading time values are larger than
> +	 * the rtc->start_secs, which means they did not subtract the offset
> +	 * when writing into RTC device, so we do not need to add the offset.
> +	 */
> +	if (secs >= rtc->start_secs)
> +		return;
> +
> +	rtc_time64_to_tm(secs + rtc->offset_secs, tm);
> +}
> +
> +static void rtc_subtract_offset(struct rtc_device *rtc, struct rtc_time *tm)
> +{
> +	time64_t secs;
> +
> +	if (!rtc->offset_secs)
> +		return;
> +
> +	secs = rtc_tm_to_time64(tm);
> +	/*
> +	 * If the setting time values are in the valid range of RTC hardware
> +	 * device, then no need to subtract the offset when setting time to RTC
> +	 * device. Otherwise we need to subtract the offset to make the time
> +	 * values are valid for RTC hardware device.
> +	 */
> +	if (secs <= rtc->max_hw_secs)
> +		return;
> +
> +	rtc_time64_to_tm(secs - rtc->offset_secs, tm);
> +}
> +
>  static int __rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm)
>  {
>  	int err;
> @@ -36,6 +76,8 @@ static int __rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm)
>  			return err;
>  		}
>  
> +		rtc_add_offset(rtc, tm);
> +
>  		err = rtc_valid_tm(tm);
>  		if (err < 0)
>  			dev_dbg(&rtc->dev, "read_time: rtc_time isn't valid\n");
> @@ -69,6 +111,8 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
>  	if (err)
>  		return err;
>  
> +	rtc_subtract_offset(rtc, tm);
> +
>  	err = mutex_lock_interruptible(&rtc->ops_lock);
>  	if (err)
>  		return err;
> @@ -123,6 +167,8 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc, struct rtc_wkalrm *al
>  	}
>  
>  	mutex_unlock(&rtc->ops_lock);
> +
> +	rtc_add_offset(rtc, &alarm->time);
>  	return err;
>  }
>  
> @@ -338,6 +384,7 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
>  	if (err)
>  		return err;
>  
> +	rtc_subtract_offset(rtc, &alarm->time);
>  	scheduled = rtc_tm_to_time64(&alarm->time);
>  
>  	/* Make sure we're not setting alarms in the past */
> @@ -1074,7 +1121,8 @@ int rtc_read_range(struct rtc_device *rtc, time64_t *max_hw_secs,
>   * @ tm: time values need to valid.
>   *
>   * Only the rtc->max_hw_secs was set, then we can valid if the setting time
> - * values are beyond the RTC range.
> + * values are beyond the RTC range. When drivers set one start time values,
> + * we need to valid if the setting time values are in the new expanded range.
>   */
>  int rtc_valid_range(struct rtc_device *rtc, struct rtc_time *tm)
>  {
> @@ -1084,7 +1132,8 @@ int rtc_valid_range(struct rtc_device *rtc, struct rtc_time *tm)
>  		return 0;
>  
>  	secs = rtc_tm_to_time64(tm);
> -	if (secs < rtc->min_hw_secs || secs > rtc->max_hw_secs)
> +	if (secs < rtc->start_secs ||
> +	    secs > (rtc->start_secs + rtc->max_hw_secs - rtc->min_hw_secs))
>  		return -EINVAL;
>  
>  	return 0;
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index 19a8989..11879b7 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -156,6 +156,8 @@ struct rtc_device {
>  
>  	time64_t max_hw_secs;
>  	time64_t min_hw_secs;
> +	time64_t start_secs;
> +	time64_t offset_secs;
>  
>  #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
>  	struct work_struct uie_task;
> -- 
> 1.7.9.5
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
