Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36310 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbdG2L5V (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 29 Jul 2017 07:57:21 -0400
From: SZ Lin <sz.lin@moxa.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SZ Lin <sz.lin@moxa.com>
Subject: [PATCH] rtc: ds1374: Fix decimal permission coding issue
Date: Sat, 29 Jul 2017 19:56:24 +0800
Message-Id: <20170729115624.18814-1-sz.lin@moxa.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Fixed ERROR: Use 4 digit octal (0777) not decimal permissions to fulfill
the current coding-style

This error was detected by checkpatch.pl

Signed-off-by: SZ Lin <sz.lin@moxa.com>
---
 drivers/rtc/rtc-ds1374.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 38a2e9e684df..7d55ad297f36 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -378,7 +378,7 @@ static struct i2c_client *save_client;
 
 static int wdt_margin = WD_TIMO;
 static unsigned long wdt_is_open;
-module_param(wdt_margin, int, 0);
+module_param(wdt_margin, int, 0000);
 MODULE_PARM_DESC(wdt_margin, "Watchdog timeout in seconds (default 32s)");
 
 static const struct watchdog_info ds1374_wdt_info = {
-- 
2.13.3
