Return-Path: <rtc-linux+bncBAABBU4T6OWAKGQE5NLAUII@googlegroups.com>
MIME-Version: 1.0
Received: from mailout1.samsung.com (mailout1.samsung.com. [203.254.224.24])
        by gmr-mx.google.com with ESMTPS id x3si134138pdh.2.2015.07.07.23.57.23
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 23:57:23 -0700 (PDT)
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NR502BX9PZLL640@mailout1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 08 Jul 2015 15:57:21 +0900 (KST)
From: Maninder Singh <maninder1.s@samsung.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc: pankaj.m@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [rtc-linux] [PATCH 1/1] drivers/rtc/rtc-bq32k.c: remove redundant check
Date: Wed, 08 Jul 2015 12:26:47 +0530
Message-id: <1436338607-43389-1-git-send-email-maninder1.s@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

removing below static analysis error:-
(error) Possible null pointer dereference: client

if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
							^^^^^^^
Error comes beacause client is dereferenced before NULL check.
So probabily NULL this check is not required.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 drivers/rtc/rtc-bq32k.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index 92679df..409de9f 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -212,7 +212,7 @@ static int bq32k_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	if (client && client->dev.of_node)
+	if (client->dev.of_node)
 		trickle_charger_of_init(dev, client->dev.of_node);
 
 	rtc = devm_rtc_device_register(&client->dev, bq32k_driver.driver.name,
-- 
1.7.9.5

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
