Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:41711 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbeIXU2F (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 24 Sep 2018 16:28:05 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: armada38x: add range
Date: Mon, 24 Sep 2018 16:25:35 +0200
Message-Id: <20180924142536.27801-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20180924142536.27801-1-alexandre.belloni@bootlin.com>
References: <20180924142536.27801-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The RTC is a 32bit seconds counter.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-armada38x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index b74338d6dde6..d0278ad0a7f9 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -577,6 +577,8 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
 	/* Update RTC-MBUS bridge timing parameters */
 	rtc->data->update_mbus_timing(rtc);
 
+	rtc->rtc_dev->range_max = U32_MAX;
+
 	ret = rtc_register_device(rtc->rtc_dev);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
-- 
2.19.0
