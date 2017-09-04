Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753997AbdIDWxt (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 4 Sep 2017 18:53:49 -0400
From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>,
        =?UTF-8?q?=E8=92=8B=E4=B8=BD=E7=90=B4?= <jiang.liqin@geniatech.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4 0/3] arm64: Realtek RTD1295 RTC
Date: Tue,  5 Sep 2017 00:53:21 +0200
Message-Id: <20170904225324.29138-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hello,

This series adds the RTC for the Realtek RTD1295 SoC.
Based on my RTD1295 clk series.

There being no public source code for RTD1295, the implementation is based on
register offsets seen in the vendor DT, as well as older mach-rtk119x code
published by QNAP.

v4 adds a missing clk_put().

The DT node depends on the clk series for clock index and header.

More experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

v3 -> v4:
* Added clk_put() (Alexandre)

v2 -> v3:
* Dropped spinlock (Andrew)
* Improved year_days vs. days_in_year readability

v1 -> v2:
* Updated rtc driver to no longer use open/release (Alexandre)
* Cleaned up debug output (Andrew)
* Avoided COMPILE_TEST division errors (kbuild)
* Various cleanups and extensions

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
Cc: Roc He <hepeng@zidoo.tv>
Cc: 蒋丽琴 <jiang.liqin@geniatech.com>
Cc: devicetree@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>

Andreas Färber (3):
  dt-bindings: rtc: Add Realtek RTD1295
  rtc: Add Realtek RTD1295
  arm64: dts: realtek: Add RTD1295 RTC node

 .../devicetree/bindings/rtc/realtek,rtd119x.txt    |  16 ++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |   6 +
 drivers/rtc/Kconfig                                |   8 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-rtd119x.c                          | 242 +++++++++++++++++++++
 5 files changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt
 create mode 100644 drivers/rtc/rtc-rtd119x.c

-- 
2.13.5
