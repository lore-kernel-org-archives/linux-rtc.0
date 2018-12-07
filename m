Return-Path: <SRS0=ySH3=OQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D63C64EB1
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 11:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F62F20892
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 11:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F62F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLGLgb (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:36:31 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:5386 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbeLGLgb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 7 Dec 2018 06:36:31 -0500
X-IronPort-AV: E=Sophos;i="5.56,326,1539615600"; 
   d="scan'208";a="2022477"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2018 20:36:29 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A75EE40455F9;
        Fri,  7 Dec 2018 20:36:26 +0900 (JST)
From:   Biju Das <biju.das@bp.renesas.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Biju Das <biju.das@bp.renesas.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 2/5] dt-bindings: rtc: pcf85363: Document pcf85263 real-time clock
Date:   Fri,  7 Dec 2018 11:27:43 +0000
Message-Id: <1544182066-31528-3-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The pcf85263 RTC is compatible with the pcf85363 RTC.

The difference between the pcf85263 and pcf85363 RTC is that the latter has
64 bytes more RAM. This renders them incompatible from a DT point of view.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
V1-->V2
	* Incorporated Simon's review comment.
V2-->V3
	* No Change.
V3-->V4
	* No Change.
---
 Documentation/devicetree/bindings/rtc/pcf85363.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/pcf85363.txt b/Documentation/devicetree/bindings/rtc/pcf85363.txt
index 76fdabc..94adc1c 100644
--- a/Documentation/devicetree/bindings/rtc/pcf85363.txt
+++ b/Documentation/devicetree/bindings/rtc/pcf85363.txt
@@ -1,8 +1,8 @@
-NXP PCF85363 Real Time Clock
+NXP PCF85263/PCF85363 Real Time Clock
 ============================
 
 Required properties:
-- compatible: Should contain "nxp,pcf85363".
+- compatible: Should contain "nxp,pcf85263" or "nxp,pcf85363".
 - reg: I2C address for chip.
 
 Optional properties:
-- 
2.7.4

