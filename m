Return-Path: <rtc-linux+bncBD7ZDTFR7QFRBK4QYW5AKGQETI6DT6I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from foss.arm.com (foss.arm.com. [217.140.101.70])
        by gmr-mx.google.com with ESMTP id m28si633268pfa.0.2016.06.03.02.04.42
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Jun 2016 02:04:42 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: ab8500: move device_init_wakeup() call
To: Linus Walleij <linus.walleij@linaro.org>
References: <1464875584-31505-1-git-send-email-linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Sudeep Holla <sudeep.holla@arm.com>, rtc-linux@googlegroups.com,
 stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Message-ID: <57514826.8030801@arm.com>
Date: Fri, 3 Jun 2016 10:04:38 +0100
MIME-Version: 1.0
In-Reply-To: <1464875584-31505-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 02/06/16 14:53, Linus Walleij wrote:
> commit 93a6f9168f2f ("rtc: ab8500: remove misuse of IRQF_NO_SUSPEND flag")
> introduced the dev_pm_set_wake_irq() call to register a wake
> IRQ for the AB8500 driver.
>
> However this causes a regression since device_init_wakeup() must be
> called *after* dev_pm_set_wake_irq() not *before* it. Before this
> patch we get an error message like this during system resume from
> sleep:
>

I am unable to understand this. Because it's the exact same sequence in
rtc-pl031.c which works fine for me on ARM64 Juno platform. So I am
struggle to understand the linkage of the backtrace to this calling
sequence as I can't see any dependency. Let me know if you have already
figured out where exactly does it go wrong.

Prior to commit 93a6f9168f2f, set_irq_wake was never tested and hence
one possible reason I can think of is set_irq_wake_real may be failing
on suspend but the error value is ignored.

-- 
Regards,
Sudeep

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
