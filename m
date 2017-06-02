Return-Path: <linux-rtc-owner@vger.kernel.org>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 3/5] rtc: pcf8563: avoid using rtc->name
Date: Fri,  2 Jun 2017 14:21:55 +0200
Message-Id: <20170602122157.4677-3-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170602122157.4677-1-alexandre.belloni@free-electrons.com>
References: <20170602122157.4677-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <rtc-linux.googlegroups.com>

pcf8563->rtc->name is a copy of pcf8563_driver.driver.name, use it instead

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-pcf8563.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 1227ceab61ee..cea6ea4df970 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -606,7 +606,7 @@ static int pcf8563_probe(struct i2c_client *client,
 		err = devm_request_threaded_irq(&client->dev, client->irq,
 				NULL, pcf8563_irq,
 				IRQF_SHARED|IRQF_ONESHOT|IRQF_TRIGGER_FALLING,
-				pcf8563->rtc->name, client);
+				pcf8563_driver.driver.name, client);
 		if (err) {
 			dev_err(&client->dev, "unable to request IRQ %d\n",
 								client->irq);
-- 
2.11.0
