Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33181 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752499AbdHTBhc (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 19 Aug 2017 21:37:32 -0400
From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>,
        =?UTF-8?q?=E8=92=8B=E4=B8=BD=E7=90=B4?= <jiang.liqin@geniatech.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org
Subject: [RFC 0/3] arm64: Realtek RTD1295 RTC
Date: Sun, 20 Aug 2017 03:36:28 +0200
Message-Id: <20170820013632.18375-1-afaerber@suse.de>
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

The base year is hardcoded - probably should be a DT property like downstream?

The DT node depends on the clk series for clock index and header.

More experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
Cc: Roc He <hepeng@zidoo.tv>
Cc: 蒋丽琴 <jiang.liqin@geniatech.com>
Cc: devicetree@vger.kernel.org

Andreas Färber (3):
  dt-bindings: rtc: Add Realtek RTD1295
  rtc: Add Realtek RTD1295
  arm64: dts: realtek: Add RTD1295 RTC node

 .../devicetree/bindings/rtc/realtek,rtd119x.txt    |  16 ++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |   6 +
 drivers/rtc/Kconfig                                |   8 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-rtd119x.c                          | 175 +++++++++++++++++++++
 5 files changed, 206 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt
 create mode 100644 drivers/rtc/rtc-rtd119x.c

-- 
2.12.3
