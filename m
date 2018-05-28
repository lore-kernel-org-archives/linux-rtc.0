Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44151 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753734AbeE1Huo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 28 May 2018 03:50:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id q22-v6so5460311pff.11
        for <linux-rtc@vger.kernel.org>; Mon, 28 May 2018 00:50:44 -0700 (PDT)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc: linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] rtc: sun6i: Fix bit_idx value for clk_register_gate
Date: Mon, 28 May 2018 13:20:32 +0530
Message-Id: <20180528075032.6769-1-jagan@amarulasolutions.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Michael Trimarchi <michael@amarulasolutions.com>

clk-gate core will take bit_idx through clk_register_gate
and then do clk_gate_ops by using BIT(bit_idx), but rtc-sun6i
is passing bit_idx as BIT(bit_idx) it becomes BIT(BIT(bit_idx)
which is wrong and eventually external gate clock is not enabling.

This patch fixed by passing bit index and the original change
introduced from below commit.
"rtc: sun6i: Add support for the external oscillator gate"
(sha1: 	17ecd246414b3a0fe0cb248c86977a8bda465b7b)

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/rtc/rtc-sun6i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 2e6fb275acc8..a66f40c96582 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -74,7 +74,7 @@
 #define SUN6I_ALARM_CONFIG_WAKEUP		BIT(0)
 
 #define SUN6I_LOSC_OUT_GATING			0x0060
-#define SUN6I_LOSC_OUT_GATING_EN		BIT(0)
+#define SUN6I_LOSC_OUT_GATING_EN		0
 
 /*
  * Get date values
-- 
2.14.3
