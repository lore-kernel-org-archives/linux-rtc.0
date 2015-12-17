Return-Path: <rtc-linux+bncBAABBZF4ZKZQKGQEOZUS2CY@googlegroups.com>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com. [195.245.231.151])
        by gmr-mx.google.com with ESMTPS id 204si65011wmx.1.2015.12.17.03.37.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2015 03:37:07 -0800 (PST)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, LINUXKERNEL
	<linux-kernel@vger.kernel.org>, RTC-LINUX <rtc-linux@googlegroups.com>,
	"David Dajun Chen" <david.chen@diasemi.com>, Support Opensource
	<Support.Opensource@diasemi.com>
Subject: [rtc-linux] RE: [PATCH V1] rtc: da9063: access ordering error during
 RTC interrupt system power on
Date: Thu, 17 Dec 2015 11:37:06 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB70173D28DCB@SW-EX-MBX02.diasemi.com>
References: <20151208163406.B34683FB25@swsrvapps-01.diasemi.com>
 <20151216234702.GK8574@piout.net>
In-Reply-To: <20151216234702.GK8574@piout.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 16 December 2015 23:47 Alexandre Belloni wrote:
> Subject: Re: [PATCH V1] rtc: da9063: access ordering error during RTC interrupt system power on
> 
> This seems mostly fine, however ...

Hi Alexandre,
Thanks for reviewing this.

> On 08/12/2015 at 16:28:39 +0000, Steve Twiss wrote :
> >  	irq_alarm = platform_get_irq_byname(pdev, "ALARM");
> >  	ret = devm_request_threaded_irq(&pdev->dev, irq_alarm, NULL,
> >  					da9063_alarm_event,
> >  					IRQF_TRIGGER_LOW |
> IRQF_ONESHOT,
> >  					"ALARM", rtc);
> > -	if (ret) {
> > +	if (ret)
> >  		dev_err(&pdev->dev, "Failed to request ALARM IRQ %d:
> %d\n",
> >  			irq_alarm, ret);
> > -		return ret;
> > -	}
> > -
> 
> ... now that requesting the interrupt is optional, you probably want to
> prevent userspace from thinking it will get an interrupt after setting
> the alarm by returning -EINVAL in da9063_rtc_read_alarm() and
> da9063_rtc_set_alarm() in that case.
> 

.. I'm not quite certain I understand.
Does the patch looks worse that it is?
This part,

+	if (ret)
		dev_err(&pdev->dev, "Failed to request ALARM IRQ %d: %d\n",
			irq_alarm, ret);
 -		return ret;

looks like it has erased the return ret,

> 
> > -	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev,
> DA9063_DRVNAME_RTC,
> > -					   &da9063_rtc_ops, THIS_MODULE);
> > -	if (IS_ERR(rtc->rtc_dev))
> > -		return PTR_ERR(rtc->rtc_dev);
> >
> > -	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
> > -	rtc->rtc_sync = false;
> >  	return ret;

But it does exist at the end of the patch.
So there will still be an error sent if the IRQ is not requested properly.
Is this what you meant in your previous e-mail?

Regards,
Stephen

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
