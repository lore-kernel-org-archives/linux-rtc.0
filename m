Return-Path: <SRS0=m1go=DA=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63033C47423
	for <linux-rtc@archiver.kernel.org>; Wed, 23 Sep 2020 08:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F8B23741
	for <linux-rtc@archiver.kernel.org>; Wed, 23 Sep 2020 08:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="iWhOkBAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIWIGw (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 23 Sep 2020 04:06:52 -0400
Received: from [115.28.160.31] ([115.28.160.31]:55530 "EHLO
        mailbox.box.xen0n.name" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbgIWIGw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 23 Sep 2020 04:06:52 -0400
Received: from ld50.lan (unknown [101.224.80.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 52AD5607BE;
        Wed, 23 Sep 2020 15:59:50 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xen0n.name; s=mail;
        t=1600847990; bh=75X06Lpb9Z3b1YfZC/s/JM+hPVwtT2MFnEGIBVtQUgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWhOkBAzFVbwVV4BN3D+PuPTswRrFNcRU/I37eX/mWwNNygpcwmpOW4uadj1F6FRG
         g5BQ3S/m4CMmMPYrw0r+iMKSQu2P+kWASe7QiaFcVif97Lp/h697kF3I0tR+odnNFP
         Hb4GoLYOUWQaoRSEpqGwzW3xzt72UH9a5BZGn+kA=
From:   WANG Xuerui <git@xen0n.name>
To:     linux-rtc@vger.kernel.org
Cc:     WANG Xuerui <git@xen0n.name>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/4] dt-bindings: rtc: Add bindings for LS2X RTC
Date:   Wed, 23 Sep 2020 15:58:43 +0800
Message-Id: <20200923075845.360974-3-git@xen0n.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923075845.360974-1-git@xen0n.name>
References: <20200923075845.360974-1-git@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Document the binding for the LS2X RTC block found on the Loongson-2K SoC
and the LS7A bridge, originally appearing on the Loongson-2H.

Signed-off-by: WANG Xuerui <git@xen0n.name>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index c7d14de214c4..233666c47d97 100644
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
2.28.0

