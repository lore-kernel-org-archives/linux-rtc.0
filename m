Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36103 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdJEWW0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 Oct 2017 18:22:26 -0400
Date: Thu, 5 Oct 2017 17:22:24 -0500
From: Rob Herring <robh@kernel.org>
To: Chen Zhong <chen.zhong@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        Andi Shyti <andi.shyti@samsung.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v5 2/6] dt-bindings: input: Add common keyboard document
 bindings
Message-ID: <20171005222224.ffeewebacx7bljx2@rob-hp-laptop>
References: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
 <1506509048-19032-3-git-send-email-chen.zhong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506509048-19032-3-git-send-email-chen.zhong@mediatek.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Sep 27, 2017 at 06:44:04PM +0800, Chen Zhong wrote:
> This patch adds the device tree binding documentation for common
> keyboard.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> ---
>  Documentation/devicetree/bindings/input/keys.txt |    8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/keys.txt

Acked-by: Rob Herring <robh@kernel.org>
