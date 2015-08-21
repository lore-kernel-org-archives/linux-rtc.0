Return-Path: <rtc-linux+bncBDS7HNEFSALRB3FT32XAKGQEEJRWDMY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt6si188064wib.1.2015.08.21.14.36.44
        for <rtc-linux@googlegroups.com>;
        Fri, 21 Aug 2015 14:36:44 -0700 (PDT)
Date: Fri, 21 Aug 2015 23:36:42 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, bcousson@baylibre.com, johan@kernel.org,
	linux-omap@vger.kernel.org, rtc-linux@googlegroups.com,
	grygorii.strashko@ti.com
Subject: [rtc-linux] Re: [PATCH v5 2/3] rtc: omap: Add internal clock enabling support
Message-ID: <20150821213642.GJ3769@piout.net>
References: <1439890876-19024-1-git-send-email-j-keerthy@ti.com>
 <1439890876-19024-3-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439890876-19024-3-git-send-email-j-keerthy@ti.com>
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

On 18/08/2015 at 15:11:15 +0530, Keerthy wrote :
> @@ -681,6 +688,9 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
>  
>  	device_init_wakeup(&pdev->dev, 0);
>  
> +	if (!IS_ERR(rtc->clk))
> +		clk_disable_unprepare(rtc->clk);
> +
>  	rtc->type->unlock(rtc);
>  	/* leave rtc running, but disable irqs */

Is it actually still running once the clock is disabled?

>  	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);



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
