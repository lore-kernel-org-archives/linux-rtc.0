Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBO7CW67AKGQE5NQ2ZQQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id x75si1358148wmf.1.2016.09.05.15.27.07
        for <rtc-linux@googlegroups.com>;
        Mon, 05 Sep 2016 15:27:07 -0700 (PDT)
Date: Tue, 6 Sep 2016 00:26:56 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, matthew.garrett@nebula.com
Subject: [rtc-linux] Re: [PATCH v2 1/2] rtc-cmos: Ensure no expired alarm is
 left enabled after resume
Message-ID: <20160905222656.ziowskma2gizsjtj@piout.net>
References: <20160831225900.20122-1-gabriele.mzt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160831225900.20122-1-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi

On 01/09/2016 at 00:58:59 +0200, Gabriele Mazzotta wrote :
>  static int cmos_resume(struct device *dev)
>  {
>  	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
>  	unsigned char tmp;
> +	bool is_wkalrm_expired;
>  
>  	if (cmos->enabled_wake) {
>  		if (cmos->wake_off)
> @@ -913,6 +935,8 @@ static int cmos_resume(struct device *dev)
>  		cmos->enabled_wake = 0;
>  	}
>  
> +	is_wkalrm_expired = cmos_is_wkalrm_expired(dev);
> +
>  	spin_lock_irq(&rtc_lock);
>  	tmp = cmos->suspend_ctrl;
>  	cmos->suspend_ctrl = 0;
> @@ -939,6 +963,17 @@ static int cmos_resume(struct device *dev)
>  			tmp &= ~RTC_AIE;
>  			hpet_mask_rtc_irq_bit(RTC_AIE);
>  		} while (mask & RTC_AIE);
> +
> +		/*
> +		 * If RTC_AIE is set and we have an alarm set to go off in the
> +		 * past, then the BIOS woke the system when the alarm went off
> +		 * and we now have to clear it.
> +		 */
> +		if ((tmp & RTC_AIE) && is_wkalrm_expired) {

Is there any issue dropping is_wkalrm_expired and calling
cmos_is_wkalrm_expired() here? That would avoid calling
cmos_is_wkalrm_expired on each wakeup.

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
