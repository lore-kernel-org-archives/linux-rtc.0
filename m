Return-Path: <rtc-linux+bncBDS7HNEFSALRBPM3YSUQKGQEDG5DTII@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id g5si112404wix.1.2015.04.17.06.42.21
        for <rtc-linux@googlegroups.com>;
        Fri, 17 Apr 2015 06:42:21 -0700 (PDT)
Date: Fri, 17 Apr 2015 15:42:08 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Arnaud Ebalard <arno@natisbad.org>,
	Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>, stable@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: Fix concurrency access in armada38x_rtc_set_time
Message-ID: <20150417134208.GH29796@piout.net>
References: <1429103633-24376-1-git-send-email-gregory.clement@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1429103633-24376-1-git-send-email-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 15/04/2015 at 15:13:53 +0200, Gregory CLEMENT wrote :
> While setting the time, the RTC TIME register should not be
> accessed. However due to hardware constraints, setting the RTC time
> involves sleeping during 100ms. This sleep was done outside the
> critical section protected by the spinlock, so it was possible to read
> the RTC TIME register and get an incorrect value. This patch
> introduces a mutex for protecting the RTC TIME access, unlike the
> spinlock it is allowed to sleep in a critical section protected by a
> mutex. The RTC STATUS register can still be used from the interrupt
> handler but it has no effect on setting the time.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> Cc: <stable@vger.kernel.org> #v4.0
> ---
> Hi,
> 
> I finally got more information about the RTC behavior and while it is
> fine accessing RTC_STATUS register during between RTC_STATUS reset and
> writing time in RTC_TIME register, reading RTC_TIME during this period
> might five incorrect value.
> 
> It is too late to fix 4.0, but we are in time for 4.1 and this patch
> was tagged to be applied to the stable version of 4.0.
> 
> Gregory
> 
> 
>  drivers/rtc/rtc-armada38x.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
> index 43e04af39e09..cb70ced7e0db 100644
> --- a/drivers/rtc/rtc-armada38x.c
> +++ b/drivers/rtc/rtc-armada38x.c
> @@ -40,6 +40,13 @@ struct armada38x_rtc {
>  	void __iomem	    *regs;
>  	void __iomem	    *regs_soc;
>  	spinlock_t	    lock;
> +	/*
> +	 * While setting the time, the RTC TIME register should not be
> +	 * accessed. Setting the RTC time involves sleeping during
> +	 * 100ms, so a mutex instead of a spinlock is used to protect
> +	 * it
> +	 */
> +	struct mutex	    mutex_time;
>  	int		    irq;
>  };
>  
> @@ -59,8 +66,7 @@ static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
>  	unsigned long time, time_check, flags;
>  
> -	spin_lock_irqsave(&rtc->lock, flags);
> -
> +	mutex_lock(&rtc->mutex_time);
>  	time = readl(rtc->regs + RTC_TIME);
>  	/*
>  	 * WA for failing time set attempts. As stated in HW ERRATA if
> @@ -71,7 +77,7 @@ static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	if ((time_check - time) > 1)
>  		time_check = readl(rtc->regs + RTC_TIME);
>  
> -	spin_unlock_irqrestore(&rtc->lock, flags);
> +	mutex_unlock(&rtc->mutex_time);
>  
>  	rtc_time_to_tm(time_check, tm);
>  
> @@ -94,19 +100,12 @@ static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	 * then wait for 100ms before writing to the time register to be
>  	 * sure that the data will be taken into account.
>  	 */
> -	spin_lock_irqsave(&rtc->lock, flags);
> -
> +	mutex_lock(&rtc->mutex_time);
>  	rtc_delayed_write(0, rtc, RTC_STATUS);
> -
> -	spin_unlock_irqrestore(&rtc->lock, flags);
> -
>  	msleep(100);
> -
> -	spin_lock_irqsave(&rtc->lock, flags);
> -
>  	rtc_delayed_write(time, rtc, RTC_TIME);
> +	mutex_unlock(&rtc->mutex_time);
>  
> -	spin_unlock_irqrestore(&rtc->lock, flags);
>  out:
>  	return ret;
>  }
> @@ -230,6 +229,7 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	spin_lock_init(&rtc->lock);
> +	mutex_init(&rtc->mutex_time);
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rtc");
>  	rtc->regs = devm_ioremap_resource(&pdev->dev, res);
> -- 
> 2.1.0
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
