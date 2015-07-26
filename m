Return-Path: <rtc-linux+bncBD5O5IWPJMIL7JWVVUCRUBA2LP4KO@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-x22b.google.com (mail-wi0-x22b.google.com. [2a00:1450:400c:c05::22b])
        by gmr-mx.google.com with ESMTPS id t6si246143wiz.0.2015.07.26.14.38.07
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jul 2015 14:38:07 -0700 (PDT)
Received: by mail-wi0-x22b.google.com with SMTP id ud3so117707903wib.1
        for <rtc-linux@googlegroups.com>; Sun, 26 Jul 2015 14:38:07 -0700 (PDT)
From: Philippe Reynes <tremyfr@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	shawn.guo@linaro.org,
	kernel@pengutronix.de,
	linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Philippe Reynes <tremyfr@gmail.com>
Subject: [rtc-linux] [PATCH v5 2/6] imx35: define two clocks for rtc
Date: Sun, 26 Jul 2015 23:37:49 +0200
Message-Id: <1437946673-7402-3-git-send-email-tremyfr@gmail.com>
In-Reply-To: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
References: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
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

The imx35 don't define clocks for rtc.
This patch add two clocks, as needed
by the mxc rtc driver.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 drivers/clk/imx/clk-imx35.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index 69138ba..8623cd4 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -66,7 +66,7 @@ static const char *std_sel[] = {"ppll", "arm"};
 static const char *ipg_per_sel[] = {"ahb_per_div", "arm_per_div"};
 
 enum mx35_clks {
-	ckih, mpll, ppll, mpll_075, arm, hsp, hsp_div, hsp_sel, ahb, ipg,
+	ckih, ckil, mpll, ppll, mpll_075, arm, hsp, hsp_div, hsp_sel, ahb, ipg,
 	arm_per_div, ahb_per_div, ipg_per, uart_sel, uart_div, esdhc_sel,
 	esdhc1_div, esdhc2_div, esdhc3_div, spdif_sel, spdif_div_pre,
 	spdif_div_post, ssi_sel, ssi1_div_pre, ssi1_div_post, ssi2_div_pre,
@@ -107,6 +107,7 @@ int __init mx35_clocks_init(void)
 	}
 
 	clk[ckih] = imx_clk_fixed("ckih", 24000000);
+	clk[ckil] = imx_clk_fixed("ckih", 32768);
 	clk[mpll] = imx_clk_pllv1(IMX_PLLV1_IMX35, "mpll", "ckih", base + MX35_CCM_MPCTL);
 	clk[ppll] = imx_clk_pllv1(IMX_PLLV1_IMX35, "ppll", "ckih", base + MX35_CCM_PPCTL);
 
@@ -258,6 +259,9 @@ int __init mx35_clocks_init(void)
 	clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.1");
 	clk_register_clkdev(clk[uart3_gate], "per", "imx21-uart.2");
 	clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.2");
+	/* i.mx35 has the i.mx21 type rtc */
+	clk_register_clkdev(clk[ckil], "ref", "imx21-rtc");
+	clk_register_clkdev(clk[rtc_gate], "ipg", "imx21-rtc");
 	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.0");
 	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.0");
 	clk_register_clkdev(clk[usbotg_gate], "ahb", "mxc-ehci.0");
-- 
1.7.4.4

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
