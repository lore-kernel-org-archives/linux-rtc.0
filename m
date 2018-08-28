Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38401 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2Cd6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 28 Aug 2018 22:33:58 -0400
Date: Tue, 28 Aug 2018 17:40:09 -0500
From: Rob Herring <robh@kernel.org>
To: Tony Xie <tony.xie@rock-chips.com>
Cc: heiko@sntech.de, broonie@kernel.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com
Subject: Re: [PATCH v3 3/5] dt-bindings: mfd: rk808: Add binding information
 for RK809 and RK817.
Message-ID: <20180828224009.GA25643@bogus>
References: <1535081441-20718-1-git-send-email-tony.xie@rock-chips.com>
 <1535081441-20718-4-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1535081441-20718-4-git-send-email-tony.xie@rock-chips.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, 24 Aug 2018 11:30:39 +0800, Tony Xie wrote:
> Add device tree bindings documentation for Rockchip's RK809 & RK817 PMIC.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/mfd/rk808.txt | 56 +++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
