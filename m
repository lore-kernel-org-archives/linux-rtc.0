Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33499 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755386AbeAHGFU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 8 Jan 2018 01:05:20 -0500
Received: by mail-pg0-f68.google.com with SMTP id i196so4915877pgd.0
        for <linux-rtc@vger.kernel.org>; Sun, 07 Jan 2018 22:05:20 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: arnd@arndb.de, broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH 1/3] rtc: Use time64_t to save range_max of RTC
Date: Mon,  8 Jan 2018 14:04:48 +0800
Message-Id: <f64a09a864c00955eb994a0c03c503795adb0eee.1515390560.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

We need use rtc->range_max to valid if the time values are valid,
and the time values are saved by time64_t type. So change the
rtc->range_max to time64_t type for comparison correctly.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/linux/rtc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 69e358c..4ac60af 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -153,7 +153,7 @@ struct rtc_device {
 	struct bin_attribute *nvram;
 
 	time64_t range_min;
-	timeu64_t range_max;
+	time64_t range_max;
 
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 	struct work_struct uie_task;
-- 
1.7.9.5
