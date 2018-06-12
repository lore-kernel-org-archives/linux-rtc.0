Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:48194 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932373AbeFLMD2 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 12 Jun 2018 08:03:28 -0400
Date: Tue, 12 Jun 2018 15:03:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] rtc: mrst: fix error code in probe()
Message-ID: <20180612120302.kprwknomakzg7bdn@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

We should be returning "retval".  The "mrst_rtc.rtc" variable is a valid
pointer.

Fixes: 32b41f93dcaf ("rtc: mrst: switch to devm functions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index 097a4d4e2aba..1925aaf09093 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -367,10 +367,8 @@ static int vrtc_mrst_do_probe(struct device *dev, struct resource *iomem,
 	}
 
 	retval = rtc_register_device(mrst_rtc.rtc);
-	if (retval) {
-		retval = PTR_ERR(mrst_rtc.rtc);
+	if (retval)
 		goto cleanup0;
-	}
 
 	dev_dbg(dev, "initialised\n");
 	return 0;
