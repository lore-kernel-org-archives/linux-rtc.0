Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46894 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeBUU5D (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 21 Feb 2018 15:57:03 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 002/100] rtc: ds1553: let the core handle invalid time
Date: Wed, 21 Feb 2018 21:54:57 +0100
Message-Id: <20180221205635.31314-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Returning a valid time when the time is invalid is a bad practice, because
then userspace is not able to react on the information. Also, it doesn't
make sense to return epoch because it is already the default time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1553.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index 7334c824371a..2441b9a2b366 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -127,10 +127,6 @@ static int ds1553_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	/* year is 1900 + tm->tm_year */
 	tm->tm_year = bcd2bin(year) + bcd2bin(century) * 100 - 1900;
 
-	if (rtc_valid_tm(tm) < 0) {
-		dev_err(dev, "retrieved date/time is not valid.\n");
-		rtc_time_to_tm(0, tm);
-	}
 	return 0;
 }
 
-- 
2.16.1
