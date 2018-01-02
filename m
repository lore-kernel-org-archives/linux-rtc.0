Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44798 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeABFKi (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Jan 2018 00:10:38 -0500
Received: by mail-pg0-f68.google.com with SMTP id i5so7965389pgq.11
        for <linux-rtc@vger.kernel.org>; Mon, 01 Jan 2018 21:10:37 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        corbet@lwn.net
Cc: arnd@arndb.de, broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [RFC PATCH 4/4] rtc: sc27xx: Add the get_range interface
Date: Tue,  2 Jan 2018 13:10:08 +0800
Message-Id: <2240e08e757926ff01d3b73596b0a8c9e29f2530.1514869622.git.baolin.wang@linaro.org>
In-Reply-To: <9ab56bdcaeb52241e22b738d6babe7b01728f64c.1514869621.git.baolin.wang@linaro.org>
References: <9ab56bdcaeb52241e22b738d6babe7b01728f64c.1514869621.git.baolin.wang@linaro.org>
In-Reply-To: <9ab56bdcaeb52241e22b738d6babe7b01728f64c.1514869621.git.baolin.wang@linaro.org>
References: <9ab56bdcaeb52241e22b738d6babe7b01728f64c.1514869621.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Add the get_range interface for sc27xx RTC driver to tell the RTC
core what is the valid range for RTC hardware device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/rtc-sc27xx.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index d544d52..97b1120 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -536,12 +536,22 @@ static int sprd_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	return ret;
 }
 
+static int sprd_rtc_read_range(struct device *dev, time64_t *max_hw_secs,
+			       time64_t *min_hw_secs)
+{
+	*min_hw_secs = 0;
+	*max_hw_secs = (((time64_t)(SPRD_RTC_DAY_MASK * 24) + 23) * 60 + 59) * 60 + 59;
+
+	return 0;
+}
+
 static const struct rtc_class_ops sprd_rtc_ops = {
 	.read_time = sprd_rtc_read_time,
 	.set_time = sprd_rtc_set_time,
 	.read_alarm = sprd_rtc_read_alarm,
 	.set_alarm = sprd_rtc_set_alarm,
 	.alarm_irq_enable = sprd_rtc_alarm_irq_enable,
+	.read_range = sprd_rtc_read_range,
 };
 
 static irqreturn_t sprd_rtc_handler(int irq, void *dev_id)
-- 
1.7.9.5
