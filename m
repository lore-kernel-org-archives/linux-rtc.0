Return-Path: <SRS0=SXQY=SF=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224FCC4360F
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Apr 2019 15:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD2F2075E
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Apr 2019 15:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfDCPUB (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:20:01 -0400
Received: from sauhun.de ([88.99.104.3]:49514 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfDCPUB (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 3 Apr 2019 11:20:01 -0400
Received: from localhost (p54B3311F.dip0.t-ipconnect.de [84.179.49.31])
        by pokefinder.org (Postfix) with ESMTPSA id 857D52C282F;
        Wed,  3 Apr 2019 17:19:59 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] rtc: don't reference bogus function pointer in kdoc
Date:   Wed,  3 Apr 2019 17:19:52 +0200
Message-Id: <20190403151952.8415-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The mentioned function pointer is long gone since early 2011. Remove the
reference in the comment and reword it slightly.

Fixes: 51ba60c5bb3b ("RTC: Cleanup rtc_class_ops->update_irq_enable()")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

I stumbled over this when trying to understand UIE handling during my
DA9063 debugging session.

 drivers/rtc/interface.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 98d9c87b0d1b..4ac33b931f3d 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -571,10 +571,9 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 	mutex_unlock(&rtc->ops_lock);
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 	/*
-	 * Enable emulation if the driver did not provide
-	 * the update_irq_enable function pointer or if returned
-	 * -EINVAL to signal that it has been configured without
-	 * interrupts or that are not available at the moment.
+	 * Enable emulation if the driver returned -EINVAL to signal that it has
+	 * been configured without interrupts or they are not available at the
+	 * moment.
 	 */
 	if (err == -EINVAL)
 		err = rtc_dev_update_irq_enable_emul(rtc, enabled);
-- 
2.19.1

