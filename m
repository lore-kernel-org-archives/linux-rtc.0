Return-Path: <SRS0=XIIG=RG=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A45C43381
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 21:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B5920830
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 21:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfCCVpX (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 3 Mar 2019 16:45:23 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57111 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfCCVpX (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 3 Mar 2019 16:45:23 -0500
X-Originating-IP: 82.246.155.60
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2D490C0004;
        Sun,  3 Mar 2019 21:45:20 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: zynqmp: let the core handle range
Date:   Sun,  3 Mar 2019 22:45:03 +0100
Message-Id: <20190303214503.17400-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303214503.17400-1-alexandre.belloni@bootlin.com>
References: <20190303214503.17400-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Let the core handle the RTC range instead of open coding it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-zynqmp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index f0dd20785b54..bb950945ec7f 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -49,7 +49,6 @@
 
 #define RTC_CALIB_DEF		0x198233
 #define RTC_CALIB_MASK		0x1FFFFF
-#define RTC_SEC_MAX_VAL		0xFFFFFFFF
 
 struct xlnx_rtc_dev {
 	struct rtc_device	*rtc;
@@ -71,9 +70,6 @@ static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	 */
 	new_time = rtc_tm_to_time64(tm) + 1;
 
-	if (new_time > RTC_SEC_MAX_VAL)
-		return -EINVAL;
-
 	/*
 	 * Writing into calibration register will clear the Tick Counter and
 	 * force the next second to be signaled exactly in 1 second period
@@ -154,9 +150,6 @@ static int xlnx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	alarm_time = rtc_tm_to_time64(&alrm->time);
 
-	if (alarm_time > RTC_SEC_MAX_VAL)
-		return -EINVAL;
-
 	writel((u32)alarm_time, (xrtcdev->reg_base + RTC_ALRM));
 
 	xlnx_rtc_alarm_irq_enable(dev, alrm->enabled);
@@ -227,6 +220,7 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(xrtcdev->rtc);
 
 	xrtcdev->rtc->ops = &xlnx_rtc_ops;
+	xrtcdev->rtc->range_max = U32_MAX;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-- 
2.20.1

