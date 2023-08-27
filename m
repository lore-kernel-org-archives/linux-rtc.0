Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B442FC83F15
	for <linux-rtc@archiver.kernel.org>; Sun, 27 Aug 2023 22:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjH0WRZ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 27 Aug 2023 18:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjH0WRB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 27 Aug 2023 18:17:01 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4986B6;
        Sun, 27 Aug 2023 15:16:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEE05E0002;
        Sun, 27 Aug 2023 22:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693174616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IEBggQJcGAS2ZTc+gnah+Y1oXvRlQWb/y/kodguClMc=;
        b=Aa6BsT7BThDBVLPQsE4BoCEmWtZeyLWKR2IXiOyVlGRZ9GjobAqglzXF9I6NaC0LNQyuYn
        NwU2gaJ+f0Y9iBOt6B1Fx3ZsNZ3n975TeuLkzUy62M6eT0y70lKObV9qViXtiWLWFhQnGa
        nNfP5+z/k1iBMGM6YwglepBtLozr6dDI1SE7T7Q79zOVuSw6fYGIslo4uKqVxz6lYD7kTx
        1zxG3cOkwXZoBmErMO43HsVYhnAdyBeyQh+AzbA74CiaP3KYqDf2KHy5l1easYKjQfCC+M
        hVuthTm4BMrjDOg4LRDszeQLvK52tfxNjaOObqU+uFXPdivU+hMLHCg81t508Q==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] rtc: sun6i: remove unnecessary message
Date:   Mon, 28 Aug 2023 00:16:40 +0200
Message-ID: <20230827221643.544259-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The core already print a message once the rtc is successfully registered,
it is not necessary to print an other one.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sun6i.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 753a2d9c8a17..8e0c66906103 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -846,8 +846,6 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	dev_info(&pdev->dev, "RTC enabled\n");
-
 	return 0;
 }
 
-- 
2.41.0

