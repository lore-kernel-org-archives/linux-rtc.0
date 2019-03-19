Return-Path: <SRS0=7wLf=RW=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5096CC43381
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Mar 2019 07:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1D42083D
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Mar 2019 07:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2aGIzZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCSHkT (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:40:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34792 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfCSHkT (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 19 Mar 2019 03:40:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id y18so13668694lfe.1
        for <linux-rtc@vger.kernel.org>; Tue, 19 Mar 2019 00:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Krb4lvgEUmQBaeJqExnSd0PSKtC32SBEI1LvUN2a8U=;
        b=Z2aGIzZln4sMYCS78oVZTPVa6WVBq+WXeJhSTKAzqlyVU4VkE5P0saObatJQrnsiVr
         IvjNWCPbgSwQtW3qRzsA1QhFtyPI4GnCxHf6ETPCZdJlknHR/+z391N5oBd9Z0SNTm8h
         Ng2WW2XDFRKjN3Psz6l58WGwv89W6ixlJzoGQat2gHcAtNDjHvxLNepTY6gSIjaRkz4d
         bU7OcAWSAM3Rm2FIUk4+a87DrRh/Pll4DhL1Lm9AWEGFBde8HPARDcra0B1el6gzz7RV
         iha1rt8Bqy4ezD1lEWk3tcWNYnkhDM7JPpBUM3sPlpz2E2w4Z/PQcvyjVqNfCfBZoy8A
         SPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Krb4lvgEUmQBaeJqExnSd0PSKtC32SBEI1LvUN2a8U=;
        b=MGJU5GZJYbtHmRTUovNp6fSRNtlJ+ffww6ZtHaY2QC7U680PFg8RZWewSKxPgakzzm
         bYJNKts5z8HDltq8pjpVbCFI84DNpmdpLYrbFdeTrkz+L0yRd4uWEATiJBa6CebSqZgq
         wz4QBHO2G0pINFQ0ZebwsMoWDA+y4GKYnZSxunRVrQAhu2vEMHVyFc1tQyVSoHY9wlkM
         gO08ZWDrF80KNEJJgi11/XRu7E4kU2s3MDpRc+lpzCRj/xOQOAFmP3xW1pb8p1cw9E+n
         qrwkDPkQdqXr/SjwdzPscx0mXwFRMzck/3aaUSAyDCXr49+7BkiSmYuuE4sE8RShBX/J
         B2hw==
X-Gm-Message-State: APjAAAWUzLue5m++qVxSLRdqSwDcDTJFHWlW46pRsRUsSUNuIDQJide7
        v6PD/RBL2pAf7yFbwuw+s3hZ3w==
X-Google-Smtp-Source: APXvYqzsipAL6j+WUlfjNTS/Q3MJ1Fr1x/2XLSNoJo7p/GNzJHSaKbJpA3gXyzWq6njaZ7IRTUGzjw==
X-Received: by 2002:a19:f008:: with SMTP id p8mr11907006lfc.134.1552981217377;
        Tue, 19 Mar 2019 00:40:17 -0700 (PDT)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id m23sm751650lfj.89.2019.03.19.00.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 00:40:16 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2 v2] rtc: x1205: Add DT bindings
Date:   Tue, 19 Mar 2019 08:40:13 +0100
Message-Id: <20190319074014.20616-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

This adds device tree bindings for the Xircom X1205 RTC found
in the Linksys NSLU2.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase on v5.1-rc1
- Resend
---
 .../devicetree/bindings/rtc/xircom,x1205.txt         | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/xircom,x1205.txt

diff --git a/Documentation/devicetree/bindings/rtc/xircom,x1205.txt b/Documentation/devicetree/bindings/rtc/xircom,x1205.txt
new file mode 100644
index 000000000000..3e3102a32728
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/xircom,x1205.txt
@@ -0,0 +1,12 @@
+* Xircom X1205 I2C RTC
+
+Required properties:
+- compatible: Should be "xircom,x1205"
+- reg: I2C address
+
+Example:
+
+rtc@6f {
+	compatible = "xicor,x1205";
+	reg = <0x6f>;
+};
-- 
2.20.1

