Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.139]:38332 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755101AbeCHKWV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Mar 2018 05:22:21 -0500
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, broonie@kernel.org
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-rtc@vger.kernel.org,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        linux-clk@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/4] Set name of regmap_config
Date: Thu,  8 Mar 2018 18:21:50 +0800
Message-Id: <20180308102154.25686-1-jeffy.chen@rock-chips.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


After 9b947a13e7f6 ("regmap: use debugfs even when no device"), we are
allowing regmap to create debugfs without a valid device. Some of them
would end up using "dummy*" as debugfs name.

This series try to set names in some regmap_config to avoid that.


Changes in v3:
Modify commit message.

Jeffy Chen (4):
  mfd: syscon: Set name of regmap_config
  rtc: at91sam9: Pass pdev->dev to regmap_init_mmio()
  clk: lpc32xx: Set name of regmap_config
  ARM: rockchip: Set name of regmap_config

 arch/arm/mach-rockchip/platsmp.c | 1 +
 drivers/clk/nxp/clk-lpc32xx.c    | 1 +
 drivers/mfd/syscon.c             | 1 +
 drivers/rtc/rtc-at91sam9.c       | 2 +-
 4 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.11.0
