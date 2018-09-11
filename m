Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34142 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeIKRiU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 11 Sep 2018 13:38:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id g33-v6so25927137wrd.1
        for <linux-rtc@vger.kernel.org>; Tue, 11 Sep 2018 05:39:10 -0700 (PDT)
Date: Tue, 11 Sep 2018 13:39:07 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Tony Xie <tony.xie@rock-chips.com>
Cc: heiko@sntech.de, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v4 1/5] mfd: rk808: Add RK817 and RK809 support
Message-ID: <20180911123907.GN4185@dell>
References: <1535968829-19418-1-git-send-email-tony.xie@rock-chips.com>
 <1535968829-19418-2-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1535968829-19418-2-git-send-email-tony.xie@rock-chips.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, 03 Sep 2018, Tony Xie wrote:

>     The rk809 and rk817 are a Power Management IC (PMIC) for multimedia
>     and handheld devices. It contains the following components:
> 
>         - Regulators
>         - RTC
>         - Clocking
> 
>     Both RK809 and RK817 chips are using a similar register map,
>     so we can reuse the RTC and Clocking and regulators functionality.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> ---

It's often helpful to place a Changelog in this space.

>  drivers/mfd/Kconfig       |   6 +-
>  drivers/mfd/rk808.c       | 218 +++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/rk808.h | 172 ++++++++++++++++++++++++++++++++++++
>  kernel/reboot.c           |   1 +
>  4 files changed, 391 insertions(+), 6 deletions(-)

I just reviewed v4.

It looks like the review comments are still relevant.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
