Return-Path: <rtc-linux+bncBDS7HNEFSALRBLM5YSWAKGQERS6K6AY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si362629wib.2.2015.06.29.02.23.57
        for <rtc-linux@googlegroups.com>;
        Mon, 29 Jun 2015 02:23:57 -0700 (PDT)
Date: Mon, 29 Jun 2015 11:23:54 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Philippe Reynes <tremyfr@gmail.com>
Cc: a.zummo@towertech.it, shawn.guo@linaro.org, kernel@pengutronix.de,
	linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v3 3/6] rtc: mxc: use a second rtc clock
Message-ID: <20150629092354.GW485@piout.net>
References: <1434820360-21935-1-git-send-email-tremyfr@gmail.com>
 <1434820360-21935-4-git-send-email-tremyfr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1434820360-21935-4-git-send-email-tremyfr@gmail.com>
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

On 20/06/2015 at 19:12:37 +0200, Philippe Reynes wrote :
> -	rate = clk_get_rate(pdata->clk);
> +	pdata->clk_rtc = devm_clk_get(&pdev->dev, "rtc");
> +	if (IS_ERR(pdata->clk_rtc)) {
> +		dev_err(&pdev->dev, "unable to get rtc clock!\n");
> +		ret = PTR_ERR(pdata->clk_rtc);
> +		goto exit_put_clk;
> +	}
> +
> +	rate = clk_get_rate(pdata->clk_rtc);
>  

You have to prepare_enable() before using get_rate(). Else, it is not
guaranteed to work:
"clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
                This is only valid once the clock source has been enabled."
http://lxr.free-electrons.com/source/include/linux/clk.h#L269

It may work right now because the clock is enabled elsewhere. But that
may change at some point in time (we had the issue on at91).


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
