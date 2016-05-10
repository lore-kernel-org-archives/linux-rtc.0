Return-Path: <rtc-linux+bncBAABB257Y64QKGQEOZ3NYJA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.x-arc.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id e78si75364wmc.3.2016.05.10.06.19.39
        for <rtc-linux@googlegroups.com>;
        Tue, 10 May 2016 06:19:39 -0700 (PDT)
From: Wadim Egorov <w.egorov@phytec.de>
To: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
Subject: [rtc-linux] [PATCH v5 0/6] Add support for rk818
Date: Tue, 10 May 2016 15:18:54 +0200
Message-Id: <1462886340-7893-1-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello,

patches are based on top of

commit d5623161accb ("mfd: rk808: Use devm_mfd_add_devices() for mfd_device registration")

in linux-next.

Changes since v4:
- Added Acked-by from Mark Brown in patch 1
- Dropped a patch from this series which was applied by Mark Brown
  commit 129d7cf98f5c ("regulator: rk808: Add rk808_reg_ops_ranges for LDO3")

Wadim Egorov (6):
  regulator: rk808: Migrate to regulator core's simplified DT parsing
    code
  mfd: RK808: Add RK818 support
  regulator: rk808: Add regulator driver for RK818
  mfd: dt-bindings: Add RK818 device tree bindings document
  clk: Kconfig: Name RK818 in Kconfig for COMMON_CLK_RK808
  rtc: Kconfig: Name RK818 in Kconfig for RTC_DRV_RK808

 Documentation/devicetree/bindings/mfd/rk808.txt |  37 ++-
 drivers/clk/Kconfig                             |   4 +-
 drivers/mfd/Kconfig                             |   4 +-
 drivers/mfd/rk808.c                             | 231 ++++++++++++---
 drivers/regulator/Kconfig                       |   4 +-
 drivers/regulator/rk808-regulator.c             | 363 +++++++++++++-----------
 drivers/rtc/Kconfig                             |   4 +-
 include/linux/mfd/rk808.h                       | 162 ++++++++++-
 8 files changed, 590 insertions(+), 219 deletions(-)

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
