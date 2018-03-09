Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.140]:47944 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeCIBwM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Mar 2018 20:52:12 -0500
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, broonie@kernel.org,
        alexandre.belloni@bootlin.com
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-rtc@vger.kernel.org,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Stephen Boyd <sboyd@kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/4] Set name of regmap_config
Date: Fri,  9 Mar 2018 09:51:42 +0800
Message-Id: <20180309015146.8297-1-jeffy.chen@rock-chips.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


After 9b947a13e7f6 ("regmap: use debugfs even when no device"), we are
allowing regmap to create debugfs without a valid device. Some of them
would end up using "dummy*" as debugfs name.

This series try to set names in some regmap_config to avoid that.


Changes in v4:
Not to use rtc dev to init regmap, the gpbr is not directly related to
the rtc.

Changes in v3:
Modify commit message.

Jeffy Chen (4):
  mfd: syscon: Set name of regmap_config
  rtc: at91sam9: Set name of regmap_config
  clk: lpc32xx: Set name of regmap_config
  ARM: rockchip: Set name of regmap_config

 arch/arm/mach-rockchip/platsmp.c | 1 +
 drivers/clk/nxp/clk-lpc32xx.c    | 1 +
 drivers/mfd/syscon.c             | 1 +
 drivers/rtc/rtc-at91sam9.c       | 1 +
 4 files changed, 4 insertions(+)

-- 
2.11.0
