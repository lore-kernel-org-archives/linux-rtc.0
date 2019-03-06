Return-Path: <SRS0=JgwP=RJ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25555C4360F
	for <linux-rtc@archiver.kernel.org>; Wed,  6 Mar 2019 09:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F8420661
	for <linux-rtc@archiver.kernel.org>; Wed,  6 Mar 2019 09:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfCFJvj (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:51:39 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:48027 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfCFJvi (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 6 Mar 2019 04:51:38 -0500
Received: from localhost (alyon-652-1-90-156.w90-42.abo.wanadoo.fr [90.42.94.156])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 9F67F200008;
        Wed,  6 Mar 2019 09:51:36 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc: abx80x: convert to SPDX identifier
Date:   Wed,  6 Mar 2019 10:51:32 +0100
Message-Id: <20190306095134.18550-1-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-abx80x.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 6ddcad642d1e..8e7eb08281f7 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * A driver for the I2C members of the Abracon AB x8xx RTC family,
  * and compatible: AB 1805 and AB 0805
@@ -7,10 +8,6 @@
  * Author: Philippe De Muyter <phdm@macqel.be>
  * Author: Alexandre Belloni <alexandre.belloni@bootlin.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <linux/bcd.h>
-- 
2.20.1

