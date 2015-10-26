Return-Path: <rtc-linux+bncBD747RFBYUPBBXWJXCYQKGQER6WWYPA@googlegroups.com>
MIME-Version: 1.0
Received: from mailout4.samsung.com (mailout4.samsung.com. [203.254.224.34])
        by gmr-mx.google.com with ESMTPS id zg1si3550955pbb.2.2015.10.26.06.04.29
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 Oct 2015 06:04:30 -0700 (PDT)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWT01CUUWBGJO20@mailout4.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 26 Oct 2015 22:04:28 +0900 (KST)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: lee.jones@linaro.org, broonie@kernel.org
Cc: k.kozlowski@samsung.com, mturquette@baylibre.com,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v3 4/5] clk: s2mps15: Add support for S2MPS15 clocks
Date: Mon, 26 Oct 2015 18:21:21 +0530
Message-id: <1445863883-5187-5-git-send-email-alim.akhtar@samsung.com>
In-reply-to: <1445863883-5187-1-git-send-email-alim.akhtar@samsung.com>
References: <1445863883-5187-1-git-send-email-alim.akhtar@samsung.com>
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

S2MPS15 PMIC has three 32k buffered clocks outputs. This patch
adds supports for the same to the s2mps11 clock driver.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/Kconfig       |    5 +++--
 drivers/clk/clk-s2mps11.c |   24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index a1fa61159179..037a314b5d76 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -120,9 +120,10 @@ config COMMON_CLK_S2MPS11
 	tristate "Clock driver for S2MPS1X/S5M8767 MFD"
 	depends on MFD_SEC_CORE
 	---help---
-	  This driver supports S2MPS11/S2MPS14/S5M8767 crystal oscillator
+	  This driver supports S2MPS1X/S5M8767 crystal oscillator
 	  clock. These multi-function devices have two (S2MPS14) or three
-	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
+	  (S2MPS11/S2MPS13/S2MPS15/S5M8767) fixed-rate oscillators,
+	  clocked at 32KHz each.
 
 config CLK_TWL6040
 	tristate "External McPDM functional clock from twl6040"
diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index d266299dfdb1..455500dca653 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -25,6 +25,7 @@
 #include <linux/mfd/samsung/s2mps11.h>
 #include <linux/mfd/samsung/s2mps13.h>
 #include <linux/mfd/samsung/s2mps14.h>
+#include <linux/mfd/samsung/s2mps15.h>
 #include <linux/mfd/samsung/s5m8767.h>
 #include <linux/mfd/samsung/core.h>
 
@@ -148,6 +149,24 @@ static struct clk_init_data s2mps14_clks_init[S2MPS11_CLKS_NUM] = {
 	},
 };
 
+static struct clk_init_data s2mps15_clks_init[S2MPS11_CLKS_NUM] = {
+	[S2MPS11_CLK_AP] = {
+		.name = "s2mps15_ap",
+		.ops = &s2mps11_clk_ops,
+		.flags = CLK_IS_ROOT,
+	},
+	[S2MPS11_CLK_CP] = {
+		.name = "s2mps15_cp",
+		.ops = &s2mps11_clk_ops,
+		.flags = CLK_IS_ROOT,
+	},
+	[S2MPS11_CLK_BT] = {
+		.name = "s2mps15_bt",
+		.ops = &s2mps11_clk_ops,
+		.flags = CLK_IS_ROOT,
+	},
+};
+
 static struct device_node *s2mps11_clk_parse_dt(struct platform_device *pdev,
 		struct clk_init_data *clks_init)
 {
@@ -207,6 +226,10 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 		s2mps11_reg = S2MPS14_REG_RTCCTRL;
 		clks_init = s2mps14_clks_init;
 		break;
+	case S2MPS15X:
+		s2mps11_reg = S2MPS15_REG_RTC_BUF;
+		clks_init = s2mps15_clks_init;
+		break;
 	case S5M8767X:
 		s2mps11_reg = S5M8767_REG_CTRL1;
 		clks_init = s2mps11_clks_init;
@@ -292,6 +315,7 @@ static const struct platform_device_id s2mps11_clk_id[] = {
 	{ "s2mps11-clk", S2MPS11X},
 	{ "s2mps13-clk", S2MPS13X},
 	{ "s2mps14-clk", S2MPS14X},
+	{ "s2mps15-clk", S2MPS15X},
 	{ "s5m8767-clk", S5M8767X},
 	{ },
 };
-- 
1.7.10.4

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
