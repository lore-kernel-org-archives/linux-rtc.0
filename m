Return-Path: <rtc-linux+bncBCMILY6JWQBBBYGA665QKGQEMRKGWZA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw. [140.112.30.61])
        by gmr-mx.google.com with ESMTPS id c11si207830pfc.2.2016.07.06.21.53.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jul 2016 21:53:52 -0700 (PDT)
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com [209.85.223.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 8D16F20708
	for <rtc-linux@googlegroups.com>; Thu,  7 Jul 2016 12:53:50 +0800 (CST)
Received: by mail-io0-f181.google.com with SMTP id f30so13335116ioj.2
        for <rtc-linux@googlegroups.com>; Wed, 06 Jul 2016 21:53:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <577DDF8C.6060404@roslen.de>
References: <577CC494.8020103@roslen.de> <20160706202000.GC4247@lukather> <577DDF8C.6060404@roslen.de>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 7 Jul 2016 12:53:29 +0800
Message-ID: <CAGb2v64Q6ERA2cHP48Wop5hdmKq0aYSUDfU6Q7qDGRJmk5G--g@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: sunxi: use external oscillator
To: Stephan Roslen <stephan@roslen.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
	rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Jul 7, 2016 at 12:50 PM, Stephan Roslen <stephan@roslen.de> wrote:
> On 06.07.2016 22:20, Maxime Ripard wrote:
>> On Wed, Jul 06, 2016 at 10:43:00AM +0200, Stephan Roslen wrote:
>>> +    writel(loscctrl, chip->base + SUNXI_LOSC_CTRL);
>>> +    udelay(100);
>>
>> Why is that udelay needed?
>
> I found that studying the sunxi 3.4 kernel code and considered it a neces=
sary delay for the hardware setup and update SUNXI_LOSC_CTRL_SRC_SEL bit. M=
y assumption was wrong, it seems. At least a few reboots show, that it is l=
ikely to work without.
>
>>
>>> +
>>> +    loscctrl =3D readl(chip->base + SUNXI_LOSC_CTRL);
>>> +    if (!(loscctrl & SUNXI_LOSC_CTRL_SRC_SEL)) {
>>> +            dev_err(&pdev->dev, "Error: Set LOSC to external failed.\n=
");
>>> +            dev_err(&pdev->dev, "Warning: RTC time will be wrong!\n");
>>> +    }
>>> +
>>
>> This isn't needed
>>
>> The issue is actually worse than that.
>>
>> That register controls the losc source for the whole clock tree, so it
>> will affect every clock in the system.
>>
>> In order to have that correctly propagated, you should register a new
>> mux here in the clock framework, and have all the other clocks using
>> that mux as a parent.
>
> I agree. Checking the diagram in subsection 1.5.2 of the A20 manual it se=
ems, that LOSC can be a source for clocks like CPU and some SoC busses. So =
my patch could indeed mess with the whole clock tree.

(Please wrap your email)

Within the current sunxi clk structure, the LOSC is registered as a fixed
32.768 KHz clk. So this patch actually makes things right.

ChenYu

>
>>
>> That's going to be tricky, because the clocks usually probe way
>> earlier than the RTC driver. So I'm guessing you could do a clock
>> driver that maps the registers, register its clock, and then when the
>> RTC probes just takes over what has been setup already by the clock
>> driver. This also means removing the ability for the RTC to be
>> compiled as a module.
>
> I agree again. Though I think, the RTC should still work as a module. The=
 CLK driver could provide the regmap MFD style and the RTC driver may acces=
s it. Or rather the CLK driver should use an MFD, that is provided early, t=
oo. Eventually even a syscon? Actually the whole bunch described in subsect=
ion 1.9 (including timers, arlarms, rtc and even the watchdog) would have t=
o rely on that MFD. Do I miss a point?
>
> Stephan

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
