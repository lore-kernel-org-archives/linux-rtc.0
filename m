Return-Path: <SRS0=7Ksz=RA=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8345FC43381
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Feb 2019 20:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F64120842
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Feb 2019 20:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfBYUYv (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:24:51 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:50247 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfBYUYu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 25 Feb 2019 15:24:50 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 324111C0007;
        Mon, 25 Feb 2019 20:24:49 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: remove rtc_class_ops.read_callback
Date:   Mon, 25 Feb 2019 21:24:47 +0100
Message-Id: <20190225202447.17054-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Since commit 416f0e8056f7 ("RTC: sa1100: Update the sa1100 RTC driver."),
the last user of .read_callback is gone. It has been 8 years and now new
user appeared. Simply remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/dev.c   | 5 -----
 include/linux/rtc.h | 3 +--
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
index 43d962a9c210..1d006ef4bb57 100644
--- a/drivers/rtc/dev.c
+++ b/drivers/rtc/dev.c
@@ -178,11 +178,6 @@ rtc_dev_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	remove_wait_queue(&rtc->irq_queue, &wait);
 
 	if (ret == 0) {
-		/* Check for any data updates */
-		if (rtc->ops->read_callback)
-			data = rtc->ops->read_callback(rtc->dev.parent,
-						       data);
-
 		if (sizeof(int) != sizeof(long) &&
 		    count == sizeof(unsigned int))
 			ret = put_user(data, (unsigned int __user *)buf) ?:
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index c1089fe5344a..f89bfbb54902 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -67,7 +67,7 @@ extern struct class *rtc_class;
  *
  * The (current) exceptions are mostly filesystem hooks:
  *   - the proc() hook for procfs
- *   - non-ioctl() chardev hooks:  open(), release(), read_callback()
+ *   - non-ioctl() chardev hooks:  open(), release()
  *
  * REVISIT those periodic irq calls *do* have ops_lock when they're
  * issued through ioctl() ...
@@ -81,7 +81,6 @@ struct rtc_class_ops {
 	int (*proc)(struct device *, struct seq_file *);
 	int (*set_mmss64)(struct device *, time64_t secs);
 	int (*set_mmss)(struct device *, unsigned long secs);
-	int (*read_callback)(struct device *, int data);
 	int (*alarm_irq_enable)(struct device *, unsigned int enabled);
 	int (*read_offset)(struct device *, long *offset);
 	int (*set_offset)(struct device *, long offset);
-- 
2.20.1

