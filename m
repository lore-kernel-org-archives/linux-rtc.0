Return-Path: <rtc-linux+bncBAABBVOOZ3GAKGQESGHOKYI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from regular1.263xmail.com (regular1.263xmail.com. [211.150.99.131])
        by gmr-mx.google.com with ESMTPS id e11si1855398pfd.4.2017.08.15.19.00.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 19:00:52 -0700 (PDT)
From: Joseph Chen <chenjh@rock-chips.com>
To: gnurou@gmail.com,
	linus.walleij@linaro.org,
	dmitry.torokhov@gmail.com,
	lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	broonie@kernel.org,
	zhangqing@rock-chips.com,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	linux-rockchip@lists.infradead.org,
	wdc@rock-chips.com,
	tony.xie@rock-chips.com,
	linux-input@vger.kernel.org,
	mark.rutland@arm.com,
	w.egorov@phytec.de,
	linux-clk@vger.kernel.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	Joseph Chen <chenjh@rock-chips.com>
Subject: [rtc-linux] [RESEND v9 05/12] clk: Kconfig: Name RK805 in Kconfig for COMMON_CLK_RK808
Date: Wed, 16 Aug 2017 10:00:03 +0800
Message-Id: <1502848803-22954-1-git-send-email-chenjh@rock-chips.com>
In-Reply-To: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
References: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Elaine Zhang <zhangqing@rock-chips.com>

The RK808 and RK805 PMICs are using a similar register map.
We can reuse the clk driver for the RK805 PMIC. So let's add
the RK805 in the Kconfig description.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
---
 drivers/clk/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 9356ab4..7ca8f02 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -39,10 +39,10 @@ config COMMON_CLK_MAX77686
 	  clock.
 
 config COMMON_CLK_RK808
-	tristate "Clock driver for RK808/RK818"
+	tristate "Clock driver for RK805/RK808/RK818"
 	depends on MFD_RK808
 	---help---
-	  This driver supports RK808 and RK818 crystal oscillator clock. These
+	  This driver supports RK805, RK808 and RK818 crystal oscillator clock. These
 	  multi-function devices have two fixed-rate oscillators,
 	  clocked at 32KHz each. Clkout1 is always on, Clkout2 can off
 	  by control register.
-- 
1.9.1


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
