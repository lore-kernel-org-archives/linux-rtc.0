Return-Path: <rtc-linux+bncBDS7HNEFSALRB4OB2W4AKGQEKK7MYFI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k143si34816wmg.1.2016.04.18.15.34.24
        for <rtc-linux@googlegroups.com>;
        Mon, 18 Apr 2016 15:34:24 -0700 (PDT)
Date: Tue, 19 Apr 2016 00:34:14 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>,
	RTC-LINUX <rtc-linux@googlegroups.com>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V1] rtc: da9053: fix access ordering error
 during RTC interrupt at system power on
Message-ID: <20160418223414.GB25196@piout.net>
References: <20160414111014.BB8B73FB1D@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160414111014.BB8B73FB1D@swsrvapps-01.diasemi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 14/04/2016 at 12:04:54 +0100, Steve Twiss wrote :
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> This fix alters the ordering of the IRQ and device registrations in the RTC
> driver probe function. This change will apply to the RTC driver that supports
> both DA9052 and DA9053 PMICs.
> 
> A problem could occur with the existing RTC driver if:
> 
> A system is started from a cold boot using the PMIC RTC IRQ to initiate a
> power on operation. For instance, if an RTC alarm is used to start a
> platform from power off.
> The existing driver IRQ is requested before the device has been properly
> registered.
> 
> i.e.
> ret = da9052_request_irq()
> comes before
> rtc->rtc = devm_rtc_device_register();
> 
> In this case, an interrupt exists before the device has been registered and
> the IRQ handler can be called immediately: this can happen be before the
> memory for rtc->rtc has been allocated. The IRQ handler da9052_rtc_irq()
> contains the function call:
> 
> rtc_update_irq(rtc->rtc, 1, RTC_IRQF | RTC_AF);
> 
> which in turn tries to access the unavailable rtc->rtc.
> 
> The fix is to reorder the functions inside the RTC probe. The IRQ is
> requested after the RTC device resource has been registered so that
> da9052_request_irq() is the last thing to happen.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
Applied, thanks.

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
