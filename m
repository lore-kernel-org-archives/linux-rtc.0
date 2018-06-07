Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:33140 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752570AbeFGI3o (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 7 Jun 2018 04:29:44 -0400
Date: Thu, 7 Jun 2018 11:29:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] rtc: pxa: fix probe function
Message-ID: <20180607082909.iyukeclgrb3dtjsy@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This patch is from static analysis and I don't have the hardware to
to test it.  I think the test is reversed so now the probe function
will return success early and the last part of the function is dead
code.

Fixes: 3cdf4ad9633e ("rtc: pxa: convert to use shared sa1100 functions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index 47304f5664d8..e1887b86fdc7 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -363,7 +363,7 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 	sa1100_rtc->rtar = pxa_rtc->base + 0x4;
 	sa1100_rtc->rttr = pxa_rtc->base + 0xc;
 	ret = sa1100_rtc_init(pdev, sa1100_rtc);
-	if (!ret) {
+	if (ret) {
 		dev_err(dev, "Unable to init SA1100 RTC sub-device\n");
 		return ret;
 	}
