Return-Path: <rtc-linux+bncBAABBBHIY6WQKGQEXJBY4KY@googlegroups.com>
Received: from mail.ginzinger.com (mail.ginzinger.com. [31.193.165.229])
        by gmr-mx.google.com with ESMTP id ec7si82548wib.3.2015.07.24.01.14.59
        for <rtc-linux@googlegroups.com>;
        Fri, 24 Jul 2015 01:14:59 -0700 (PDT)
From: Roosen Henri <Henri.Roosen@ginzinger.com>
To: 'Alexandre Belloni' <alexandre.belloni@free-electrons.com>
CC: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"a.zummo@towertech.it" <a.zummo@towertech.it>
Subject: [rtc-linux] AW: [PATCH] rtc: rtc-rx8025: remove obsolete
 local_irq_disable() and local_irq_enable() for rtc_update_irq()
Date: Fri, 24 Jul 2015 08:14:58 +0000
Message-ID: <FC629F1A536C6F42B960B5E32E20BD35922388@exc2.buero.ginzinger.com>
References: <FC629F1A536C6F42B960B5E32E20BD35922297@exc2.buero.ginzinger.com>
 <20150722220529.GQ2853@piout.net>
In-Reply-To: <20150722220529.GQ2853@piout.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

> -----Urspr=C3=BCngliche Nachricht-----
> Von: Alexandre Belloni [mailto:alexandre.belloni@free-electrons.com]
> Gesendet: Donnerstag, 23. Juli 2015 00:05
> An: Roosen Henri
> Cc: rtc-linux@googlegroups.com; a.zummo@towertech.it
> Betreff: Re: [PATCH] rtc: rtc-rx8025: remove obsolete local_irq_disable()=
 and
> local_irq_enable() for rtc_update_irq()
>
> Hi,

Hi Alexandre,

>
> Seems good to me, I had a similar cleanup that I didn't send yet. do you =
have
> an rx8025? I have more cleanups and I can't test them.
>

Unfortunately I don't have a rx8025. But I have a system with a rx8803. The=
 manufacturer is providing a driver which is derived from the rx8025 driver=
.

> On 21/07/2015 at 07:11:02 +0000, Roosen Henri wrote :
> > From b68f4bd992a6bf538edb860662be3178394f8bf5 Mon Sep 17 00:00:00
> 2001
> > From: Henri Roosen <henri.roosen@ginzinger.com>
> > Date: Thu, 16 Jul 2015 10:16:41 +0200
> > Subject: [PATCH] rtc: rtc-rx8025: remove obsolete local_irq_disable()
> > and
> >  local_irq_enable() for rtc_update_irq()
> >
> > Since commit e6229bec25be4ba00f31dd26e25721cc96c22262
> rtc_update_irq()
> > is callable with irqs enabled.
> >
>
> This triggers a checkpatch warning:
>  ERROR: Please use git commit description style 'commit <12+ chars of sha=
1>
> ("<title line>")' - ie: 'commit 0123456789ab ("commit description")'
>  #14: Since commit e6229bec25be4ba00f31dd26e25721cc96c22262
> rtc_update_irq()
>

Sorry, I missed this for the previous patches. I'll fix it and send a new v=
ersion (v3) of the patch.

> > Signed-off-by: Henri Roosen <henri.roosen@ginzinger.com>
> > ---
> >  drivers/rtc/rtc-rx8025.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c index
> > e6298e0..9be9c37 100644
> > --- a/drivers/rtc/rtc-rx8025.c
> > +++ b/drivers/rtc/rtc-rx8025.c
> > @@ -161,9 +161,7 @@ static void rx8025_work(struct work_struct *work)
> >         if (status & RX8025_BIT_CTRL2_CTFG) {
> >                 /* periodic */
> >                 status &=3D ~RX8025_BIT_CTRL2_CTFG;
> > -               local_irq_disable();
> >                 rtc_update_irq(rx8025->rtc, 1, RTC_PF | RTC_IRQF);
> > -               local_irq_enable();
> >         }
> >
> >         if (status & RX8025_BIT_CTRL2_DAFG) { @@ -172,9 +170,7 @@
> > static void rx8025_work(struct work_struct *work)
> >                 if (rx8025_write_reg(client, RX8025_REG_CTRL1,
> >                                      rx8025->ctrl1 & ~RX8025_BIT_CTRL1_=
DALE))
> >                         goto out;
> > -               local_irq_disable();
> >                 rtc_update_irq(rx8025->rtc, 1, RTC_AF | RTC_IRQF);
> > -               local_irq_enable();
> >         }
> >
> >         /* acknowledge IRQ */
>
> Unfortunately, your patch doesn't apply because the identation has ben
> mangled, probably by your mailer (tabs became spaces). Can you resend?

I've switched now to using git send-email on my private email address. This=
 should not mangle the patch anymore. Please find patch v3 in a little whil=
e.

Thanks,
Henri

>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering http://free-electrons.com

________________________________

Ginzinger electronic systems GmbH
Gewerbegebiet Pirath 16
4952 Weng im Innkreis
www.ginzinger.com

Firmenbuchnummer: FN 364958d
Firmenbuchgericht: Ried im Innkreis
UID-Nr.: ATU66521089

________________________________
*** BETRIEBSURLAUB VON MONTAG, DEN 27. JULI 2015 BIS FREITAG, DEN 7. AUGUST=
 2015 ***
*** COMPANY HOLIDAY FROM MONDAY, THE 27 JULY 2015 TO FRIDAY, 7 AUGUST 2015 =
***

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
