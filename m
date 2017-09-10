Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:49994 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750943AbdIJTkE (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 10 Sep 2017 15:40:04 -0400
From: Mathieu Malaterre <malat@debian.org>
Cc: Mathieu Malaterre <malat@debian.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: jz4740: remove duplicate 'write' in message
Date: Sun, 10 Sep 2017 21:39:57 +0200
Message-Id: <20170910193957.25037-1-malat@debian.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Trivial fix in error message with duplicate 'write'

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/rtc/rtc-jz4740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 36981263caa0..89e05306154e 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -369,7 +369,7 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 		ret = jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SCRATCHPAD, 0x12345678);
 		ret = jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SEC, 0);
 		if (ret) {
-			dev_err(&pdev->dev, "Could not write write to RTC registers\n");
+			dev_err(&pdev->dev, "Could not write to RTC registers\n");
 			return ret;
 		}
 	}
-- 
2.11.0
