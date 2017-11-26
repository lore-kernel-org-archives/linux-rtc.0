Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751793AbdKZAlf (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 25 Nov 2017 19:41:35 -0500
From: Cole Robinson <crobinso@redhat.com>
To: linux-rtc@vger.kernel.org
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        linux-kernel@vger.kernel.org, Cole Robinson <crobinso@redhat.com>
Subject: [PATCH] rtc: Remove unused RTC_DEVICE_NAME_SIZE
Date: Sat, 25 Nov 2017 19:41:32 -0500
Message-Id: <2cb5fda40f5ac0a6cc0ab59914c98062741c2e8b.1511656401.git.crobinso@redhat.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The last usage was removed in 5c82a6ae0 when rtc_device.name
was removed

Signed-off-by: Cole Robinson <crobinso@redhat.com>
---
Just noticed this when looking at commits a few months back...

 include/linux/rtc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 41319a2e409b..fc6c90b57be0 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -87,7 +87,6 @@ struct rtc_class_ops {
 	int (*set_offset)(struct device *, long offset);
 };
 
-#define RTC_DEVICE_NAME_SIZE 20
 typedef struct rtc_task {
 	void (*func)(void *private_data);
 	void *private_data;
-- 
2.14.3
