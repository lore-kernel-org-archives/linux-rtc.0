Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:39013 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeEQUdo (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 17 May 2018 16:33:44 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/7] rtc: rx8581: add RTC range
Date: Thu, 17 May 2018 22:33:26 +0200
Message-Id: <20180517203331.24504-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20180517203331.24504-1-alexandre.belloni@bootlin.com>
References: <20180517203331.24504-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The rx8581 can support dates from 01/01/2000 to 31/12/2099.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rx8581.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index c64911a08531..c5ffd30ca672 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -291,6 +291,8 @@ static int rx8581_probe(struct i2c_client *client,
 		return PTR_ERR(rx8581->rtc);
 
 	rx8581->rtc->ops = &rx8581_rtc_ops;
+	rx8581->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rx8581->rtc->range_max = RTC_TIMESTAMP_END_2099;
 
 	return rtc_register_device(rx8581->rtc);
 }
-- 
2.17.0
