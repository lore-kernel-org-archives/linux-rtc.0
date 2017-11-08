Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46666 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbdKHT6a (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 8 Nov 2017 14:58:30 -0500
Received: by mail-qk0-f196.google.com with SMTP id o6so4900717qkh.3
        for <linux-rtc@vger.kernel.org>; Wed, 08 Nov 2017 11:58:30 -0800 (PST)
From: Akshay Bhat <akshay.bhat@timesys.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akshay Bhat <akshay.bhat@timesys.com>
Subject: [PATCH v2] rtc: rx8010: Fix for incorrect return value
Date: Wed,  8 Nov 2017 14:58:14 -0500
Message-Id: <1510171094-4859-1-git-send-email-akshay.bhat@timesys.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The err variable is not being reset after a successful read. Explicitly
return 0 at the end of function call to account for all return paths.

Reported-by: Jens-Peter Oswald <oswald@lre.de>
Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
v2: Address comments from Alexandre Belloni
- Return 0 at end of function instead of resetting err variable

 drivers/rtc/rtc-rx8010.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 2e06e5f..5c5938a 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -247,7 +247,7 @@ static int rx8010_init_client(struct i2c_client *client)
 
 	rx8010->ctrlreg = (ctrl[1] & ~RX8010_CTRL_TEST);
 
-	return err;
+	return 0;
 }
 
 static int rx8010_read_alarm(struct device *dev, struct rtc_wkalrm *t)
@@ -276,7 +276,7 @@ static int rx8010_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	t->enabled = !!(rx8010->ctrlreg & RX8010_CTRL_AIE);
 	t->pending = (flagreg & RX8010_FLAG_AF) && t->enabled;
 
-	return err;
+	return 0;
 }
 
 static int rx8010_set_alarm(struct device *dev, struct rtc_wkalrm *t)
-- 
2.7.4
