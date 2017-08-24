Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBSVT7LGAKGQENGNY35A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 74si406697wmf.8.2017.08.24.02.18.01
        for <rtc-linux@googlegroups.com>;
        Thu, 24 Aug 2017 02:18:01 -0700 (PDT)
Date: Thu, 24 Aug 2017 11:17:50 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joseph Chen <chenjh@rock-chips.com>
Cc: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com,
	lee.jones@linaro.org, linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, broonie@kernel.org,
	zhangqing@rock-chips.com, robh+dt@kernel.org, lgirdwood@gmail.com,
	linux-rockchip@lists.infradead.org, wdc@rock-chips.com,
	tony.xie@rock-chips.com, linux-input@vger.kernel.org,
	mark.rutland@arm.com, w.egorov@phytec.de, linux-clk@vger.kernel.org,
	a.zummo@towertech.it, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [RESEND v9 06/12] rtc: Kconfig: Name RK805 in Kconfig
 for RTC_DRV_RK808
Message-ID: <20170824091750.yoo5wzg77ftt2wyt@piout.net>
References: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
 <1502848835-24800-1-git-send-email-chenjh@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <1502848835-24800-1-git-send-email-chenjh@rock-chips.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 16/08/2017 at 10:00:35 +0800, Joseph Chen wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> The RK808 and RK805 PMICs are using a similar register map.
> We can reuse the rtc driver for the RK805 PMIC. So let's add
> the RK805 in the Kconfig description.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
> ---
>  drivers/rtc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
