Return-Path: <rtc-linux+bncBAABBEMR3KXAKGQE3RYUGMI@googlegroups.com>
Received: from na01-by2-obe.outbound.protection.outlook.com (mail-by2on0146.outbound.protection.outlook.com. [207.46.100.146])
        by gmr-mx.google.com with ESMTPS id j6si80161igx.0.2015.08.20.19.10.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Aug 2015 19:10:25 -0700 (PDT)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <alexandre.belloni@free-electrons.com>
CC: <k.kozlowski.k@gmail.com>, <rtc-linux@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, Wang Dongsheng <dongsheng.wang@freescale.com>
Subject: [rtc-linux] [PATCH v3] rtc/ds3232: fix ds3232 get a WARNING trace in
 resume function
Date: Fri, 21 Aug 2015 10:04:55 +0800
Message-ID: <1440122695-12181-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

If ds3232 work on some platform that is not implementation
irq_set_wake, ds3232 will get a WARNING trace in resume.
So fix ds3232->suspended state to false when irq_set_irq_wake
return error.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
*v3*
- Remove kernel trace in commit message.
- s/Can not/Cannot/
*v2*
- Use dev_warn_once to instead of dev_info

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 7e48e53..3554970 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -463,7 +463,10 @@ static int ds3232_suspend(struct device *dev)
 
 	if (device_can_wakeup(dev)) {
 		ds3232->suspended = true;
-		irq_set_irq_wake(client->irq, 1);
+		if (irq_set_irq_wake(client->irq, 1)) {
+			dev_warn_once(dev, "Cannot set wakeup sources\n");
+			ds3232->suspended = false;
+		}
 	}
 
 	return 0;
-- 
2.1.0.27.g96db324

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
