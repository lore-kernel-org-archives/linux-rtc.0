Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:56439 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbeABJpE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Jan 2018 04:45:04 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Patrick Bruenn <p.bruenn@beckhoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: mxc_v2: remove __exit annotation
Date: Tue,  2 Jan 2018 10:43:33 +0100
Message-Id: <20180102094443.3246258-1-arnd@arndb.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The mxc_rtc_remove is incorrectly annotated as __exit:

`mxc_rtc_remove' referenced in section `.data' of drivers/rtc/rtc-mxc_v2.o: defined in discarded section `.exit.text' of drivers/rtc/rtc-mxc_v2.o

This should not be done, as devices can be dynamically bound
and unbound to a driver.

Fixes: 54c47014b474 ("rtc: add mxc driver for i.MX53 SRTC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-mxc_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
index b637095b0716..77a065e23a84 100644
--- a/drivers/rtc/rtc-mxc_v2.c
+++ b/drivers/rtc/rtc-mxc_v2.c
@@ -368,7 +368,7 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __exit mxc_rtc_remove(struct platform_device *pdev)
+static int mxc_rtc_remove(struct platform_device *pdev)
 {
 	struct mxc_rtc_data *pdata = platform_get_drvdata(pdev);
 
-- 
2.9.0
