Return-Path: <SRS0=ZUbX=YO=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FF8CA9EB0
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Oct 2019 15:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17EA2084B
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Oct 2019 15:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfJUP6S (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:58:18 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38151 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfJUP6L (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 21 Oct 2019 11:58:11 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id EAFFD60005;
        Mon, 21 Oct 2019 15:58:08 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/4] rtc: sirfsoc: remove .remove
Date:   Mon, 21 Oct 2019 17:58:05 +0200
Message-Id: <20191021155806.3625-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021155806.3625-1-alexandre.belloni@bootlin.com>
References: <20191021155806.3625-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

dpm_sysfs_remove() and device_pm_remove() are already called by
device_del() on device removal so there is no need to call
device_init_wakeup(dev, false) from the driver and it allows to remove the
.remove callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sirfsoc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/rtc/rtc-sirfsoc.c b/drivers/rtc/rtc-sirfsoc.c
index c759c55359a1..a2c9c55667cd 100644
--- a/drivers/rtc/rtc-sirfsoc.c
+++ b/drivers/rtc/rtc-sirfsoc.c
@@ -365,13 +365,6 @@ static int sirfsoc_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sirfsoc_rtc_remove(struct platform_device *pdev)
-{
-	device_init_wakeup(&pdev->dev, 0);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int sirfsoc_rtc_suspend(struct device *dev)
 {
@@ -450,7 +443,6 @@ static struct platform_driver sirfsoc_rtc_driver = {
 		.of_match_table = sirfsoc_rtc_of_match,
 	},
 	.probe = sirfsoc_rtc_probe,
-	.remove = sirfsoc_rtc_remove,
 };
 module_platform_driver(sirfsoc_rtc_driver);
 
-- 
2.21.0

