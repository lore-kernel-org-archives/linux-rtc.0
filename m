Return-Path: <SRS0=SQ63=S2=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA8C10F11
	for <linux-rtc@archiver.kernel.org>; Wed, 24 Apr 2019 14:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A73C2084F
	for <linux-rtc@archiver.kernel.org>; Wed, 24 Apr 2019 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117748;
	bh=9OI4e7G5h1rVd+XwFPX8jug7HwMBucdz4jR5TW70JEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u3r0z1k7t/Y9p/UxDah39tJvRORfxMFJJtCNPBwoq7oV5FesUDclcFTX++MflFqg/
	 RnUWJYPr8/RcZg8ZuVlCwJZiLj1VM5KbQ+/gy6FdSvZMn5zlujHI0tbx+lepkne93S
	 k00hVHNwKwufK7Jn8vK0wT4Ok1gdCP8ZNvMF9tAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbfDXOzm (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732703AbfDXOuv (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 24 Apr 2019 10:50:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238FD21903;
        Wed, 24 Apr 2019 14:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117450;
        bh=9OI4e7G5h1rVd+XwFPX8jug7HwMBucdz4jR5TW70JEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZ0glvXL5/Vc5d6PiLKiPBJFFWTJexyHODUS/Awt59aVyfmqFCwQhJM/Ycf/qz2KA
         O8sPpvelH8AidZxvGq7s8+thK5V+3fwvbH4TYkcahpPgNqd/dZQbUD7/kBs+s2DLID
         J1vy0cGTJUliLZDe+R1uO7WWld84KjO/mfZGt4Xc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 16/28] rtc: da9063: set uie_unsupported when relevant
Date:   Wed, 24 Apr 2019 10:50:00 -0400
Message-Id: <20190424145012.30886-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145012.30886-1-sashal@kernel.org>
References: <20190424145012.30886-1-sashal@kernel.org>
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
index f85cae240f12..7e92e491c2e7 100644
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

