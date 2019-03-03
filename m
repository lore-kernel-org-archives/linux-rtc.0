Return-Path: <SRS0=XIIG=RG=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA07C43381
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 22:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9228620815
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 22:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfCCWVp (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 3 Mar 2019 17:21:45 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:59147 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfCCWVp (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 3 Mar 2019 17:21:45 -0500
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 16A02200005;
        Sun,  3 Mar 2019 22:21:42 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/4] rtc: tx4939: use .set_time
Date:   Sun,  3 Mar 2019 23:21:20 +0100
Message-Id: <20190303222120.22434-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303222120.22434-1-alexandre.belloni@bootlin.com>
References: <20190303222120.22434-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Switch from .set_mmss to .set_time as the former is deprecated.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tx4939.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 8acb8adc11d7..404de455409b 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -65,10 +65,11 @@ static int tx4939_rtc_cmd(struct tx4939_rtc_reg __iomem *rtcreg, int cmd)
 	return 0;
 }
 
-static int tx4939_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int tx4939_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
 	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
+	unsigned long secs = rtc_tm_to_time64(tm);
 	int i, ret;
 	unsigned char buf[6];
 
@@ -203,7 +204,7 @@ static const struct rtc_class_ops tx4939_rtc_ops = {
 	.read_time		= tx4939_rtc_read_time,
 	.read_alarm		= tx4939_rtc_read_alarm,
 	.set_alarm		= tx4939_rtc_set_alarm,
-	.set_mmss		= tx4939_rtc_set_mmss,
+	.set_time		= tx4939_rtc_set_time,
 	.alarm_irq_enable	= tx4939_rtc_alarm_irq_enable,
 };
 
-- 
2.20.1

