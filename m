Return-Path: <rtc-linux+bncBDEKVJM7XAHRBW5NROWQKGQESCVC2DA@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.10])
        by gmr-mx.google.com with ESMTPS id gt9si268398wib.2.2015.07.12.14.06.35
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2015 14:06:35 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Roman Yeryomin <roman@advem.lv>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felix Fietkau <nbd@openwrt.org>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [rtc-linux] Re: Gemini Soc timers
Date: Sun, 12 Jul 2015 23:06:03 +0200
Message-ID: <9777530.lnQDW33Iqo@wuerfel>
In-Reply-To: <CACRpkdbf2CfT7fJ6wAC3WB9=-Cp0A5xZAO1-Rh78o-U26Fr0Ag@mail.gmail.com>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com> <975d474dd947bcef8d3dd70ef18a5c29@advem.lv> <CACRpkdbf2CfT7fJ6wAC3WB9=-Cp0A5xZAO1-Rh78o-U26Fr0Ag@mail.gmail.com>
MIME-Version: 1.0
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

On Friday 10 July 2015 10:48:26 Linus Walleij wrote:
> On Thu, Jul 9, 2015 at 6:48 PM, Roman Yeryomin <roman@advem.lv> wrote:
> > [Me]
> >> As usual they are just keeping it out of mainline, and this
> >> is adding sched_clock() and other goodies so should
> >> probably be upstreamed ASAP.
> >
> >
> > This is what I initially submitted here.
> 
> Ah. I missed part of the start of the discussion it seems.
> 
> > But Arnd wanted to see a smaller patch which only fixes gemini timer issue
> > (t.i. shed clock being 100Hz instead of 25MHz).
> > Also I've submitted 4.1 support yesterday, but patches didn't change much
> > comparing to 3.18
> 
> On the other hand I think the bigger patch is OK actually.
> 
> I rewrote the timer support some time back and did not get
> anyone to test it properly at the time, so the patch went in
> untested. So this is a fix.

The bigger patch seemed a little too verbose to have it backported
to stable kernels, so I asked for a minimal fix that could be marked
as stable, with the other changes applied on top for the current
arm-soc tree.

I'm still on parental leave and not dealing with patches directly,
so whichever patch we want should get routed through Ulli to arm@kernel.org

	Arnd

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
