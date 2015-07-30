Return-Path: <rtc-linux+bncBDS7HNEFSALRBQO44WWQKGQEJ7Y3YAY@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id cj6si777019wib.1.2015.07.29.17.22.24
        for <rtc-linux@googlegroups.com>;
        Wed, 29 Jul 2015 17:22:24 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-pm@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	linux-clk@vger.kernel.org
Subject: [rtc-linux] [PATCH 00/20] ARM: at91: Properly handle slow clock
Date: Thu, 30 Jul 2015 02:21:46 +0200
Message-Id: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
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

Hi,

It was discovered that all the slow clock user were not properly claiming it.
This can end up in a system hang because the last registered user is releasing
it, and it gets disabled.

commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system hang")
was a workaround. This series is adding the slow clock to the necessary drivers
to avoid the issue and then removes that workaround.

The Documentation updates and DT patches should probably go through the AT91
tree this cycle to avoid breakage.

Then the other patches can go through each subsystem tree. They are trivial
enough to also go in this cycle.

The final clk patch depends on the other ones and may be taken for the next
cycle to avoid synchronization issues.

I've thrown in a cleanup for at91-reset as it avoids adding support for that
clock to the platform data initialization

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org

Alexandre Belloni (20):
  Documentation: dt: atmel-at91: add clocks to system timer, rstc and
    shdwc
  Documentation: watchdog: at91sam9_wdt: add clocks property
  Documentation: dt: rtc: at91rm9200: add clocks property
  ARM: at91/dt: at91rm9200: use slow clock where necessary
  ARM: at91/dt: at91sam9260: use slow clock where necessary
  ARM: at91/dt: at91sam9261: use slow clock where necessary
  ARM: at91/dt: at91sam9263: use slow clock where necessary
  ARM: at91/dt: at91sam9g45: use slow clock where necessary
  ARM: at91/dt: at91sam9n12: use slow clock where necessary
  ARM: at91/dt: at91sam9rl: use slow clock where necessary
  ARM: at91/dt: at91sam9x5: use slow clock where necessary
  ARM: at91/dt: sama5d3: use slow clock where necessary
  ARM: at91/dt: sama5d4: use slow clock where necessary
  rtc: at91rm9200: get and use slow clock
  watchdog: at91sam9: get and use slow clock
  power/reset: at91-reset: remove useless at91_reset_platform_probe()
  power/reset: at91-reset: get and use slow clock
  power/reset: at91-poweroff: get and use slow clock
  clocksource: atmel-st: get and use slow clock
  clk: at91: Revert "keep slow clk enabled to prevent system hang"

 .../devicetree/bindings/arm/atmel-at91.txt         | 11 +++--
 .../bindings/rtc/atmel,at91rm9200-rtc.txt          |  2 +
 .../devicetree/bindings/watchdog/atmel-wdt.txt     |  2 +
 arch/arm/boot/dts/at91rm9200.dtsi                  |  2 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |  3 ++
 arch/arm/boot/dts/at91sam9261.dtsi                 |  3 ++
 arch/arm/boot/dts/at91sam9263.dtsi                 |  3 ++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  4 ++
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  4 ++
 arch/arm/boot/dts/at91sam9rl.dtsi                  |  4 ++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  4 ++
 arch/arm/boot/dts/sama5d3.dtsi                     |  4 ++
 arch/arm/boot/dts/sama5d4.dtsi                     |  4 ++
 drivers/clk/at91/clk-slow.c                        | 27 -------------
 drivers/clocksource/timer-atmel-st.c               | 31 +++++++++-----
 drivers/power/reset/at91-poweroff.c                | 13 ++++++
 drivers/power/reset/at91-reset.c                   | 47 ++++++----------------
 drivers/rtc/rtc-at91rm9200.c                       | 27 +++++++++++--
 drivers/watchdog/at91sam9_wdt.c                    | 22 +++++++++-
 19 files changed, 138 insertions(+), 79 deletions(-)

-- 
2.1.4

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
