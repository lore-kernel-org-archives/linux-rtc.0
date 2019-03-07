Return-Path: <SRS0=zgku=RK=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E574C43381
	for <linux-rtc@archiver.kernel.org>; Thu,  7 Mar 2019 11:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0830820835
	for <linux-rtc@archiver.kernel.org>; Thu,  7 Mar 2019 11:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfCGLEO (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:04:14 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:38909 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGLEO (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 7 Mar 2019 06:04:14 -0500
Received: from localhost (alyon-652-1-90-156.w90-42.abo.wanadoo.fr [90.42.94.156])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A60E024000A;
        Thu,  7 Mar 2019 11:04:12 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: zynqmp: convert to SPDX identifier
Date:   Thu,  7 Mar 2019 12:04:08 +0100
Message-Id: <20190307110408.5671-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Use SPDX-License-Identifier instead of a verbose license text.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-zynqmp.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index bb950945ec7f..00639594de0c 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Xilinx Zynq Ultrascale+ MPSoC Real Time Clock Driver
  *
  * Copyright (C) 2015 Xilinx, Inc.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program. If not, see <http://www.gnu.org/licenses/>.
- *
  */
 
 #include <linux/delay.h>
-- 
2.20.1

