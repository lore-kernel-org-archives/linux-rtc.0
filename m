Return-Path: <rtc-linux+bncBDS7HNEFSALRB7PL32ZQKGQE6EQPEWQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id b62si566655wmc.0.2015.12.21.00.19.09
        for <rtc-linux@googlegroups.com>;
        Mon, 21 Dec 2015 00:19:09 -0800 (PST)
Date: Mon, 21 Dec 2015 09:19:08 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	RTC-LINUX <rtc-linux@googlegroups.com>,
	David Dajun Chen <david.chen@diasemi.com>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V1] rtc: da9063: access ordering error during
 RTC interrupt system power on
Message-ID: <20151221081908.GG3541@piout.net>
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

On 08/12/2015 at 16:28:39 +0000, Steve Twiss wrote :
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> This fix alters the ordering of the IRQ and device registrations in the RTC
> driver probe function. This change will apply to the RTC driver that supports
> both DA9063 and DA9062 PMICs.
> 
> A problem could occur with the existing RTC driver if:
> 
> A system is started from a cold boot using the PMIC RTC IRQ to initiate a
> power on operation. For instance, if an RTC alarm is used to start a
> platform from power off.
> The existing driver IRQ is requested before the device has been properly
> registered.
> i.e.
>     ret = devm_request_threaded_irq() 
> comes before
>     rtc->rtc_dev = devm_rtc_device_register();
> 
> In this case, the interrupt can be called before the device has been
> registered and the handler can be called immediately. The IRQ handler
> da9063_alarm_event() contains the function call
> 
>     rtc_update_irq(rtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
> 
> which in turn tries to access the unavailable rtc->rtc_dev.
> 
> The fix is to reorder the functions inside the RTC probe. The IRQ is
> requested after the RTC device resource has been registered so that
> get_irq_byname is the last thing to happen.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

This patch has been applied and landed in v4.4-rc6


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
