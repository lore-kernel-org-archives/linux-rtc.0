Return-Path: <linux-rtc-owner@vger.kernel.org>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 4/5] rtc: ds1307: avoid using rtc-name
Date: Fri,  2 Jun 2017 14:21:56 +0200
Message-Id: <20170602122157.4677-4-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170602122157.4677-1-alexandre.belloni@free-electrons.com>
References: <20170602122157.4677-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <rtc-linux.googlegroups.com>

ds1307->rtc->name is a copy of ds1307->client->name, use it instead.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 77339b3d50a1..99e893ddd029 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1728,7 +1728,7 @@ static int ds1307_probe(struct i2c_client *client,
 		err = devm_request_threaded_irq(&client->dev,
 						client->irq, NULL, irq_handler,
 						IRQF_SHARED | IRQF_ONESHOT,
-						ds1307->rtc->name, client);
+						ds1307->client->name, client);
 		if (err) {
 			client->irq = 0;
 			device_set_wakeup_capable(&client->dev, false);
-- 
2.11.0
