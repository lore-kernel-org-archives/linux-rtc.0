Return-Path: <rtc-linux+bncBAABBBUH7C5QKGQE5CCPLZA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-out1.kundencontroller.de (mail-out1.kundencontroller.de. [2a02:180:ffff:1::551f:b822])
        by gmr-mx.google.com with ESMTPS id x70si36258wmf.1.2016.07.06.22.11.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jul 2016 22:11:41 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: sunxi: use external oscillator
To: Maxime Ripard <maxime.ripard@free-electrons.com>
References: <577CC494.8020103@roslen.de> <20160706202000.GC4247@lukather>
 <577DDF8C.6060404@roslen.de>
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 wens@csie.org, rtc-linux@googlegroups.com
From: Stephan Roslen <stephan@roslen.de>
Message-ID: <577DE48B.2020009@roslen.de>
Date: Thu, 7 Jul 2016 07:11:39 +0200
MIME-Version: 1.0
In-Reply-To: <577DDF8C.6060404@roslen.de>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 07.07.2016 06:50, Stephan Roslen wrote:
> On 06.07.2016 22:20, Maxime Ripard wrote:
>> The issue is actually worse than that.
>>
>> That register controls the losc source for the whole clock tree, so it
>> will affect every clock in the system.
>>
>> In order to have that correctly propagated, you should register a new
>> mux here in the clock framework, and have all the other clocks using
>> that mux as a parent.
>=20
> I agree. Checking the diagram in subsection 1.5.2 of the A20 manual it se=
ems, that LOSC can be a source for clocks like CPU and some SoC busses. So =
my patch could indeed mess with the whole clock tree.

Sorry for the addition. The mess of course is not that huge, for the mux se=
lects between a 32KHz Oscillator with +- 20% tolerance, thus ranging from 2=
5.6 to 38.4 KHz and the 32.768KHz external oscillator. Hence muxing to 32.7=
68KHz should be no problem for any clk, that was fine with the internal osc=
illator as clk source. Though still you're absolutely right, that this shou=
ld be handled in code correctly.

Stephan

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
