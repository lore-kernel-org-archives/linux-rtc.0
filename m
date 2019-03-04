Return-Path: <SRS0=54M4=RH=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF1EC4360F
	for <linux-rtc@archiver.kernel.org>; Mon,  4 Mar 2019 10:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B105E2082F
	for <linux-rtc@archiver.kernel.org>; Mon,  4 Mar 2019 10:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfCDKFB (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:05:01 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:47685 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfCDKFB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 4 Mar 2019 05:05:01 -0500
X-Originating-IP: 82.246.155.60
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0A4F324000A;
        Mon,  4 Mar 2019 10:04:58 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: rv8803: let the core handle range
Date:   Mon,  4 Mar 2019 11:04:56 +0100
Message-Id: <20190304100456.28483-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Let the core handle the RTC range instead of open coding it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv8803.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 450a0b831a2d..df000a68d6b1 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -236,9 +236,6 @@ static int rv8803_set_time(struct device *dev, struct rtc_time *tm)
 	u8 date[7];
 	int ctrl, flags, ret;
 
-	if ((tm->tm_year < 100) || (tm->tm_year > 199))
-		return -EINVAL;
-
 	ctrl = rv8803_read_reg(rv8803->client, RV8803_CTRL);
 	if (ctrl < 0)
 		return ctrl;
@@ -602,6 +599,8 @@ static int rv8803_probe(struct i2c_client *client,
 
 	rv8803->rtc->ops = &rv8803_rtc_ops;
 	rv8803->rtc->nvram_old_abi = true;
+	rv8803->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rv8803->rtc->range_max = RTC_TIMESTAMP_END_2099;
 	err = rtc_register_device(rv8803->rtc);
 	if (err)
 		return err;
-- 
2.20.1

