Return-Path: <rtc-linux+bncBAABB2PEYK4AKGQEIIZ26JQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.rapiddevelopmentkit.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id s141si1048518wmd.1.2016.04.15.02.20.41
        for <rtc-linux@googlegroups.com>;
        Fri, 15 Apr 2016 02:20:41 -0700 (PDT)
From: Wadim Egorov <w.egorov@phytec.de>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, linux-rockchip@lists.infradead.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com, arnd@arndb.de, k.kozlowski@samsung.com, javier@osg.samsung.com, kgene@kernel.org, olof@lixom.net, geert+renesas@glider.be, sjoerd.simons@collabora.co.uk, treding@nvidia.com, public_timo.s@silentcreek.de
Subject: [rtc-linux] [PATCH 0/6] Add RK818 PMIC support
Date: Fri, 15 Apr 2016 11:16:24 +0200
Message-Id: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
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

I just renamed now the RK808 mfd and regulator drivers.

Patch 4 is a cosmetic patch for the regulator driver.

Unfortunately I have no hardware with a RK808 PMIC, so I can not test this part.

Regards,
Wadim


Changes since RFC:
* split up in more patches: renaming + adding new driver
* renamed rk808.c driver -> rk8xx.c
* renamed rk808-regulator.c driver -> rk8xx-regulator.c

Wadim Egorov (6):
  mfd: RK808: Make RK808 generic, rename rk808.c to rk8xx.c
  mfd: RK808: Add RK818 support
  regulator: rk808: Make rk808 generic, rename rk808-regulator.c
  regulator: rk8xx: Migrate to regulator core's simplified DT parsing
    code
  regulator: rk8xx: Add regulator driver for RK818
  mfd: dt-bindings: Add RK818 device tree bindings document

 Documentation/devicetree/bindings/mfd/rk808.txt    |  37 +-
 arch/arm/configs/multi_v7_defconfig                |   4 +-
 drivers/clk/Kconfig                                |   2 +-
 drivers/mfd/Kconfig                                |   6 +-
 drivers/mfd/Makefile                               |   2 +-
 drivers/mfd/rk808.c                                | 276 -------------
 drivers/mfd/rk8xx.c                                | 436 ++++++++++++++++++++
 drivers/regulator/Kconfig                          |   6 +-
 drivers/regulator/Makefile                         |   2 +-
 .../{rk808-regulator.c => rk8xx-regulator.c}       | 451 ++++++++++++---------
 drivers/rtc/Kconfig                                |   2 +-
 include/linux/mfd/rk808.h                          | 183 ++++++++-
 12 files changed, 906 insertions(+), 501 deletions(-)
 delete mode 100644 drivers/mfd/rk808.c
 create mode 100644 drivers/mfd/rk8xx.c
 rename drivers/regulator/{rk808-regulator.c => rk8xx-regulator.c} (57%)

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
