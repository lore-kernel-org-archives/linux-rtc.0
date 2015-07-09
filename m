Return-Path: <rtc-linux+bncBDS7HNEFSALRBN6C7GWAKGQEHSSUNRI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t6si127881wiz.0.2015.07.09.04.55.35
        for <rtc-linux@googlegroups.com>;
        Thu, 09 Jul 2015 04:55:35 -0700 (PDT)
Date: Thu, 9 Jul 2015 13:55:33 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Chao Xie <chao.xie@marvell.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [RESEND PATCH-v2] rtc: 88pm80x: add device tree support
Message-ID: <20150709115533.GY3127@piout.net>
References: <1436424952-29680-1-git-send-email-vaibhav.hiremath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1436424952-29680-1-git-send-email-vaibhav.hiremath@linaro.org>
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

On 09/07/2015 at 12:25:51 +0530, Vaibhav Hiremath wrote :
> Along with DT support, this patch also cleans up the unnecessary
> code around 'rtc_wakeup' initialization.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

No need to resend, I'll take it. I'm current busy with other things and
it is still early in the development cycle.

> -	if (pm80x_pdata) {
> -		pdata = pm80x_pdata->rtc;
> -		if (pdata)
> -			info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
> -	}
> +	/* remeber whether this power up is caused by PMIC RTC or not */

I'll fix that typo...

> +	info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
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
