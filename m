Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8938C433FE
	for <linux-rtc@archiver.kernel.org>; Wed,  9 Mar 2022 16:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiCIQgI (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbiCIQaM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 9 Mar 2022 11:30:12 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C6EDCE0C;
        Wed,  9 Mar 2022 08:23:36 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 031261C0007;
        Wed,  9 Mar 2022 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x/9FC3dqS4J5aUJ7Jx2MXbLIRNUGfD6UD255BevEblg=;
        b=S+2Qll1ycSAlQNIi4fDz0YWCLIotNynzsugI1QJUu+0rZWTkKwgEZj5EQk/DHw7Y4+1EIx
        Bwjdo4KVWK8oGung3666ZuHfKnebIbsEZR9laK38KWGor3nsQP4iRJK3urLiJDmdsaYyt7
        W0jzKMVRB184AnkWU5VVWIQIxIv2+VYNEz68SIjx4vwVcZ9IpDNk1/88tGCRaG10UajC6C
        R4c7Ww6+Zjo2VwK+IWfSgnAddsGWTI7VnnoGT1jQUhWYhZzSwl9j7lOzP7eEmO7Cj4vUEa
        Dec9rbyZJOwSH+rIypt7UA+SNn8oX/FuHhPsFZLyYhS21HOLg4PvAx3ezzLLCA==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/29] rtc: spear: drop uie_unsupported
Date:   Wed,  9 Mar 2022 17:22:51 +0100
Message-Id: <20220309162301.61679-20-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Since commitc9f5c7e7a84f ("rtc: rtc-spear: Provide flag for no support of
UIE mode") which was in 2012, the core changed a lot and UIE are now
supported using regular alarms. Drop uie_unsupported now to reflect that.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-spear.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index e386bd714b52..c395af3ebc91 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -387,7 +387,6 @@ static int spear_rtc_probe(struct platform_device *pdev)
 	config->rtc->ops = &spear_rtc_ops;
 	config->rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
 	config->rtc->range_min = RTC_TIMESTAMP_END_9999;
-	config->rtc->uie_unsupported = 1;
 
 	status = devm_rtc_register_device(config->rtc);
 	if (status)
-- 
2.35.1

