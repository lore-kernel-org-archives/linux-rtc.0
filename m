Return-Path: <rtc-linux+bncBAABBBUH7C5QKGQE5CCPLZA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-out1.kundencontroller.de (mail-out1.kundencontroller.de. [2a02:180:ffff:1::551f:b822])
        by gmr-mx.google.com with ESMTPS id f70si102196wmf.0.2016.07.06.21.50.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jul 2016 21:50:27 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: sunxi: use external oscillator
To: Maxime Ripard <maxime.ripard@free-electrons.com>
References: <577CC494.8020103@roslen.de> <20160706202000.GC4247@lukather>
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 wens@csie.org, rtc-linux@googlegroups.com
From: Stephan Roslen <stephan@roslen.de>
Message-ID: <577DDF8C.6060404@roslen.de>
Date: Thu, 7 Jul 2016 06:50:20 +0200
MIME-Version: 1.0
In-Reply-To: <20160706202000.GC4247@lukather>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 06.07.2016 22:20, Maxime Ripard wrote:
> On Wed, Jul 06, 2016 at 10:43:00AM +0200, Stephan Roslen wrote:
>> +	writel(loscctrl, chip->base + SUNXI_LOSC_CTRL);
>> +	udelay(100);
>=20
> Why is that udelay needed?

I found that studying the sunxi 3.4 kernel code and considered it a necessa=
ry delay for the hardware setup and update SUNXI_LOSC_CTRL_SRC_SEL bit. My =
assumption was wrong, it seems. At least a few reboots show, that it is lik=
ely to work without.

>=20
>> +
>> +	loscctrl =3D readl(chip->base + SUNXI_LOSC_CTRL);
>> +	if (!(loscctrl & SUNXI_LOSC_CTRL_SRC_SEL)) {
>> +		dev_err(&pdev->dev, "Error: Set LOSC to external failed.\n");
>> +		dev_err(&pdev->dev, "Warning: RTC time will be wrong!\n");
>> +	}
>> +
>=20
> This isn't needed
>=20
> The issue is actually worse than that.
>=20
> That register controls the losc source for the whole clock tree, so it
> will affect every clock in the system.
>=20
> In order to have that correctly propagated, you should register a new
> mux here in the clock framework, and have all the other clocks using
> that mux as a parent.

I agree. Checking the diagram in subsection 1.5.2 of the A20 manual it seem=
s, that LOSC can be a source for clocks like CPU and some SoC busses. So my=
 patch could indeed mess with the whole clock tree.

>=20
> That's going to be tricky, because the clocks usually probe way
> earlier than the RTC driver. So I'm guessing you could do a clock
> driver that maps the registers, register its clock, and then when the
> RTC probes just takes over what has been setup already by the clock
> driver. This also means removing the ability for the RTC to be
> compiled as a module.

I agree again. Though I think, the RTC should still work as a module. The C=
LK driver could provide the regmap MFD style and the RTC driver may access =
it. Or rather the CLK driver should use an MFD, that is provided early, too=
. Eventually even a syscon? Actually the whole bunch described in subsectio=
n 1.9 (including timers, arlarms, rtc and even the watchdog) would have to =
rely on that MFD. Do I miss a point?

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
