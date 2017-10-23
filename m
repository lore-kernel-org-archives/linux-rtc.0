Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:41430 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750756AbdJWHQz (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 23 Oct 2017 03:16:55 -0400
From: <sean.wang@mediatek.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v3 0/4] rtc: mediatek: add support for SoC based RTC on MT7622
Date: Mon, 23 Oct 2017 15:16:43 +0800
Message-ID: <cover.1508741262.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Changes since v2:
- Remove time extension with yr_base 
- Add fixup that ensures all time fields in hardware keeping consistency
inside the mtk_rtc_get_alarm_or_time call
- Add validity for time range should be between 2001 to 2099
- Enhance comments with aligned style and explanation for certain limiation in
hardware
- Rename dt-binding naming from rtc-mediatek.txt to rtc-mt7622.txt
- Rename config naming from RTC_DRV_MEDIATEK to RTC_DRV_MT7622

Changes since v1:
- Rename to rtc-mt7622.c from rtc-mediatek.c
- Use [readl,writel]_relaxed instead of __raw_* version
- Remove redundant register reading in mtk_rtc_get_alarm_or_time()
- Stop alarm when alarm is really expired in mtk_rtc_alarmirq()
- Extend the maximum year the RTC/Alarm can count/support using year rebasing
- Remove unnesscary log which is already done in core layer

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

 .../devicetree/bindings/rtc/rtc-mt7622.txt         |  21 +
 MAINTAINERS                                        |   3 +
 drivers/rtc/Kconfig                                |  18 +-
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-mt7622.c                           | 422 +++++++++++++++++++++
 5 files changed, 461 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt7622.txt
 create mode 100644 drivers/rtc/rtc-mt7622.c

-- 
2.7.4
