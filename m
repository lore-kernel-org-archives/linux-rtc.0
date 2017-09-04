Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53973 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754028AbdIDUqP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 4 Sep 2017 16:46:15 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 6/7] rtc: ds1307: fix braces
Date: Mon,  4 Sep 2017 22:46:07 +0200
Message-Id: <20170904204608.7090-6-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170904204608.7090-1-alexandre.belloni@free-electrons.com>
References: <20170904204608.7090-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Fix unnecessary or unbalanced braces.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1307.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index bac0f9ec9351..9df50db228c6 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1667,9 +1667,8 @@ static int ds1307_probe(struct i2c_client *client,
 	}
 
 	ds1307->rtc = devm_rtc_allocate_device(ds1307->dev);
-	if (IS_ERR(ds1307->rtc)) {
+	if (IS_ERR(ds1307->rtc))
 		return PTR_ERR(ds1307->rtc);
-	}
 
 	if (ds1307_can_wakeup_device && !want_irq) {
 		dev_info(ds1307->dev,
@@ -1688,8 +1687,9 @@ static int ds1307_probe(struct i2c_client *client,
 			device_set_wakeup_capable(ds1307->dev, false);
 			clear_bit(HAS_ALARM, &ds1307->flags);
 			dev_err(ds1307->dev, "unable to request IRQ!\n");
-		} else
+		} else {
 			dev_dbg(ds1307->dev, "got IRQ %d\n", client->irq);
+		}
 	}
 
 	if (chip->nvram_size) {
-- 
2.14.1
