Return-Path: <rtc-linux+bncBDU5DXUG4MFRBUNWW2XQKGQEPIWRYVA@googlegroups.com>
MIME-Version: 1.0
Received: from youngberry.canonical.com (youngberry.canonical.com. [91.189.89.112])
        by gmr-mx.google.com with ESMTPS id k7si193517wif.1.2015.09.07.07.12.32
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 07 Sep 2015 07:12:32 -0700 (PDT)
From: Colin King <colin.king@canonical.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] char: remove unused variable res to clean up
 build warning
Date: Mon,  7 Sep 2015 15:12:29 +0100
Message-Id: <1441635149-6131-1-git-send-email-colin.king@canonical.com>
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

From: Colin Ian King <colin.king@canonical.com>

Commit f368ed6088ae9 ("char: make misc_deregister a void function")
did not remove unused variable res and now we get a build warning:

drivers/rtc/rtc-ds1374.c: In function 'ds1374_remove':
drivers/rtc/rtc-ds1374.c:667:6: warning: unused variable 'res' 
[-Wunused-variable]
  int res;

simply remove this unused variable.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rtc/rtc-ds1374.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 72c9333..36b1b84 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -663,9 +663,8 @@ static int ds1374_probe(struct i2c_client *client,
 static int ds1374_remove(struct i2c_client *client)
 {
 	struct ds1374 *ds1374 = i2c_get_clientdata(client);
-#ifdef CONFIG_RTC_DRV_DS1374_WDT
-	int res;
 
+#ifdef CONFIG_RTC_DRV_DS1374_WDT
 	misc_deregister(&ds1374_miscdev);
 	ds1374_miscdev.parent = NULL;
 	unregister_reboot_notifier(&ds1374_wdt_notifier);
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
