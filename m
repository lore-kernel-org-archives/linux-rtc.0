Return-Path: <rtc-linux+bncBDP6N55ZUYDRBJH4WWWQKGQEBKKZA2Q@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com. [2607:f8b0:400e:c03::22b])
        by gmr-mx.google.com with ESMTPS id rv6si2016592pac.1.2015.07.20.16.03.00
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2015 16:03:00 -0700 (PDT)
Received: by mail-pa0-x22b.google.com with SMTP id hj5so108250811pac.3
        for <rtc-linux@googlegroups.com>; Mon, 20 Jul 2015 16:03:00 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 3/4] RTC: properly manage lifetime of dev and cdev
 in rtc device
Date: Mon, 20 Jul 2015 16:02:51 -0700
Message-Id: <1437433372-15425-3-git-send-email-dmitry.torokhov@gmail.com>
In-Reply-To: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
References: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
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

struct rtc embeds both struct dev and struct cdev.  Unfortunately character
device structure may outlive the parent rtc structure unless we set it up
as parent of character device so that it will stay pinned until character
device is freed.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/rtc/rtc-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index 799c34b..a6d9434 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -477,6 +477,7 @@ void rtc_dev_prepare(struct rtc_device *rtc)
 
 	cdev_init(&rtc->char_dev, &rtc_dev_fops);
 	rtc->char_dev.owner = rtc->owner;
+	rtc->char_dev.kobj.parent = &rtc->dev.kobj;
 }
 
 void rtc_dev_add_device(struct rtc_device *rtc)
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
