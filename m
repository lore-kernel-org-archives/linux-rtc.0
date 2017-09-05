Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:37120 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbdIEHhQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 5 Sep 2017 03:37:16 -0400
Received: by mail-wr0-f180.google.com with SMTP id n33so6522771wrn.4
        for <linux-rtc@vger.kernel.org>; Tue, 05 Sep 2017 00:37:15 -0700 (PDT)
Date: Tue, 5 Sep 2017 08:37:11 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Chen Zhong <chen.zhong@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Andi Shyti <andi.shyti@samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 5/5] mfd: mt6397: Add PMIC keys support to MT6397
 driver
Message-ID: <20170905073711.vj75nniqg2ajkoeg@dell>
References: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
 <1503642753-12385-6-git-send-email-chen.zhong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1503642753-12385-6-git-send-email-chen.zhong@mediatek.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, 25 Aug 2017, Chen Zhong wrote:

> This patch adds compatible strings and interrupts for pmic keys
> which serves as child device of MFD.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c |   22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
