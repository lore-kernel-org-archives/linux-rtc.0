Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389694AbeHARFH (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 1 Aug 2018 13:05:07 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Tony Xie <tony.xie@rock-chips.com>, heiko@sntech.de
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1533024029-30273-1-git-send-email-tony.xie@rock-chips.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, tony.xie@rock-chips.com,
        huangtao@rock-chips.com, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, linux-kernel@vger.kernel.org,
        xsf@rock-chips.com, linux-rockchip@lists.infradead.org,
        broonie@kernel.org, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chenjh@rock-chips.com
References: <1533023850-29004-1-git-send-email-tony.xie@rock-chips.com>
 <1533024029-30273-1-git-send-email-tony.xie@rock-chips.com>
Message-ID: <153313673531.17365.8764698693425766723@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v2 5/5] clk: RK808: add RK809 and RK817 support.
Date: Wed, 01 Aug 2018 08:18:55 -0700
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Quoting Tony Xie (2018-07-31 01:00:29)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 721572a..fc1427c 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -46,11 +46,11 @@ config COMMON_CLK_MAX77686
>           clock.
>  =

>  config COMMON_CLK_RK808
> -       tristate "Clock driver for RK805/RK808/RK818"
> +       tristate "Clock driver for RK805/RK808/RK809/RK817/RK818"
>         depends on MFD_RK808
>         ---help---
> -         This driver supports RK805, RK808 and RK818 crystal oscillator =
clock. These
> -         multi-function devices have two fixed-rate oscillators,
> +         This driver supports RK805, RK809 and RK817, RK808 and RK818 cr=
ystal oscillator clock.
> +          These multi-function devices have two fixed-rate oscillators,

Something got messed up with the indentation here. Please fix.

>           clocked at 32KHz each. Clkout1 is always on, Clkout2 can off
>           by control register.
> =20
