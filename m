Return-Path: <rtc-linux+bncBC4L3MVYV4CBBC64T66AKGQE3I3CPCI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.natisbad.org (36.223.133.77.rev.sfr.net. [77.133.223.36])
        by gmr-mx.google.com with ESMTP id o85si1877283wme.0.2016.07.14.12.54.51
        for <rtc-linux@googlegroups.com>;
        Thu, 14 Jul 2016 12:54:51 -0700 (PDT)
From: arno@natisbad.org (Arnaud Ebalard)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,  rtc-linux@googlegroups.com,  linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: fix century bit support
References: <1468370064-19255-1-git-send-email-alexandre.belloni@free-electrons.com>
Date: Thu, 14 Jul 2016 21:54:45 +0200
Message-ID: <87inw8hu62.fsf@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:

> Add an option to properly support the century bit of ds1337 and compatibles
> and ds1340.
> Because the driver had a bug until now, it is not possible to switch users
> to the fixed code directly as RTCs in the field will wrongly have the
> century bit set.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>
> Arnaud, do you mind testing that patch, I still don't have the necessary
> hardware but I think this is the proper course of action.

I did some tests w/ all patches applied (the one below and the ones in
the other series). I had to fix two errors: one pointed in the patch
below and the other one in a patch in the other series (I'll reply to
the patch).

With both RTC_DRV_DS1307 and RTC_DRV_DS1307_CENTURY enabled, this works
as expected on my side: booting on a system which had only seen an
ISL12057 driver, the time on the system at boot (or via hwclock -r) is
correct. Playing w/ -s and -w options works as expected. Booting back on
a kernel w/ ISL12057 driver, things are also ok. So, AFAICT, your
changes do the work.

One small thing though: for user which have always used RTC_DRV_ISL12057
config knob, the change will not be transparent. Would it be possible to
somehow make that old kernel config knob some kind of alias for
RTC_DRV_DS1307 and RTC_DRV_DS1307_CENTURY in Kconfig?

Cheers,

a+


> +#ifdef CONFIG_RTC_DRV_DS1307_CENTURY
> +	switch (ds1307->type) {
> +	case ds_1337:
> +	case ds_1339:
> +	case ds_3231:
> +		if (ds1307->regs[DS1307_REG_MONTH] && DS1337_BIT_CENTURY)

                                                   ^^


> +			t->tm_year += 100;
> +		break;
> +	case ds_1340:
> +		if (ds1307->regs[DS1307_REG_HOUR] && DS1340_BIT_CENTURY)

                                                  ^^

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
