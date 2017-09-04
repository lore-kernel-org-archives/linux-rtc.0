Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53974 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754027AbdIDUqP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 4 Sep 2017 16:46:15 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 7/7] rtc: ds1307: use octal permissions
Date: Mon,  4 Sep 2017 22:46:08 +0200
Message-Id: <20170904204608.7090-7-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170904204608.7090-1-alexandre.belloni@free-electrons.com>
References: <20170904204608.7090-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Octal permissions are preferred over symbolic permissions.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 9df50db228c6..9d680d36afc0 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1051,7 +1051,7 @@ static ssize_t ds3231_hwmon_show_temp(struct device *dev,
 
 	return sprintf(buf, "%d\n", temp);
 }
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ds3231_hwmon_show_temp,
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, ds3231_hwmon_show_temp,
 			  NULL, 0);
 
 static struct attribute *ds3231_hwmon_attrs[] = {
-- 
2.14.1
