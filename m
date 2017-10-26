Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27132 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932285AbdJZI1V (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 26 Oct 2017 04:27:21 -0400
Date: Thu, 26 Oct 2017 17:27:44 +0900
From: Andi Shyti <andi.shyti@samsung.com>
To: Chen Zhong <chen.zhong@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v5 5/6] input: Add MediaTek PMIC keys support
Message-id: <20171026082744.GA29398@gangnam>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
In-reply-to: <1506509048-19032-6-git-send-email-chen.zhong@mediatek.com>
References: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
        <CGME20170927104421epcas2p190d03c1c6759f394debfc01b23641ece@epcas2p1.samsung.com>
        <1506509048-19032-6-git-send-email-chen.zhong@mediatek.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On Wed, Sep 27, 2017 at 06:44:07PM +0800, Chen Zhong wrote:
> This patch add support to handle MediaTek PMIC MT6397/MT6323 key
> interrupts including pwrkey and homekey, also add setting for
> long press key shutdown behavior.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>

if you want you can add:

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Andi
