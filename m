Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73258C49EA2
	for <linux-rtc@archiver.kernel.org>; Sun, 20 Jun 2021 22:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F85E61164
	for <linux-rtc@archiver.kernel.org>; Sun, 20 Jun 2021 22:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFTWm4 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 20 Jun 2021 18:42:56 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55733 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhFTWmx (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 20 Jun 2021 18:42:53 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E78C5C0005;
        Sun, 20 Jun 2021 22:40:37 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: rtc: ti,bq32k: take maintainership
Date:   Mon, 21 Jun 2021 00:40:29 +0200
Message-Id: <20210620224030.1115356-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Take maintainership of the binding as PAvel said he doesn't have the
hardware anymore.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/rtc/ti,bq32000.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/ti,bq32000.yaml b/Documentation/devicetree/bindings/rtc/ti,bq32000.yaml
index 392bd71bd1be..bf9c1c4ddb7e 100644
--- a/Documentation/devicetree/bindings/rtc/ti,bq32000.yaml
+++ b/Documentation/devicetree/bindings/rtc/ti,bq32000.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: TI BQ32000 I2C Serial Real-Time Clock
 
 maintainers:
-  - Pavel Machek <pavel@ucw.cz>
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
 
 allOf:
   - $ref: rtc.yaml#
-- 
2.31.1

