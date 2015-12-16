Return-Path: <rtc-linux+bncBDS7HNEFSALRB57PY6ZQKGQESFIAVTA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 204si968366wmx.1.2015.12.16.15.47.02
        for <rtc-linux@googlegroups.com>;
        Wed, 16 Dec 2015 15:47:03 -0800 (PST)
Date: Thu, 17 Dec 2015 00:47:02 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	RTC-LINUX <rtc-linux@googlegroups.com>,
	David Dajun Chen <david.chen@diasemi.com>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V1] rtc: da9063: access ordering error during
 RTC interrupt system power on
Message-ID: <20151216234702.GK8574@piout.net>
References: <20151208163406.B34683FB25@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20151208163406.B34683FB25@swsrvapps-01.diasemi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

This seems mostly fine, however ...

On 08/12/2015 at 16:28:39 +0000, Steve Twiss wrote :
>  	irq_alarm = platform_get_irq_byname(pdev, "ALARM");
>  	ret = devm_request_threaded_irq(&pdev->dev, irq_alarm, NULL,
>  					da9063_alarm_event,
>  					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  					"ALARM", rtc);
> -	if (ret) {
> +	if (ret)
>  		dev_err(&pdev->dev, "Failed to request ALARM IRQ %d: %d\n",
>  			irq_alarm, ret);
> -		return ret;
> -	}
> -

... now that requesting the interrupt is optional, you probably want to
prevent userspace from thinking it will get an interrupt after setting
the alarm by returning -EINVAL in da9063_rtc_read_alarm() and
da9063_rtc_set_alarm() in that case.

> -	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, DA9063_DRVNAME_RTC,
> -					   &da9063_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(rtc->rtc_dev))
> -		return PTR_ERR(rtc->rtc_dev);
>  
> -	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
> -	rtc->rtc_sync = false;
>  	return ret;
>  }
>  
> -- 
> end-of-patch for PATCH V1
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
