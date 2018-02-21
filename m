Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47056 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeBUU5q (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 21 Feb 2018 15:57:46 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 075/100] rtc: zynqmp: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:56:10 +0100
Message-Id: <20180221205635.31314-76-alexandre.belloni@bootlin.com>
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

rtc_time64_to_tm never generates an invalid tm. It is not necessary to
validate it. Also, the RTC core is always calling rtc_valid_tm after the
read_time callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index da18a8ae3c1d..fba994dc31eb 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -122,7 +122,7 @@ static int xlnx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		rtc_time64_to_tm(read_time, tm);
 	}
 
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int xlnx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
-- 
2.16.1
