Return-Path: <SRS0=dQwf=R6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31D5C43381
	for <linux-rtc@archiver.kernel.org>; Wed, 27 Mar 2019 01:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27E62075D
	for <linux-rtc@archiver.kernel.org>; Wed, 27 Mar 2019 01:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHVz2e2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbfC0BCg (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:02:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45178 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfC0BCg (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 26 Mar 2019 21:02:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so2458510plb.12;
        Tue, 26 Mar 2019 18:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BSwFhYguijpTFoY9p4NUWZwAj7qdGw4AZTrGKzgCdaM=;
        b=QHVz2e2PgH2Vw9HKpEFdhwhDg027GlhgmRzKNI8xlxPYgnkDfkOrhlcqe1w3cKe4Ga
         ibmcQWbb/3NH8bGR+VG/6O819pYB9DuGQKyfUlwu3LpCbYsDXN6p/C43aArw8+q3BIre
         kdR9o4ZxHu095EaBos2P6DNf8WgPudvtUMDOXJFlhflhlcq8Wzun4jsJopi2SQuMos6v
         jrlUk6fydWNxN5vXPl70C+Pujts+muIAK+Mq/SgRQ5MREOCYC3KCgxJv/QZY/MaX4mAo
         ovSiGmWhTbfZFiy6uCrE2Lf0kEPswfee+RiBfmSbSVM9kQ/fwoog2Y54c9J0NixdhkW3
         6x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BSwFhYguijpTFoY9p4NUWZwAj7qdGw4AZTrGKzgCdaM=;
        b=XZO+4mHXLztbQnVJKpQU+sXhunRcTLREM9bejZfnpIaFz3SRPyci5IA8kTkUEWkeug
         i6C8Iz8ftR2Kb85q+DDMWZI5DOqDY4eGtZCSOUspRjNE4uwQ+wXfC70S/VCaIhGZ4e93
         wGYAjB+xfT5PPI2i523dqrhpG/E2+zcMDNCs5eGbqYe5LQWnNBonLkOKXuPOO1UV4295
         PrXf/epi+oOIGO9SrXwEh+kFDVEeuMhlGRNvXxsm4bRUHrK/zWdnA6GKh55ToOoqwYwk
         qNecgp/p83Sr6uwsCB2dRX0qYSidO1QqZubDySDW9xr4wRcNEIGrkVk2sXBrmAsvrDwe
         znsg==
X-Gm-Message-State: APjAAAUMrV7ZYa8skt2KCLWkPYgMCxhAMmmIXNC4x+XbAAtjp3ZXSx2u
        DQI1cdoACE8soBDI2IRCgRmZ/JPi
X-Google-Smtp-Source: APXvYqxQfDD/MtGlllmsOymGh+HFy7CB250o5r9o3FQ0CgmvwKzE4j/gSYmiiyE7OFmaKIcgeuv+sA==
X-Received: by 2002:a17:902:f084:: with SMTP id go4mr34583963plb.15.1553648555412;
        Tue, 26 Mar 2019 18:02:35 -0700 (PDT)
Received: from voyager.jms.id.au ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id u13sm41111703pfa.169.2019.03.26.18.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 18:02:34 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation); Wed, 27 Mar 2019 11:32:27 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH v3 1/2] dt-bindings: rtc: Add on-chip ASPEED RTC documentation
Date:   Wed, 27 Mar 2019 11:32:14 +1030
Message-Id: <20190327010215.10231-2-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327010215.10231-1-joel@jms.id.au>
References: <20190327010215.10231-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Describe the RTC as used in the ASPEED BMC SoCs.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3: Add interrupts property
---
 .../devicetree/bindings/rtc/rtc-aspeed.txt    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
new file mode 100644
index 000000000000..2e956b3dc276
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
@@ -0,0 +1,22 @@
+ASPEED BMC RTC
+==============
+
+Required properties:
+ - compatible: should be one of the following
+   * aspeed,ast2400-rtc for the ast2400
+   * aspeed,ast2500-rtc for the ast2500
+   * aspeed,ast2600-rtc for the ast2600
+
+ - reg: physical base address of the controller and length of memory mapped
+   region
+
+ - interrupts: The interrupt number
+
+Example:
+
+   rtc@1e781000 {
+           compatible = "aspeed,ast2400-rtc";
+           reg = <0x1e781000 0x18>;
+           interrupts = <22>;
+           status = "disabled";
+   };
-- 
2.20.1

