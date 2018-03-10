Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from gateway24.websitewelcome.com ([192.185.50.45]:26990 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750735AbeCJGwE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 10 Mar 2018 01:52:04 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 3CF8B11E78
        for <linux-rtc@vger.kernel.org>; Sat, 10 Mar 2018 00:27:36 -0600 (CST)
Date: Sat, 10 Mar 2018 00:27:35 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 2/2] rtc: s5m: Remove VLA usage
Message-ID: <543a0a74122172acae549329b35964f402da8b77.1520660422.git.gustavo@embeddedor.com>
References: <cover.1520660422.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520660422.git.gustavo@embeddedor.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

In preparation to enabling -Wvla, remove VLAs and replace them
with fixed-length arrays instead.

>From a security viewpoint, the use of Variable Length Arrays can be
a vector for stack overflow attacks. Also, in general, as the code
evolves it is easy to lose track of how big a VLA can get. Thus, we
can end up having segfaults that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/rtc/rtc-s5m.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 4c363de..8428455 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -47,6 +47,8 @@ enum {
 	RTC_MONTH,
 	RTC_YEAR1,
 	RTC_YEAR2,
+	/* Make sure this is always the last enum name. */
+	RTC_MAX_NUM_TIME_REGS
 };
 
 /*
@@ -378,7 +380,7 @@ static void s5m8763_tm_to_data(struct rtc_time *tm, u8 *data)
 static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
-	u8 data[info->regs->regs_count];
+	u8 data[RTC_MAX_NUM_TIME_REGS];
 	int ret;
 
 	if (info->regs->read_time_udr_mask) {
@@ -424,7 +426,7 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
-	u8 data[info->regs->regs_count];
+	u8 data[RTC_MAX_NUM_TIME_REGS];
 	int ret = 0;
 
 	switch (info->device_type) {
@@ -461,7 +463,7 @@ static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
-	u8 data[info->regs->regs_count];
+	u8 data[RTC_MAX_NUM_TIME_REGS];
 	unsigned int val;
 	int ret, i;
 
@@ -511,7 +513,7 @@ static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
 {
-	u8 data[info->regs->regs_count];
+	u8 data[RTC_MAX_NUM_TIME_REGS];
 	int ret, i;
 	struct rtc_time tm;
 
@@ -556,7 +558,7 @@ static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
 static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
 {
 	int ret;
-	u8 data[info->regs->regs_count];
+	u8 data[RTC_MAX_NUM_TIME_REGS];
 	u8 alarm0_conf;
 	struct rtc_time tm;
 
@@ -609,7 +611,7 @@ static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
 static int s5m_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
-	u8 data[info->regs->regs_count];
+	u8 data[RTC_MAX_NUM_TIME_REGS];
 	int ret;
 
 	switch (info->device_type) {
-- 
2.7.4
