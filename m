Return-Path: <rtc-linux+bncBDSJBYGBRIMBB7F3S7CAKGQEAJCIDWY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id c129si565325wme.1.2017.01.23.02.42.03
        for <rtc-linux@googlegroups.com>;
        Mon, 23 Jan 2017 02:42:03 -0800 (PST)
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [rtc-linux] [PATCH v2 0/7] rtc: sun6i: Fix the RTC accuracy
Date: Mon, 23 Jan 2017 11:41:45 +0100
Message-Id: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

The RTC used in the A31 and later SoC has an accuracy issue, which is
already significant even after a couple of hours.

This is due to the fact that the oscillator used by default is an internal
and very inaccurate one.

A first attempt at fixing that by switching to the external oscillator was
done in the patch "rtc: sun6i: Switch to the external oscillator". However,
it turned out to be problematic since it was tracked properly in the clock
framework, which might lead to some clocks being disabled, even though
their devices were not notified.

This is a second attempt, this time by making it part of the CCF. It
turned out to be a bit more complicated than one would expect since the mux
found inside the RTC also controls one of the input of the main clock unit.
Therefore, it needs to be probed before the main clock unit driver.

Let me know what you think,
Maxime

Changes from v1:
  - Force the muxing to the external oscillator even for old DT
  - Make the patches a bit more stable friendly
  - Change the bindings to have a cell of 1, to account for the external
    output of the oscillator
  - Split the driver remove() removal into a separate patch and switched to
    devm
  - Reordered the patches

Maxime Ripard (7):
  rtc: sun6i: Disable the build as a module
  rtc: sun6i: Add some locking
  rtc: sun6i: Switch to the external oscillator
  rtc: sun6i: Expose the 32kHz oscillator
  rtc: sun6i: Switch to devm_rtc_device_register
  ARM: sun8i: a23/a33: Enable the real LOSC and use it
  ARM: sun8i: a23/a33: Add the oscillators accuracy

 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt |  10 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                |  15 +-
 drivers/rtc/Kconfig                                 |   2 +-
 drivers/rtc/rtc-sun6i.c                             | 182 ++++++++++---
 4 files changed, 174 insertions(+), 35 deletions(-)

base-commit: 99cef370ac9939df2aeb16c96d07e842b2fa8201
-- 
git-series 0.8.11

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
