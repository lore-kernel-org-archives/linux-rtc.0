Return-Path: <rtc-linux+bncBDSJBYGBRIMBBQXGRDCAKGQEN255DQQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 133si220577wmj.1.2017.01.20.07.56.49
        for <rtc-linux@googlegroups.com>;
        Fri, 20 Jan 2017 07:56:49 -0800 (PST)
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [rtc-linux] [PATCH 0/6] rtc: sun6i: Fix the RTC accuracy
Date: Fri, 20 Jan 2017 16:56:37 +0100
Message-Id: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
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

Maxime Ripard (6):
  rtc: sun6i: Expose the 32kHz oscillator
  rtc: sun6i: Add some locking
  rtc: sun6i: Disable the build as a module
  rtc: sun6i: Force the mux to the external oscillator
  ARM: sun8i: a23/a33: Enable the real LOSC and use it
  ARM: sun8i: a23/a33: Add the oscillators accuracy

 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt |   8 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                |  15 +-
 drivers/rtc/Kconfig                                 |   2 +-
 drivers/rtc/rtc-sun6i.c                             | 189 +++++++++++--
 4 files changed, 181 insertions(+), 33 deletions(-)

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
