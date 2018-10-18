Return-Path: <SRS0=eRiM=M6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B311CECDE43
	for <linux-rtc@archiver.kernel.org>; Thu, 18 Oct 2018 08:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A95921473
	for <linux-rtc@archiver.kernel.org>; Thu, 18 Oct 2018 08:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqOW8k7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A95921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeJRQwz (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:52:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32948 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbeJRQwy (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 18 Oct 2018 12:52:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id s4-v6so14034172plp.0
        for <linux-rtc@vger.kernel.org>; Thu, 18 Oct 2018 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=x1nRgoQUZ83pegJhrhtQ6KjoIL98LywhZ2h6g+wmhPg=;
        b=XqOW8k7jjTgAWLYpZfRfud/yIu2mDZv3OPT7bqPN/Pm289Hvi37fhtx6uKf/M576oE
         Hp8wdCDZJQRo0LC7Zp7EXzQ1ddEJ5+qLB5D0/riHdTy4fpeTFwkqRsdxAleHmBPHBNmR
         OzMUIlKj+UZJ/yUYLMUuvr6dMTYAIRgKmxg00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=x1nRgoQUZ83pegJhrhtQ6KjoIL98LywhZ2h6g+wmhPg=;
        b=jI1lDol8CWiGmPJT5RE347gCe2CPq7uiQ2Xk/0/imTI5i4OaOb9ZynVGoYE2rw2FaN
         ss1lqakAQbLzjg8DyowSBRBM/lU69qp/3nvKcXUCNyf2SeMjfrNa6u9AevxUvB9jHNdS
         KuLfsXp69W9mO8OCCekyvUHdOA6zSLPxAkwRtagda80BvNpcA/5cHz9lg1NB5yO3/avO
         zihpjADxwjOMZiZ9g1PUBr5x6HlIFmkMhTkkvi6axSs00Xez+MVUhKqePUDHlsep/gtW
         P4tNpV2vpPbQu/8n0YT/1DWPJllA9hk71YP0PQHRcZwmcFS7usZtEEdca6Ku8U70kkU2
         kYQA==
X-Gm-Message-State: ABuFfohR65tnn5qNYVbRKZzw9mZKz5uInp6MvgzCoPPE4JhFUfs/wqcZ
        loSeQxd6X8Hl3f4MPn9/1LCelA==
X-Google-Smtp-Source: ACcGV63dWK+HPGo3vMfRcStAgZb5Yi+U9KoasZ9xIA6UaK9RBeGxy9DY5FI9ynon4sDMkQpviv++JQ==
X-Received: by 2002:a17:902:7e0b:: with SMTP id b11-v6mr28875383plm.246.1539852775833;
        Thu, 18 Oct 2018 01:52:55 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x186-v6sm18467528pfb.125.2018.10.18.01.52.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 01:52:54 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH 4/5] rtc: sc27xx: Add check to see if need to enable the alarm interrupt
Date:   Thu, 18 Oct 2018 16:52:29 +0800
Message-Id: <4b0d13b57a64b6ba6ba65c4c2b60319633911427.1539851865.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1539851865.git.baolin.wang@linaro.org>
References: <cover.1539851865.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1539851865.git.baolin.wang@linaro.org>
References: <cover.1539851865.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The RTC interrupt enable register is not put in always-power-on region
supplied by VDDRTC, so we should check if we need enable the alarm
interrupt when system booting.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/rtc-sc27xx.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index 4ecabe6..72bb002 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -563,6 +563,32 @@ static int sprd_rtc_check_power_down(struct sprd_rtc *rtc)
 	return 0;
 }
 
+static int sprd_rtc_check_alarm_int(struct sprd_rtc *rtc)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(rtc->regmap, rtc->base + SPRD_RTC_SPG_VALUE, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * The SPRD_RTC_INT_EN register is not put in always-power-on region
+	 * supplied by VDDRTC, so we should check if we need enable the alarm
+	 * interrupt when system booting.
+	 *
+	 * If we have set SPRD_RTC_POWEROFF_ALM_FLAG which is saved in
+	 * always-power-on region, that means we have set one alarm last time,
+	 * so we should enable the alarm interrupt to help RTC core to see if
+	 * there is an alarm already set in RTC hardware.
+	 */
+	if (!(val & SPRD_RTC_POWEROFF_ALM_FLAG))
+		return 0;
+
+	return regmap_update_bits(rtc->regmap, rtc->base + SPRD_RTC_INT_EN,
+				  SPRD_RTC_ALARM_EN, SPRD_RTC_ALARM_EN);
+}
+
 static int sprd_rtc_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -596,6 +622,13 @@ static int sprd_rtc_probe(struct platform_device *pdev)
 	rtc->dev = &pdev->dev;
 	platform_set_drvdata(pdev, rtc);
 
+	/* check if we need set the alarm interrupt */
+	ret = sprd_rtc_check_alarm_int(rtc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to check RTC alarm interrupt\n");
+		return ret;
+	}
+
 	/* check if RTC time values are valid */
 	ret = sprd_rtc_check_power_down(rtc);
 	if (ret) {
-- 
1.7.9.5

