Return-Path: <rtc-linux+bncBAABBSXAUSZQKGQEO6IQ7KA@googlegroups.com>
MIME-Version: 1.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id 70si1807973pfr.1.2015.12.09.23.56.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 09 Dec 2015 23:56:57 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NZ400CKHU2T1380@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 10 Dec 2015 07:56:53 +0000 (GMT)
From: Andrzej Hajda <a.hajda@samsung.com>
To: rtc-linux@googlegroups.com (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: [rtc-linux] [PATCH] rtc: rv8803: fix handling return value of i2c_smbus_read_byte_data
Date: Thu, 10 Dec 2015 08:55:33 +0100
Message-id: <1449734133-29235-1-git-send-email-a.hajda@samsung.com>
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

The function can return negative values, so its result should
be assigned to signed variable.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/assign_signed_to_unsigned.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2046107

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/rtc/rtc-rv8803.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index e7329e2..f883aa2 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -61,7 +61,7 @@ static irqreturn_t rv8803_handle_irq(int irq, void *dev_id)
 	struct i2c_client *client = dev_id;
 	struct rv8803_data *rv8803 = i2c_get_clientdata(client);
 	unsigned long events = 0;
-	u8 flags;
+	int flags;
 
 	spin_lock(&rv8803->flags_lock);
 
-- 
1.9.1

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
