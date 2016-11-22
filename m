Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBJUP2PAQKGQEKVKET7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d6si603606wmd.0.2016.11.22.14.33.10
        for <rtc-linux@googlegroups.com>;
        Tue, 22 Nov 2016 14:33:10 -0800 (PST)
Date: Tue, 22 Nov 2016 23:33:00 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Subject: [rtc-linux] Re: [PATCH 2/3] rtc: rtc-twl: make driver DT only
Message-ID: <20161122223300.3mgdlvrkhwcasthe@piout.net>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478945246-32056-3-git-send-email-Nicolae_Rosia@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1478945246-32056-3-git-send-email-Nicolae_Rosia@mentor.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 12/11/2016 at 12:07:25 +0200, Nicolae Rosia wrote :
> @@ -625,15 +631,11 @@ static int twl_rtc_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(twl_rtc_pm_ops, twl_rtc_suspend, twl_rtc_resume);
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id twl_rtc_of_match[] = {
>  	{.compatible = "ti,twl4030-rtc", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, twl_rtc_of_match);
> -#endif
> -
> -MODULE_ALIAS("platform:twl_rtc");
>  
>  static struct platform_driver twl4030rtc_driver = {
>  	.probe		= twl_rtc_probe,


You can then get rid of of_match_ptr()


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
