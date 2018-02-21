Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46976 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeBUU5Y (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 21 Feb 2018 15:57:24 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 030/100] rtc: fm3130: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:25 +0100
Message-Id: <20180221205635.31314-31-alexandre.belloni@bootlin.com>
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The RTC core is always calling rtc_valid_tm after the read_time callback.
It is not necessary to call it just before returning from the callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-fm3130.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-fm3130.c b/drivers/rtc/rtc-fm3130.c
index 576eadbba296..e1137670d4d2 100644
--- a/drivers/rtc/rtc-fm3130.c
+++ b/drivers/rtc/rtc-fm3130.c
@@ -136,8 +136,7 @@ static int fm3130_get_time(struct device *dev, struct rtc_time *t)
 		t->tm_hour, t->tm_mday,
 		t->tm_mon, t->tm_year, t->tm_wday);
 
-	/* initial clock setting can be undefined */
-	return rtc_valid_tm(t);
+	return 0;
 }
 
 
-- 
2.16.1
