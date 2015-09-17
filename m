Return-Path: <rtc-linux+bncBDHPTCWTXEHRBDE65KXQKGQEHRKUUCQ@googlegroups.com>
Received: from gloria.sntech.de (gloria.sntech.de. [95.129.55.99])
        by gmr-mx.google.com with ESMTPS id fg9si5557wib.0.2015.09.17.02.59.39
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 02:59:39 -0700 (PDT)
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Xing Zheng <zhengxing@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Alessandro Zummo <a.zummo@towertech.it>, devicetree@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, rtc-linux@googlegroups.com, Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v2 0/9] Build and support rk3036 SoC platform
Date: Thu, 17 Sep 2015 11:59:28 +0200
Message-ID: <5090899.2Tj4WpOV4G@diego>
In-Reply-To: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
References: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

Am Donnerstag, 17. September 2015, 16:28:51 schrieb Xing Zheng:
> we need to support rk3036 soc platform via upstream, there are
> 3 primary parts for the initial release of minimum system: dts,
> pinctrl, and clock tree for rk3036, and additional, add a rtc
> hym8563 patch to fix initial invaild, we can use these startup
> and run to init processs.
> 
> Thanks.
> 
> changed in v2:
> - based on v1, add clock controller documentation
> - enable timer5 startup
> - add smp for cpu1
> - initial set time for rtc-hym8563
> 
> changes since v1:
> - add dts, pinctrl and clock tree for rk3036 soc platform
> 
> The patchset (9):
> 9) rtc: hym8563: make sure hym8563 can be normal work
> 8) ARM: rockchip: add support smp for rk3036
> 7) rockchip: make sure timer5 is enabled on rk3036 platforms
> 6) pinctrl: rockchip: add support for the rk3036
> 5) dt-bindings: add documentation of rk3036 clock controller
> 4) clk: rockchip: add new clock type and controller for rk3036
> 3) clk: rockchip: add clock controller for rk3036
> 2) clk: rockchip: add dt-binding header for rk3036
> 1) ARM: dts: rockchip: add core rk3036 dts
> 
> 
> Changes in v2:
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> 
> Xing Zheng (9):
>   ARM: dts: rockchip: add core rk3036 dts
>   clk: rockchip: add dt-binding header for rk3036
>   clk: rockchip: add clock controller for rk3036
>   clk: rockchip: add new clock type and controller for rk3036
>   dt-bindings: add documentation of rk3036 clock controller
>   pinctrl: rockchip: add support for the rk3036
>   rockchip: make sure timer5 is enabled on rk3036 platforms
>   ARM: rockchip: add support smp for rk3036
>   rtc: hym8563: make sure hym8563 can be normal work

am I missing some patches? I only got patches 1-4.

Anyway, you should reorder a bit

- whatever other patches are necessary before
- dt-bindings: add documentation of rk3036 clock controller
- clk: rockchip: add dt-binding header for rk3036
- clk: rockchip: add new pll type for rk3036
-  clk: rockchip: add clock controller for rk3036
- ARM: dts: rockchip: add core rk3036 dts

The dts patch for example depends on the clock-header, so it really should 
come after its addition.


Heiko

> 
>  .../bindings/clock/rockchip,rk3036-cru.txt         |   60 +++
>  .../bindings/pinctrl/rockchip,pinctrl.txt          |    1 +
>  arch/arm/boot/dts/Makefile                         |    1 +
>  arch/arm/boot/dts/rk3036-sdk.dts                   |   62 +++
>  arch/arm/boot/dts/rk3036.dtsi                      |  381 +++++++++++++++
>  arch/arm/mach-rockchip/platsmp.c                   |  121 +++++
>  arch/arm/mach-rockchip/rockchip.c                  |   22 +
>  drivers/clk/rockchip/Makefile                      |    1 +
>  drivers/clk/rockchip/clk-pll.c                     |  262 +++++++++-
>  drivers/clk/rockchip/clk-rk3036.c                  |  504
> ++++++++++++++++++++ drivers/clk/rockchip/clk.h                         |  
> 30 ++
>  drivers/pinctrl/pinctrl-rockchip.c                 |   17 +
>  drivers/rtc/rtc-hym8563.c                          |   93 ++++
>  include/dt-bindings/clock/rk3036-cru.h             |  198 ++++++++
>  14 files changed, 1752 insertions(+), 1 deletion(-)
>  create mode 100644
> Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt create mode
> 100644 arch/arm/boot/dts/rk3036-sdk.dts
>  create mode 100644 arch/arm/boot/dts/rk3036.dtsi
>  create mode 100644 drivers/clk/rockchip/clk-rk3036.c
>  create mode 100644 include/dt-bindings/clock/rk3036-cru.h

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
