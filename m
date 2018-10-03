Return-Path: <SRS0=Sf1+=MP=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5DBC00449
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Oct 2018 13:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B4B20684
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Oct 2018 13:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bseIzeGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B4B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeJCUUg (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:20:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46540 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeJCUUg (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 3 Oct 2018 16:20:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id g32-v6so5317713edg.13
        for <linux-rtc@vger.kernel.org>; Wed, 03 Oct 2018 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8esBCSBr3jYCnVQM+nHKFpnHc8GkeHnrmBkv/9+OhJU=;
        b=bseIzeGdbgwIYXSTlVAGXwFBVuVeCg2kSIZcI/E5Q98PAENw7tvjf8EG0/DLAqZ3Sn
         OKGa6IF/fTsRCD6C7ErtTzGDl4rzLjPIkiWo/iyiICoZvo6aOe2dvl/AMCL9ZkKmzoiI
         cJtLvK4aIjYUPPaO0imjBAZihuSMsCI86YdlHLgkf9RROWb1LDY0CJuBmbx5I5rbPiCw
         Sr+wUXgfnrXEwbm1DuRLbpyLXjWBMfPN1J28JeGwgyyDWOrgulnAAWJftvVhpgTATRMP
         GsVmbvX6pi8LbxdESgy243za23OrlRAxoH4dOEK/3EAw/+ZENXkRsUkdQgNUHunzNLb0
         kSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8esBCSBr3jYCnVQM+nHKFpnHc8GkeHnrmBkv/9+OhJU=;
        b=JZKpFRK+w03SJabNE5iiHeUj3ZFSYULYzIoz5edyDD18ldTKY/mtJAXz6Ejrs2dlNz
         YUvus5lZIlU273CjvpnRAu+zdiM6qv61YDDfAXTcViaxyx2KwwayWSDMHuIU3KPj8KEs
         +gByOZV+F9d/JHlZ2FQId9MeqSkKDlnkU8YMbRe0zkPMpscvqx2mAroTBQYLE597hYWn
         v5EuylVKVJhfT+f9DM0tR/CJ/L5mDrsD4P9oam16I/t9nan4GrCqpN3XU5FavYCci2Cu
         q5TorX5PY6FQEGkhamQ1ljx+FuU5mUL8Q1fIapp/O8nJwUuA7NciDc1JhY/0zcu46Yxa
         /x1A==
X-Gm-Message-State: ABuFfoi2jWV6sbKgVoQJE5Xy82Q2oHfauYFQ72S6e/xYvz+MFFmp2k7e
        dAjL1+iBKTC9Lmf5KQsHhtpWiykKyoU=
X-Google-Smtp-Source: ACcGV63LuVWyEubxB/qyMDf0cH7Hqvfa7a2g/32tZ9jwb68Lv+anORJPGuKRqBqcbI8tk2E0YEMBjA==
X-Received: by 2002:a50:c181:: with SMTP id m1-v6mr2496319edf.199.1538573529577;
        Wed, 03 Oct 2018 06:32:09 -0700 (PDT)
Received: from aurora.jms.id.au ([213.244.178.17])
        by smtp.gmail.com with ESMTPSA id b26-v6sm482247edw.0.2018.10.03.06.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 06:32:08 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Wed, 03 Oct 2018 15:32:07 +0200
From:   Joel Stanley <joel@jms.id.au>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Christian Svensson <christian@cmd.nu>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH 2/2] dt-bindings: rtc: Add ASPEED description
Date:   Wed,  3 Oct 2018 15:31:55 +0200
Message-Id: <20181003133155.27494-3-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003133155.27494-1-joel@jms.id.au>
References: <20181003133155.27494-1-joel@jms.id.au>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Describe the RTC as used in the ASPEED ast2400 and ast2500 SoCs.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/rtc/rtc-aspeed.txt     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
new file mode 100644
index 000000000000..d31a4d24c75f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
@@ -0,0 +1,18 @@
+ASPEED BMC RTC
+==============
+
+Required properties:
+ - compatible: should be one of the following
+   * aspeed,ast2400-rtc for the ast2400
+   * aspeed,ast2500-rtc for the ast2500
+
+ - reg: physical base address of the controller and length of memory mapped
+   region
+
+Example:
+
+   rtc@1e781000 {
+           compatible = "aspeed,ast2400-rtc";
+           reg = <0x1e781000 0x18>;
+           status = "disabled";
+   };
-- 
2.17.1

