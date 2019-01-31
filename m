Return-Path: <SRS0=M17z=QH=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B65EC169C4
	for <linux-rtc@archiver.kernel.org>; Thu, 31 Jan 2019 15:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC46218AF
	for <linux-rtc@archiver.kernel.org>; Thu, 31 Jan 2019 15:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AKQ8oBPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfAaPG5 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:06:57 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39045 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfAaPG4 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 31 Jan 2019 10:06:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so2567394lfh.6
        for <linux-rtc@vger.kernel.org>; Thu, 31 Jan 2019 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ELV9R5dzc3QWtNGPdgByoUd6LbKlFXrTe/vKF1qU9OQ=;
        b=AKQ8oBPmhgIpq3dBUD6Xt97i8W2/wViNspm26Q4AwncBxrN9qe1vD5syQ22iDuJDla
         LRP+JmeWXd0jFA4Hav1lUtUJckOcudqqoiXmSzDgURxJctMyRHkDsAHagIB7ssWuvnvY
         fSfEFuoDKtw9GfnCY4jJaz6qAjuvjhOENsFpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ELV9R5dzc3QWtNGPdgByoUd6LbKlFXrTe/vKF1qU9OQ=;
        b=lnz4OlejZCtNd2Iyt7cc9UMmzPScmL6Hd7f0fpLymqhKDUB44xTq77UpAFsLtY07Ur
         kQ8HNIHq98vxdZ/gQLhJ63RVXv3JgeYEhvXjvQkWs5HHInv8R01RXEEowKKjl/DDhuI5
         YRoAafsOQE3QuQjHrORKmPCMVcFf1Xv+yXEmhq/EmcJlHDxFCmORSPrL7/m8gd7+lPXt
         qrgxYuSUVSDcmBOymyov7175ybQDcw/Dd+QmTWb5uuF3kloj9Q4uXE8fI76wHY2u4131
         MMiKigklj5f9JwXYdHONFVWh8UVa13bJ760fF1a0y0enWj84TmpZ1XmODoD8k0D7tqBF
         xfYg==
X-Gm-Message-State: AHQUAub1ca+fhYH4QoRMLz4TMhJTh41UMaetV1oZNtg/bSVebP9KnpyF
        NmTrHa1kjBGzufxF0CUTs1aTFA==
X-Google-Smtp-Source: AHgI3Iam47J0S5a3qZy64sau7geNltPsY+Q7UeEMj8Vcwi4gYqBtXIVlI2uy5zrtVIewahHrOkbydQ==
X-Received: by 2002:ac2:5382:: with SMTP id g2mr4104382lfh.159.1548947214197;
        Thu, 31 Jan 2019 07:06:54 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id t22sm936508lfb.0.2019.01.31.07.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 07:06:52 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] rtx: x1205: Add DT bindings
Date:   Thu, 31 Jan 2019 16:06:41 +0100
Message-Id: <20190131150642.26289-1-linus.walleij@linaro.org>
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

