Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:33547 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbeISGs6 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 19 Sep 2018 02:48:58 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: isl1208: don't include core header file
Date: Wed, 19 Sep 2018 03:13:22 +0200
Message-Id: <20180919011322.3985-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20180919011322.3985-1-alexandre.belloni@bootlin.com>
References: <20180919011322.3985-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The core header file is reserved for the core, stop including it.

Also reorder includes alphabetically.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-isl1208.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index e1e9434c9972..15094df12985 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -10,12 +10,11 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/i2c.h>
 #include <linux/bcd.h>
-#include <linux/rtc.h>
-#include "rtc-core.h"
+#include <linux/i2c.h>
+#include <linux/module.h>
 #include <linux/of_irq.h>
+#include <linux/rtc.h>
 
 /* Register map */
 /* rtc section */
-- 
2.19.0
