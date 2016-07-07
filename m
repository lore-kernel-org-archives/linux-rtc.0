Return-Path: <rtc-linux+bncBAABBBUH7C5QKGQE5CCPLZA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-out1.kundencontroller.de (mail-out1.kundencontroller.de. [2a02:180:ffff:1::551f:b822])
        by gmr-mx.google.com with ESMTPS id x70si42823wmf.1.2016.07.06.23.12.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jul 2016 23:12:16 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: sunxi: use external oscillator
To: Chen-Yu Tsai <wens@csie.org>
References: <577CC494.8020103@roslen.de> <20160706202000.GC4247@lukather>
 <577DDF8C.6060404@roslen.de>
 <CAGb2v64Q6ERA2cHP48Wop5hdmKq0aYSUDfU6Q7qDGRJmk5G--g@mail.gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com
From: Stephan Roslen <stephan@roslen.de>
Message-ID: <577DF2B9.602@roslen.de>
Date: Thu, 7 Jul 2016 08:12:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAGb2v64Q6ERA2cHP48Wop5hdmKq0aYSUDfU6Q7qDGRJmk5G--g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 07.07.2016 06:53, Chen-Yu Tsai wrote:
> On Thu, Jul 7, 2016 at 12:50 PM, Stephan Roslen <stephan@roslen.de> wrote:
>> I agree. Checking the diagram in subsection 1.5.2 of the A20 manual it seems, that LOSC can be a source for clocks like CPU and some SoC busses. So my patch could indeed mess with the whole clock tree.
> 
> (Please wrap your email)

Sorry.

> 
> Within the current sunxi clk structure, the LOSC is registered as a fixed
> 32.768 KHz clk. So this patch actually makes things right.

In this case it should still be addressed somewhere in drivers/clk/sunxi, not 
in drivers/rtc, I guess? Would you prefer setting the external 32.768 KHz crystal
as hard coded default instead of providing the muxer? It could be considered okay,
for the data sheet seems to demand presence of the external oscillator and there
is absolutely no use in a 32KHz +- 20% oscillator, if a 32.768KHz crystal is
available.

Stephan

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
