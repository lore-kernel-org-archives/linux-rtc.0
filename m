Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:14639 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdH2Hew (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 29 Aug 2017 03:34:52 -0400
Date: Tue, 29 Aug 2017 16:34:53 +0900
From: Andi Shyti <andi.shyti@samsung.com>
To: Chen Zhong <chen.zhong@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 4/5] input: Add MediaTek PMIC keys support
Message-id: <20170829073453.GB4469@gangnam>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
In-reply-to: <1503642753-12385-5-git-send-email-chen.zhong@mediatek.com>
References: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
        <CGME20170825063247epcas5p1df2f4440010dd55dada66e8764d18e50@epcas5p1.samsung.com>
        <1503642753-12385-5-git-send-email-chen.zhong@mediatek.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Chen,

what I would ask you is to be consistent with the naming, if your
driver is called mtk-pmic, then all your functions and global
variables should be named accordingly as mtk_pmic or MTK_PMIC.
Please check in between the lines for real examples:

> +#define PWRKEY_RST_EN_MASK	0x1
> +#define PWRKEY_RST_EN_SHIFT	6
> +#define HOMEKEY_RST_EN_MASK	0x1
> +#define HOMEKEY_RST_EN_SHIFT	5
> +#define RST_DU_MASK		0x3
> +#define RST_DU_SHIFT		8
> +
> +#define PMIC_PWRKEY_INDEX	0
> +#define PMIC_HOMEKEY_INDEX	1
> +#define PMIC_MAX_KEY_COUNT	2

#define MTK_PMIC_*

> +struct pmic_keys_regs {

struct mtk_pmic_keys_regs

> +	u32 deb_reg;
> +	u32 deb_mask;
> +	u32 intsel_reg;
> +	u32 intsel_mask;
> +};
> +
> +#define PMIC_KEYS_REGS(_deb_reg, _deb_mask, _intsel_reg, _intsel_mask)	\

MTK_PMIC_KEYS_REGS

> +{									\
> +	.deb_reg		= _deb_reg,				\
> +	.deb_mask		= _deb_mask,				\
> +	.intsel_reg		= _intsel_reg,				\
> +	.intsel_mask		= _intsel_mask,				\
> +}
> +
> +struct pmic_regs {

mtk_pmic_regs

and so on... you got the point.

Andi
