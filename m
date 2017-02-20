Return-Path: <rtc-linux+bncBC6YH6VTZQDRBBGEVTCQKGQE57ZUQWQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id f7si891112wmg.3.2017.02.20.09.06.11
        for <rtc-linux@googlegroups.com>;
        Mon, 20 Feb 2017 09:06:11 -0800 (PST)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,  rtc-linux@googlegroups.com,  Jason Cooper <jason@lakedaemon.net>,  Andrew Lunn <andrew@lunn.ch>,  Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,  Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,  linux-arm-kernel@lists.infradead.org,  Haim Boot <hayim@marvell.com>
Subject: [rtc-linux] Re: [PATCH v2 0/3] Extend rtc-armada38x support for
 Armada 7K/8K
References: <20170217101907.8963-1-gregory.clement@free-electrons.com>
Date: Mon, 20 Feb 2017 18:06:11 +0100
In-Reply-To: <20170217101907.8963-1-gregory.clement@free-electrons.com>
	(Gregory CLEMENT's message of "Fri, 17 Feb 2017 11:19:04 +0100")
Message-ID: <87tw7oaj24.fsf@free-electrons.com>
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

Hi,
=20
 On ven., f=C3=A9vr. 17 2017, Gregory CLEMENT <gregory.clement@free-electro=
ns.com> wrote:

> The Armada 7K/8K SoCs use the same RTC IP than the Armada 38x. However
> the SOC integration differs in 2 points:
>      - MBUS bridge timing initialization
>      - IRQ configuration at SoC level
>
> This patch set extends the driver support to these SoCs family.
>
> In this second version the device tree was updated allowing to use the
> RTC on Armada 80x0 SoCs. Indeed on the Armada 80x0, the RTC clock in
> CP master is not connected (by package) to the oscillator. So this one
> is disabled for the Armada 8020 and the Armada 8040. On these SoCs it
> will be the RTC clock in CP slave connected to the oscillator which
> will be used.

I saw on IRC than Russell managed to have a more coherent date with this
series on his 8040 based board. For the record, as the U-Boot on this
board didn't provide a "date reset" command for the RTC located on CP
slave, then Russell needed to do the following:

devmem2 0xf428401c w 0
devmem2 0xf4284018 w 0x2000
followed by:
date 021612342017; ntpdate ...; hwclock -uw

But this issue was related to the bootloader not to the kernel. The
other potential issue seen by Russell was about the GIC mapping for the
interrupt, but here again this mapping was done by the 1st stage
bootloader.

Given this information would it be OK to applied this series?

Thanks,

Gregory

>
> Thanks,
>
> Gregory
>
> Gregory CLEMENT (3):
>   rtc: armada38x: Prepare driver to manage different versions
>   rtc: armada38x: Add support for Armada 7K/8K
>   arm64: dts: marvell: add RTC description for Armada 7K/8K
>
>  .../devicetree/bindings/rtc/armada-380-rtc.txt     |   8 +-
>  arch/arm64/boot/dts/marvell/armada-8020.dtsi       |  10 +
>  arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   9 +
>  .../boot/dts/marvell/armada-cp110-master.dtsi      |   7 +
>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |   7 +
>  drivers/rtc/rtc-armada38x.c                        | 217 +++++++++++++++=
+-----
>  6 files changed, 202 insertions(+), 56 deletions(-)
>
> --=20
> 2.11.0
>

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

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
