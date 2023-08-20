Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C5FEE4996
	for <linux-rtc@archiver.kernel.org>; Sun, 20 Aug 2023 20:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjHTUiR (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 20 Aug 2023 16:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjHTUiO (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 20 Aug 2023 16:38:14 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3C0118;
        Sun, 20 Aug 2023 13:37:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E5A1C0004;
        Sun, 20 Aug 2023 20:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692563812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yUtefMT07gosJBbgTgNu4VdcZGzI0rus4/1Y01+kc00=;
        b=JtwW6ncnkZ8aI420nBV4QtWYCdvAUtbOqhZK1Y7mwDsmWr3W/pzx72Ufi0oLTru1V8wLZo
        qwLoaW2lxz2xNMWPfKMJOt1P1s8pfOforkd+/bSTcocRwp4WDOTi3j8ric/zA70DzTtLOp
        KhY+TcBNbENdQQbierxgAuORd0NsN8EJwIjCDivqShnXVJTaEx1cxJsF/b399ctdUJ7N3v
        HcElchr2BydBicjE/GvAteJQk8wTHar/U4Kce24tBncrMfjfdWCEs1qGxOP+C9JumB1Unn
        sUMuda+fSYBgCYKoot/9DrROtIhgNF8oqj2qadQcDi/ooa9wYHx+3YDqOas8ZA==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pcf2127: remove useless check
Date:   Sun, 20 Aug 2023 22:36:46 +0200
Message-ID: <20230820203647.243799-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Let's cut down on the number of strings in the driver as returning ret here
will return 0 and the message is only useful when introducing support for a
new RTC in the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf2127.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 78141bb06ab0..8960213ce9da 100644
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
-		return ret;
-	}
-
 	/*
 	 * Enable interrupt generation when TSF timestamp flag is set.
 	 * Interrupt signals are open-drain outputs and can be left floating if
-- 
2.41.0

