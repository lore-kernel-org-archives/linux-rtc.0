Return-Path: <rtc-linux+bncBDS7HNEFSALRBTPES6VAKGQETGXRLWQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q10si202342wiz.0.2015.05.03.03.02.53
        for <rtc-linux@googlegroups.com>;
        Sun, 03 May 2015 03:02:53 -0700 (PDT)
Date: Sun, 3 May 2015 12:02:44 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 1/2] rtc: interface: Fix coding style violations
Message-ID: <20150503100244.GT12076@piout.net>
References: <1430647031-13584-1-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1430647031-13584-1-git-send-email-k.kozlowski.k@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 03/05/2015 at 18:57:10 +0900, Krzysztof Kozlowski wrote :
> Fix issues reported by checkpatch:
>   ERROR: open brace '{' following struct go on the same line
>   ERROR: "foo* bar" should be "foo *bar"
> Additionally adjust alignment of wrapper function arguments.

I did s/wrapper/wrapped/ and applied, thanks

> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> 
> ---
> 
> Changes since v1:
> 1. Adjust alignment (suggested by Alexandre Belloni).
> ---
>  include/linux/rtc.h | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index c8b68741994e..4a5e2bda4358 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -101,8 +101,7 @@ struct rtc_timer {
>  /* flags */
>  #define RTC_DEV_BUSY 0
>  
> -struct rtc_device
> -{
> +struct rtc_device {
>  	struct device dev;
>  	struct module *owner;
>  
> @@ -202,10 +201,10 @@ int rtc_register(rtc_task_t *task);
>  int rtc_unregister(rtc_task_t *task);
>  int rtc_control(rtc_task_t *t, unsigned int cmd, unsigned long arg);
>  
> -void rtc_timer_init(struct rtc_timer *timer, void (*f)(void* p), void* data);
> -int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer* timer,
> -			ktime_t expires, ktime_t period);
> -int rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer* timer);
> +void rtc_timer_init(struct rtc_timer *timer, void (*f)(void *p), void *data);
> +int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
> +		    ktime_t expires, ktime_t period);
> +int rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer);
>  void rtc_timer_do_work(struct work_struct *work);
>  
>  static inline bool is_leap_year(unsigned int year)
> -- 
> 2.1.4
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
