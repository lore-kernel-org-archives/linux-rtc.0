Return-Path: <SRS0=47cv=RQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05365C43381
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Mar 2019 22:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48DF2087C
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Mar 2019 22:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfCMWEc (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:04:32 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42285 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfCMWEc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Mar 2019 18:04:32 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0287360002;
        Wed, 13 Mar 2019 22:04:29 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: convert core to SPDX identifier
Date:   Wed, 13 Mar 2019 23:04:26 +0100
Message-Id: <20190313220426.13202-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Use SPDX-License-Identifier instead of a verbose license text. Also fix the
block comment alignment.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/class.c     | 7 ++-----
 drivers/rtc/dev.c       | 7 ++-----
 drivers/rtc/hctosys.c   | 7 ++-----
 drivers/rtc/interface.c | 7 ++-----
 drivers/rtc/lib.c       | 7 ++-----
 drivers/rtc/nvmem.c     | 5 +----
 drivers/rtc/proc.c      | 7 ++-----
 drivers/rtc/sysfs.c     | 7 ++-----
 drivers/rtc/systohc.c   | 7 +------
 9 files changed, 16 insertions(+), 45 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index ac93b76f2b11..22190ad28e8b 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * RTC subsystem, base class
  *
@@ -5,11 +6,7 @@
  * Author: Alessandro Zummo <a.zummo@towertech.it>
  *
  * class skeleton from drivers/hwmon/hwmon.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
index 1d006ef4bb57..f68aae035b81 100644
--- a/drivers/rtc/dev.c
+++ b/drivers/rtc/dev.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * RTC subsystem, dev interface
  *
@@ -5,11 +6,7 @@
  * Author: Alessandro Zummo <a.zummo@towertech.it>
  *
  * based on arch/arm/common/rtctime.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
diff --git a/drivers/rtc/hctosys.c b/drivers/rtc/hctosys.c
index ff2092a0d38c..eacbe500c44b 100644
--- a/drivers/rtc/hctosys.c
+++ b/drivers/rtc/hctosys.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * RTC subsystem, initialize system time on startup
  *
  * Copyright (C) 2005 Tower Technologies
  * Author: Alessandro Zummo <a.zummo@towertech.it>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 98d9c87b0d1b..28bd767e03a0 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * RTC subsystem, interface functions
  *
@@ -5,11 +6,7 @@
  * Author: Alessandro Zummo <a.zummo@towertech.it>
  *
  * based on arch/arm/common/rtctime.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <linux/rtc.h>
 #include <linux/sched.h>
diff --git a/drivers/rtc/lib.c b/drivers/rtc/lib.c
index 9714cb3d1e29..3d0dc70ff7d8 100644
--- a/drivers/rtc/lib.c
+++ b/drivers/rtc/lib.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * rtc and date/time utility functions
  *
@@ -5,11 +6,7 @@
  * Author: Alessandro Zummo <a.zummo@towertech.it>
  *
  * based on arch/arm/common/rtctime.c and other bits
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <linux/export.h>
 #include <linux/rtc.h>
diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index dce518d5e50e..7481a4cd2753 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * RTC subsystem, nvmem interface
  *
  * Copyright (C) 2017 Alexandre Belloni
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/err.h>
diff --git a/drivers/rtc/proc.c b/drivers/rtc/proc.c
index 4d74e4f4ff30..a741c4d8f5a5 100644
--- a/drivers/rtc/proc.c
+++ b/drivers/rtc/proc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * RTC subsystem, proc interface
  *
@@ -5,11 +6,7 @@
  * Author: Alessandro Zummo <a.zummo@towertech.it>
  *
  * based on arch/arm/common/rtctime.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <linux/module.h>
 #include <linux/rtc.h>
diff --git a/drivers/rtc/sysfs.c b/drivers/rtc/sysfs.c
index a8f22ee726bb..0d3dac557df5 100644
--- a/drivers/rtc/sysfs.c
+++ b/drivers/rtc/sysfs.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * RTC subsystem, sysfs interface
  *
  * Copyright (C) 2005 Tower Technologies
  * Author: Alessandro Zummo <a.zummo@towertech.it>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <linux/module.h>
 #include <linux/rtc.h>
diff --git a/drivers/rtc/systohc.c b/drivers/rtc/systohc.c
index 718293d72426..8bf8e0c1e8fd 100644
--- a/drivers/rtc/systohc.c
+++ b/drivers/rtc/systohc.c
@@ -1,9 +1,4 @@
-/*
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/rtc.h>
 #include <linux/time.h>
 
-- 
2.20.1

