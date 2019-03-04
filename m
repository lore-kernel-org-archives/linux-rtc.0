Return-Path: <SRS0=54M4=RH=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0495C43381
	for <linux-rtc@archiver.kernel.org>; Mon,  4 Mar 2019 10:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F86120823
	for <linux-rtc@archiver.kernel.org>; Mon,  4 Mar 2019 10:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfCDKUY (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:20:24 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50971 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfCDKUY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 4 Mar 2019 05:20:24 -0500
X-Originating-IP: 82.246.155.60
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2F059C000A;
        Mon,  4 Mar 2019 10:20:21 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: pic32: let the core handle range
Date:   Mon,  4 Mar 2019 11:20:14 +0100
Message-Id: <20190304102014.529-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304102014.529-1-alexandre.belloni@bootlin.com>
References: <20190304102014.529-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Let the core handle the RTC range instead of open coding it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pic32.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-pic32.c b/drivers/rtc/rtc-pic32.c
index 43bd701daef2..7824acc18b6e 100644
--- a/drivers/rtc/rtc-pic32.c
+++ b/drivers/rtc/rtc-pic32.c
@@ -180,22 +180,16 @@ static int pic32_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
 	struct pic32_rtc_dev *pdata = dev_get_drvdata(dev);
 	void __iomem *base = pdata->reg_base;
-	int year = tm->tm_year - 100;
 
 	dev_dbg(dev, "set time %ptR\n", tm);
 
-	if (year < 0 || year >= 100) {
-		dev_err(dev, "rtc only supports 100 years\n");
-		return -EINVAL;
-	}
-
 	clk_enable(pdata->clk);
 	writeb(bin2bcd(tm->tm_sec),  base + PIC32_RTCSEC);
 	writeb(bin2bcd(tm->tm_min),  base + PIC32_RTCMIN);
 	writeb(bin2bcd(tm->tm_hour), base + PIC32_RTCHOUR);
 	writeb(bin2bcd(tm->tm_mday), base + PIC32_RTCDAY);
 	writeb(bin2bcd(tm->tm_mon + 1), base + PIC32_RTCMON);
-	writeb(bin2bcd(year), base + PIC32_RTCYEAR);
+	writeb(bin2bcd(tm->tm_year - 100), base + PIC32_RTCYEAR);
 	clk_disable(pdata->clk);
 
 	return 0;
@@ -353,6 +347,8 @@ static int pic32_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(pdata->rtc);
 
 	pdata->rtc->ops = &pic32_rtcops;
+	pdata->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	pdata->rtc->range_max = RTC_TIMESTAMP_END_2099;
 
 	ret = rtc_register_device(pdata->rtc);
 	if (ret)
-- 
2.20.1

