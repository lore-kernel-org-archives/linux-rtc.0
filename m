Return-Path: <rtc-linux+bncBDE6RCFOWIARBD5Q4KWQKGQEDADPPQA@googlegroups.com>
Received: from mail-ob0-f180.google.com (mail-ob0-f180.google.com. [209.85.214.180])
        by gmr-mx.google.com with ESMTPS id a11si1399815igv.3.2015.07.29.02.08.31
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2015 02:08:31 -0700 (PDT)
Received: by mail-ob0-f180.google.com with SMTP id eg2so2668761obd.0
        for <rtc-linux@googlegroups.com>; Wed, 29 Jul 2015 02:08:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1438149721-11072-1-git-send-email-leo.yan@linaro.org>
References: <1438149721-11072-1-git-send-email-leo.yan@linaro.org>
Date: Wed, 29 Jul 2015 11:08:30 +0200
Message-ID: <CACRpkdZ5Kvc0LPeG_HAHwejoCRV4JRbpA2+zwNCAxTqzxdDYzQ@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH] drivers/rtc/rtc-pl031.c: reset registers in
 init flow
From: Linus Walleij <linus.walleij@linaro.org>
To: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deepak Saxena <dsaxena@plexity.net>,
	Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, Jul 29, 2015 at 8:02 AM, Leo Yan <leo.yan@linaro.org> wrote:

> When use rtc-pl031 for suspend test on Hisilicon's SoC Hi6220, Usually
> the data register (DR) will read back as value zero. So the suspend
> test code will set the match register (MR) for 10 seconds' timeout; But
> there have chance later will read back some random values from DR
> register; So finally miss with match value and will not trigger
> waken up event anymore.
>
> This issue can be dismissed by reset registers in initialization flow;
> And this code have no harm for ST's variant.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

I don't understand this...

> +       /* Init registers */
> +       writel(0x0, ldata->base + RTC_LR);

This will reset the clock to jan 1st 1970 on every reboot.
The idea is that the RTC should *preserve* the system time
if you reboot the system, so NACK.

Usually userspace has a script using hwclock to read the
system time from the rtc to system time with hwclock -s
after userspace comes up. Likewise it writes it back with
hwclock -w before rebooting.

> +       writel(0x0, ldata->base + RTC_DR);

This is a read-only register in the PL031 clean variant.
What do you want to achieve here? Is this register writeable
on the HiSilicon?

> +       writel(0x0, ldata->base + RTC_IMSC);

OK

> +       writel(RTC_BIT_AI, ldata->base + RTC_ICR);

So why do we want to have the alarm enabled by
default, before the kernel nor userspace has requested
it?

If your problem is with suspend/resume I suggest you work
on the [runtime]_suspend/resume hooks instead of probe().
Possibly you need to save/restore state across suspend/resume.

Yours,
Linus Walleij

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
