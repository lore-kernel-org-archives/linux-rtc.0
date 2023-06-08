Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D118CC7EE29
	for <linux-rtc@archiver.kernel.org>; Thu,  8 Jun 2023 19:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjFHTmH (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjFHTmG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Jun 2023 15:42:06 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD812E61
        for <linux-rtc@vger.kernel.org>; Thu,  8 Jun 2023 12:42:05 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 7L2uq3N8w8gUX7L2uqbsxa; Thu, 08 Jun 2023 21:11:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686251507;
        bh=rMbp0A0nCVWbFNITEeTCYWZN0nSZsQCHQh6V232GAHE=;
        h=From:To:Cc:Subject:Date;
        b=rx4ykTJ6CnQ8aiS9/VY7PU0mBKR/mRJ1mhqdYbBlA9YI8mM9rK3+ZCenaCyWoaNsE
         Z3UMLlZoSRo2dFVZWfzKuU0WrhfX+k8XikdQ+VQnlPqI/hus9WzTrxcwdjRzjwI2iN
         ha5olxDqPTDlqHdnECJGd/XuLWuk/WWc1KRmym4b7XQakdGrKqXRzHH4jdG8MMQbd/
         1X3/i+2Xt6nHhi5REkkYWaJKtW1+YZ2wwvXXHO3sQ+E5dIRkpeFSbIRDuULSbo03uN
         nucZmyyyGzqTOik/a0M38rXnk56MIbc9bjWczMwLo7T4QxHFWLszksPtesOJa2igmp
         Am5Yeq9L6AIQg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Jun 2023 21:11:47 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: [PATCH 1/2] rtc: st-lpc: Release some resources in st_rtc_probe() in case of error
Date:   Thu,  8 Jun 2023 21:11:42 +0200
Message-Id: <866af6adbc7454a7b4505eb6c28fbdc86ccff39e.1686251455.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

If an error occurs after clk_get(), the corresponding resources should be
released.

Use devm_clk_get() to fix it.

Fixes: b5b2bdfc2893 ("rtc: st: Add new driver for ST's LPC RTC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/rtc/rtc-st-lpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 0f8e4231098e..d04d46f9cc65 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -228,7 +228,7 @@ static int st_rtc_probe(struct platform_device *pdev)
 	enable_irq_wake(rtc->irq);
 	disable_irq(rtc->irq);
 
-	rtc->clk = clk_get(&pdev->dev, NULL);
+	rtc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(rtc->clk)) {
 		dev_err(&pdev->dev, "Unable to request clock\n");
 		return PTR_ERR(rtc->clk);
-- 
2.34.1

