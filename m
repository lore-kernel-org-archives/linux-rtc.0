Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F93C6FD1C
	for <linux-rtc@archiver.kernel.org>; Thu, 23 Mar 2023 08:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCWI7z (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 23 Mar 2023 04:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjCWI7u (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 23 Mar 2023 04:59:50 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B0830E7;
        Thu, 23 Mar 2023 01:59:48 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32N8xbdD061805;
        Thu, 23 Mar 2023 03:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679561977;
        bh=vlYds6UzcqS+9v3/F0rZRe6bOfqsdIBTaQvZgdI4u2c=;
        h=From:To:CC:Subject:Date;
        b=VZzlWKVtDleJwYwUM/AAXdhAttqEKsPJONO/Pk6KYeak4XUDgUxzk76eATipmkx+w
         xvTsheHkZMrbkFu0DQgjOXMCxQ3mtoVJkjZo7wkeBtrVhpgmKWgiTKS09ua27wtaYI
         FKqhI9mihd5k91HXgPkMu9LPQjzDtmHO1jZSpO+g=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32N8xbQZ049521
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Mar 2023 03:59:37 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 23
 Mar 2023 03:59:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 23 Mar 2023 03:59:37 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32N8xZlr027625;
        Thu, 23 Mar 2023 03:59:36 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        <linux-rtc@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] rtc: k3: handle errors while enabling wake irq
Date:   Thu, 23 Mar 2023 14:29:04 +0530
Message-ID: <20230323085904.957999-1-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Due to the potential failure of enable_irq_wake(), it would be better to
return error if it fails.

Fixes: b09d633575e5 ("rtc: Introduce ti-k3-rtc")
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Changelog:
Address the comments from Alexandre Belloni

V1 link:
https://lore.kernel.org/linux-rtc/20230323081942.951542-1-d-gole@ti.com

 drivers/rtc/rtc-ti-k3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ti-k3.c b/drivers/rtc/rtc-ti-k3.c
index ba23163cc042..0d90fe923355 100644
--- a/drivers/rtc/rtc-ti-k3.c
+++ b/drivers/rtc/rtc-ti-k3.c
@@ -632,7 +632,8 @@ static int __maybe_unused ti_k3_rtc_suspend(struct device *dev)
 	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev))
-		enable_irq_wake(priv->irq);
+		return enable_irq_wake(priv->irq);
+
 	return 0;
 }
 
-- 
2.25.1

