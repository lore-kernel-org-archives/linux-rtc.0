Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37850 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbeBLCi4 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 11 Feb 2018 21:38:56 -0500
Received: by mail-qt0-f195.google.com with SMTP id w1so2111279qti.4
        for <linux-rtc@vger.kernel.org>; Sun, 11 Feb 2018 18:38:56 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: alexandre.belloni@free-electrons.com
Cc: p.bruenn@beckhoff.com, linux-rtc@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] rtc: mxc_v2: Fix _iomem pointer notation
Date: Mon, 12 Feb 2018 00:38:46 -0200
Message-Id: <1518403126-28456-1-git-send-email-festevam@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

Fix the iomem pointer notation in order to fix the following sparse
warnings:

drivers/rtc/rtc-mxc_v2.c:280:18: warning: incorrect type in argument 1 (different address spaces)
drivers/rtc/rtc-mxc_v2.c:280:18:    expected void const volatile [noderef] <asn:2>*addr
drivers/rtc/rtc-mxc_v2.c:280:18:    got void *[noderef] <asn:2>ioaddr
drivers/rtc/rtc-mxc_v2.c:329:44: warning: incorrect type in argument 1 (different address spaces)
drivers/rtc/rtc-mxc_v2.c:329:44:    expected void *[noderef] <asn:2>ioaddr
drivers/rtc/rtc-mxc_v2.c:329:44:    got void [noderef] <asn:2>*
drivers/rtc/rtc-mxc_v2.c:339:44: warning: incorrect type in argument 1 (different address spaces)
drivers/rtc/rtc-mxc_v2.c:339:44:    expected void *[noderef] <asn:2>ioaddr
drivers/rtc/rtc-mxc_v2.c:339:44:    got void [noderef] <asn:2>*

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/rtc/rtc-mxc_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
index 784221d..9e14efb 100644
--- a/drivers/rtc/rtc-mxc_v2.c
+++ b/drivers/rtc/rtc-mxc_v2.c
@@ -273,7 +273,7 @@ static const struct rtc_class_ops mxc_rtc_ops = {
 	.alarm_irq_enable = mxc_rtc_alarm_irq_enable,
 };
 
-static int mxc_rtc_wait_for_flag(void *__iomem ioaddr, int flag)
+static int mxc_rtc_wait_for_flag(void __iomem *ioaddr, int flag)
 {
 	unsigned int timeout = REG_READ_TIMEOUT;
 
-- 
2.7.4
