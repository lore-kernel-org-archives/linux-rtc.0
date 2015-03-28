Return-Path: <rtc-linux+bncBAABBNNR3SUAKGQEQOTA5WY@googlegroups.com>
MIME-Version: 1.0
Received: from filtteri2.pp.htv.fi (filtteri2.pp.htv.fi. [213.243.153.185])
        by gmr-mx.google.com with ESMTP id xg8si395845lbb.0.2015.03.28.14.10.13
        for <rtc-linux@googlegroups.com>;
        Sat, 28 Mar 2015 14:10:13 -0700 (PDT)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [rtc-linux] [PATCH 1/3] rtc: initialize rtc name early
Date: Sat, 28 Mar 2015 23:09:34 +0200
Message-Id: <1427576976-22353-1-git-send-email-aaro.koskinen@iki.fi>
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

In some error cases RTC name is used before it is initialized:

	rtc-rs5c372 0-0032: clock needs to be set
	rtc-rs5c372 0-0032: rs5c372b found, 24hr, driver version 0.6
	rtc (null): read_time: fail to read
	rtc-rs5c372 0-0032: rtc core: registered rtc-rs5c372 as rtc0

Fix by initializing the name early.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/rtc/class.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 472a5ad..014ecbc 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -225,15 +225,15 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 	rtc->pie_timer.function = rtc_pie_update_irq;
 	rtc->pie_enabled = 0;
 
+	strlcpy(rtc->name, name, RTC_DEVICE_NAME_SIZE);
+	dev_set_name(&rtc->dev, "rtc%d", id);
+
 	/* Check to see if there is an ALARM already set in hw */
 	err = __rtc_read_alarm(rtc, &alrm);
 
 	if (!err && !rtc_valid_tm(&alrm.time))
 		rtc_initialize_alarm(rtc, &alrm);
 
-	strlcpy(rtc->name, name, RTC_DEVICE_NAME_SIZE);
-	dev_set_name(&rtc->dev, "rtc%d", id);
-
 	rtc_dev_prepare(rtc);
 
 	err = device_register(&rtc->dev);
-- 
2.2.0

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
