Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46060 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbdK2O0w (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 29 Nov 2017 09:26:52 -0500
Received: by mail-wr0-f193.google.com with SMTP id h1so3538172wre.12
        for <linux-rtc@vger.kernel.org>; Wed, 29 Nov 2017 06:26:52 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH] rtc: stm32: Fix copyright
Date: Wed, 29 Nov 2017 15:26:44 +0100
Message-Id: <20171129142644.23576-1-benjamin.gaignard@st.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Uniformize STMicroelectronics copyrights header

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
CC: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 3a5c3d7d0c77..f25dabe8fd02 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -1,6 +1,6 @@
 /*
- * Copyright (C) Amelie Delaunay 2016
- * Author:  Amelie Delaunay <amelie.delaunay@st.com>
+ * Copyright (C) STMicroelectronics SA 2017
+ * Author:  Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
  * License terms:  GNU General Public License (GPL), version 2
  */
 
-- 
2.15.0
