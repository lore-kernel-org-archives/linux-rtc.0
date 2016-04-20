Return-Path: <rtc-linux+bncBDHZXHXDRAMBBRVQ3O4AKGQEGWBWL4Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from smtp.codeaurora.org (smtp.codeaurora.org. [198.145.29.96])
        by gmr-mx.google.com with ESMTPS id d22si3880147pfd.0.2016.04.19.18.15.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Apr 2016 18:15:50 -0700 (PDT)
From: Stephen Boyd <sboyd@codeaurora.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Michael Tatarinov <kukabu@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: ds1307: Remove CLK_IS_ROOT
Date: Tue, 19 Apr 2016 18:15:48 -0700
Message-Id: <1461114948-17987-1-git-send-email-sboyd@codeaurora.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Michael Tatarinov <kukabu@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/rtc/rtc-ds1307.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 043c307d85da..e99fd749e35e 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1151,12 +1151,10 @@ static struct clk_init_data ds3231_clks_init[] = {
 	[DS3231_CLK_SQW] = {
 		.name = "ds3231_clk_sqw",
 		.ops = &ds3231_clk_sqw_ops,
-		.flags = CLK_IS_ROOT,
 	},
 	[DS3231_CLK_32KHZ] = {
 		.name = "ds3231_clk_32khz",
 		.ops = &ds3231_clk_32khz_ops,
-		.flags = CLK_IS_ROOT,
 	},
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

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
