Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52774 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753010AbdJLWGw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 18:06:52 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 1/2] rtc: omap: fix error path when pinctrl_register fails
Date: Fri, 13 Oct 2017 00:06:44 +0200
Message-Id: <20171012220645.8704-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

If pinctrl_register() fails probe will return with an error without locking
the RTC and disabling pm_runtime.
Set ret and jump to err instead.

Fixes: 97ea1906b3c2 ("rtc: omap: Support ext_wakeup configuration")
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-omap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 13f7cd11c07e..3bdc041fc2e9 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -830,7 +830,8 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	rtc->pctldev = pinctrl_register(&rtc_pinctrl_desc, &pdev->dev, rtc);
 	if (IS_ERR(rtc->pctldev)) {
 		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
-		return PTR_ERR(rtc->pctldev);
+		ret = PTR_ERR(rtc->pctldev);
+		goto err;
 	}
 
 	return 0;
-- 
2.14.2
