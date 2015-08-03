Return-Path: <rtc-linux+bncBCH4V2OOTYHBBTW57OWQKGQEHKPFLWQ@googlegroups.com>
Received: from mail-wi0-x229.google.com (mail-wi0-x229.google.com. [2a00:1450:400c:c05::229])
        by gmr-mx.google.com with ESMTPS id bk2si270168wib.1.2015.08.02.21.32.14
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Aug 2015 21:32:14 -0700 (PDT)
Received: by mail-wi0-x229.google.com with SMTP id xm9so97281824wib.1
        for <rtc-linux@googlegroups.com>; Sun, 02 Aug 2015 21:32:14 -0700 (PDT)
Date: Mon, 3 Aug 2015 06:32:02 +0200 (CEST)
From: "'Hans Ulli Kroll' via rtc-linux" <rtc-linux@googlegroups.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
cc: akpm@linux-foundation.org, linaro-kernel@lists.linaro.org,
    linux-kernel@vger.kernel.org,
    "moderated list:BLACKFIN RTC DRIVER" <adi-buildroot-devel@lists.sourceforge.net>,
    Alessandro Zummo <a.zummo@towertech.it>,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    Hans Ulli Kroll <ulli.kroll@googlemail.com>,
    "moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
    "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH 9/15 V2] drivers: rtc: Drop (un)likely before IS_ERR(_OR_NULL)
In-Reply-To: <b8be698a8625ceb9adc8da51cd9474626db7c3d1.1438339891.git.viresh.kumar@linaro.org>
Message-ID: <alpine.LNX.2.00.1508030631150.8913@T520.work>
References: <cdfa3fb76901fe1c4a5756e7e64cb3370cf6317a.1438331416.git.viresh.kumar@linaro.org> <b8be698a8625ceb9adc8da51cd9474626db7c3d1.1438339891.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi

On Fri, 31 Jul 2015, Viresh Kumar wrote:

> IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
> is no need to do that again from its callers. Drop it.
> 
> gemini driver was using likely() for a failure case while the rtc driver
> is getting registered. That looks wrong and it should really be
> unlikely. But because we are killing all the unlikely() flags, lets kill
> that too.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - Removed the likely() part from gemini driver and the changelog wasn't
>   updated to match that. Fixed the changelog now.
> 
>  drivers/rtc/interface.c  | 2 +-
>  drivers/rtc/rtc-bfin.c   | 2 +-
>  drivers/rtc/rtc-gemini.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 11b639067312..5836751b8203 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -564,7 +564,7 @@ enum hrtimer_restart rtc_pie_update_irq(struct hrtimer *timer)
>  void rtc_update_irq(struct rtc_device *rtc,
>  		unsigned long num, unsigned long events)
>  {
> -	if (unlikely(IS_ERR_OR_NULL(rtc)))
> +	if (IS_ERR_OR_NULL(rtc))
>  		return;
>  
>  	pm_stay_awake(rtc->dev.parent);
> diff --git a/drivers/rtc/rtc-bfin.c b/drivers/rtc/rtc-bfin.c
> index 3d44b11721ea..535a5f9338d0 100644
> --- a/drivers/rtc/rtc-bfin.c
> +++ b/drivers/rtc/rtc-bfin.c
> @@ -361,7 +361,7 @@ static int bfin_rtc_probe(struct platform_device *pdev)
>  	/* Register our RTC with the RTC framework */
>  	rtc->rtc_dev = devm_rtc_device_register(dev, pdev->name, &bfin_rtc_ops,
>  						THIS_MODULE);
> -	if (unlikely(IS_ERR(rtc->rtc_dev)))
> +	if (IS_ERR(rtc->rtc_dev))
>  		return PTR_ERR(rtc->rtc_dev);
>  
>  	/* Grab the IRQ and init the hardware */
> diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
> index 35f4486738fc..2fed93e1114a 100644
> --- a/drivers/rtc/rtc-gemini.c
> +++ b/drivers/rtc/rtc-gemini.c
> @@ -148,7 +148,7 @@ static int gemini_rtc_probe(struct platform_device *pdev)
>  
>  	rtc->rtc_dev = rtc_device_register(pdev->name, dev,
>  					   &gemini_rtc_ops, THIS_MODULE);
> -	if (likely(IS_ERR(rtc->rtc_dev)))
> +	if (IS_ERR(rtc->rtc_dev))
>  		return PTR_ERR(rtc->rtc_dev);
>  
>  	return 0;
> -- 
> 2.4.0
> 
> 

For the mach-gemini part
Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
