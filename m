Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D82C07E9C
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Jul 2021 08:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD31861C73
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Jul 2021 08:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhGGIPF (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 7 Jul 2021 04:15:05 -0400
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:52462 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhGGIPE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 7 Jul 2021 04:15:04 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 1677wSA8019263; Wed, 7 Jul 2021 16:58:31 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1677wFTM032280; Wed, 7 Jul 2021 16:58:15 +0900
X-Iguazu-Qid: 2wGqsZ5qxpEwtgN91O
X-Iguazu-QSIG: v=2; s=0; t=1625644695; q=2wGqsZ5qxpEwtgN91O; m=y3kfJ6GQrh7uDGDWD3SG8E2ZM2WTRzR1KsUTW+uloe4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1110) id 1677wEvQ020151
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 7 Jul 2021 16:58:14 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 500D51000C1;
        Wed,  7 Jul 2021 16:58:14 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 1677wDxd013858;
        Wed, 7 Jul 2021 16:58:14 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 10/10] rtc: spear: convert to SPDX identifier
Date:   Wed,  7 Jul 2021 16:58:04 +0900
X-TSB-HOP: ON
Message-Id: <20210707075804.337458-11-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210707075804.337458-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210707075804.337458-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Use SPDX-License-Identifier instead of a verbose license text.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/rtc/rtc-spear.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index ee721e53c155..b4a520056b1a 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * drivers/rtc/rtc-spear.c
  *
  * Copyright (C) 2010 ST Microelectronics
  * Rajeev Kumar<rajeev-dlh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/bcd.h>
-- 
2.32.0

