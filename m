Return-Path: <SRS0=ssRk=Q4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8965CC43381
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Feb 2019 09:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FE020880
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Feb 2019 09:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfBUJq2 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:46:28 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:47347 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725385AbfBUJq1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 21 Feb 2019 04:46:27 -0500
X-IronPort-AV: E=Sophos;i="5.58,394,1544454000"; 
   d="scan'208";a="8478521"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Feb 2019 18:46:26 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 71F524322CC0;
        Thu, 21 Feb 2019 18:46:24 +0900 (JST)
From:   Biju Das <biju.das@bp.renesas.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Biju Das <biju.das@bp.renesas.com>, linux-rtc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/5] rtc: rx8581: Add support for rx8571 RTC
Date:   Thu, 21 Feb 2019 09:40:45 +0000
Message-Id: <1550742048-28068-3-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550742048-28068-1-git-send-email-biju.das@bp.renesas.com>
References: <1550742048-28068-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The Epson rx8571 RTC is compatible with the Epson rx8581 RTC.

The difference between the rx8571 and rx8581 RTC is that the former has
16 bytes more RAM.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/rtc/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 7c7a5da..bdbcc5c 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -601,9 +601,10 @@ config RTC_DRV_RX8010
 	  will be called rtc-rx8010.
 
 config RTC_DRV_RX8581
-	tristate "Epson RX-8581"
+	tristate "Epson RX-8571/RX-8581"
 	help
-	  If you say yes here you will get support for the Epson RX-8581.
+	  If you say yes here you will get support for the Epson RX-8571/
+	  RX-8581.
 
 	  This driver can also be built as a module. If so the module
 	  will be called rtc-rx8581.
-- 
2.7.4

