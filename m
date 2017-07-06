Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49166 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbdGFJm0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 05:42:26 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 08/11] rtc: rv8803: remove rv8803_remove
Date: Thu,  6 Jul 2017 11:42:05 +0200
Message-Id: <20170706094208.16240-9-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
References: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

rv8803_remove() is now empty, remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rv8803.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 10474ab7887d..aae2576741a6 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -612,11 +612,6 @@ static int rv8803_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int rv8803_remove(struct i2c_client *client)
-{
-	return 0;
-}
-
 static const struct i2c_device_id rv8803_id[] = {
 	{ "rv8803", rv_8803 },
 	{ "rx8900", rx_8900 },
@@ -643,7 +638,6 @@ static struct i2c_driver rv8803_driver = {
 		.of_match_table = of_match_ptr(rv8803_of_match),
 	},
 	.probe		= rv8803_probe,
-	.remove		= rv8803_remove,
 	.id_table	= rv8803_id,
 };
 module_i2c_driver(rv8803_driver);
-- 
2.11.0
