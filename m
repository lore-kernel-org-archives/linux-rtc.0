Return-Path: <SRS0=1ScD=RX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96793C43381
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 11:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DE82175B
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 11:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfCTLa3 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:30:29 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50867 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTLa3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Mar 2019 07:30:29 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 34B38C0012;
        Wed, 20 Mar 2019 11:30:25 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] rtc: sh: set range
Date:   Wed, 20 Mar 2019 12:30:10 +0100
Message-Id: <20190320113010.8955-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320113010.8955-1-alexandre.belloni@bootlin.com>
References: <20190320113010.8955-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The SH RTC is a BCD RTC with some version having 4 digits for the year.

The range for the RTCs with only 2 digits for the year was unfortunately
shifted to handle 1999 to 2098.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sh.c | 8 ++++++++
 include/linux/rtc.h  | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index b582af10ddb5..37964a867de7 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -601,6 +601,14 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 	rtc->rtc_dev->ops = &sh_rtc_ops;
 	rtc->rtc_dev->max_user_freq = 256;
 
+	if (rtc->capabilities & RTC_CAP_4_DIGIT_YEAR) {
+		rtc->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_1900;
+		rtc->rtc_dev->range_max = RTC_TIMESTAMP_END_9999;
+	} else {
+		rtc->rtc_dev->range_min = mktime64(1999, 1, 1, 0, 0, 0);
+		rtc->rtc_dev->range_max = mktime64(2098, 12, 31, 23, 59, 59);
+	}
+
 	ret = rtc_register_device(rtc->rtc_dev);
 	if (ret)
 		goto err_unmap;
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index f89bfbb54902..588120ba372c 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -165,6 +165,7 @@ struct rtc_device {
 #define RTC_TIMESTAMP_BEGIN_1900	-2208989361LL /* 1900-01-01 00:00:00 */
 #define RTC_TIMESTAMP_BEGIN_2000	946684800LL /* 2000-01-01 00:00:00 */
 #define RTC_TIMESTAMP_END_2099		4102444799LL /* 2099-12-31 23:59:59 */
+#define RTC_TIMESTAMP_END_9999		253402300799LL /* 9999-12-31 23:59:59 */
 
 extern struct rtc_device *devm_rtc_device_register(struct device *dev,
 					const char *name,
-- 
2.20.1

