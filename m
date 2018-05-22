Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39608 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbeEVCqG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 21 May 2018 22:46:06 -0400
Received: by mail-qt0-f195.google.com with SMTP id f1-v6so21592078qtj.6
        for <linux-rtc@vger.kernel.org>; Mon, 21 May 2018 19:46:06 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 2/2] rtc: mxc: Switch to SPDX identifier
Date: Mon, 21 May 2018 23:45:59 -0300
Message-Id: <1526957159-19418-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1526957159-19418-1-git-send-email-festevam@gmail.com>
References: <1526957159-19418-1-git-send-email-festevam@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/rtc/rtc-mxc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 822ebe4..878c6ee 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -1,13 +1,6 @@
-/*
- * Copyright 2004-2008 Freescale Semiconductor, Inc. All Rights Reserved.
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
+// Copyright 2004-2008 Freescale Semiconductor, Inc. All Rights Reserved.
 
 #include <linux/io.h>
 #include <linux/rtc.h>
-- 
2.7.4
