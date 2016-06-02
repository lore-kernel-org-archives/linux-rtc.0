Return-Path: <rtc-linux+bncBAABBCNPX65AKGQEBHOKI4I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.phycore.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id j140si835240wmf.1.2016.06.01.23.51.53
        for <rtc-linux@googlegroups.com>;
        Wed, 01 Jun 2016 23:51:53 -0700 (PDT)
From: Wadim Egorov <w.egorov@phytec.de>
To: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
Subject: [rtc-linux] [RESEND PATCH v5 4/5] clk: Kconfig: Name RK818 in Kconfig
 for COMMON_CLK_RK808
Date: Thu, 2 Jun 2016 08:50:27 +0200
Message-Id: <1464850228-17244-4-git-send-email-w.egorov@phytec.de>
In-Reply-To: <1464850228-17244-1-git-send-email-w.egorov@phytec.de>
References: <1464850228-17244-1-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The RK808 and RK818 PMICs are using a similar register map.
We can reuse the clk driver for the RK818 PMIC. So let's add
the RK818 in the Kconfig description.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 53ddba2..87b9fd2 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -49,10 +49,10 @@ config COMMON_CLK_MAX77802
 	  This driver supports Maxim 77802 crystal oscillator clock.
 
 config COMMON_CLK_RK808
-	tristate "Clock driver for RK808"
+	tristate "Clock driver for RK808/RK818"
 	depends on MFD_RK808
 	---help---
-	  This driver supports RK808 crystal oscillator clock. These
+	  This driver supports RK808 and RK818 crystal oscillator clock. These
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
