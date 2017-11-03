Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:53947 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756217AbdKCRdf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 3 Nov 2017 13:33:35 -0400
Received: by mail-qt0-f193.google.com with SMTP id n61so4117573qte.10
        for <linux-rtc@vger.kernel.org>; Fri, 03 Nov 2017 10:33:35 -0700 (PDT)
From: Akshay Bhat <akshay.bhat@timesys.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akshay Bhat <akshay.bhat@timesys.com>
Subject: [PATCH 2/3] rtc: rx8010: Specify correct address for RX8010_RESV31
Date: Fri,  3 Nov 2017 13:32:40 -0400
Message-Id: <1509730361-23905-2-git-send-email-akshay.bhat@timesys.com>
In-Reply-To: <1509730361-23905-1-git-send-email-akshay.bhat@timesys.com>
References: <1509730361-23905-1-git-send-email-akshay.bhat@timesys.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Define for reserved register 31 had the incorrect address. Specify
the correct address.

Reported-by: Jens-Peter Oswald <oswald@lre.de>
Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 drivers/rtc/rtc-rx8010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index f948f75..2e06e5f 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -35,7 +35,7 @@
 #define RX8010_CTRL    0x1F
 /* 0x20 to 0x2F are user registers */
 #define RX8010_RESV30  0x30
-#define RX8010_RESV31  0x32
+#define RX8010_RESV31  0x31
 #define RX8010_IRQ     0x32
 
 #define RX8010_EXT_WADA  BIT(3)
-- 
2.7.4
