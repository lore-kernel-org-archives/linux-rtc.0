Return-Path: <rtc-linux+bncBCPM5SUWUYIRB4OKQ63AKGQERZQT7VA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com. [2607:f8b0:400e:c03::244])
        by gmr-mx.google.com with ESMTPS id ff2si2930908pad.2.2016.02.15.06.49.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 06:49:21 -0800 (PST)
Received: by mail-pa0-x244.google.com with SMTP id y7so782099paa.3
        for <rtc-linux@googlegroups.com>; Mon, 15 Feb 2016 06:49:21 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 1/4] rtc-rx8025: fix irq handler registration
Date: Mon, 15 Feb 2016 23:49:06 +0900
Message-Id: <1455547749-5229-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

When IRQ line for this chips is connected, devm_request_threaded_irq()
refuses to register irq handler with the following message.

genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index bd911ba..561248a 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -539,8 +539,9 @@ static int rx8025_probe(struct i2c_client *client,
 	if (client->irq > 0) {
 		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
 		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-						rx8025_handle_irq, 0, "rx8025",
-						client);
+						rx8025_handle_irq,
+						IRQF_ONESHOT,
+						"rx8025", client);
 		if (err) {
 			dev_err(&client->dev, "unable to request IRQ, alarms disabled\n");
 			client->irq = 0;
-- 
2.5.0

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
