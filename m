Return-Path: <SRS0=M17z=QH=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F48C169C4
	for <linux-rtc@archiver.kernel.org>; Thu, 31 Jan 2019 15:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36800218AF
	for <linux-rtc@archiver.kernel.org>; Thu, 31 Jan 2019 15:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPUEQFSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfAaPHA (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:07:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37597 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAaPHA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 31 Jan 2019 10:07:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id u188so613937lff.4
        for <linux-rtc@vger.kernel.org>; Thu, 31 Jan 2019 07:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OrBYAdDHoe9pzzUUjlJ27M7UFbgZmNW8eTvGMtTwssA=;
        b=jPUEQFSSWCdUIb3jNmCnU2XAhiF0b54Qq1yGngEyw8Si/kKnkF5dkjCRbcuyVZgzLz
         AdVVuPm5aBSjrVruJe7sm4Y4h0kFDUJAWXjaZSA64ZYfn7HUvNyibuPqdjcinGVpaQkL
         ZZHtxoiJCEuTq0pkzkWRX7XbB8dDOrh7jNINA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OrBYAdDHoe9pzzUUjlJ27M7UFbgZmNW8eTvGMtTwssA=;
        b=LbSaiJogWi5iRx0vtr1k2vvsPmnToCJ97+OtzcvLHp6t1X8mOUrrRQwv2sbG/mvvYB
         GeO+zan56XyAFJJ+zRi3BarT8Hmkd8/8OI4yqJoDmlVoQ2vaxZQ8964t/PrZ4h6XuGIY
         YcSKEWBRVpE2ZNHsUlRz/GK+oCku6appJVwaGgey9M8ylKy4kg23AZO7yxVBiFimIA0U
         5gZ0ffE6sKMKoZHFp+mKs5YXR2d+a0QF37BuQv2MiNZ4+mCwvTHtRaqzkwOkWO2BE2QJ
         pnRATnyWOpqWwTk+H4BWDqVoAm8l4HDmVsuVjvMKmRuiae4nj5JapaCWG6D2nC8vzwa5
         /7Ug==
X-Gm-Message-State: AJcUukfOwZmtkfEVj3964YwnbgLqJ1hVBWMRio/INUSA18+yo8OvN0Nm
        KUQRmNrEYGpWcxoMkmvTSMJWcQ==
X-Google-Smtp-Source: ALg8bN4h9MInQxCBCn8lAq/hUl8AZBxjwfxKvNxAZKJBapeEgyYPJr7WLI65/n7uLllX60lhG66LTg==
X-Received: by 2002:a19:d242:: with SMTP id j63mr28971072lfg.26.1548947217739;
        Thu, 31 Jan 2019 07:06:57 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id t22sm936508lfb.0.2019.01.31.07.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 07:06:56 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] rtc: x1205: Add DT probing support
Date:   Thu, 31 Jan 2019 16:06:42 +0100
Message-Id: <20190131150642.26289-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131150642.26289-1-linus.walleij@linaro.org>
References: <20190131150642.26289-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

This makes it possible to probe the X1205 RTC from the
device tree. This is needed when adding device tree boot
support for the IXP4xx-based NSLU2 which has this RTC.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/rtc/rtc-x1205.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/rtc/rtc-x1205.c b/drivers/rtc/rtc-x1205.c
index f08f18e4fcdf..c2b64c9363da 100644
--- a/drivers/rtc/rtc-x1205.c
+++ b/drivers/rtc/rtc-x1205.c
@@ -673,9 +673,15 @@ static const struct i2c_device_id x1205_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, x1205_id);
 
+static const struct of_device_id x1205_dt_ids[] = {
+	{ .compatible = "xircom,x1205", },
+};
+MODULE_DEVICE_TABLE(of, x1205_dt_ids);
+
 static struct i2c_driver x1205_driver = {
 	.driver		= {
 		.name	= "rtc-x1205",
+		.of_match_table = x1205_dt_ids,
 	},
 	.probe		= x1205_probe,
 	.remove		= x1205_remove,
-- 
2.20.1

