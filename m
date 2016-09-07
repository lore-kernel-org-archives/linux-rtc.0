Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBPMIYC7AKGQE5BFQFMA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e21si243952wmc.2.2016.09.07.05.12.45
        for <rtc-linux@googlegroups.com>;
        Wed, 07 Sep 2016 05:12:45 -0700 (PDT)
Date: Wed, 7 Sep 2016 14:12:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: a.zummo@towertech.it, rostedt@goodmis.org, mingo@redhat.com,
	john.stultz@linaro.org, tglx@linutronix.de, broonie@kernel.org,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: Add some dummy static inline functions
Message-ID: <20160907121234.wrmxikrkrnw6lm7z@piout.net>
References: <08716c8296f91fc43a64fbd0a4145b451a02f161.1473232117.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <08716c8296f91fc43a64fbd0a4145b451a02f161.1473232117.git.baolin.wang@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/09/2016 at 15:17:26 +0800, Baolin Wang wrote :
> Add some dummy static inline functions in case CONFIG_RTC_LIB is not defined.
> 

The question your commit log should answer is why?

> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Fixes: a0a6e06d545a ("time: alarmtimer: Add tracepoints for alarmtimers")
> ---
>  include/linux/rtc.h |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index b693ada..521f752 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -16,13 +16,60 @@
>  #include <linux/interrupt.h>
>  #include <uapi/linux/rtc.h>
>  
> +#ifdef CONFIG_RTC_LIB
>  extern int rtc_month_days(unsigned int month, unsigned int year);
> -extern int rtc_year_days(unsigned int day, unsigned int month, unsigned int year);
> +extern int rtc_year_days(unsigned int day, unsigned int month,
> +			 unsigned int year);
>  extern int rtc_valid_tm(struct rtc_time *tm);
>  extern time64_t rtc_tm_to_time64(struct rtc_time *tm);
>  extern void rtc_time64_to_tm(time64_t time, struct rtc_time *tm);
>  ktime_t rtc_tm_to_ktime(struct rtc_time tm);
>  struct rtc_time rtc_ktime_to_tm(ktime_t kt);
> +#else
> +static inline int rtc_month_days(unsigned int month, unsigned int year)
> +{
> +	return 0;
> +}
> +
> +static inline int rtc_year_days(unsigned int day, unsigned int month,
> +				unsigned int year)
> +{
> +	return 0;
> +}
> +
> +static inline int rtc_valid_tm(struct rtc_time *tm)
> +{
> +	return 0;
> +}
> +
> +static inline time64_t rtc_tm_to_time64(struct rtc_time *tm)
> +{
> +	time64_t ret;
> +
> +	memset(&ret, 0, sizeof(time64_t));
> +	return ret;
> +}
> +
> +static inline void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
> +{
> +}
> +
> +static inline ktime_t rtc_tm_to_ktime(struct rtc_time tm)
> +{
> +	ktime_t ret;
> +
> +	memset(&ret, 0, sizeof(ktime_t));
> +	return ret;
> +}
> +
> +static inline struct rtc_time rtc_ktime_to_tm(ktime_t kt)
> +{
> +	struct rtc_time ret;
> +
> +	memset(&ret, 0, sizeof(struct rtc_time));
> +	return ret;
> +}
> +#endif
>  
>  /*
>   * rtc_tm_sub - Return the difference in seconds.
> -- 
> 1.7.9.5
> 

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
