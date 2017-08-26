Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:37749 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751662AbdHZCar (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Aug 2017 22:30:47 -0400
Message-ID: <1503714639.3340.14.camel@mhfsdcap03>
Subject: Re: [PATCH v3 0/5] Add MediaTek PMIC keys support
From: Chen Zhong <chen.zhong@mediatek.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Andi Shyti <andi.shyti@samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>
Date: Sat, 26 Aug 2017 10:30:39 +0800
In-Reply-To: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
References: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Sorry for missing the change history.

Changes since v2:
- use standard properties for keycodes and debounce time
- change to use platform_get_irq in leaf drivers
- use better ways to define IRQ resources

Changes since v1:
- create irq mappings in mfd core driver instead of leaf drivers
- remove some unused parts in mtk-pmic-keys driver

On Fri, 2017-08-25 at 14:32 +0800, Chen Zhong wrote:
> MediaTek PMIC are multi-function devices that can handle key interrupts,
> typically there are two keys attached to PMIC, which called pwrkey
> and homekey. PWRKEY usually used to wake up system from sleep. Homekey
> can used as volume down key due to board design. Long press keys can
> shutdown PMIC, the mode can be choose to be one key only or two keys
> together.
> This series add support for key functions for MediaTek PMIC MT6397/MT6323.
> 
> Chen Zhong (5):
>   mfd: mt6397: create irq mappings in mfd core driver
>   dt-bindings: input: Add document bindings for mtk-pmic-keys
>   dt-bindings: mfd: Add bindings for the keys as subnode of PMIC
>   input: Add MediaTek PMIC keys support
>   mfd: mt6397: Add PMIC keys support to MT6397 driver
> 
>  .../devicetree/bindings/input/mtk-pmic-keys.txt    |  38 +++
>  Documentation/devicetree/bindings/mfd/mt6397.txt   |   6 +
>  drivers/input/keyboard/Kconfig                     |   9 +
>  drivers/input/keyboard/Makefile                    |   1 +
>  drivers/input/keyboard/mtk-pmic-keys.c             | 308 +++++++++++++++++++++
>  drivers/mfd/mt6397-core.c                          |  26 +-
>  drivers/rtc/rtc-mt6397.c                           |   7 +-
>  7 files changed, 388 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
>  create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c
> 
