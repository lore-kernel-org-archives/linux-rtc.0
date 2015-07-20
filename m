Return-Path: <rtc-linux+bncBDP6N55ZUYDRBIH4WWWQKGQEDVM7AII@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x232.google.com (mail-pd0-x232.google.com. [2607:f8b0:400e:c02::232])
        by gmr-mx.google.com with ESMTPS id ff6si718272pac.2.2015.07.20.16.02.56
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2015 16:02:56 -0700 (PDT)
Received: by mail-pd0-x232.google.com with SMTP id g1so108364665pdr.2
        for <rtc-linux@googlegroups.com>; Mon, 20 Jul 2015 16:02:56 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Vasiliy Kulikov <segooon@gmail.com>
Subject: [rtc-linux] [PATCH 1/4] RTC: fix double free in rtc_register_device()
 error path
Date: Mon, 20 Jul 2015 16:02:49 -0700
Message-Id: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
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

Commit 59cca865f21e9e7beab73fcf79ba4eb776a4c228 correctly noted that naked
kfree() should not be used after failed device_register() call, however,
while it added the needed put_device() it forgot to remove the original
kfree() causing double-free.

Cc: Vasiliy Kulikov <segooon@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/rtc/class.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index ea2a315..eb82ec2 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -234,8 +234,9 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 
 	err = device_register(&rtc->dev);
 	if (err) {
+		/* This will free both memory and the ID */
 		put_device(&rtc->dev);
-		goto exit_kfree;
+		goto exit;
 	}
 
 	rtc_dev_add_device(rtc);
@@ -247,9 +248,6 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 
 	return rtc;
 
-exit_kfree:
-	kfree(rtc);
-
 exit_ida:
 	ida_simple_remove(&rtc_ida, id);
 
-- 
2.4.3.573.g4eafbef

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
