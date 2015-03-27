Return-Path: <rtc-linux+bncBDS7HNEFSALRBD5T2WUAKGQEAGQHN6Q@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id g5si97503wib.3.2015.03.27.06.22.22
        for <rtc-linux@googlegroups.com>;
        Fri, 27 Mar 2015 06:22:22 -0700 (PDT)
Date: Fri, 27 Mar 2015 14:22:22 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: RTC: Restore alarm after resume
Message-ID: <20150327132222.GC3568@piout.net>
References: <1419275979-24307-1-git-send-email-matthew.garrett@nebula.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1419275979-24307-1-git-send-email-matthew.garrett@nebula.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Matthew,

On 22/12/2014 at 19:19:39 +0000, Matthew Garrett wrote :
> Some platform firmware may interfere with the RTC alarm over suspend,
> resulting in the kernel and hardware having different ideas about system state
> but also potentially causing problems with firmware that assumes the OS will
> clean this case up. This patch saves the RTC alarm state on suspend and will
> restore it on resume if the alarm has not yet fired - if it has, it will clear
> the RTC alarm.
> 
> Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
> Tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> ---
>  drivers/rtc/class.c | 24 ++++++++++++++++++++++++
>  include/linux/rtc.h |  4 ++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
> index 472a5ad..c7e09e2 100644
> --- a/drivers/rtc/class.c
> +++ b/drivers/rtc/class.c
> @@ -55,6 +55,8 @@ static int rtc_suspend(struct device *dev)
>  	struct timespec64	delta, delta_delta;
>  	int err;
>  
> +	rtc->valid_alarm = !rtc_read_alarm(rtc, &rtc->alarm);
> +
>  	if (has_persistent_clock())
>  		return 0;
>  
> @@ -102,6 +104,27 @@ static int rtc_resume(struct device *dev)
>  	struct timespec64	sleep_time;
>  	int err;
>  
> +	/*
> +	 * Ensure that the platform hasn't overwritten a pending alarm while
> +	 * suspended
> +	 */
> +	if (rtc->valid_alarm) {
> +		long now, scheduled;
> +
> +		rtc_read_time(rtc, &tm);
> +		rtc_tm_to_time(&rtc->alarm.time, &scheduled);
> +		rtc_tm_to_time(&tm, &now);
> +
> +		/* Clear the alarm registers if it went off during suspend */
> +		if (scheduled <= now) {
> +			rtc_time_to_tm(0, &rtc->alarm.time);
> +			rtc->alarm.enabled = 0;
> +		}
> +
> +		if (rtc->ops && rtc->ops->set_alarm)
> +			rtc->ops->set_alarm(rtc->dev.parent, &rtc->alarm);
> +	}
> +

My main concern here is that reading the time and the alarm can be slow,
in particular with i2c RTC.

Isn't that issue pretty much specific to x86? I know you think otherwise
but I believe this would better be done from your driver. If more
platforms/RTCs are affected, it will still be time to try to solve it in
a more generic way.

Moreover, the class suspend/resume functions are only defined when
CONFIG_RTC_HCTOSYS is set so you may still have broken platforms with
some configurations.


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
