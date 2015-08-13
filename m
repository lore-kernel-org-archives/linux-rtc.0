Return-Path: <rtc-linux+bncBDE6RCFOWIARBC6DWKXAKGQE7RGK6II@googlegroups.com>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com. [209.85.218.49])
        by gmr-mx.google.com with ESMTPS id x1si235395igb.2.2015.08.13.06.54.18
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 06:54:18 -0700 (PDT)
Received: by oio137 with SMTP id 137so26875557oio.0
        for <rtc-linux@googlegroups.com>; Thu, 13 Aug 2015 06:54:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439358807-9024-2-git-send-email-dongsheng.wang@freescale.com>
References: <1439358807-9024-1-git-send-email-dongsheng.wang@freescale.com>
	<1439358807-9024-2-git-send-email-dongsheng.wang@freescale.com>
Date: Thu, 13 Aug 2015 15:54:18 +0200
Message-ID: <CACRpkdbninKuGzhEc5mN+85j-=w_wYQgra-Ark_Du6gWKN2=tg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/2] soc/fsl: add ftm alarm driver for ls1021a platform
From: Linus Walleij <linus.walleij@linaro.org>
To: Dongsheng Wang <dongsheng.wang@freescale.com>, John Stultz <john.stultz@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, "Nair, Sandeep" <sandeep_n@ti.com>,
	Hans de Goede <hdegoede@redhat.com>, alison.wang@freescale.com,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
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

On Wed, Aug 12, 2015 at 7:53 AM, Dongsheng Wang
<dongsheng.wang@freescale.com> wrote:

> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>
> Only Ftm0 can be used when system going to deep sleep. So this driver
> to support ftm0 as a wakeup source.
>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> *V2*
> Change Copyright 2014 to 2015.
(...)
> +config FTM_ALARM
> +       bool "FTM alarm driver"
> +       depends on SOC_LS1021A
> +       default n
> +       help
> +         Say y here to enable FTM alarm support.  The FTM alarm provides
> +         alarm functions for wakeup system from deep sleep.  There is only
> +         one FTM can be used in ALARM(FTM 0).
(...)
> +static u32 time_to_cycle(unsigned long time)
> +static u32 cycle_to_time(u32 cycle)
> +static int ftm_set_alarm(u64 cycle)
> +static irqreturn_t ftm_alarm_interrupt(int irq, void *dev_id)
> +static ssize_t ftm_alarm_show(struct device *dev,
> +                             struct device_attribute *attr,
> +                             char *buf)
> +static ssize_t ftm_alarm_store(struct device *dev,
> +                              struct device_attribute *attr,
> +                              const char *buf, size_t count)
(...)
> +static struct device_attribute ftm_alarm_attributes = __ATTR(ftm_alarm, 0644,
> +                       ftm_alarm_show, ftm_alarm_store);

If you're gonna invent ABIs, document then in Documentation/ABI/testing/*.

But I don't get it. Why is this driver not in drivers/rtc?

It does a subset of what an RTC does. The ioctl()'s of an RTC
can do what you want to do. And much much more.

If it can't do all an RTC can do, surely the RTC subsystem
can be augmented to host it anyway. It's way to close to
an RTC to have it's own random sysfs driver like this.

Unless I'm totally off, rewrite this to an RTC driver and post
it to the RTC maintainers.

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
