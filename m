Return-Path: <rtc-linux+bncBCEKJX4XQ4ORBAV3UKXAKGQE6VYFGSI@googlegroups.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com (mail-bn1on0145.outbound.protection.outlook.com. [157.56.110.145])
        by gmr-mx.google.com with ESMTPS id m197si916857ywd.2.2015.08.10.05.48.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Aug 2015 05:48:01 -0700 (PDT)
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <alexandre.belloni@free-electrons.com>
CC: <festevam@gmail.com>, <rtc-linux@googlegroups.com>, Fabio Estevam
	<fabio.estevam@freescale.com>
Subject: [rtc-linux] [PATCH 2/2] rtc: rtc-ds1374: Remove unused variable
Date: Mon, 10 Aug 2015 09:47:45 -0300
Message-ID: <1439210865-8611-2-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1439210865-8611-1-git-send-email-fabio.estevam@freescale.com>
References: <1439210865-8611-1-git-send-email-fabio.estevam@freescale.com>
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

Remove unused variable 'res' and fix the following build warning:

drivers/rtc/rtc-ds1374.c:667:6: warning: unused variable 'res' [-Wunused-variable]

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/rtc/rtc-ds1374.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 7067232..3b3049c 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -664,8 +664,6 @@ static int ds1374_remove(struct i2c_client *client)
 {
 	struct ds1374 *ds1374 = i2c_get_clientdata(client);
 #ifdef CONFIG_RTC_DRV_DS1374_WDT
-	int res;
-
 	misc_deregister(&ds1374_miscdev);
 	ds1374_miscdev.parent = NULL;
 	unregister_reboot_notifier(&ds1374_wdt_notifier);
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
