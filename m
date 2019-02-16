Return-Path: <SRS0=bWBc=QX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21004C43381
	for <linux-rtc@archiver.kernel.org>; Sat, 16 Feb 2019 01:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD61222A1
	for <linux-rtc@archiver.kernel.org>; Sat, 16 Feb 2019 01:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbfBPBWV (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 15 Feb 2019 20:22:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbfBPBWU (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 15 Feb 2019 20:22:20 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6B248295561866BC362C;
        Sat, 16 Feb 2019 09:22:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 16 Feb 2019 09:22:09 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nick Crews <ncrews@chromium.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-rtc@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] rtc: wilco_ec: Make some functions static
Date:   Sat, 16 Feb 2019 01:36:03 +0000
Message-ID: <20190216013603.117969-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Fixes the following sparse warnings:

drivers/rtc/rtc-wilco-ec.c:72:5: warning:
 symbol 'wilco_ec_rtc_read' was not declared. Should it be static?
drivers/rtc/rtc-wilco-ec.c:106:5: warning:
 symbol 'wilco_ec_rtc_write' was not declared. Should it be static?

Fixes: 79c4ec4869b5 ("platform/chrome: wilco_ec: Add RTC driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/rtc/rtc-wilco-ec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
index 35cc56114c1c..e62bda0cb53e 100644
--- a/drivers/rtc/rtc-wilco-ec.c
+++ b/drivers/rtc/rtc-wilco-ec.c
@@ -69,7 +69,7 @@ struct ec_rtc_write {
 	u8 weekday;
 } __packed;
 
-int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
+static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
 {
 	struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
 	u8 param = EC_CMOS_TOD_READ;
@@ -103,7 +103,7 @@ int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm)
+static int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm)
 {
 	struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
 	struct ec_rtc_write rtc;



