Return-Path: <SRS0=lKmk=OH=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49575C04EBC
	for <linux-rtc@archiver.kernel.org>; Wed, 28 Nov 2018 09:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C0021104
	for <linux-rtc@archiver.kernel.org>; Wed, 28 Nov 2018 09:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C0021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeK1Uih (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:38:37 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:49540 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbeK1Uih (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 28 Nov 2018 15:38:37 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 352325F725; Wed, 28 Nov 2018 17:30:28 +0800 (CST)
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
Subject: [PATCH 01/15] dt-bindings: rtc: sun6i-rtc: Rewrite clock outputs as a list
Date:   Wed, 28 Nov 2018 17:29:58 +0800
Message-Id: <20181128093013.24442-2-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The clock output section for this binding describes the two outputs in
the descriptions for both the #clock-cells and clock-output-names
properties.

Instead of overlapping information that is hard to read, rewrite the
clock outputs as a list of indices and descriptions. The properies
can reference this list instead. This will also make it easier to
add notes or conditions to the clocks, and also for adding new outputs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
index 12c083c1140a..d3e96459fc66 100644
--- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
@@ -10,10 +10,12 @@ Required properties:
 
 Required properties for new device trees
 - clocks	: phandle to the 32kHz external oscillator
-- clock-output-names : names of the LOSC and its external output clocks created
-- #clock-cells  : must be equals to 1. The RTC provides two clocks: the
-		  LOSC and its external output, with index 0 and 1
-		  respectively.
+- clock-output-names : names of the two clock outputs. See below.
+- #clock-cells  : must be equal to 1.
+
+The RTC provides the following clocks at the given indices:
+- 0: LOSC
+- 1: LOSC external output, known as X32KFOUT in the datasheet.
 
 Example:
 
-- 
2.20.0.rc1

