Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57010 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdGFPNs (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 11:13:48 -0400
Date: Thu, 6 Jul 2017 17:13:30 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Miodrag Dinic <Miodrag.Dinic@imgtec.com>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <James.Hogan@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        "jinqian@google.com" <jinqian@google.com>, Bo Hu <bohu@google.com>,
        "lfy@google.com" <lfy@google.com>
Subject: Re: [PATCH v2 02/10] MIPS: ranchu: Add Goldfish RTC driver
Message-ID: <20170706151330.4ovj7mmcjf4qlh4o@piout.net>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1498664922-28493-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <20170705215602.vihwoio2dagxy2fc@piout.net>
 <232DDC0A2B605E4F9E85F6904417885F015D929D3D@BADAG02.ba.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <232DDC0A2B605E4F9E85F6904417885F015D929D3D@BADAG02.ba.imgtec.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 06/07/2017 at 13:25:09 +0000, Miodrag Dinic wrote:
> > > +static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
> > > +{
> > > +     u64 time;
> > > +     u64 time_low;
> > > +     u64 time_high;
> > > +     u64 time_high_prev;
> > > +
> > > +     struct goldfish_rtc *qrtc =
> > > +                     platform_get_drvdata(to_platform_device(dev));
> > > +     void __iomem *base = qrtc->base;
> > > +
> > > +     time_high = readl(base + TIMER_TIME_HIGH);
> > > +     do {
> > > +             time_high_prev = time_high;
> > > +             time_low = readl(base + TIMER_TIME_LOW);
> > > +             time_high = readl(base + TIMER_TIME_HIGH);
> > > +     } while (time_high != time_high_prev);
> > 
> > I'm not sure why you need that loop as the comments for TIMER_TIME_LOW
> > and TIMER_TIME_HIGH indicate that TIMER_TIME_HIGH is latched when
> > TIMER_TIME_LOW is read. Note that the original driver from google
> > doesn't do that.
> 
> This is the way how other HW drivers are doing it, so we used this
> approach to make it more in-line with other HW, and it also does not
> make any assumptions regarding TIMER_TIME_HIGH is latched or not.
> This is the relevant part of code on the RTC device side which emulates these reads:
> 
> static uint64_t goldfish_timer_read(void *opaque, hwaddr offset, unsigned size)
> {
>     struct timer_state *s = (struct timer_state *)opaque;
>     switch(offset) {
>         case TIMER_TIME_LOW:
>             s->now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>             return s->now_ns;
>         case TIMER_TIME_HIGH:
>             return s->now_ns >> 32;
>         default:
>             cpu_abort(current_cpu,
>                       "goldfish_timer_read: Bad offset %" HWADDR_PRIx "\n",
>                       offset);
>             return 0;
>     }
> }
> 
> So theoretically speaking, we could imagine the situation that the kernel pre-empts after the
> first TIMER_TIME_LOW read and another request for reading the time gets processed, so
> the previous call would end-up having stale TIMER_TIME_LOW value.
> This is however very unlikely to happen, but one extra read in the loop doesn't hurt and
> actually makes the code less prone to error.
> 

Every call to the RTC callbacks are protected by a mutex so this will
never happen.

Most of the RTCs are actually latching the time on the first register
read and don't require specific handling. I'd prefer to keep the driver
simple.


> > > +     qrtc->irq = platform_get_irq(pdev, 0);
> > > +     if (qrtc->irq < 0)
> > > +             return -ENODEV;
> > > +
> > 
> > Is the irq so important that you have to fail here even if the driver
> > doesn't support any alarm?
> 
> Well currently it does not support alarm features, but we are considering
> to implement it in some other iteration. Maybe we will introduce it in the next version
> if not we will remove the IRQ handling. Thanks.
> 

I'd say that you should probably leave out the whole IRQ handling until
you really handle alarms in the driver or do you have a way to generate
alarms (and so interrupts) without using the driver?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
