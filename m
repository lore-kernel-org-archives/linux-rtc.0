Return-Path: <rtc-linux+bncBDA7X7F2WUEBB4HRY6VAKGQEDQG3ZQA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com. [74.125.82.43])
        by gmr-mx.google.com with ESMTPS id m3si95496wia.1.2015.05.12.05.58.24
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 05:58:24 -0700 (PDT)
Received: by mail-wg0-f43.google.com with SMTP id n8so8836248wgi.0
        for <rtc-linux@googlegroups.com>; Tue, 12 May 2015 05:58:24 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	wim@iguana.be,
	a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux@roeck-us.net
Cc: kernel@stlinux.com,
	Lee Jones <lee.jones@linaro.org>
Subject: [rtc-linux] [PATCH v2 00/12] mfd: Add support for Clocksource to LPC set
Date: Tue, 12 May 2015 13:58:08 +0100
Message-Id: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

ST's Low Power Controller (LPC) controls three devices; watchdog, RTC
and a Clocksource Timer.  Only one of the devices can be used at any
one time, which is enforced by the Device Driver model.
 
This patchset provides support for the Clocksource driver.  Watchdog
and RTC are already in -next.

Lee Jones (12):
  mfd: dt-bindings: Provide human readable define for Clocksource mode
  clocksource: sti: Provide support for the ST LPC Clocksource IP
  clocksource: sti: Provide 'use timer as sched clock' capability
  clocksource: bindings: Provide bindings for ST's LPC Clocksource
    device
  watchdog: st_wdt: Update IP layout information to include Clocksource
  watchdog: bindings: Supply knowledge of a third supported device -
    clocksource
  rtc: st: Update IP layout information to include Clocksource
  rtc: bindings: Supply knowledge of a third supported device -
    clocksource
  MAINTAINERS: Add the LPC Clocksource to STi maintained driver list
  ARM: STi: DT: STih407: Switch LPC mode from RTC to Clocksource
  ARM: STi: Enable LPC Clocksource
  ARM: STi: Update platform level menuconfig 'help'

 .../devicetree/bindings/rtc/rtc-st-lpc.txt         |  15 ++-
 .../devicetree/bindings/timer/st,stih407-lpc       |  28 +++++
 .../devicetree/bindings/watchdog/st_lpc_wdt.txt    |  12 +-
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/stih407-family.dtsi              |   2 +-
 arch/arm/mach-sti/Kconfig                          |  10 +-
 drivers/clocksource/Kconfig                        |   9 ++
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/clksrc_st_lpc.c                | 129 +++++++++++++++++++++
 drivers/rtc/rtc-st-lpc.c                           |   2 +-
 drivers/watchdog/st_lpc_wdt.c                      |   2 +-
 include/dt-bindings/mfd/st-lpc.h                   |   1 +
 12 files changed, 194 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/st,stih407-lpc
 create mode 100644 drivers/clocksource/clksrc_st_lpc.c

-- 
1.9.1

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
