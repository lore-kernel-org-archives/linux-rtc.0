Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704B0C433EF
	for <linux-rtc@archiver.kernel.org>; Wed,  9 Mar 2022 16:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbiCIQgK (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbiCIQaa (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 9 Mar 2022 11:30:30 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CB9FBA40;
        Wed,  9 Mar 2022 08:23:54 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C08F11BF205;
        Wed,  9 Mar 2022 16:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jD5tZeMJyZNMNUWfLN3vw5FbsgGz51lMl3mCcg3MPjE=;
        b=BMC5w2NzXVe7zRADn1A6UdYADpO486ZK6WcQC2IMUvL4EAugjInUOP0LipITC/2nqKRUBr
        eNMR26Ia3MTXYuI8hYA3QqkQTSrLZEn3IYP7Bz0+VVCONcj75KrKFKXLbho+83Vur5HuxP
        XrwcP8d1Jy6/r1vrj4i77l5SonEABuYed8q08lFC5YIDooFHS7+5+cJ7SElo0+wF0PSidG
        Yo0MFfxbwwtXfIk9C9Ujy4cUJqXj2Fq2evz+APy9Gh7u7vu+MPvouN2J8bzLS8zucraA9J
        O8i8k3UeMozPMHheJyRwb4zB4RhGDzTirEf1kqyBZUSv/hvz+3Wtg1bdiqUQHw==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/29] rtc: hym8563: switch to RTC_FEATURE_UPDATE_INTERRUPT
Date:   Wed,  9 Mar 2022 17:22:58 +0100
Message-Id: <20220309162301.61679-27-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Stop using uie_unsupported and clear RTC_FEATURE_UPDATE_INTERRUPT instead.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-hym8563.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 78f21f623d89..90e602e99d03 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -545,8 +545,7 @@ static int hym8563_probe(struct i2c_client *client,
 
 	hym8563->rtc->ops = &hym8563_rtc_ops;
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, hym8563->rtc->features);
-	/* the hym8563 alarm only supports a minute accuracy */
-	hym8563->rtc->uie_unsupported = 1;
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, hym8563->rtc->features);
 
 #ifdef CONFIG_COMMON_CLK
 	hym8563_clkout_register_clk(hym8563);
-- 
2.35.1

