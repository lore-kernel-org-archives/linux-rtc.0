Return-Path: <rtc-linux+bncBCMILY6JWQBBBWUAW7CAKGQEI75NYPA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from wens.csie.org (mirror2.csie.ntu.edu.tw. [140.112.30.76])
        by gmr-mx.google.com with ESMTPS id z3si2135277pfj.0.2017.01.29.02.13.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jan 2017 02:13:46 -0800 (PST)
From: Chen-Yu Tsai <wens@csie.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: sun6i: Fix compatibility with old DT binding
Date: Sun, 29 Jan 2017 18:13:43 +0800
Message-Id: <20170129101343.7222-1-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Commit 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator") adds
a new clock for the rtc block with a 2 step probe mechanism. To share
the register region between both the clock and rtc instance, a static
pointer is used to keep the related data structure.

To preserve compatibility with the old binding, the data structure
should be saved as soon as the registers are mapped in, regardless
of the presence of the clock bindings, so that the rtc device can
retrieve it when it is probed.

This fixes the rtc device not probing when we use the updated driver
with an old device tree blob.

Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rtc/rtc-sun6i.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 613f42ade533..08510ca58996 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -211,6 +211,9 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	writel(SUN6I_LOSC_CTRL_KEY | SUN6I_LOSC_CTRL_EXT_OSC,
 	       rtc->base + SUN6I_LOSC_CTRL);
 
+	/* Yes, I know, this is ugly. */
+	sun6i_rtc = rtc;
+
 	/* Deal with old DTs */
 	if (!of_get_property(node, "clocks", NULL))
 		return;
@@ -243,9 +246,6 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	clk_data->num = 1;
 	clk_data->hws[0] = &rtc->hw;
 	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	/* Yes, I know, this is ugly. */
-	sun6i_rtc = rtc;
 }
 CLK_OF_DECLARE_DRIVER(sun6i_rtc_clk, "allwinner,sun6i-a31-rtc",
 		      sun6i_rtc_clk_init);
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
