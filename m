Return-Path: <rtc-linux+bncBDS7HNEFSALRBENS423AKGQEY2ECSWI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id z75si145524wmz.2.2016.03.04.06.17.53
        for <rtc-linux@googlegroups.com>;
        Fri, 04 Mar 2016 06:17:53 -0800 (PST)
Date: Fri, 4 Mar 2016 15:16:51 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] Re: [PATCH v3 7/8] rtc: ds3232-core: fix issue when irq
 is shared several devices
Message-ID: <20160304141651.GB27662@piout.net>
References: <1456758832-10590-1-git-send-email-akinobu.mita@gmail.com>
 <1456758832-10590-7-git-send-email-akinobu.mita@gmail.com>
 <CAC5umygNbz=nnPU6oTDsmrwWRKLFJE3Hq2ei1mPQ425CvfVE9Q@mail.gmail.com>
 <20160303225756.GA2587@piout.net>
 <CAC5umyiOPbXVOOjd-4oLnovPz19M57EL7RhL115rXVx7xd0MNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAC5umyiOPbXVOOjd-4oLnovPz19M57EL7RhL115rXVx7xd0MNQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/03/2016 at 22:56:01 +0900, Akinobu Mita wrote :
> 2016-03-04 7:57 GMT+09:00 Alexandre Belloni
> <alexandre.belloni@free-electrons.com>:
> > On 03/03/2016 at 23:10:35 +0900, Akinobu Mita wrote :
> >> 2016-03-01 0:13 GMT+09:00 Akinobu Mita <akinobu.mita@gmail.com>:
> >> > ds3232-core requests irq with IRQF_SHARED, so irq can be shared by
> >> > several devices.  But the irq handler for ds3232 unconditionally
> >> > disables the irq at first and the irq is re-enabled only when the
> >> > interrupt source was the ds3232's alarm.  This behaviour breaks the
> >> > devices sharing the same irq in the various scenarios.
> >> >
> >> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> >> > Cc: Alessandro Zummo <a.zummo@towertech.it>
> >> > Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >> > Cc: Dennis Aberilla <denzzzhome@yahoo.com>
> >> > ---
> >> > * New patch from this version
> >> >
> >> >  drivers/rtc/rtc-ds3232-core.c | 14 ++------------
> >> >  1 file changed, 2 insertions(+), 12 deletions(-)
> >> >
> >> > diff --git a/drivers/rtc/rtc-ds3232-core.c b/drivers/rtc/rtc-ds3232-core.c
> >> > index be8dfe0..6489380 100644
> >> > --- a/drivers/rtc/rtc-ds3232-core.c
> >> > +++ b/drivers/rtc/rtc-ds3232-core.c
> >> > @@ -59,7 +59,6 @@ struct ds3232 {
> >> >          */
> >> >         struct mutex mutex;
> >> >         bool suspended;
> >> > -       int exiting;
> >> >  };
> >> >
> >> >  static int ds3232_check_rtc_status(struct device *dev)
> >> > @@ -314,8 +313,6 @@ static irqreturn_t ds3232_irq(int irq, void *dev_id)
> >> >         struct device *dev = dev_id;
> >> >         struct ds3232 *ds3232 = dev_get_drvdata(dev);
> >> >
> >> > -       disable_irq_nosync(irq);
> >> > -
> >> >         /*
> >> >          * If rtc as a wakeup source, can't schedule the work
> >> >          * at system resume flow, because at this time the i2c bus
> >>
> >> I found that this patch is not correct because interrupt is re-enabled
> >> after this hardirq handler finished without clearing Alarm Flag or
> >> Alarm Interrupt Enable in RTC register.
> >>
> >> Maybe we should drop IRQF_SHARED flag.
> >
> > I think the best is to completely reworke the irq handling. It dates
> > from many many year ago and can be replace by a simple threaded irq.
> > This will solve your issue.
> 
> I tried converting to threaded irq.  But it needs to deal with suspend
> resume paths. (i.e. the following comment in ds3232_irq)
> 
>         /*
>          * If rtc as a wakeup source, can't schedule the work
>          * at system resume flow, because at this time the i2c bus
>          * has not been resumed.
>          */
> 
> Unfortunately, I don't have the computer that can use RTC on i2c-bus
> as wake up source.  So I think dropping IRQF_SHARED is safe for now.

That comment is bogus, you can drop it as well. It may have been the
case a few years ago but that is not true anymore (else a lot of other
RTC would fail).

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
