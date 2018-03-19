Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:54264 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964834AbeCSXsd (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 19 Mar 2018 19:48:33 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/6] rtc: mrst: remove artificial limitation
Date: Tue, 20 Mar 2018 00:48:14 +0100
Message-Id: <20180319234817.16199-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20180319234817.16199-1-alexandre.belloni@bootlin.com>
References: <20180319234817.16199-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The hardware supports years up to 100 so don't limit the year to 2038
artificially.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mrst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index 901a8d170f68..fcb9de5218b2 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -122,7 +122,7 @@ static int mrst_set_time(struct device *dev, struct rtc_time *time)
 	min = time->tm_min;
 	sec = time->tm_sec;
 
-	if (yrs < 72 || yrs > 138)
+	if (yrs < 72 || yrs > 172)
 		return -EINVAL;
 	yrs -= 72;
 
-- 
2.16.2
