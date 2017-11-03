Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43628 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756417AbdKCRdo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 3 Nov 2017 13:33:44 -0400
Received: by mail-qt0-f193.google.com with SMTP id j58so4161769qtj.0
        for <linux-rtc@vger.kernel.org>; Fri, 03 Nov 2017 10:33:44 -0700 (PDT)
From: Akshay Bhat <akshay.bhat@timesys.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akshay Bhat <akshay.bhat@timesys.com>
Subject: [PATCH 3/3] rtc: rx8010: Fix for incorrect return value
Date: Fri,  3 Nov 2017 13:32:41 -0400
Message-Id: <1509730361-23905-3-git-send-email-akshay.bhat@timesys.com>
In-Reply-To: <1509730361-23905-1-git-send-email-akshay.bhat@timesys.com>
References: <1509730361-23905-1-git-send-email-akshay.bhat@timesys.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The err variable is not being reset after a successful read. Explicitly
reset err variable to account for all return paths.

Reported-by: Jens-Peter Oswald <oswald@lre.de>
Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 drivers/rtc/rtc-rx8010.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 2e06e5f..1ce2078 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -223,6 +223,7 @@ static int rx8010_init_client(struct i2c_client *client)
 					    2, ctrl);
 	if (err != 2)
 		return err < 0 ? err : -EIO;
+	err = 0;
 
 	if (ctrl[0] & RX8010_FLAG_VLF)
 		dev_warn(&client->dev, "Frequency stop was detected\n");
@@ -261,6 +262,7 @@ static int rx8010_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	err = i2c_smbus_read_i2c_block_data(client, RX8010_ALMIN, 3, alarmvals);
 	if (err != 3)
 		return err < 0 ? err : -EIO;
+	err = 0;
 
 	flagreg = i2c_smbus_read_byte_data(client, RX8010_FLAG);
 	if (flagreg < 0)
-- 
2.7.4
