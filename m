Return-Path: <SRS0=mxAq=7K=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B862C433DF
	for <linux-rtc@archiver.kernel.org>; Thu, 28 May 2020 12:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BC9215A4
	for <linux-rtc@archiver.kernel.org>; Thu, 28 May 2020 12:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbgE1MEb (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 28 May 2020 08:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388957AbgE1MEa (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 28 May 2020 08:04:30 -0400
X-Greylist: delayed 1082 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 May 2020 05:04:30 PDT
Received: from mail.net18.km6g.us (mail.net18.km6g.us [IPv6:2607:5300:203:24b0:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D77C05BD1E
        for <linux-rtc@vger.kernel.org>; Thu, 28 May 2020 05:04:30 -0700 (PDT)
Received: from [2001:470:8afe:60:716b:c9b9:d55a:f6f1] (helo=balrog20.km6g.us)
        by mail.net18.km6g.us with esmtp (Exim 4.93.0.4 (FreeBSD))
        (envelope-from <kevin+linux@km6g.us>)
        id 1jeGzQ-000Cds-9C; Thu, 28 May 2020 07:46:24 -0400
From:   "Kevin P. Fleming" <kevin+linux@km6g.us>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     "Kevin P. Fleming" <kevin+linux@km6g.us>
Subject: [PATCH] rtc: abx80x: Add Device Tree matching table
Date:   Thu, 28 May 2020 07:46:17 -0400
Message-Id: <20200528114617.166587-1-kevin+linux@km6g.us>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Enable automatic loading of the module when a Device Tree overlay
specifies a device supported by this driver.

Signed-off-by: Kevin P. Fleming <kevin+linux@km6g.us>
---
 drivers/rtc/rtc-abx80x.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 3521d8e8dc38..67bf3b8cfe65 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -13,6 +13,7 @@
 #include <linux/bcd.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/rtc.h>
 #include <linux/watchdog.h>
 
@@ -863,9 +864,57 @@ static const struct i2c_device_id abx80x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, abx80x_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id abx80x_of_match[] = {
+	{
+		.compatible = "abracon,abx80x",
+		.data = (void *)ABX80X
+	},
+	{
+		.compatible = "abracon,ab0801",
+		.data = (void *)AB0801
+	},
+	{
+		.compatible = "abracon,ab0803",
+		.data = (void *)AB0803
+	},
+	{
+		.compatible = "abracon,ab0804",
+		.data = (void *)AB0804
+	},
+	{
+		.compatible = "abracon,ab0805",
+		.data = (void *)AB0805
+	},
+	{
+		.compatible = "abracon,ab1801",
+		.data = (void *)AB1801
+	},
+	{
+		.compatible = "abracon,ab1803",
+		.data = (void *)AB1803
+	},
+	{
+		.compatible = "abracon,ab1804",
+		.data = (void *)AB1804
+	},
+	{
+		.compatible = "abracon,ab1805",
+		.data = (void *)AB1805
+	},
+	{
+		.compatible = "microcrystal,rv1805",
+		.data = (void *)RV1805
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, abx80x_of_match);
+#endif
+
 static struct i2c_driver abx80x_driver = {
 	.driver		= {
 		.name	= "rtc-abx80x",
+		.of_match_table = of_match_ptr(abx80x_of_match),
 	},
 	.probe		= abx80x_probe,
 	.id_table	= abx80x_id,
-- 
2.26.2

