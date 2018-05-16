Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:58997 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeEPUcl (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 16 May 2018 16:32:41 -0400
Date: Wed, 16 May 2018 22:32:40 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] rtc: stm32: add stm32mp1 rtc support
Message-ID: <20180516203240.GB24496@piout.net>
References: <1525880770-22263-1-git-send-email-amelie.delaunay@st.com>
 <1525880770-22263-4-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525880770-22263-4-git-send-email-amelie.delaunay@st.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 09/05/2018 17:46:10+0200, Amelie Delaunay wrote:
>  struct stm32_rtc_registers {
> @@ -86,6 +98,9 @@ struct stm32_rtc_registers {
>  	u8 prer;
>  	u8 alrmar;
>  	u8 wpr;
> +	u8 sr;
> +	u8 scr;
> +	u16 verr;

All those offsets should probably be u16 or u32...

> +	if (regs.verr != UNDEF_REG) {

...else, this is not working, as reported by kbuild

> +		u32 ver = readl_relaxed(rtc->base + regs.verr);
> +
> +		dev_info(&pdev->dev, "registered rev:%d.%d\n",
> +			 (ver >> STM32_RTC_VERR_MAJREV_SHIFT) & 0xF,
> +			 (ver >> STM32_RTC_VERR_MINREV_SHIFT) & 0xF);
> +	}
> +

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
