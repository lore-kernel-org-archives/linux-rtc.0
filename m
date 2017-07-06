Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49169 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbdGFJmX (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 05:42:23 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 09/11] rtc: ds1307: switch to rtc_register_device
Date: Thu,  6 Jul 2017 11:42:06 +0200
Message-Id: <20170706094208.16240-10-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
References: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This removes a possible race condition and crash and allows for further
improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1307.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 43e9dc6f2edc..bac920a50ece 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1663,8 +1663,8 @@ static int ds1307_probe(struct i2c_client *client,
 		device_set_wakeup_capable(ds1307->dev, true);
 		set_bit(HAS_ALARM, &ds1307->flags);
 	}
-	ds1307->rtc = devm_rtc_device_register(ds1307->dev, ds1307->name,
-				rtc_ops, THIS_MODULE);
+
+	ds1307->rtc = devm_rtc_allocate_device(ds1307->dev);
 	if (IS_ERR(ds1307->rtc)) {
 		return PTR_ERR(ds1307->rtc);
 	}
@@ -1726,6 +1726,11 @@ static int ds1307_probe(struct i2c_client *client,
 		}
 	}
 
+	ds1307->rtc->ops = rtc_ops;
+	err = rtc_register_device(ds1307->rtc);
+	if (err)
+		return err;
+
 	ds1307_hwmon_register(ds1307);
 	ds1307_clks_register(ds1307);
 
-- 
2.11.0
