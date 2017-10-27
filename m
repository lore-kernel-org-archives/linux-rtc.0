Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47898 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbdJ0LJw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 27 Oct 2017 07:09:52 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: ds1390: Add OF device ID table
Date: Fri, 27 Oct 2017 13:09:47 +0200
Message-Id: <20171027110947.12803-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. Worse, the compatible is documented but
doesn't currently match the driver.

Add the proper compatible to the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1390.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
index aa0d2c6f1edc..4d5b007d7fc6 100644
--- a/drivers/rtc/rtc-ds1390.c
+++ b/drivers/rtc/rtc-ds1390.c
@@ -216,9 +216,16 @@ static int ds1390_probe(struct spi_device *spi)
 	return res;
 }
 
+static const struct of_device_id ds1390_of_match[] = {
+	{ .compatible = "dallas,ds1390" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ds1390_of_match);
+
 static struct spi_driver ds1390_driver = {
 	.driver = {
 		.name	= "rtc-ds1390",
+		.of_match_table = of_match_ptr(ds1390_of_match),
 	},
 	.probe	= ds1390_probe,
 };
-- 
2.15.0.rc2
