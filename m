Return-Path: <rtc-linux+bncBCMILY6JWQBBBXED2W5QKGQE5DDVACY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from wens.csie.org (mirror2.csie.ntu.edu.tw. [140.112.30.76])
        by gmr-mx.google.com with ESMTPS id c11si800037pfc.2.2016.06.30.08.59.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2016 08:59:24 -0700 (PDT)
From: Chen-Yu Tsai <wens@csie.org>
To: Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v4 0/7] mfd: ac100: Add support for X-Powers AC100
 audio codec / RTC combo IC
Date: Thu, 30 Jun 2016 23:58:44 +0800
Message-Id: <1467302331-9663-1-git-send-email-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi everyone,

This series adds support for X-Powers' AC100 audio codec / RTC combo IC.
This chip is found on Allwinner A80 SoC based boards, and is also part
of the AXP813/AXP818 PMIC found with Allwinner A83T SoCs.

The series focuses on the RTC side of the chip. The audio codec will
be done later, once the digital audio interface of the SoC is supported.

Changes since v3:

  - bulk write support for regmaps without raw formatting patch merged
    and thus dropped from series.

  - sun9i device node re-ordering patches merged and thus dropped from
    series.

  - Fixed device node name and added labels to device tree binding example.

  - Moved 4M_adda clock to codec side, and added clock bindings to codec
    node.

  - Rename RTC clock output related prefixes from clk32k to clkout.

  - Rename default clock output names to cko{1,2,3}-rtc.

  - Move struct tm to/from RTC conversion offsets inline with reg[]
    assignments

  - Drop separate mutex and use rtc->ops_lock in interrupt handler.

  - Use platform_get_irq instead of of_get_irq.

  - Add struct of_device_id and .of_match_table to RTC driver.

Changes since v2:

  - Fix ac100_codec interrupt line in DT binding example.

  - Fix copy-paste errors in RTC set_alarm. Alarm now works.

  - Drop file name from MFD driver.

  - Add / update copyright notices.

  - Change license of RTC driver to GPL v2, matching MFD driver.

  - Fix MFD driver MODULE_LICENSE to match license declaration in header.

Changes since v1:

  - Complete register definitions and regmap regions.

v1 was actually a working version that wasn't updated with the codec
register definitions.

Patch 1 adds device tree bindings for the AC100.

Patch 2 adds the mfd driver for the AC100.

Patch 3 adds the RTC driver for the AC100.

Patch 4 adds RTC clk output support to the RTC driver.
This is a separate patch as the clk code is over 300 LoC. Having a
separate patch should make it easier for the clk maintainers to review.

Patch 5 adds the AC100 device nodes to the A80 Optimus board dts.

Patch 6 adds the AC100 device nodes to the Cubieboard4 board dts.

Patch 7 changes the fixed osc_32k clk to a fixed factor clk,
representing the 32k clk input pin on the SoC, and also hooks up the
ac100 rtc clk output to this clk in the board dts files.

I'm hoping we can merge the driver bits (patches 1~4) through the
mfd tree, with acks from the rtc and clk maintainers for patches
3 and 4.


Regards
ChenYu


Chen-Yu Tsai (7):
  mfd: ac100: Add device tree bindings for X-Powers AC100 codec/RTC
    combo IC
  mfd: ac100: Add driver for X-Powers AC100 audio codec / RTC combo IC
  rtc: ac100: Add RTC driver for X-Powers AC100
  rtc: ac100: Add clk output support
  ARM: dts: sun9i: a80-optimus: Add device node for AC100
  ARM: dts: sun9i: cubieboard4: Add device node for AC100
  ARM: dts: sun9i: Switch to the AC100 RTC clock outputs for osc32k

 Documentation/devicetree/bindings/mfd/ac100.txt |  49 ++
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts     |  29 ++
 arch/arm/boot/dts/sun9i-a80-optimus.dts         |  29 ++
 arch/arm/boot/dts/sun9i-a80.dtsi                |   9 +-
 drivers/mfd/Kconfig                             |  10 +
 drivers/mfd/Makefile                            |   2 +
 drivers/mfd/ac100.c                             | 137 ++++++
 drivers/rtc/Kconfig                             |  10 +
 drivers/rtc/Makefile                            |   1 +
 drivers/rtc/rtc-ac100.c                         | 627 ++++++++++++++++++++++++
 include/linux/mfd/ac100.h                       | 178 +++++++
 11 files changed, 1075 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt
 create mode 100644 drivers/mfd/ac100.c
 create mode 100644 drivers/rtc/rtc-ac100.c
 create mode 100644 include/linux/mfd/ac100.h

-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
