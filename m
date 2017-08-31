Return-Path: <rtc-linux+bncBDHZXHXDRAMBBQ5TULGQKGQEME5WDDY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.codeaurora.org (smtp.codeaurora.org. [198.145.29.96])
        by gmr-mx.google.com with ESMTPS id g79si331594ita.0.2017.08.31.16.20.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Aug 2017 16:20:34 -0700 (PDT)
Date: Thu, 31 Aug 2017 16:20:32 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Joseph Chen <chenjh@rock-chips.com>
Cc: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com,
	lee.jones@linaro.org, linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, broonie@kernel.org,
	zhangqing@rock-chips.com, robh+dt@kernel.org, lgirdwood@gmail.com,
	linux-rockchip@lists.infradead.org, wdc@rock-chips.com,
	tony.xie@rock-chips.com, linux-input@vger.kernel.org,
	mark.rutland@arm.com, w.egorov@phytec.de, linux-clk@vger.kernel.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [RESEND v9 05/12] clk: Kconfig: Name RK805 in Kconfig
 for COMMON_CLK_RK808
Message-ID: <20170831232032.GI21656@codeaurora.org>
References: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
 <1502848803-22954-1-git-send-email-chenjh@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <1502848803-22954-1-git-send-email-chenjh@rock-chips.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 08/16, Joseph Chen wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> The RK808 and RK805 PMICs are using a similar register map.
> We can reuse the clk driver for the RK805 PMIC. So let's add
> the RK805 in the Kconfig description.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
