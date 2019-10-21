Return-Path: <SRS0=ZUbX=YO=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B09CA9EB0
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Oct 2019 15:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4422E2084B
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Oct 2019 15:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfJUP6O (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:58:14 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:43933 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbfJUP6L (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 21 Oct 2019 11:58:11 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 009A2100003;
        Mon, 21 Oct 2019 15:58:09 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/4] rtc: sc27xx: remove .remove
Date:   Mon, 21 Oct 2019 17:58:06 +0200
Message-Id: <20191021155806.3625-4-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-sc27xx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index b95676899750..36810dd40cd3 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -661,12 +661,6 @@ static int sprd_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sprd_rtc_remove(struct platform_device *pdev)
-{
-	device_init_wakeup(&pdev->dev, 0);
-	return 0;
-}
-
 static const struct of_device_id sprd_rtc_of_match[] = {
 	{ .compatible = "sprd,sc2731-rtc", },
 	{ },
@@ -679,7 +673,6 @@ static struct platform_driver sprd_rtc_driver = {
 		.of_match_table = sprd_rtc_of_match,
 	},
 	.probe	= sprd_rtc_probe,
-	.remove = sprd_rtc_remove,
 };
 module_platform_driver(sprd_rtc_driver);
 
-- 
2.21.0

