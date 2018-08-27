Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:53057 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeH1BMO (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 27 Aug 2018 21:12:14 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: rv8803: add Epson RX8803 support
Date: Mon, 27 Aug 2018 23:23:44 +0200
Message-Id: <20180827212344.9779-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20180827212344.9779-1-alexandre.belloni@bootlin.com>
References: <20180827212344.9779-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The Epson rx8803 is mostly similar to the Microcrystal RV8803 but the size
of the offset register is 4 bits vs 6 bits but it has a configurable
temperature compensation.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv8803.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 17ccef5d5db1..450a0b831a2d 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -615,6 +615,7 @@ static int rv8803_probe(struct i2c_client *client,
 
 static const struct i2c_device_id rv8803_id[] = {
 	{ "rv8803", rv_8803 },
+	{ "rx8803", rv_8803 },
 	{ "rx8900", rx_8900 },
 	{ }
 };
@@ -625,6 +626,10 @@ static const struct of_device_id rv8803_of_match[] = {
 		.compatible = "microcrystal,rv8803",
 		.data = (void *)rv_8803
 	},
+	{
+		.compatible = "epson,rx8803",
+		.data = (void *)rv_8803
+	},
 	{
 		.compatible = "epson,rx8900",
 		.data = (void *)rx_8900
-- 
2.18.0
