Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:34917 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbeBISFn (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 9 Feb 2018 13:05:43 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rtc@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] rtc: m41t80: move m41t80_rtc_mutex to the block where it is used
Date: Fri,  9 Feb 2018 19:05:34 +0100
Message-Id: <20180209180534.28925-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Without CONFIG_RTC_DRV_M41T80_WDT the compiler complains:

|drivers/rtc/rtc-m41t80.c:76 ‘m41t80_rtc_mutex’ defined but not used [-Wunused-variable]

Move the variable to the block where it is used.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/rtc/rtc-m41t80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index c90fba3ed861..bd268f0d6073 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -73,7 +73,6 @@
 #define M41T80_FEATURE_WD	BIT(3)	/* Extra watchdog resolution */
 #define M41T80_FEATURE_SQ_ALT	BIT(4)	/* RSx bits are in reg 4 */
 
-static DEFINE_MUTEX(m41t80_rtc_mutex);
 static const struct i2c_device_id m41t80_id[] = {
 	{ "m41t62", M41T80_FEATURE_SQ | M41T80_FEATURE_SQ_ALT },
 	{ "m41t65", M41T80_FEATURE_HT | M41T80_FEATURE_WD },
@@ -598,6 +597,7 @@ static struct clk *m41t80_sqw_register_clk(struct m41t80_data *m41t80)
  *
  *****************************************************************************
  */
+static DEFINE_MUTEX(m41t80_rtc_mutex);
 static struct i2c_client *save_client;
 
 /* Default margin */
-- 
2.15.1
