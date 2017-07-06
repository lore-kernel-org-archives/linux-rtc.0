Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49153 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdGFJmO (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 05:42:14 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 02/11] rtc: class separate id allocation from registration
Date: Thu,  6 Jul 2017 11:41:59 +0200
Message-Id: <20170706094208.16240-3-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
References: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Create rtc_device_get_id to allocate the id for an RTC.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/class.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index fb39c1334d7b..93ce88e1b1cb 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -186,6 +186,27 @@ static struct rtc_device *rtc_allocate_device(void)
 	return rtc;
 }
 
+static int rtc_device_get_id(struct device *dev)
+{
+	int of_id = -1, id = -1;
+
+	if (dev->of_node)
+		of_id = of_alias_get_id(dev->of_node, "rtc");
+	else if (dev->parent && dev->parent->of_node)
+		of_id = of_alias_get_id(dev->parent->of_node, "rtc");
+
+	if (of_id >= 0) {
+		id = ida_simple_get(&rtc_ida, of_id, of_id + 1, GFP_KERNEL);
+		if (id < 0)
+			dev_warn(dev, "/aliases ID %d not available\n", of_id);
+	}
+
+	if (id < 0)
+		id = ida_simple_get(&rtc_ida, 0, 0, GFP_KERNEL);
+
+	return id;
+}
+
 /**
  * rtc_device_register - register w/ RTC class
  * @dev: the device to register
@@ -201,27 +222,12 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 {
 	struct rtc_device *rtc;
 	struct rtc_wkalrm alrm;
-	int of_id = -1, id = -1, err;
-
-	if (dev->of_node)
-		of_id = of_alias_get_id(dev->of_node, "rtc");
-	else if (dev->parent && dev->parent->of_node)
-		of_id = of_alias_get_id(dev->parent->of_node, "rtc");
-
-	if (of_id >= 0) {
-		id = ida_simple_get(&rtc_ida, of_id, of_id + 1,
-				    GFP_KERNEL);
-		if (id < 0)
-			dev_warn(dev, "/aliases ID %d not available\n",
-				    of_id);
-	}
+	int id, err;
 
+	id = rtc_device_get_id(dev);
 	if (id < 0) {
-		id = ida_simple_get(&rtc_ida, 0, 0, GFP_KERNEL);
-		if (id < 0) {
-			err = id;
-			goto exit;
-		}
+		err = id;
+		goto exit;
 	}
 
 	rtc = rtc_allocate_device();
-- 
2.11.0
