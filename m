Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49171 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbdGFJmj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 05:42:39 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 11/11] rtc: ds1307: remove ds1307_remove
Date: Thu,  6 Jul 2017 11:42:08 +0200
Message-Id: <20170706094208.16240-12-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
References: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

ds1307_remove() is now empty, remove it

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1307.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 6f91c11a5f03..ea83ddc5a513 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1701,11 +1701,6 @@ static int ds1307_probe(struct i2c_client *client,
 	return err;
 }
 
-static int ds1307_remove(struct i2c_client *client)
-{
-	return 0;
-}
-
 static struct i2c_driver ds1307_driver = {
 	.driver = {
 		.name	= "rtc-ds1307",
@@ -1713,7 +1708,6 @@ static struct i2c_driver ds1307_driver = {
 		.acpi_match_table = ACPI_PTR(ds1307_acpi_ids),
 	},
 	.probe		= ds1307_probe,
-	.remove		= ds1307_remove,
 	.id_table	= ds1307_id,
 };
 
-- 
2.11.0
