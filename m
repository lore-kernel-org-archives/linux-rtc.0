Return-Path: <rtc-linux+bncBDS7HNEFSALRBDMA46VQKGQEFGLWS5A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si90629wib.2.2015.06.11.10.06.20
        for <rtc-linux@googlegroups.com>;
        Thu, 11 Jun 2015 10:06:20 -0700 (PDT)
Date: Thu, 11 Jun 2015 19:06:19 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>
Subject: [rtc-linux] Re: [PATCH v2 2/4] rtc/lib: Introduce rtc_tm_subtract()
 helper function
Message-ID: <20150611170619.GM5222@piout.net>
References: <1433235862-1638-1-git-send-email-xlpang@126.com>
 <1433235862-1638-2-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1433235862-1638-2-git-send-email-xlpang@126.com>
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

I'm fine with the whole series, I would just rename things a bit:

On 02/06/2015 at 17:04:20 +0800, Xunlei Pang wrote :
>  /*
> + * rtc_tm_subtract - Return the difference in seconds.
> + */
> +time64_t rtc_tm_subtract(struct rtc_time *minuend, struct rtc_time *subtrahend)
> +{
> +	return rtc_tm_to_time64(minuend) - rtc_tm_to_time64(subtrahend);
> +}
> +EXPORT_SYMBOL_GPL(rtc_tm_subtract);
> +
> +/*
>   * Convert rtc_time to ktime
>   */
>  ktime_t rtc_tm_to_ktime(struct rtc_time tm)
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index 8dcf682..13e4138 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -21,6 +21,8 @@ extern int rtc_year_days(unsigned int day, unsigned int month, unsigned int year
>  extern int rtc_valid_tm(struct rtc_time *tm);
>  extern time64_t rtc_tm_to_time64(struct rtc_time *tm);
>  extern void rtc_time64_to_tm(time64_t time, struct rtc_time *tm);
> +extern time64_t rtc_tm_subtract(struct rtc_time *minuend,
> +		struct rtc_time *subtrahend);

I would use something closer to what is done for timespecs in time.h,
like:

static inline time64_t rtc_tm_sub(struct rtc_time *lhs, struct rtc_time *rhs)
{
	return rtc_tm_to_time64(lhs) - rtc_tm_to_time64(rhs);
}

and not modify rtc-lib.c

Can you make that modification ?

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
