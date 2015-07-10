Return-Path: <rtc-linux+bncBDE6RCFOWIARBWUN72WAKGQE2ZWP4DA@googlegroups.com>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com. [209.85.214.175])
        by gmr-mx.google.com with ESMTPS id o7si116399igp.1.2015.07.10.01.48.26
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2015 01:48:26 -0700 (PDT)
Received: by mail-ob0-f175.google.com with SMTP id bs4so187506722obd.3
        for <rtc-linux@googlegroups.com>; Fri, 10 Jul 2015 01:48:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <975d474dd947bcef8d3dd70ef18a5c29@advem.lv>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
	<2131951.l0j0CIttAZ@wuerfel>
	<f22e65faa7d86074cda27973f83d7a52@advem.lv>
	<1781580.JRD7b0UrJA@wuerfel>
	<alpine.LNX.2.00.1507091343150.24357@localhost>
	<5e6214ee669fbd797ad2ef257ce52068@advem.lv>
	<CACRpkdYm-W8FqBgvustJUweizocmX9LtVS6Q=7j8EjF8D+H77Q@mail.gmail.com>
	<975d474dd947bcef8d3dd70ef18a5c29@advem.lv>
Date: Fri, 10 Jul 2015 10:48:26 +0200
Message-ID: <CACRpkdbf2CfT7fJ6wAC3WB9=-Cp0A5xZAO1-Rh78o-U26Fr0Ag@mail.gmail.com>
Subject: [rtc-linux] Re: Gemini Soc timers
From: Linus Walleij <linus.walleij@linaro.org>
To: Roman Yeryomin <roman@advem.lv>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felix Fietkau <nbd@openwrt.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>
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

On Thu, Jul 9, 2015 at 6:48 PM, Roman Yeryomin <roman@advem.lv> wrote:
> [Me]
>> As usual they are just keeping it out of mainline, and this
>> is adding sched_clock() and other goodies so should
>> probably be upstreamed ASAP.
>
>
> This is what I initially submitted here.

Ah. I missed part of the start of the discussion it seems.

> But Arnd wanted to see a smaller patch which only fixes gemini timer issue
> (t.i. shed clock being 100Hz instead of 25MHz).
> Also I've submitted 4.1 support yesterday, but patches didn't change much
> comparing to 3.18

On the other hand I think the bigger patch is OK actually.

I rewrote the timer support some time back and did not get
anyone to test it properly at the time, so the patch went in
untested. So this is a fix.

I think this should be applied as-is since you can actually
test the whole thing on real hardware, and also add:

Fixes: f3372c01816e "ARM: gemini: convert to GENERIC_CLOCKEVENTS"
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> I would love to see all those patches/drivers in mainline - tell me where do
> I submit all that :)

I recently looked at some of the patch stacks in OpenWRT and
get a bit sad that the stuff did not go upstream, so I am ready
to help in any way I can.

Anything GPIO related I am ready to help in reviewing/applying
and I will also help out with ARM32 if I can. Sadly I do not have
a Gemini system.

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
