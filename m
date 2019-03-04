Return-Path: <SRS0=54M4=RH=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A81C43381
	for <linux-rtc@archiver.kernel.org>; Mon,  4 Mar 2019 19:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC222070B
	for <linux-rtc@archiver.kernel.org>; Mon,  4 Mar 2019 19:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbfCDTTg (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:19:36 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:56987 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDTTg (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 4 Mar 2019 14:19:36 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id EF12F24000A;
        Mon,  4 Mar 2019 19:19:34 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: update my email address
Date:   Mon,  4 Mar 2019 20:19:28 +0100
Message-Id: <20190304191928.10400-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Use my current email address.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-abx80x.c | 4 ++--
 drivers/rtc/rtc-rv8803.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index b76f65983658..6ddcad642d1e 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -5,7 +5,7 @@
  * Copyright 2014-2015 Macq S.A.
  *
  * Author: Philippe De Muyter <phdm@macqel.be>
- * Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
+ * Author: Alexandre Belloni <alexandre.belloni@bootlin.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -906,6 +906,6 @@ static struct i2c_driver abx80x_driver = {
 module_i2c_driver(abx80x_driver);
 
 MODULE_AUTHOR("Philippe De Muyter <phdm@macqel.be>");
-MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@free-electrons.com>");
+MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@bootlin.com>");
 MODULE_DESCRIPTION("Abracon ABX80X RTC driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 7ffd18ab0cdd..0b102c3cf5a4 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -3,7 +3,7 @@
  * RTC driver for the Micro Crystal RV8803
  *
  * Copyright (C) 2015 Micro Crystal SA
- * Alexandre Belloni <alexandre.belloni@free-electrons.com>
+ * Alexandre Belloni <alexandre.belloni@bootlin.com>
  *
  */
 
@@ -643,6 +643,6 @@ static struct i2c_driver rv8803_driver = {
 };
 module_i2c_driver(rv8803_driver);
 
-MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@free-electrons.com>");
+MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@bootlin.com>");
 MODULE_DESCRIPTION("Micro Crystal RV8803 RTC driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

