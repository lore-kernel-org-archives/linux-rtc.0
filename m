Return-Path: <SRS0=lKmk=OH=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7497C43441
	for <linux-rtc@archiver.kernel.org>; Wed, 28 Nov 2018 09:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7329020989
	for <linux-rtc@archiver.kernel.org>; Wed, 28 Nov 2018 09:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7329020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeK1Uii (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:38:38 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:49524 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728142AbeK1Uih (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 28 Nov 2018 15:38:37 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 47BB85FD9A; Wed, 28 Nov 2018 17:30:28 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 04/15] dt-bindings: rtc: sun6i-rtc: Export internal RC oscillator
Date:   Wed, 28 Nov 2018 17:30:01 +0800
Message-Id: <20181128093013.24442-5-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Experiments showed that on at least the H3/H5/A64 the RTC's internal
oscillator also feeds the CPUS mux in the PRCM.

Export this clock through the device tree, instead of having to use
a dummy fixed-clock device node, for the PRCM to consume. This will
properly describe the relationship between the clocks.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
index 78c4fb472eb7..1bd37faadecb 100644
--- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
@@ -24,7 +24,7 @@ Required properties:
 
 Required properties for new device trees
 - clocks	: phandle to the 32kHz external oscillator
-- clock-output-names : names of the two clock outputs. See below.
+- clock-output-names : names of the three clock outputs. See below.
 - #clock-cells  : must be equal to 1.
 
 The RTC provides the following clocks at the given indices:
@@ -32,6 +32,7 @@ The RTC provides the following clocks at the given indices:
 - 1: LOSC external output, known as X32KFOUT in the datasheet.
      This clock is not available on the A31 and is deprecated for old
      device trees still using the "allwinner,sun6i-a31-rtc" compatible.
+- 2: InternalOSC, or internal RC oscillator
 
 Example:
 
-- 
2.20.0.rc1

