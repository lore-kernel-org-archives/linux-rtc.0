Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36280 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeDJLtt (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 10 Apr 2018 07:49:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id g14so8077414pfh.3
        for <linux-rtc@vger.kernel.org>; Tue, 10 Apr 2018 04:49:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-rtc@vger.kernel.org
Subject: [PATCH 2/3] powerpc/powernv: Fix OPAL RTC driver OPAL_BUSY loops
Date: Tue, 10 Apr 2018 21:49:32 +1000
Message-Id: <20180410114933.24581-3-npiggin@gmail.com>
In-Reply-To: <20180410114933.24581-1-npiggin@gmail.com>
References: <20180410114933.24581-1-npiggin@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The OPAL RTC driver does not sleep in case it gets OPAL_BUSY or
OPAL_BUSY_EVENT from firmware, which causes large scheduling
latencies, up to 50 seconds have been observed here when RTC stops
responding (BMC reboot can do it).

Fix this by converting it to the standard form OPAL_BUSY loop that
sleeps.

Fixes 628daa8d5abfd ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks"
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-rtc@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-rtc.c |  8 +++--
 drivers/rtc/rtc-opal.c                    | 37 ++++++++++++++---------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-rtc.c b/arch/powerpc/platforms/powernv/opal-rtc.c
index f8868864f373..aa2a5139462e 100644
--- a/arch/powerpc/platforms/powernv/opal-rtc.c
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -48,10 +48,12 @@ unsigned long __init opal_get_boot_time(void)
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			mdelay(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else if (rc == OPAL_BUSY)
-			mdelay(10);
+		} else if (rc == OPAL_BUSY) {
+			mdelay(OPAL_BUSY_DELAY_MS);
+		}
 	}
 	if (rc != OPAL_SUCCESS)
 		return 0;
diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 304e891e35fc..60f2250fd96b 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -57,7 +57,7 @@ static void tm_to_opal(struct rtc_time *tm, u32 *y_m_d, u64 *h_m_s_ms)
 
 static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
 {
-	long rc = OPAL_BUSY;
+	s64 rc = OPAL_BUSY;
 	int retries = 10;
 	u32 y_m_d;
 	u64 h_m_s_ms;
@@ -66,13 +66,17 @@ static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else if (retries-- && (rc == OPAL_HARDWARE
-				       || rc == OPAL_INTERNAL_ERROR))
-			msleep(10);
-		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
-			break;
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		} else if (rc == OPAL_HARDWARE || rc == OPAL_INTERNAL_ERROR) {
+			if (retries--) {
+				msleep(10); /* Wait 10ms before retry */
+				rc = OPAL_BUSY; /* go around again */
+			}
+		}
 	}
 
 	if (rc != OPAL_SUCCESS)
@@ -87,21 +91,26 @@ static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
 
 static int opal_set_rtc_time(struct device *dev, struct rtc_time *tm)
 {
-	long rc = OPAL_BUSY;
+	s64 rc = OPAL_BUSY;
 	int retries = 10;
 	u32 y_m_d = 0;
 	u64 h_m_s_ms = 0;
 
 	tm_to_opal(tm, &y_m_d, &h_m_s_ms);
+
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_write(y_m_d, h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else if (retries-- && (rc == OPAL_HARDWARE
-				       || rc == OPAL_INTERNAL_ERROR))
-			msleep(10);
-		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
-			break;
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		} else if (rc == OPAL_HARDWARE || rc == OPAL_INTERNAL_ERROR) {
+			if (retries--) {
+				msleep(10); /* Wait 10ms before retry */
+				rc = OPAL_BUSY; /* go around again */
+			}
+		}
 	}
 
 	return rc == OPAL_SUCCESS ? 0 : -EIO;
-- 
2.17.0
