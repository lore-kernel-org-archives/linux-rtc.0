Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35478 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756235AbdGLLyn (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 12 Jul 2017 07:54:43 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: m41t80: constify attribute_group structures.
Date: Wed, 12 Jul 2017 17:24:08 +0530
Message-Id: <25a7f1388403165803a78ffeb63e4a5429c38a45.1499860262.git.arvind.yadav.cs@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work
with const attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   4162	    544	      0	   4706	   1262	drivers/rtc/rtc-m41t80.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   4226	    480	      0	   4706	   1262	drivers/rtc/rtc-m41t80.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/rtc/rtc-m41t80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 5ec4653..c15a19e 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -524,7 +524,7 @@ static ssize_t sqwfreq_store(struct device *dev,
 	NULL,
 };
 
-static struct attribute_group attr_group = {
+static const struct attribute_group attr_group = {
 	.attrs = attrs,
 };
 
-- 
1.9.1
