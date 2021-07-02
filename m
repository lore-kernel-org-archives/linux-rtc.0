Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4D6C11F68
	for <linux-rtc@archiver.kernel.org>; Fri,  2 Jul 2021 06:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B835161156
	for <linux-rtc@archiver.kernel.org>; Fri,  2 Jul 2021 06:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhGBG5y (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 2 Jul 2021 02:57:54 -0400
Received: from [115.28.160.31] ([115.28.160.31]:41726 "EHLO
        mailbox.box.xen0n.name" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S230048AbhGBG5y (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 2 Jul 2021 02:57:54 -0400
Received: from ld50.lan (unknown [101.224.80.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 7732D6010D;
        Fri,  2 Jul 2021 14:55:18 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xen0n.name; s=mail;
        t=1625208918; bh=KyFmzNY9iME7gAnoVZLtCu1aHJKWM5wIRQgf7jjbe/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5HDQBKw9sXJKohsG6OT7RGFgAgwJhtk1sfOImcC2NFQV7WuJlsmSmBrWQ7QlLOxp
         yNYCiP20e1gVNVt1sODuD27phUihz7cF06vV1ZUdi4oIvT4aF5gDYwBDK8WYqKwS0E
         k2blY3+kwnZ3Q0U7xIQSxSpAkP67gLz+wpUNaF4w=
From:   WANG Xuerui <git@xen0n.name>
To:     linux-rtc@vger.kernel.org
Cc:     WANG Xuerui <git@xen0n.name>, Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v5 2/6] dt-bindings: rtc: Add bindings for LS2X RTC
Date:   Fri,  2 Jul 2021 14:54:47 +0800
Message-Id: <20210702065451.1175356-3-git@xen0n.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210702065451.1175356-1-git@xen0n.name>
References: <20210702065451.1175356-1-git@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Document the binding for the LS2X RTC block found on the Loongson-2K SoC
and the LS7A bridge, originally appearing on the Loongson-2H.

Signed-off-by: WANG Xuerui <git@xen0n.name>
Acked-by: Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index 7548d8714871..568aa89989fe 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -42,6 +42,8 @@ properties:
       - isil,isl1218
       # Intersil ISL12022 Real-time Clock
       - isil,isl12022
+      # Loongson LS2X RTC
+      - loongson,ls2x-rtc
       # Real Time Clock Module with I2C-Bus
       - microcrystal,rv3028
       # Real Time Clock Module with I2C-Bus
-- 
2.30.1

