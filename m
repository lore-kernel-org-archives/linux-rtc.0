Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:44143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933445AbeFROWu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 18 Jun 2018 10:22:50 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: use ktime_get_real_ts64() instead of getnstimeofday64()
Date: Mon, 18 Jun 2018 16:22:14 +0200
Message-Id: <20180618142238.3509274-1-arnd@arndb.de>
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
