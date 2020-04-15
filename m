Return-Path: <SRS0=khO5=57=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629E1C2BA19
	for <linux-rtc@archiver.kernel.org>; Wed, 15 Apr 2020 13:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3127B2076D
	for <linux-rtc@archiver.kernel.org>; Wed, 15 Apr 2020 13:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586956455;
	bh=0rcL6w+U3QxTPUxJYsUdrnHmbxHPVlcjvRNL/c8lbPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CLd8Ku4jJ/Y8FbeHkTKd6nbMzGNP86oqasee9l6fAklLoNk5HRtsYJCrzzhhw4VBn
	 l4dsByihLAVij2mS2CkEiZ8apsqoqePoFgSz+AQgLtz48nxvni0T9avIhyC4XM3ULG
	 Bf9sCdy9nRLbXdny0e8LtrudiNNDopO0QlyrrR/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506172AbgDONOG (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897048AbgDOLfY (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 15 Apr 2020 07:35:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A04B220768;
        Wed, 15 Apr 2020 11:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950524;
        bh=0rcL6w+U3QxTPUxJYsUdrnHmbxHPVlcjvRNL/c8lbPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDfEd735AGEUvk/tRW1pQ11y6yI2qsQBKgIDaSuWgxYsxMDd4RGQUOOe25VFe/6KX
         JKtdA28nDJeRrqXzN/KrWxbS9b0n9ZxguFLUGEdVnTrWzHTeo508gwvmb0/Ug4JrBv
         O6hI5L4R3GGHk9PXlLVwJwUekdg0s+lptcxriX8k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 033/129] rtc: 88pm860x: fix possible race condition
Date:   Wed, 15 Apr 2020 07:33:08 -0400
Message-Id: <20200415113445.11881-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 9cf4789e6e4673d0b2c96fa6bb0c35e81b43111a ]

The RTC IRQ is requested before the struct rtc_device is allocated,
this may lead to a NULL pointer dereference in the IRQ handler.

To fix this issue, allocating the rtc_device struct before requesting
the RTC IRQ using devm_rtc_allocate_device, and use rtc_register_device
to register the RTC device.

Also remove the unnecessary error message as the core already prints the
info.

Link: https://lore.kernel.org/r/20200311223956.51352-1-alexandre.belloni@bootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-88pm860x.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-88pm860x.c b/drivers/rtc/rtc-88pm860x.c
index 4743b16a8d849..1526402e126b2 100644
--- a/drivers/rtc/rtc-88pm860x.c
+++ b/drivers/rtc/rtc-88pm860x.c
@@ -336,6 +336,10 @@ static int pm860x_rtc_probe(struct platform_device *pdev)
 	info->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, info);
 
+	info->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(info->rtc_dev))
+		return PTR_ERR(info->rtc_dev);
+
 	ret = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
 					rtc_update_handler, IRQF_ONESHOT, "rtc",
 					info);
@@ -377,13 +381,11 @@ static int pm860x_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
-	info->rtc_dev = devm_rtc_device_register(&pdev->dev, "88pm860x-rtc",
-					    &pm860x_rtc_ops, THIS_MODULE);
-	ret = PTR_ERR(info->rtc_dev);
-	if (IS_ERR(info->rtc_dev)) {
-		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
+	info->rtc_dev->ops = &pm860x_rtc_ops;
+
+	ret = rtc_register_device(info->rtc_dev);
+	if (ret)
 		return ret;
-	}
 
 	/*
 	 * enable internal XO instead of internal 3.25MHz clock since it can
-- 
2.20.1

