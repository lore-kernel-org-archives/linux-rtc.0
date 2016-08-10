Return-Path: <rtc-linux+bncBAABBF65VO6QKGQE7LLC4KA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.visioncatalog.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id o85si422471wme.0.2016.08.10.02.06.31
        for <rtc-linux@googlegroups.com>;
        Wed, 10 Aug 2016 02:06:31 -0700 (PDT)
From: Wadim Egorov <w.egorov@phytec.de>
To: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: dianders@chromium.org, zyw@rock-chips.com, robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Subject: [rtc-linux] [PATCH v7 0/4] Add support for rk818
Date: Wed, 10 Aug 2016 11:05:03 +0200
Message-Id: <1470819907-11237-1-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Changes since v6:
- Dropped a patch from this series which was applied by Michael Turquette
  commit cb98fd5d4da1 ("clk: Kconfig: Name RK818 in Kconfig for COMMON_CLK_RK808")
- Squashed patch
  mfd: RK808: Fetch PMIC variant from chip id register
  into the first patch.

Wadim Egorov (4):
  mfd: RK808: Add RK818 support
  regulator: rk808: Add regulator driver for RK818
  mfd: dt-bindings: Add RK818 device tree bindings document
  rtc: Kconfig: Name RK818 in Kconfig for RTC_DRV_RK808

 Documentation/devicetree/bindings/mfd/rk808.txt |  37 +++-
 drivers/mfd/Kconfig                             |   4 +-
 drivers/mfd/rk808.c                             | 226 ++++++++++++++++++++----
 drivers/regulator/Kconfig                       |   4 +-
 drivers/regulator/rk808-regulator.c             | 143 ++++++++++++++-
 drivers/rtc/Kconfig                             |   4 +-
 include/linux/mfd/rk808.h                       | 154 +++++++++++++++-
 7 files changed, 516 insertions(+), 56 deletions(-)

-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
