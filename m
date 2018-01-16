Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbeAPOpe (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 16 Jan 2018 09:45:34 -0500
From: James Hogan <jhogan@kernel.org>
To: Miodrag Dinic <miodrag.dinic@mips.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH] rtc: goldfish: Add missing MODULE_LICENSE
Date: Tue, 16 Jan 2018 14:45:21 +0000
Message-Id: <20180116144521.392-1-jhogan@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Fix the following warning in MIPS allmodconfig by adding a
MODULE_LICENSE() at the end of rtc-goldfish.c, based on the file header
comment which says GNU General Public License version 2:

WARNING: modpost: missing MODULE_LICENSE() in drivers/rtc/rtc-goldfish.o

Fixes: f22d9cdcb5eb ("rtc: goldfish: Add RTC driver for Android emulator")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Miodrag Dinic <miodrag.dinic@mips.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
---
 drivers/rtc/rtc-goldfish.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
index d67769265185..a1c44d0c8557 100644
--- a/drivers/rtc/rtc-goldfish.c
+++ b/drivers/rtc/rtc-goldfish.c
@@ -235,3 +235,5 @@ static struct platform_driver goldfish_rtc = {
 };
 
 module_platform_driver(goldfish_rtc);
+
+MODULE_LICENSE("GPL v2");
-- 
2.13.6
