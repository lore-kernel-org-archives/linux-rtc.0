Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31782C07E9B
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Jul 2021 08:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A66561CBD
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Jul 2021 08:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhGGIZl (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 7 Jul 2021 04:25:41 -0400
Received: from mo-csw-fb1514.securemx.jp ([210.130.202.170]:35850 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhGGIZl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 7 Jul 2021 04:25:41 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1514) id 1677wSc4011244; Wed, 7 Jul 2021 16:58:29 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 1677wFFD011491; Wed, 7 Jul 2021 16:58:15 +0900
X-Iguazu-Qid: 34tMXTv7x6uLiSwkVM
X-Iguazu-QSIG: v=2; s=0; t=1625644695; q=34tMXTv7x6uLiSwkVM; m=SsldDnNxEH4BNgfHTrgrAak+bsrgFojEn6S5Lk00vy0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 1677wDPT006423
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 7 Jul 2021 16:58:14 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 9817E1000B0;
        Wed,  7 Jul 2021 16:58:13 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 1677wDT1013841;
        Wed, 7 Jul 2021 16:58:13 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 06/10] rtc: rtd119x: Fix format of SPDX identifier
Date:   Wed,  7 Jul 2021 16:58:00 +0900
X-TSB-HOP: ON
Message-Id: <20210707075804.337458-7-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210707075804.337458-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210707075804.337458-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

For C files, use the C99 format (//).

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/rtc/rtc-rtd119x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rtd119x.c b/drivers/rtc/rtc-rtd119x.c
index bb98f2d574a5..8f9abd65846c 100644
--- a/drivers/rtc/rtc-rtd119x.c
+++ b/drivers/rtc/rtc-rtd119x.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Realtek RTD129x RTC
  *
  * Copyright (c) 2017 Andreas Färber
- *
- * SPDX-License-Identifier: GPL-2.0+
  */
 
 #include <linux/clk.h>
-- 
2.32.0

