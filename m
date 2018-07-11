Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:46405 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKMvw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 11 Jul 2018 08:51:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Stultz <john.stultz@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] rtc: use ktime_get_real_ts64() instead of getnstimeofday64()
Date: Wed, 11 Jul 2018 14:47:12 +0200
Message-Id: <20180711124723.1114803-1-arnd@arndb.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

getnstimeofday64() is just a wrapper around the ktime accessor, so
we should use that directly.

I considered using ktime_get_boottime_ts64() (to avoid leap second
problems) or ktime_get_real_seconds() (to simplify the calculation,
but in the end concluded that the existing interface is probably
the most appropriate in this case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally sent on Jun 18, but got no reply

Alexandre, could you pick this up into the rtc tree?
---
 drivers/rtc/class.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index d37588f08055..7fa32c922617 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -68,7 +68,7 @@ static int rtc_suspend(struct device *dev)
 		return 0;
 	}
 
-	getnstimeofday64(&old_system);
+	ktime_get_real_ts64(&old_system);
 	old_rtc.tv_sec = rtc_tm_to_time64(&tm);
 
 
@@ -110,7 +110,7 @@ static int rtc_resume(struct device *dev)
 		return 0;
 
 	/* snapshot the current rtc and system time at resume */
-	getnstimeofday64(&new_system);
+	ktime_get_real_ts64(&new_system);
 	err = rtc_read_time(rtc, &tm);
 	if (err < 0) {
 		pr_debug("%s:  fail to read rtc time\n", dev_name(&rtc->dev));
-- 
2.9.0
