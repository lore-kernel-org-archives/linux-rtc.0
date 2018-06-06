Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56850 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbeFFPJN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 6 Jun 2018 11:09:13 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: [PATCH v3 06/12] rtc: cros-ec: Switch to SPDX identifier.
Date: Wed,  6 Jun 2018 17:08:54 +0200
Message-Id: <20180606150900.8342-7-enric.balletbo@collabora.com>
In-Reply-To: <20180606150900.8342-1-enric.balletbo@collabora.com>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/rtc/rtc-cros-ec.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index f2b87f9159c1..e5444296075e 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -1,19 +1,8 @@
-/*
- * RTC driver for Chrome OS Embedded Controller
- *
- * Copyright (c) 2017, Google, Inc
- *
- * Author: Stephen Barber <smbarber@chromium.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+// RTC driver for ChromeOS Embedded Controller.
+//
+// Copyright (C) 2017 Google, Inc.
+// Author: Stephen Barber <smbarber@chromium.org>
 
 #include <linux/kernel.h>
 #include <linux/mfd/cros_ec.h>
-- 
2.17.1
