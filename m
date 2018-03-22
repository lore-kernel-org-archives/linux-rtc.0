Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from gateway33.websitewelcome.com ([192.185.146.210]:33200 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751825AbeCVTxa (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 22 Mar 2018 15:53:30 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 061E74423
        for <linux-rtc@vger.kernel.org>; Thu, 22 Mar 2018 14:53:30 -0500 (CDT)
Date: Thu, 22 Mar 2018 14:53:28 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] rtc: isl12022: use true and false for boolean values
Message-ID: <20180322195328.GA25733@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/rtc/rtc-isl12022.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index fa5c15d..890ccfc 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -201,7 +201,7 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 				return ret;
 		}
 
-		isl12022->write_enabled = 1;
+		isl12022->write_enabled = true;
 	}
 
 	/* hours, minutes and seconds */
-- 
2.7.4
