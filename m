Return-Path: <rtc-linux+bncBC7LNKXBRUKBB6HT5GXQKGQEBIBWEBQ@googlegroups.com>
MIME-Version: 1.0
Received: from regular1.263xmail.com (regular1.263xmail.com. [211.150.99.133])
        by gmr-mx.google.com with ESMTPS id mh4si153548igb.0.2015.09.17.01.29.42
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 01:29:43 -0700 (PDT)
From: Xing Zheng <zhengxing@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Xing Zheng <zhengxing@rock-chips.com>,
	Russell King <linux@arm.linux.org.uk>,
	Michael Turquette <mturquette@baylibre.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	devicetree@vger.kernel.org,
	Stephen Boyd <sboyd@codeaurora.org>,
	linux-gpio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	rtc-linux@googlegroups.com,
	Mark Rutland <mark.rutland@arm.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH v2 0/9] Build and support rk3036 SoC platform
Date: Thu, 17 Sep 2015 16:28:51 +0800
Message-Id: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>


Hi,
we need to support rk3036 soc platform via upstream, there are
3 primary parts for the initial release of minimum system: dts,
pinctrl, and clock tree for rk3036, and additional, add a rtc
hym8563 patch to fix initial invaild, we can use these startup
and run to init processs.

Thanks.

changed in v2:
- based on v1, add clock controller documentation
- enable timer5 startup
- add smp for cpu1
- initial set time for rtc-hym8563

changes since v1:
- add dts, pinctrl and clock tree for rk3036 soc platform

The patchset (9):
9) rtc: hym8563: make sure hym8563 can be normal work
8) ARM: rockchip: add support smp for rk3036
7) rockchip: make sure timer5 is enabled on rk3036 platforms
6) pinctrl: rockchip: add support for the rk3036
5) dt-bindings: add documentation of rk3036 clock controller
4) clk: rockchip: add new clock type and controller for rk3036
3) clk: rockchip: add clock controller for rk3036
2) clk: rockchip: add dt-binding header for rk3036
1) ARM: dts: rockchip: add core rk3036 dts


Changes in v2:
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

Xing Zheng (9):
  ARM: dts: rockchip: add core rk3036 dts
  clk: rockchip: add dt-binding header for rk3036
  clk: rockchip: add clock controller for rk3036
  clk: rockchip: add new clock type and controller for rk3036
  dt-bindings: add documentation of rk3036 clock controller
  pinctrl: rockchip: add support for the rk3036
  rockchip: make sure timer5 is enabled on rk3036 platforms
  ARM: rockchip: add support smp for rk3036
  rtc: hym8563: make sure hym8563 can be normal work

 .../bindings/clock/rockchip,rk3036-cru.txt         |   60 +++
 .../bindings/pinctrl/rockchip,pinctrl.txt          |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/rk3036-sdk.dts                   |   62 +++
 arch/arm/boot/dts/rk3036.dtsi                      |  381 +++++++++++++++
 arch/arm/mach-rockchip/platsmp.c                   |  121 +++++
 arch/arm/mach-rockchip/rockchip.c                  |   22 +
 drivers/clk/rockchip/Makefile                      |    1 +
 drivers/clk/rockchip/clk-pll.c                     |  262 +++++++++-
 drivers/clk/rockchip/clk-rk3036.c                  |  504 ++++++++++++++++++++
 drivers/clk/rockchip/clk.h                         |   30 ++
 drivers/pinctrl/pinctrl-rockchip.c                 |   17 +
 drivers/rtc/rtc-hym8563.c                          |   93 ++++
 include/dt-bindings/clock/rk3036-cru.h             |  198 ++++++++
 14 files changed, 1752 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt
 create mode 100644 arch/arm/boot/dts/rk3036-sdk.dts
 create mode 100644 arch/arm/boot/dts/rk3036.dtsi
 create mode 100644 drivers/clk/rockchip/clk-rk3036.c
 create mode 100644 include/dt-bindings/clock/rk3036-cru.h

-- 
1.7.9.5


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
