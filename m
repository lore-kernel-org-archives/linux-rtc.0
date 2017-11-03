Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:49679 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756153AbdKCRdH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 3 Nov 2017 13:33:07 -0400
Received: by mail-qk0-f195.google.com with SMTP id q83so4115430qke.6
        for <linux-rtc@vger.kernel.org>; Fri, 03 Nov 2017 10:33:06 -0700 (PDT)
From: Akshay Bhat <akshay.bhat@timesys.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akshay Bhat <akshay.bhat@timesys.com>
Subject: [PATCH 1/3] rtc: rx8010: Remove duplicate define
Date: Fri,  3 Nov 2017 13:32:39 -0400
Message-Id: <1509730361-23905-1-git-send-email-akshay.bhat@timesys.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Remove duplicate define for RX8010_YEAR

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 drivers/rtc/rtc-rx8010.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 1ed3403..f948f75 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -24,7 +24,6 @@
 #define RX8010_MDAY    0x14
 #define RX8010_MONTH   0x15
 #define RX8010_YEAR    0x16
-#define RX8010_YEAR    0x16
 #define RX8010_RESV17  0x17
 #define RX8010_ALMIN   0x18
 #define RX8010_ALHOUR  0x19
-- 
2.7.4
