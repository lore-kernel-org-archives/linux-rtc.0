Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:8028 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751585AbdIRTKa (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 18 Sep 2017 15:10:30 -0400
From: Mathieu Malaterre <malat@debian.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Alex Smith <alex.smith@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: jz4740: fix loading of rtc driver
Date: Mon, 18 Sep 2017 21:10:13 +0200
Message-Id: <20170918191014.28106-1-malat@debian.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The current timeout for waiting for WRDY is not always sufficient. Always
increase it to 10000 even on JZ4740. This is technically only required on
JZ4780, where the current symptoms seen after a hard reboot are:

  jz4740-rtc 10003000.rtc: rtc core: registered 10003000.rtc as rtc0
  jz4740-rtc 10003000.rtc: Could not write to RTC registers
  jz4740-rtc: probe of 10003000.rtc failed with error -5

Suggested-by: Alex Smith <alex.smith@imgtec.com>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/rtc/rtc-jz4740.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index c9536fb0ba4a..ff65a7d2b9c9 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -82,7 +82,7 @@ static inline uint32_t jz4740_rtc_reg_read(struct jz4740_rtc *rtc, size_t reg)
 static int jz4740_rtc_wait_write_ready(struct jz4740_rtc *rtc)
 {
 	uint32_t ctrl;
-	int timeout = 1000;
+	int timeout = 10000;
 
 	do {
 		ctrl = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_CTRL);
@@ -94,7 +94,7 @@ static int jz4740_rtc_wait_write_ready(struct jz4740_rtc *rtc)
 static inline int jz4780_rtc_enable_write(struct jz4740_rtc *rtc)
 {
 	uint32_t ctrl;
-	int ret, timeout = 1000;
+	int ret, timeout = 10000;
 
 	ret = jz4740_rtc_wait_write_ready(rtc);
 	if (ret != 0)
-- 
2.11.0
