Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:33591 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729902AbeISGwL (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 19 Sep 2018 02:52:11 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: test: Switch to SPDX identifier
Date: Wed, 19 Sep 2018 03:16:32 +0200
Message-Id: <20180919011632.4459-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20180919011632.4459-1-alexandre.belloni@bootlin.com>
References: <20180919011632.4459-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Replace the license boilerplate by an SPDX identifier

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-test.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 93f1638fb8c8..6c5f09c815e8 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * An RTC test device/driver
  * Copyright (C) 2005 Tower Technologies
  * Author: Alessandro Zummo <a.zummo@towertech.it>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/module.h>
-- 
2.19.0
