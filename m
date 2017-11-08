Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33183 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdKHE3I (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 7 Nov 2017 23:29:08 -0500
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: pcf8563: don't alway enable the alarm
Date: Wed,  8 Nov 2017 05:29:01 +0100
Message-Id: <20171108042901.10686-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Allow setting the alarm and later enable it instead of enabling it
unconditionally.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-pcf8563.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 8c836c51a508..3efc86c25d27 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -387,7 +387,7 @@ static int pcf8563_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *tm)
 	if (err)
 		return err;
 
-	return pcf8563_set_alarm_mode(client, 1);
+	return pcf8563_set_alarm_mode(client, !!tm->enabled);
 }
 
 static int pcf8563_irq_enable(struct device *dev, unsigned int enabled)
-- 
2.15.0
