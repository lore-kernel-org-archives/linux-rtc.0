Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5774BC83F13
	for <linux-rtc@archiver.kernel.org>; Sun, 27 Aug 2023 21:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjH0Vq6 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 27 Aug 2023 17:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjH0Vq5 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 27 Aug 2023 17:46:57 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95D4119;
        Sun, 27 Aug 2023 14:46:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03591FF803;
        Sun, 27 Aug 2023 21:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693172812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3G8F82twzUxubTRe+spHQSEIY4WH7jzwONQD/yOtQ4I=;
        b=Di4DsPP2+xRpcZEewdo6boJUQaQATSzHQWv3R+99f6H5IzkJ9C4xRwVmA7QQV4oII/jPWU
        k1s82kHhVKU3E3NjPj5WZBEtFYs3yK6JiRijvZ+iJe2ZVAX8RhDVEqg/TTE8LNZKAi9mrr
        EgVqOzEQhm0Y/dP5CdYYg3qzl+JO+AudvnG0FkNnpcNKrSc209Kmjr3yJD1p5BHbp0NVKD
        WgRIIpYcRPxVz3Mx4RU8Yh/HZib3WaKS/3qxrcbhYJpnzXCPgoRgkugTWJn8ybp7vB1Gxd
        Qi0PyQfIRYMib10Mr1X/YpGslW32cV9aAniT0MSO076pmQIVIOJe7pdgeXKidw==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtc: pcf2127: remove useless check
Date:   Sun, 27 Aug 2023 23:46:49 +0200
Message-ID: <20230827214649.537095-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

This check is only useful when introducing support for a new RTC in the
driver. Cut down the number of strings in th driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf2127.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index de8164e1b562..9c04c4e1a49c 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -1054,15 +1054,6 @@ static int pcf2127_enable_ts(struct device *dev, int ts_id)
 		return ret;
 	}
 
-	/* TS input pin driven to GND detection is supported by all variants.
-	 * Make sure that interrupt bit is defined.
-	 */
-	if (pcf2127->cfg->ts[ts_id].gnd_detect_bit == 0) {
-		dev_err(dev, "%s: tamper detection to GND configuration invalid\n",
-			__func__);
-		return -EINVAL;
-	}
-
 	/*
 	 * Enable interrupt generation when TSF timestamp flag is set.
 	 * Interrupt signals are open-drain outputs and can be left floating if
-- 
2.41.0

