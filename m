Return-Path: <rtc-linux+bncBDAMN6NI5EERBG4JYLDQKGQEM6DVB7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from Galois.linutronix.de (Galois.linutronix.de. [2a01:7a0:2:106d:700::1])
        by gmr-mx.google.com with ESMTPS id w130si1313539wmf.0.2017.04.14.01.13.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Apr 2017 01:13:14 -0700 (PDT)
Date: Fri, 14 Apr 2017 10:13:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
    x86@kernel.org, Hans de Goede <hdegoede@redhat.com>,
    rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2] x86: i8259: export legacy_pic symbol
In-Reply-To: <20170414080818.GB10105@gmail.com>
Message-ID: <alpine.DEB.2.20.1704141012310.2327@nanos>
References: <20170408210327.2713-1-hdegoede@redhat.com> <20170413212645.ctkfqo6mkbmbosgo@piout.net> <20170414080818.GB10105@gmail.com>
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

On Fri, 14 Apr 2017, Ingo Molnar wrote:

> 
> * Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> > Hi,
> > 
> > On 08/04/2017 at 23:03:27 +0200, Hans de Goede wrote:
> > > The classic PC rtc-coms driver has a workaround for broken ACPI device
> > > nodes for it which lack an irq resource. This workaround used to
> > > unconditionally hardcode the irq to 8 in these cases.
> > > 
> > > This was causing irq conflict problems on systems without a legacy-pic
> > > so a recent patch added an if (nr_legacy_irqs()) guard to the
> > > workaround to avoid this irq conflict.
> > > 
> > > nr_legacy_irqs() uses the legacy_pic symbol under the hood causing
> > > an undefined symbol error if the rtc-cmos code is build as a module.
> > > 
> > 
> > This is kind of a pressing issue as this makes linux-next fail to build
> > for certain configurations.
> > 
> > I can carry it in my tree with your ack or let you apply it for 4.12.
> > What would you prefer?
> 
> Unless Thomas objects it looks good to me and feel free to carry it in your tree:
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
