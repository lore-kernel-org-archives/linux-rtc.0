Return-Path: <rtc-linux+bncBAABBKOT7OXAKGQEGGSPVZY@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id zt8si268050pbc.0.2015.08.27.03.42.48
        for <rtc-linux@googlegroups.com>;
        Thu, 27 Aug 2015 03:42:48 -0700 (PDT)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH] rtc: ds1374: Remove unused variable
Date: Thu, 27 Aug 2015 12:42:39 +0200
Message-Id: <1440672159-8249-1-git-send-email-javier@osg.samsung.com>
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

The res variable in ds1374_remove() is not used so remove it.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/rtc/rtc-ds1374.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 7067232ba507..84d9a6da08fb 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -664,7 +664,6 @@ static int ds1374_remove(struct i2c_client *client)
 {
 	struct ds1374 *ds1374 = i2c_get_clientdata(client);
 #ifdef CONFIG_RTC_DRV_DS1374_WDT
-	int res;
 
 	misc_deregister(&ds1374_miscdev);
 	ds1374_miscdev.parent = NULL;
-- 
2.4.3

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
