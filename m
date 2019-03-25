Return-Path: <SRS0=i680=R4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88975C43381
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 10:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524B520863
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 10:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zV2sfJ5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfCYKZB (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:25:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36972 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfCYKZA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 25 Mar 2019 06:25:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so7289864ljk.4
        for <linux-rtc@vger.kernel.org>; Mon, 25 Mar 2019 03:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcOI01Wr/+3DxH7WXfJEA8V1OyEeebKPMWO9OvVYzmQ=;
        b=zV2sfJ5OSOoelT6/jHfOWvo0LwWj7t+4JCuKx2tLrHjftzv/5+RIAXBhO4PfDZxV2J
         zIlBuQRsgMPCsGhf4aIJCmTRy9jRMQV/iS/A+G2PRERgw4LnHeQYzovXhV9vq/L1qw1o
         OCIEnK5YuxIXcWabWZ10aBozMoIlttSVf35rryYv3++dajdG4w3Ea675W3CCcl33hffT
         UYWbSBcbR5qHYiZ+82pSL5KkXKMpVU2cxLbgZIGf+9Em4AMGXyFt1U7p+/jgEnQJzRRm
         2SA+HA2yRvVze5SYagvkSlPXSbk7sVaB0CqWK4iPtP4wwjmU3gcyYhoCI3LNUnHLcbZd
         8Wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcOI01Wr/+3DxH7WXfJEA8V1OyEeebKPMWO9OvVYzmQ=;
        b=pVo+/Xto9gjGX6ijyaB7lMweJEPKDdTK3YxN2ev+0OuF1Go2blHzezKOss+hz8CkGz
         QJUgbv7ZSLYUz05TXgwsY5v3IE54VnehbTypi28Kouhw+aWi2aTyrh04hfZ3545/KjA7
         XutmNOTlNAh6jn7HWHO2T6yafCXbz2T0vyu+HLNS3qHgeI1jJsP7BJertLBnRQSLfi2N
         ab45CJy3/3FkDAIHSqbFY3aeRCqxcrCukcjo60HQVO6SciX8WVGGYCzSbXOoaZvkAEZc
         21I+CkU2F+xoKPCpf+m+rsh0O8qU65uxCEI5G8xB98PtbFUUhIh8pWRSVxqYmuwyBmvD
         zrdw==
X-Gm-Message-State: APjAAAXDjencMR83mYoelEqHT95OVoCitRCGaDUv7+/ZjDwOibjJc2rp
        WVr+xi+tsDr9jM0nXbX/QD14lQ==
X-Google-Smtp-Source: APXvYqxcqBiPnY8+yX0CyOz6ed03aUetxiGJghuiH8kObnHSdu1k6zWJvTX0wsvWi8hdKpFn4AjOrw==
X-Received: by 2002:a2e:6e14:: with SMTP id j20mr2129423ljc.172.1553509498786;
        Mon, 25 Mar 2019 03:24:58 -0700 (PDT)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id r77sm2256964ljb.29.2019.03.25.03.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 03:24:58 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] rtc: sh: fix unused variable warning
Date:   Mon, 25 Mar 2019 11:24:53 +0100
Message-Id: <20190325102453.8349-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

When building the driver rtc/rtc-sh a warning about unused variable
shows up:

../drivers/rtc/rtc-sh.c: In function ‘sh_rtc_probe’:
../drivers/rtc/rtc-sh.c:472:18: warning: unused variable ‘r’ [-Wunused-variable]
  struct rtc_time r;
                  ^

Remove the declaration of the unused varable 'r'.

Fixes: 373f7f4bf4a5 ("rtc: sh: stop resetting time to epoch")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/rtc/rtc-sh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index d72ee3a841ea..579b3ff5c644 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -469,7 +469,6 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 {
 	struct sh_rtc *rtc;
 	struct resource *res;
-	struct rtc_time r;
 	char clk_name[6];
 	int clk_id, ret;
 
-- 
2.20.1

