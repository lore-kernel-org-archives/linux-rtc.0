Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756549AbdGLLAA (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 12 Jul 2017 07:00:00 -0400
From: Alexey Klimov <alexey.klimov@arm.com>
To: linux-rtc@vger.kernel.org
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        alexandre.belloni@free-electrons.com, alexey.klimov@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org
Subject: [PATCH 3/3] rtc: sun6i: Remove unneeded initalization of ret in sun6i_rtc_setalarm()
Date: Wed, 12 Jul 2017 11:59:50 +0100
Message-Id: <1499857190-30849-3-git-send-email-alexey.klimov@arm.com>
In-Reply-To: <1499857190-30849-1-git-send-email-alexey.klimov@arm.com>
References: <1499857190-30849-1-git-send-email-alexey.klimov@arm.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Signed-off-by: Alexey Klimov <alexey.klimov@arm.com>
---
 drivers/rtc/rtc-sun6i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 77bc4d3..1886b85 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -362,7 +362,7 @@ static int sun6i_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 	unsigned long time_now = 0;
 	unsigned long time_set = 0;
 	unsigned long time_gap = 0;
-	int ret = 0;
+	int ret;
 
 	ret = sun6i_rtc_gettime(dev, &tm_now);
 	if (ret < 0) {
-- 
1.9.1
