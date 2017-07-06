Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35685 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbdGFUCK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 16:02:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id z45so2845031wrb.2
        for <linux-rtc@vger.kernel.org>; Thu, 06 Jul 2017 13:02:10 -0700 (PDT)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: rtc: ds1307: fix compile warning if RTC_DRV_DS1307_CENTURY isn't
 defined
Message-ID: <d2d61547-70e1-2e86-230a-45e1fac3381e@gmail.com>
Date: Thu, 6 Jul 2017 22:01:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Fix the following warning if RTC_DRV_DS1307_CENTURY isn't defined.

drivers/rtc/rtc-ds1307.c: In function 'ds1307_get_time':
drivers/rtc/rtc-ds1307.c:342:26: warning: unused variable 'chip' [-Wunused-variable]
  const struct chip_desc *chip = &chips[ds1307->type];
                          ^
Fixes: 436c93db60a4 ("rtc: ds1307: factor out century bit handling")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 43e9dc6f..18b6a6af 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -368,10 +368,9 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 	t->tm_mon = bcd2bin(tmp) - 1;
 	t->tm_year = bcd2bin(ds1307->regs[DS1307_REG_YEAR]) + 100;
 
-#ifdef CONFIG_RTC_DRV_DS1307_CENTURY
-	if (ds1307->regs[chip->century_reg] & chip->century_bit)
+	if (ds1307->regs[chip->century_reg] & chip->century_bit &&
+	    IS_ENABLED(CONFIG_RTC_DRV_DS1307_CENTURY))
 		t->tm_year += 100;
-#endif
 
 	dev_dbg(dev, "%s secs=%d, mins=%d, "
 		"hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
-- 
2.13.1
