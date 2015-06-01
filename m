Return-Path: <rtc-linux+bncBDA7X7F2WUEBB5EXWCVQKGQEMOXIWNY@googlegroups.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com. [209.85.212.175])
        by gmr-mx.google.com with ESMTPS id k2si461958wif.0.2015.06.01.00.38.27
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 00:38:27 -0700 (PDT)
Received: by wicmx19 with SMTP id mx19so66623278wic.0
        for <rtc-linux@googlegroups.com>; Mon, 01 Jun 2015 00:38:27 -0700 (PDT)
Date: Mon, 1 Jun 2015 08:38:23 +0100
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, wim@iguana.be, a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	linux@roeck-us.net
Cc: kernel@stlinux.com
Subject: [rtc-linux] Re: [PATCH v2 00/12] mfd: Add support for Clocksource to
 LPC set
Message-ID: <20150601073823.GB3329@x1>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Device Tree Maintainers,

All of the functional patches in this series have been Acked by the
relevant maintainers, but the (pretty simple) DT changes are in need
of a suitable Ack.

Would someone mine glancing over them please?

> ST's Low Power Controller (LPC) controls three devices; watchdog, RTC
> and a Clocksource Timer.  Only one of the devices can be used at any
> one time, which is enforced by the Device Driver model.
> =20
> This patchset provides support for the Clocksource driver.  Watchdog
> and RTC are already in -next.
>=20
> Lee Jones (12):
>   mfd: dt-bindings: Provide human readable define for Clocksource mode
>   clocksource: sti: Provide support for the ST LPC Clocksource IP
>   clocksource: sti: Provide 'use timer as sched clock' capability
>   clocksource: bindings: Provide bindings for ST's LPC Clocksource
>     device
>   watchdog: st_wdt: Update IP layout information to include Clocksource
>   watchdog: bindings: Supply knowledge of a third supported device -
>     clocksource
>   rtc: st: Update IP layout information to include Clocksource
>   rtc: bindings: Supply knowledge of a third supported device -
>     clocksource
>   MAINTAINERS: Add the LPC Clocksource to STi maintained driver list
>   ARM: STi: DT: STih407: Switch LPC mode from RTC to Clocksource
>   ARM: STi: Enable LPC Clocksource
>   ARM: STi: Update platform level menuconfig 'help'
>=20
>  .../devicetree/bindings/rtc/rtc-st-lpc.txt         |  15 ++-
>  .../devicetree/bindings/timer/st,stih407-lpc       |  28 +++++
>  .../devicetree/bindings/watchdog/st_lpc_wdt.txt    |  12 +-
>  MAINTAINERS                                        |   1 +
>  arch/arm/boot/dts/stih407-family.dtsi              |   2 +-
>  arch/arm/mach-sti/Kconfig                          |  10 +-
>  drivers/clocksource/Kconfig                        |   9 ++
>  drivers/clocksource/Makefile                       |   1 +
>  drivers/clocksource/clksrc_st_lpc.c                | 129 +++++++++++++++=
++++++
>  drivers/rtc/rtc-st-lpc.c                           |   2 +-
>  drivers/watchdog/st_lpc_wdt.c                      |   2 +-
>  include/dt-bindings/mfd/st-lpc.h                   |   1 +
>  12 files changed, 194 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/st,stih407-lp=
c
>  create mode 100644 drivers/clocksource/clksrc_st_lpc.c
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
