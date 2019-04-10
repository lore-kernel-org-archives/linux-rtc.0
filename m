Return-Path: <SRS0=qdFt=SM=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A70C10F11
	for <linux-rtc@archiver.kernel.org>; Wed, 10 Apr 2019 14:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3418720818
	for <linux-rtc@archiver.kernel.org>; Wed, 10 Apr 2019 14:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfDJOGE (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:06:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:61664 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbfDJOGD (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 10 Apr 2019 10:06:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 07:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="160423026"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2019 07:06:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C8BF2EC; Wed, 10 Apr 2019 17:05:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] rtc: rx8025: Fix a parameter to %ptR in rx8025_read_alarm()
Date:   Wed, 10 Apr 2019 17:05:59 +0300
Message-Id: <20190410140559.12909-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The commit 1921cab11723 ("rtc: rx8025: Switch to use %ptR") converted
the driver to use new %p extension, but actually used wrong type of
the parameter in one case.

Fix a parameter to %ptR in rx8025_read_alarm().

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-rx8025.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 41de38acc570..fddc996cb38d 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -311,7 +311,7 @@ static int rx8025_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 		t->time.tm_hour = bcd2bin(ald[1] & 0x1f) % 12
 			+ (ald[1] & 0x20 ? 12 : 0);
 
-	dev_dbg(dev, "%s: date: %ptRr\n", __func__, t);
+	dev_dbg(dev, "%s: date: %ptRr\n", __func__, &t->time);
 	t->enabled = !!(rx8025->ctrl1 & RX8025_BIT_CTRL1_DALE);
 	t->pending = (ctrl2 & RX8025_BIT_CTRL2_DAFG) && t->enabled;
 
-- 
2.20.1

