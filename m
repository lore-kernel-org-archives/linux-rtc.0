Return-Path: <rtc-linux+bncBDS7HNEFSALRBX6FVSXAKGQEF5KSU2A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id jv9si526978wid.0.2015.08.12.03.41.34
        for <rtc-linux@googlegroups.com>;
        Wed, 12 Aug 2015 03:41:34 -0700 (PDT)
Date: Wed, 12 Aug 2015 12:41:33 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: trivial@kernel.org, linaro-kernel@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"moderated list:BLACKFIN RTC DRIVER" <adi-buildroot-devel@lists.sourceforge.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH V1 Resend 06/10] drivers: rtc: Drop (un)likely
 before IS_ERR(_OR_NULL)
Message-ID: <20150812104133.GE3411@piout.net>
References: <cover.1439375087.git.viresh.kumar@linaro.org>
 <1a92f2e1af5309ece9736f79f312e90486a98825.1439375087.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1a92f2e1af5309ece9736f79f312e90486a98825.1439375087.git.viresh.kumar@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Viresh,

Why are you resending?

On 12/08/2015 at 15:59:43 +0530, Viresh Kumar wrote :
> IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
> is no need to do that again from its callers. Drop it.
> 
> gemini driver was using likely() for a failure case while the rtc driver
> is getting registered. That looks wrong and it should really be
> unlikely. But because we are killing all the unlikely() flags, lets kill
> that too.
> 
> Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com> (gemini)
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
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
