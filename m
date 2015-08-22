Return-Path: <rtc-linux+bncBCGP7DNSRUMRBAU24OXAKGQEJ7KQIVA@googlegroups.com>
Received: from mail.windriver.com (mail.windriver.com. [147.11.1.11])
        by gmr-mx.google.com with ESMTPS id fk4si1242772pbc.2.2015.08.22.12.26.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Aug 2015 12:26:58 -0700 (PDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        <rtc-linux@googlegroups.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [rtc-linux] [PATCH -next] rtc: drop unused ret variable orphaned by
 misc_deregister becoming void
Date: Sat, 22 Aug 2015 15:26:31 -0400
Message-ID: <1440271591-5640-1-git-send-email-paul.gortmaker@windriver.com>
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

In commit f368ed6088ae9c1fbe1c897bb5f215ce5e63fa1e ("char: make
misc_deregister a void function") this ret variable became unused
which now generates a compile warning.  Get rid of it.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/rtc/rtc-ds1374.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 7067232ba507..742ac67eb702 100644
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
