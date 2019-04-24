Return-Path: <SRS0=SQ63=S2=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12710C282E1
	for <linux-rtc@archiver.kernel.org>; Wed, 24 Apr 2019 14:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C28218FC
	for <linux-rtc@archiver.kernel.org>; Wed, 24 Apr 2019 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117001;
	bh=JB4O/BtU8CAnzEOASc8eo/2jp3RpBAdJI4FR+KJI/IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hbiRPUbEUO+TVfvbXXAh9t9BZOVqj6hZ1/u+BzcW+LH1AAbQmqtuGorVVJLmg5yuJ
	 7C0F9GzaMbdB25IPYVBiNo8mTVP3RadXBiY6xHgPg9R0CpH7QgXWmiQP457DOCN32+
	 thmcKZDEZfKdvrO31ntgQOJvq84nwCR0e80Ub3FE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfDXOkU (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731356AbfDXOkS (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 24 Apr 2019 10:40:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D6A21909;
        Wed, 24 Apr 2019 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116818;
        bh=JB4O/BtU8CAnzEOASc8eo/2jp3RpBAdJI4FR+KJI/IE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdIaGerRy0x16XaPBu64LPXy/f0qyz2JQsB1+WFquZmmh2Udjk9ksa3VcwRmxyAZq
         uPynr2M0vcgrYwlXh4fNEFETossUHCrNOccE2TqonpbDo9zHwdZT5Pz/Ch+/uiExYx
         Fq7cAPvek354q02b3QtA4L5ZB5rbRgp+ZZ/Pbr1c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 29/52] rtc: da9063: set uie_unsupported when relevant
Date:   Wed, 24 Apr 2019 10:38:47 -0400
Message-Id: <20190424143911.28890-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 882c5e552ffd06856de42261460f46e18319d259 ]

The DA9063AD doesn't support alarms on any seconds and its granularity is
the minute. Set uie_unsupported in that case.

Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-da9063.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index b4e054c64bad..69b54e5556c0 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -480,6 +480,13 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
 	rtc->rtc_sync = false;
 
+	/*
+	 * TODO: some models have alarms on a minute boundary but still support
+	 * real hardware interrupts. Add this once the core supports it.
+	 */
+	if (config->rtc_data_start != RTC_SEC)
+		rtc->rtc_dev->uie_unsupported = 1;
+
 	irq_alarm = platform_get_irq_byname(pdev, "ALARM");
 	ret = devm_request_threaded_irq(&pdev->dev, irq_alarm, NULL,
 					da9063_alarm_event,
-- 
2.19.1

