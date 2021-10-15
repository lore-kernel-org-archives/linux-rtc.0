Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CABC433FE
	for <linux-rtc@archiver.kernel.org>; Fri, 15 Oct 2021 19:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C622661151
	for <linux-rtc@archiver.kernel.org>; Fri, 15 Oct 2021 19:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbhJOTXh (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:23:37 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50585 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhJOTXg (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 15 Oct 2021 15:23:36 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id B12A4240002;
        Fri, 15 Oct 2021 19:21:28 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] rtc: add correction parameter
Date:   Fri, 15 Oct 2021 21:21:17 +0200
Message-Id: <20211015192121.817642-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015192121.817642-1-alexandre.belloni@bootlin.com>
References: <20211015192121.817642-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Add a new parameter allowing the get and set the correction using ioctls
instead of just sysfs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/dev.c        | 19 +++++++++++++++++++
 include/uapi/linux/rtc.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
index 143c097eff0f..abee1fc4705e 100644
--- a/drivers/rtc/dev.c
+++ b/drivers/rtc/dev.c
@@ -398,6 +398,16 @@ static long rtc_dev_ioctl(struct file *file,
 			param.uvalue = rtc->features[0];
 			break;
 
+		case RTC_PARAM_CORRECTION:
+			mutex_unlock(&rtc->ops_lock);
+			if (param.index != 0)
+				return -EINVAL;
+			err = rtc_read_offset(rtc, &offset);
+			mutex_lock(&rtc->ops_lock);
+			if (err == 0)
+				param.svalue = offset;
+			break;
+
 		default:
 			err = -EINVAL;
 		}
@@ -416,6 +426,15 @@ static long rtc_dev_ioctl(struct file *file,
 
 		switch(param.param) {
 		case RTC_PARAM_FEATURES:
+			err = -EINVAL;
+			break;
+
+		case RTC_PARAM_CORRECTION:
+			mutex_unlock(&rtc->ops_lock);
+			if (param.index != 0)
+				return -EINVAL;
+			return rtc_set_offset(rtc, param.svalue);
+
 		default:
 			err = -EINVAL;
 		}
diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
index ded2aaab7ec7..04da6c3082b3 100644
--- a/include/uapi/linux/rtc.h
+++ b/include/uapi/linux/rtc.h
@@ -136,6 +136,7 @@ struct rtc_param {
 
 /* parameter list */
 #define RTC_PARAM_FEATURES		0
+#define RTC_PARAM_CORRECTION		1
 
 #define RTC_MAX_FREQ	8192
 
-- 
2.31.1

