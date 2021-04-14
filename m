Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF174C43600
	for <linux-rtc@archiver.kernel.org>; Wed, 14 Apr 2021 08:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D33613C3
	for <linux-rtc@archiver.kernel.org>; Wed, 14 Apr 2021 08:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350204AbhDNIkp (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 14 Apr 2021 04:40:45 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38751 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350336AbhDNIkn (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 14 Apr 2021 04:40:43 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1F834221E6;
        Wed, 14 Apr 2021 10:40:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1618389618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KSZiirGhIs8llK0cgg6jvrJM3t5V5mzj052ckrVJ8PA=;
        b=WrrOri0urcxW3VfjvcdppoCpcVE6Sb2KvAi5cemi03xae0WjO3OwQXBzPuJhYYQxUsTAgO
        dz+7ODPFhzNWkzUZAHSxPPwykM148N13hmks/SBgKr1SdY/C8ZMMOzX+uJjqKUBYapBLYv
        eD492EznohstqyIEVVZsCRYpYlaX2fY=
From:   Michael Walle <michael@walle.cc>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Biwen Li <biwen.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH] rtc: fsl-ftm-alarm: add MODULE_TABLE()
Date:   Wed, 14 Apr 2021 10:40:06 +0200
Message-Id: <20210414084006.17933-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The module doesn't load automatically. Fix it by adding the missing
MODULE_TABLE().

Fixes: 7b0b551dbc1e ("rtc: fsl-ftm-alarm: add FTM alarm driver")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/rtc/rtc-fsl-ftm-alarm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
index 57cc09d0a806..c0df49fb978c 100644
--- a/drivers/rtc/rtc-fsl-ftm-alarm.c
+++ b/drivers/rtc/rtc-fsl-ftm-alarm.c
@@ -310,6 +310,7 @@ static const struct of_device_id ftm_rtc_match[] = {
 	{ .compatible = "fsl,lx2160a-ftm-alarm", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, ftm_rtc_match);
 
 static const struct acpi_device_id ftm_imx_acpi_ids[] = {
 	{"NXP0014",},
-- 
2.20.1

