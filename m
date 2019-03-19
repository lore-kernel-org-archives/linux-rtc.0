Return-Path: <SRS0=7wLf=RW=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8A6C10F03
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Mar 2019 07:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D65F2083D
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Mar 2019 07:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3JmbvYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCSHkV (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:40:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39689 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSHkV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 19 Mar 2019 03:40:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id m13so13642096lfb.6
        for <linux-rtc@vger.kernel.org>; Tue, 19 Mar 2019 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4L++Yl5e7QSNKsYjnhjy+1jhPG5KFyBaZyeMU59pxPA=;
        b=W3JmbvYtdjxiecPm9M2hAGUR2gQytRt4AT3LIvc6MlD/IhnSr2WeUguz8Bgnr2yNAe
         tL7miSyl5bK7Gn7O/zmpnMze0CBDg1y59Lp27WPepzXpvhJIq6DwZZrQGjz0/8xhnyPs
         lJIVIfbjM97apFy5AeC4IBxyDntJ0zvZIx8dLdvlW+xouhM4qgQuMULUJFk+FByLaTb5
         sRqVzM60uYEgb19l3LAF9MixyfuBeS3BsP0X+Rm6OvSLQ8QnpTg/VQEPvDxSY0SwO9pL
         +8Y4XfUUyBWvyig//J7FRPpgasQvXebbGoqYO+/9kU9g1UeOCSkhdP8AljoBw9qThxej
         TShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4L++Yl5e7QSNKsYjnhjy+1jhPG5KFyBaZyeMU59pxPA=;
        b=tzYcol4Fe65tlZyubD/WQIegaKjViJSRC3Lsgv8mngewP+ViSOCTchMdTxwWTqwayr
         5C2gCjXJs9oRw+ZkXLHbDmQXZKkWA49ZIuanaOp4bJ1LVLeQu74iKqDhoFTEkphQJcdr
         JgNWWHvDdVSeqT0kcp4Lz4BfY5sTl/4RtfzVY0VZJl+RUvqCzRjabHCc1JF6As8E4gCi
         sE3/72xseW/M5rRtVeUpaBhnPuLAJFaGaDld+0ZiZ7R2FMLQv1VOMUypOr6Eq+ZtxTyH
         twHJqPKz/+Yvf2uo0qs4rbIhllVJRO3KRsX0Jtqv7QH66jEqdtjyqPeXMZAHY09p7vHN
         Gb3w==
X-Gm-Message-State: APjAAAV36u9wCqCbrzZTsx/l4bhbNPzXKd4OOMjS7zq5hQuMt+sdVRqn
        kpCsXNXn6tkEIxMZXlb+FWiSPg==
X-Google-Smtp-Source: APXvYqz/n8Ky99d4EZsg54wDRd8IQfmEUGTfwclRKI7SfqvMi9zGMTXbTPb0W+D5uYci4zVp1khYrQ==
X-Received: by 2002:ac2:548f:: with SMTP id t15mr12444690lfk.166.1552981219310;
        Tue, 19 Mar 2019 00:40:19 -0700 (PDT)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id m23sm751650lfj.89.2019.03.19.00.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 00:40:18 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2 v2] rtc: x1205: Add DT probing support
Date:   Tue, 19 Mar 2019 08:40:14 +0100
Message-Id: <20190319074014.20616-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319074014.20616-1-linus.walleij@linaro.org>
References: <20190319074014.20616-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Add terminating {} to DT compatible list.
- Rebase on v5.1-rc1
- Resend
---
 drivers/rtc/rtc-x1205.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-x1205.c b/drivers/rtc/rtc-x1205.c
index f08f18e4fcdf..ad2ae2f0536e 100644
--- a/drivers/rtc/rtc-x1205.c
+++ b/drivers/rtc/rtc-x1205.c
@@ -673,9 +673,16 @@ static const struct i2c_device_id x1205_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, x1205_id);
 
+static const struct of_device_id x1205_dt_ids[] = {
+	{ .compatible = "xircom,x1205", },
+	{},
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

