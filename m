Return-Path: <SRS0=ssRk=Q4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F045C43381
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Feb 2019 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FF320880
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Feb 2019 09:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfBUJqZ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:46:25 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:8082 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725385AbfBUJqZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 21 Feb 2019 04:46:25 -0500
X-IronPort-AV: E=Sophos;i="5.58,394,1544454000"; 
   d="scan'208";a="8271397"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Feb 2019 18:46:24 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9E128431ECF1;
        Thu, 21 Feb 2019 18:46:20 +0900 (JST)
From:   Biju Das <biju.das@bp.renesas.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Biju Das <biju.das@bp.renesas.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/5] rtc: rx8581: Add rx8571 compatible
Date:   Thu, 21 Feb 2019 09:40:44 +0000
Message-Id: <1550742048-28068-2-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550742048-28068-1-git-send-email-biju.das@bp.renesas.com>
References: <1550742048-28068-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The Epson rx8571 is compatible with the Epson rx8581 RTC.

The difference between the rx8571 and rx8581 RTC is that the former has
16 bytes more RAM. This renders them incompatible from a DT point of view.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/rtc/rtc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
index 3e6a215..0bc687e 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc.txt
@@ -47,6 +47,7 @@ dallas,ds1374		I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and
 dallas,ds1672		Dallas DS1672 Real-time Clock
 dallas,ds3232		Extremely Accurate I²C RTC with Integrated Crystal and SRAM
 epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
+epson,rx8571		I2C-BUS INTERFACE REAL TIME CLOCK MODULE with Battery Backed RAM
 epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 emmicro,em3027		EM Microelectronic EM3027 Real-time Clock
 isil,isl1208		Intersil ISL1208 Low Power RTC with Battery Backed SRAM
-- 
2.7.4

