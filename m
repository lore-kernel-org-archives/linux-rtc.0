Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:21202 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751788AbdIVDdZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 21 Sep 2017 23:33:25 -0400
From: <sean.wang@mediatek.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 0/4] rtc: mediatek: add support for SoC based RTC on MT7622
Date: Fri, 22 Sep 2017 11:33:13 +0800
Message-ID: <cover.1506049341.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

This patchset introduces support for MediaTek SoC based real time clock
(RTC) Currently, the driver is already tested successfully with hwclock
and wakealarm on MT7622 SoC. And it should also be workable on other
similar MediaTek SoCs. And patch 3 is a distinct patch used to distinguish
between either SoC based or PMIC based RTC to avoid confusion for the RTC
selection for the target SoC.

Sean Wang (4):
  dt-bindings: rtc: mediatek: add bindings for MediaTek SoC based RTC
  rtc: mediatek: add driver for RTC on MT7622 SoC
  rtc: mediatek: enhance the description for MediaTek PMIC based RTC
  rtc: mediatek: update MAINTAINERS entry with MediaTek RTC driver

 .../devicetree/bindings/rtc/rtc-mediatek.txt       |  21 ++
 MAINTAINERS                                        |   3 +
 drivers/rtc/Kconfig                                |  18 +-
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-mediatek.c                         | 398 +++++++++++++++++++++
 5 files changed, 437 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mediatek.txt
 create mode 100644 drivers/rtc/rtc-mediatek.c

-- 
2.7.4
