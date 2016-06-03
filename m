Return-Path: <rtc-linux+bncBDF57NG2XIHRBBFBYW5AKGQEQXVBTSI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com. [2a00:1450:400c:c09::22e])
        by gmr-mx.google.com with ESMTPS id a65si148423wma.3.2016.06.03.02.40.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 02:40:20 -0700 (PDT)
Received: by mail-wm0-x22e.google.com with SMTP id a136so265113096wme.0
        for <rtc-linux@googlegroups.com>; Fri, 03 Jun 2016 02:40:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <57514826.8030801@arm.com>
References: <1464875584-31505-1-git-send-email-linus.walleij@linaro.org> <57514826.8030801@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 3 Jun 2016 11:40:19 +0200
Message-ID: <CAPDyKFo=pMNnEsH+a4bQOMA0_qR+vUoZY16DKmAWfVfmYXvJTQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: ab8500: move device_init_wakeup() call
To: Sudeep Holla <sudeep.holla@arm.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com,
	"# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 3 June 2016 at 11:04, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 02/06/16 14:53, Linus Walleij wrote:
>>
>> commit 93a6f9168f2f ("rtc: ab8500: remove misuse of IRQF_NO_SUSPEND flag")
>> introduced the dev_pm_set_wake_irq() call to register a wake
>> IRQ for the AB8500 driver.
>>
>> However this causes a regression since device_init_wakeup() must be
>> called *after* dev_pm_set_wake_irq() not *before* it. Before this
>> patch we get an error message like this during system resume from
>> sleep:

I think it's actually the opposite. device_init_wakeup() must be
called *before* dev_pm_set_wake_irq(), as otherwise
dev_pm_set_wake_irq() will fail.

Indeed this probably "solves" the problem for you, although only by
hiding it, as there is no error check of the return code from
dev_pm_set_wake_irq().

>>
>
> I am unable to understand this. Because it's the exact same sequence in
> rtc-pl031.c which works fine for me on ARM64 Juno platform. So I am
> struggle to understand the linkage of the backtrace to this calling
> sequence as I can't see any dependency. Let me know if you have already
> figured out where exactly does it go wrong.
>
> Prior to commit 93a6f9168f2f, set_irq_wake was never tested and hence
> one possible reason I can think of is set_irq_wake_real may be failing
> on suspend but the error value is ignored.

Yes, something else is wrong here!

Kind regards
Uffe

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
