Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34457 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760179AbdKRCDP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 17 Nov 2017 21:03:15 -0500
Received: by mail-pg0-f67.google.com with SMTP id 4so3242078pge.1
        for <linux-rtc@vger.kernel.org>; Fri, 17 Nov 2017 18:03:15 -0800 (PST)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: linux-rtc@vger.kernel.org
Cc: alexandre.belloni@free-electrons.com,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] rtc: ds1307: Remove r9701_remove function
Date: Sat, 18 Nov 2017 11:03:10 +0900
Message-Id: <20171118020310.7284-1-iwamatsu@nigauri.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

r9701_remove function is now empty, remove it.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/rtc/rtc-r9701.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/rtc/rtc-r9701.c b/drivers/rtc/rtc-r9701.c
index 83d2bcca6a8f..b6c5eb97051c 100644
--- a/drivers/rtc/rtc-r9701.c
+++ b/drivers/rtc/rtc-r9701.c
@@ -164,17 +164,11 @@ static int r9701_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int r9701_remove(struct spi_device *spi)
-{
-	return 0;
-}
-
 static struct spi_driver r9701_driver = {
 	.driver = {
 		.name	= "rtc-r9701",
 	},
 	.probe	= r9701_probe,
-	.remove = r9701_remove,
 };
 
 module_spi_driver(r9701_driver);
-- 
2.15.0
