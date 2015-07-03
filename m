Return-Path: <rtc-linux+bncBD5O5IWPJMIJ7L64VQCRUBEWWBRVY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com. [2a00:1450:400c:c05::230])
        by gmr-mx.google.com with ESMTPS id gt9si567191wib.2.2015.07.03.16.15.43
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jul 2015 16:15:43 -0700 (PDT)
Received: by mail-wi0-x230.google.com with SMTP id dq8so110158728wib.1
        for <rtc-linux@googlegroups.com>; Fri, 03 Jul 2015 16:15:43 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH v4 1/7] imx31: add a second rtc clock
Date: Sat,  4 Jul 2015 01:15:14 +0200
Message-Id: <1435965320-1478-2-git-send-email-tremyfr@gmail.com>
In-Reply-To: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
References: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
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

The mxc rtc driver needs two clock.
It was defined only one clock, so we
define the second clock.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 drivers/clk/imx/clk-imx31.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index fe66c40..01da40d 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -147,7 +147,8 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[cspi3_gate], NULL, "imx31-cspi.2");
 	clk_register_clkdev(clk[pwm_gate], "pwm", NULL);
 	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
-	clk_register_clkdev(clk[rtc_gate], NULL, "imx21-rtc");
+	clk_register_clkdev(clk[ckil], "rtc", "imx21-rtc");
+	clk_register_clkdev(clk[rtc_gate], "ipg", "imx21-rtc");
 	clk_register_clkdev(clk[epit1_gate], "epit", NULL);
 	clk_register_clkdev(clk[epit2_gate], "epit", NULL);
 	clk_register_clkdev(clk[nfc], NULL, "imx27-nand.0");
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
