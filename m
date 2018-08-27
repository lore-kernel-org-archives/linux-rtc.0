Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:41788 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0NIy (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 27 Aug 2018 09:08:54 -0400
Date: Mon, 27 Aug 2018 12:22:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Denis Osterland <Denis.Osterland@diehl.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] rtc: sysfs: fix NULL check in rtc_add_groups()
Message-ID: <20180827092234.mj44ruwkglbor3e5@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

devm_kcalloc() returns NULL, it never returns error pointers.  In the
current code we would return PTR_ERR(NULL) which is success, instead of
returning the -ENOMEM error code.

Fixes: a0a1a1ba3032 ("rtc: sysfs: facilitate attribute add to rtc device")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index f1ff30ade534..9746c32eee2e 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -338,8 +338,8 @@ int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
 
 	new_cnt = old_cnt + add_cnt + 1;
 	groups = devm_kcalloc(&rtc->dev, new_cnt, sizeof(*groups), GFP_KERNEL);
-	if (IS_ERR_OR_NULL(groups))
-		return PTR_ERR(groups);
+	if (!groups)
+		return -ENOMEM;
 	memcpy(groups, rtc->dev.groups, old_cnt * sizeof(*groups));
 	memcpy(groups + old_cnt, grps, add_cnt * sizeof(*groups));
 	groups[old_cnt + add_cnt] = NULL;
