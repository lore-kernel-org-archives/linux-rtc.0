Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:35065 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbeEUUtJ (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 21 May 2018 16:49:09 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2] rtc: st-lpc: add range
Date: Mon, 21 May 2018 22:49:05 +0200
Message-Id: <20180521204905.7113-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The RTC has a 64 bit counter.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-st-lpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 2f1ef2c28740..bee75ca7ff79 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -258,6 +258,8 @@ static int st_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rtc);
 
 	rtc->rtc_dev->ops = &st_rtc_ops;
+	rtc->rtc_dev->range_max = U64_MAX;
+	do_div(rtc->rtc_dev->range_max, rtc->clkrate);
 
 	ret = rtc_register_device(rtc->rtc_dev);
 	if (ret) {
-- 
2.17.0
