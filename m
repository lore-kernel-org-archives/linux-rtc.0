Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47041 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbeBUU5o (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 21 Feb 2018 15:57:44 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 063/100] rtc: rx8025: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:58 +0100
Message-Id: <20180221205635.31314-64-alexandre.belloni@bootlin.com>
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The RTC core is always calling rtc_valid_tm after the read_time callback.
It is not necessary to call it just before returning from the callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rx8025.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 91857d8d2df8..41127adf5765 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -214,7 +214,7 @@ static int rx8025_get_time(struct device *dev, struct rtc_time *dt)
 		dt->tm_sec, dt->tm_min, dt->tm_hour,
 		dt->tm_mday, dt->tm_mon, dt->tm_year);
 
-	return rtc_valid_tm(dt);
+	return 0;
 }
 
 static int rx8025_set_time(struct device *dev, struct rtc_time *dt)
-- 
2.16.1
