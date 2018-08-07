Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388948AbeHGSes (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 7 Aug 2018 14:34:48 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/2] rtc: maxim: Add SPDX license identifiers
Date: Tue,  7 Aug 2018 18:19:18 +0200
Message-Id: <20180807161919.7827-1-krzk@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Replace GPL v2.0+ license statements with SPDX license
identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/rtc/rtc-max77686.c | 20 +++++++-------------
 drivers/rtc/rtc-max8997.c  | 20 +++++++-------------
 drivers/rtc/rtc-max8998.c  | 20 +++++++-------------
 3 files changed, 21 insertions(+), 39 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index cefde273fae6..8a60900d6b8b 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -1,16 +1,10 @@
-/*
- * RTC driver for Maxim MAX77686 and MAX77802
- *
- * Copyright (C) 2012 Samsung Electronics Co.Ltd
- *
- *  based on rtc-max8997.c
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// RTC driver for Maxim MAX77686 and MAX77802
+//
+// Copyright (C) 2012 Samsung Electronics Co.Ltd
+//
+//  based on rtc-max8997.c
 
 #include <linux/i2c.h>
 #include <linux/slab.h>
diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
index e8cee123e8aa..08c661a332ec 100644
--- a/drivers/rtc/rtc-max8997.c
+++ b/drivers/rtc/rtc-max8997.c
@@ -1,16 +1,10 @@
-/*
- * RTC driver for Maxim MAX8997
- *
- * Copyright (C) 2013 Samsung Electronics Co.Ltd
- *
- *  based on rtc-max8998.c
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// RTC driver for Maxim MAX8997
+//
+// Copyright (C) 2013 Samsung Electronics Co.Ltd
+//
+//  based on rtc-max8998.c
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
diff --git a/drivers/rtc/rtc-max8998.c b/drivers/rtc/rtc-max8998.c
index d8c0f9b3f87d..c873b4509b3c 100644
--- a/drivers/rtc/rtc-max8998.c
+++ b/drivers/rtc/rtc-max8998.c
@@ -1,16 +1,10 @@
-/*
- * RTC driver for Maxim MAX8998
- *
- * Copyright (C) 2010 Samsung Electronics Co.Ltd
- * Author: Minkyu Kang <mk7.kang@samsung.com>
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// RTC driver for Maxim MAX8998
+//
+// Copyright (C) 2010 Samsung Electronics Co.Ltd
+// Author: Minkyu Kang <mk7.kang@samsung.com>
+// Author: Joonyoung Shim <jy0922.shim@samsung.com>
 
 #include <linux/module.h>
 #include <linux/i2c.h>
-- 
2.14.1
