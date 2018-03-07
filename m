Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:57173 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754706AbeCGXNz (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 7 Mar 2018 18:13:55 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: Add useful timestamp definitions
Date: Thu,  8 Mar 2018 00:13:52 +0100
Message-Id: <20180307231352.21840-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Add commonly used timestamps for range definition.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 include/linux/rtc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 82a3038f16ab..4c007f69082f 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -169,6 +169,11 @@ struct rtc_device {
 };
 #define to_rtc_device(d) container_of(d, struct rtc_device, dev)
 
+/* useful timestamps */
+#define RTC_TIMESTAMP_BEGIN_1900	-2208989361LL /* 1900-01-01 00:00:00 */
+#define RTC_TIMESTAMP_BEGIN_2000	946684800LL /* 2000-01-01 00:00:00 */
+#define RTC_TIMESTAMP_END_2099		4102444799LL /* 2099-12-31 23:59:59 */
+
 extern struct rtc_device *rtc_device_register(const char *name,
 					struct device *dev,
 					const struct rtc_class_ops *ops,
-- 
2.16.2
