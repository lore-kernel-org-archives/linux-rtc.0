Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:57848 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751396AbdHGB5w (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 6 Aug 2017 21:57:52 -0400
From: Chen Zhong <chen.zhong@mediatek.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Beomho Seo <beomho.seo@samsung.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>
Subject: [PATCH v2 0/5] Add MediaTek PMIC keys support
Date: Mon, 7 Aug 2017 09:57:40 +0800
Message-ID: <1502071065-6745-1-git-send-email-chen.zhong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

MediaTek PMIC are multi-function devices that can handle key interrupts,
typically there are two keys attached to PMIC, which called pwrkey
and homekey. PWRKEY usually used to wake up system from sleep. Homekey
can used as volume down key due to board design. Long press keys can
shutdown PMIC, the mode can be choose to be one key only or two keys
together.

This series add support for key functions for MediaTek PMIC MT6397/MT6323.

Chen Zhong (5):
  mfd: mt6397: create irq mappings in mfd core driver
  dt-bindings: input: Add document bindings for mtk-pmic-keys
  dt-bindings: mfd: Add bindings for the keys as subnode of PMIC
  input: Add MediaTek PMIC keys support
  mfd: mt6397: Add PMIC keys support to MT6397 driver

 .../devicetree/bindings/input/mtk-pmic-keys.txt    |   36 +++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |    6 +
 drivers/input/keyboard/Kconfig                     |    9 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/mtk-pmic-keys.c             |  331 ++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |   40 ++-
 drivers/rtc/rtc-mt6397.c                           |    2 +-
 7 files changed, 421 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
 create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c

-- 
1.7.9.5
 
