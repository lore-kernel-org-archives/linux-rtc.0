Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34223 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbeEVCqE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 21 May 2018 22:46:04 -0400
Received: by mail-qt0-f194.google.com with SMTP id m5-v6so21603573qti.1
        for <linux-rtc@vger.kernel.org>; Mon, 21 May 2018 19:46:04 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 1/2] rtc: snvs: Switch to SPDX identifier
Date: Mon, 21 May 2018 23:45:58 -0300
Message-Id: <1526957159-19418-1-git-send-email-festevam@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/rtc/rtc-snvs.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 9af591d..8a75cc3 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -1,13 +1,6 @@
-/*
- * Copyright (C) 2011-2012 Freescale Semiconductor, Inc.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2011-2012 Freescale Semiconductor, Inc.
 
 #include <linux/init.h>
 #include <linux/io.h>
-- 
2.7.4
