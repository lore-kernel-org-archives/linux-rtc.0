Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:35577 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdIEHhC (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 5 Sep 2017 03:37:02 -0400
Received: by mail-wr0-f173.google.com with SMTP id y15so6582834wrc.2
        for <linux-rtc@vger.kernel.org>; Tue, 05 Sep 2017 00:37:02 -0700 (PDT)
Date: Tue, 5 Sep 2017 08:36:58 +0100
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
Subject: Re: [PATCH v3 3/5] dt-bindings: mfd: Add bindings for the keys as
 subnode of PMIC
Message-ID: <20170905073658.dwlbsyqtl3ei7e4s@dell>
References: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
 <1503642753-12385-4-git-send-email-chen.zhong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1503642753-12385-4-git-send-email-chen.zhong@mediatek.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, 25 Aug 2017, Chen Zhong wrote:

> This patch adds documentation for device tree bindings for keys support
> as the subnode of MT6397/MT6323 PMIC.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt |    6 ++++++
>  1 file changed, 6 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
